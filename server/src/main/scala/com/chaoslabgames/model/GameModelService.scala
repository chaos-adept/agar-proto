package com.chaoslabgames.model

import akka.actor._
import com.chaoslabgames.datavalue.MoverWorldData
import com.chaoslabgames.model.GameModelService.{LoginCmd, UpdateDirectionCmd, Mover}
import com.chaoslabgames.session.Session
import com.chaoslabgames.datavalue.Point

import scala.collection.mutable


/**
 * Created by Julia on 13.09.2015.
 */
object GameModelService {
  case class LoginCmd(id:Long, session: ActorRef, name:String)
  case class UpdateDirectionCmd(id:Long, session: ActorRef, newDir:Point)
  class Mover(session:ActorRef, val name:String, var worldData:MoverWorldData)
}

class GameModelService extends Actor with ActorLogging {
  val sessions = new mutable.HashMap[Long, Mover]()

  def registerMover(id:Long, session: ActorRef, name: String) = {
    val mover = new Mover(session, name, new MoverWorldData(((0xFFFFFF).toDouble * Math.random()).toInt))
    sessions.put(id, mover)
    session ! Session.JoinEvent(id, name, mover.worldData)
  }

  override def receive = {
    case LoginCmd(id, session, name) =>
      registerMover(id, session, name)
    case UpdateDirectionCmd(id, session, dir) =>
      sessions.get(id).get.worldData.direction = dir
    case m:Any =>
      log.info("unknown message {}", m)
  }
}