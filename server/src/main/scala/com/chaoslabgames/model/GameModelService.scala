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
  case class UpdateDirectionCmd(id: Long, session: ActorRef, newDir: Point)
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

  val tickDelayMilSec = (1000f / 25f).toInt
  val speedKoef = 2f

  val sessions = new mutable.HashMap[Long, Mover]()
  private var scheduler: Cancellable = _

  @throws[Exception](classOf[Exception])
  override def preStart(): Unit = {
    scheduler = context.system.scheduler.schedule(tickDelayMilSec.millis, tickDelayMilSec.millis, self, WorldTick)
    super.preStart()
  }

  override def postStop() {
    scheduler.cancel()
    log.info("GameModel stop: {}", toString)
  }

  def registerMover(id: Long, session: ActorRef, name: String) = {
    val mover = new Mover(session, name, new MoverWorldData(((0xFFFFFF).toDouble * Math.random()).toInt))
    sessions.put(id, mover)
    session ! Session.JoinEvent(id, name, mover.worldData)
  }

  def updateWorld() = {
    sessions.foreach { case (id, mover) =>
      val direction = mover.worldData.direction
      val dirNormVec = new Vector2f(direction.x, direction.y).normalise()
      val position = mover.worldData.position
      val posVec = new Vector2f(position.x, position.y)
      val newPosVec = posVec.add(dirNormVec.scale(speedKoef))
      val newPosition = new Point(newPosVec.x, newPosVec.y)

      mover.worldData.position = newPosition
    }

    sessions.foreach { case (id, mover) =>
      val event = Session.UpdateMoverEvent(id, mover.worldData)
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

  override def receive = {
    case LoginCmd(id, session, name) =>
      registerMover(id, session, name)
    case SessionStopCmd(id, session) =>
      markSessionAsStopped(id)
    case UpdateDirectionCmd(id, session, dir) =>
      sessions.get(id).get.worldData.direction = dir
    case WorldTick =>
      updateWorld();
    case m: Any =>
      log.info("unknown message {}", m)
  }
}