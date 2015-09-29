package com.chaoslabgames.session

import akka.actor._
import akka.actor.{ActorLogging, Actor, Props, ActorRef}
import com.chaoslabgames.datavalue.MoverWorldData
import com.chaoslabgames.model.GameModelService
import com.chaoslabgames.model.GameModelService.UpdateDirectionCmd
import com.chaoslabgames.msg.Msg
import com.chaoslabgames.packet._
import com.chaoslabgames.session.Session.JoinEvent
import com.chaoslabgames.tcpfront.TcpConnection

/**
 * Created by Julia on 13.09.2015.
 */
object Session {
  def props(id: Long, connection: ActorRef, taskService: ActorRef) = Props(
    new Session(id, connection, taskService)
  )
  case class CmdMsg(code:Int, args:Any)
  case class LoginCmd(name:String)
  case object LogoutCmd
  case class JoinEvent(id:Long, name:String, moverWorldData: MoverWorldData)
  case class UpdateMoverEvent(id:Long, tickId:Long, moverWorldData: MoverWorldData)
}

class Session(val id: Long, val connection: ActorRef, val gameModel: ActorRef) extends Actor with ActorLogging {

  def convertToPkg(moverWorldData: MoverWorldData) = {
    MoverDataPkg.newBuilder()
      .setColor(moverWorldData.color)
      .setPosition(PointPkg.newBuilder()
      .setX(moverWorldData.position.x)
      .setY(moverWorldData.position.y)
      )
      .setDirection(PointPkg.newBuilder()
      .setX(moverWorldData.direction.x)
      .setY(moverWorldData.direction.y)
      )
  }


  @throws[Exception](classOf[Exception])
  override def postStop(): Unit = {
    gameModel ! GameModelService.SessionStopCmd(id, self)
    super.postStop()
  }

  override def receive = {
    case Session.CmdMsg(code, args:Array[Byte]) =>
      code match {
        case Msg.CMD_login =>
          val login = LoginPkg.parseFrom(args)
          gameModel ! GameModelService.LoginCmd(id, self, login.getName)
        case Msg.CMD_updateDirection =>
          val pkg = UpdateDirectionCmdPkg.parseFrom(args)
          val updDir = pkg.getDirection
          gameModel ! GameModelService.UpdateDirectionCmd(id, pkg.getTickId, self, new com.chaoslabgames.datavalue.Point(updDir.getX, updDir.getY))
      }
    case e:Session.JoinEvent =>
      val dataBuilder = JoinEventPkg.newBuilder()
        .setId(e.id)
        .setName(e.name)
        .setData(convertToPkg(e.moverWorldData))
      connection ! TcpConnection.Send(Msg.EVENT_JOIN, dataBuilder.build().toByteArray)
    case e:Session.UpdateMoverEvent =>
      val builder = UpdateMoverEventPkg
        .newBuilder()
        .setId(e.id)
        .setTickId(e.tickId)
        .setMoverData(convertToPkg(e.moverWorldData))
      connection ! TcpConnection.Send(Msg.EVENT_update_mover, builder.build().toByteArray)
    case m:Any =>
      log.info("unknown message {}", m)
  }
}