package com.chaoslabgames.model

import akka.actor._
import com.chaoslabgames.datavalue.MoverWorldData
import com.chaoslabgames.model.GameModelService._
import com.chaoslabgames.session.Session
import com.chaoslabgames.datavalue.Point
import org.newdawn.slick.geom.Vector2f

import scala.collection.mutable
import scala.concurrent.duration._

/**
 * Created by Julia on 13.09.2015.
 */
object GameModelService {

  case class LoginCmd(id: Long, session: ActorRef, name: String)
  case class SessionStopCmd(id: Long, session: ActorRef)
  case class UpdateDirectionCmd(id: Long, tickId: Long, session: ActorRef, newDir: Point)
  case object WorldTick

  class Mover(var session: ActorRef, val name: String, var worldData: MoverWorldData) {
    def isOffline(): Boolean = {
      session == null
    }

    def markAsOffline() = {
      session = null
      worldData.direction = new Point(0, 0)
    }
  }

}

class GameModelService extends Actor with ActorLogging {

  import context._

  val tickDelayMilSec = (1000f / 15f).toInt
  val speedKoef = 1 / 2f
  var lastUpdateTime:Long = 0L

  val sessions = new mutable.HashMap[Long, Mover]()
  val sessionLocalLastTickId = new mutable.HashMap[Long, Long]()
  private var scheduler: Cancellable = _

  @throws[Exception](classOf[Exception])
  override def preStart(): Unit = {
    scheduler = context.system.scheduler.schedule(tickDelayMilSec.millis, tickDelayMilSec.millis, self, WorldTick)
    lastUpdateTime = System.currentTimeMillis()
    super.preStart()
  }

  override def postStop() {
    scheduler.cancel()
    log.info("GameModel stop: {}", toString)
  }

  def registerMover(id: Long, session: ActorRef, name: String) = {
    val mover = new Mover(session, name, worldData = new MoverWorldData(((0xFFFFFF).toDouble * Math.random()).toInt))
    sessions.put(id, mover)
    session ! Session.JoinEvent(id, name, mover.worldData)
  }

  def updateWorld() = {
    val currentTime = System.currentTimeMillis()
    val tickId = currentTime

    val timeDelta = currentTime - lastUpdateTime

    sessions.foreach { case (id, mover) =>
      val direction = mover.worldData.direction
      val dirNormVec = new Vector2f(direction.x, direction.y).normalise()
      val position = mover.worldData.position
      val posVec = new Vector2f(position.x, position.y)
      val newPosVec = posVec.add(dirNormVec.scale(speedKoef * timeDelta))
      val newPosition = new Point(newPosVec.x, newPosVec.y)

      mover.worldData.position = newPosition
    }

    lastUpdateTime = currentTime

    sessions.foreach { case (id, mover) =>
      val event = Session.UpdateMoverEvent(id = id, tickId = tickId, mover.worldData)
      sessions.foreach { case (_, target) =>
        if (!target.isOffline()) {
          target.session ! event
        }
      }
    }


  }

  def markSessionAsStopped(id: Long): Unit = {
    val mover = sessions.get(id).get
    mover.markAsOffline()
  }

  def updateDirection(moverId: Long, tickId: Long, direction: Point): Unit = {
    val lastTickId = sessionLocalLastTickId.getOrElse(moverId, -1l)
    if (lastTickId < tickId) {
      sessions.get(moverId).get.worldData.direction = direction
      sessionLocalLastTickId.put(moverId, tickId)
    }
  }

  override def receive = {
    case LoginCmd(id, session, name) =>
      registerMover(id, session, name)
    case SessionStopCmd(id, session) =>
      markSessionAsStopped(id)
    case UpdateDirectionCmd(id, tickId, session, dir) =>
      updateDirection(id, tickId, dir)
    case WorldTick =>
      updateWorld();
    case m: Any =>
      log.info("unknown message {}", m)
  }
}