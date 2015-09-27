/**
 * Created by Julia on 14.09.2015.
 */
package game.logic.remote {
import com.awar.ags.api.ConnectionResponse;
import com.awar.ags.api.MessageType;
import com.awar.ags.api.Packet;
import com.awar.ags.connection.AvailableConnection;
import com.awar.ags.connection.TransportType;
import com.awar.ags.engine.AgsEngine;
import com.awar.ags.engine.Server;
import com.chaoslabgames.packet.JoinEventPkg;
import com.chaoslabgames.packet.LoginPkg;
import com.chaoslabgames.packet.PointPkg;
import com.chaoslabgames.packet.UpdateDirectionCmdPkg;
import com.chaoslabgames.packet.UpdateMoverEventPkg;
import com.furusystems.logging.slf4as.ILogger;
import com.furusystems.logging.slf4as.Logging;
import com.netease.protobuf.Message;

import datavalue.Mover;

import event.MoverDirectionUpdateEvent;

import event.MoverEvent;

import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Dictionary;
import flash.utils.Timer;

import game.logic.*;

import utils.Constants;

public class RemoteGameLogic extends BaseGameLogic {

    private var host:String;
    private var port:int;
    private var ags:AgsEngine;
    public static const log:ILogger = Logging.getLogger(RemoteGameLogic);

    public var CMD_Ping:uint = 1;
    public var CMD_login:uint = 2;
    public var CMD_updateDirection:uint = 3;
    public var EVENT_JOIN:uint = 4;
    public var EVENT_update_mover:uint = 5;

    private var moverDict:Dictionary;

    public function RemoteGameLogic(host:String, port:int) {
        this.host = host;
        this.port = port;
        ags = new AgsEngine();

        var server:Server = new Server("server1");
        var availConn:AvailableConnection = new AvailableConnection(host, port, TransportType.TCP);
        server.addAvailableConnection(availConn);
        ags.addServer(server);
   }


    override public function start(playerName:String):void {
        super.start(playerName);

        moverDict = new Dictionary();

        ags.addEventListener(MessageType.ConnectionAttemptResponse.name, onConnectionResponse);
        ags.addEventListener(MessageType.ConnectionResponse.name, onConnectionResponse);
        ags.addEventListener(MessageType.Packet.name, onDataReceived);
        ags.connect();
    }

    private function onConnectionResponse(e:ConnectionResponse):void {
        if (e.successful) {
            onConnected();
        } else {
            log.error("connection failed")
        }
    }

    private function onConnected():void {
        doLogin(this.playerName);
    }

    private function doLogin(playerName:String):void {
        var pkg:LoginPkg = new LoginPkg();
        pkg.name = playerName;
        sendPacket(CMD_login, pkg);
    }

    private function onUpdateMover(updMoverPkg:UpdateMoverEventPkg):void {
        var id:Number = updMoverPkg.id.toNumber();
        var mover:Mover = (moverDict[id]);
        var isUnknown:Boolean = !mover;

        mover = isUnknown ? new Mover() : mover;

        mover.position = pkgToPoint(updMoverPkg.moverData.position);
        mover.direction = pkgToPoint(updMoverPkg.moverData.direction);
        mover.color = updMoverPkg.moverData.color;

        if (isUnknown) {
            log.error("unknown mover id: " + updMoverPkg.id);
            addMover(id, mover);
        }

    }

    private var player:Mover = new Mover();

    private function onJoin(joinPkg:JoinEventPkg):void {
        player.color = joinPkg.data.color;
        player.direction = pkgToPoint(joinPkg.data.direction);
        player.position = pkgToPoint(joinPkg.data.position);
        addMover(joinPkg.id.toNumber(), player);

        dispatchEvent(new MoverEvent(MoverEvent.PLAYER_LOGGED, player));

        var updateControllerTimer:Timer = new Timer(Constants.FRAME_DURATION_IN_MILSEC);
        updateControllerTimer.addEventListener(TimerEvent.TIMER, function (e:Event):void {
            var updDirPkg:UpdateDirectionCmdPkg = new UpdateDirectionCmdPkg();
            updDirPkg.direction = new PointPkg();
            updDirPkg.direction.x = player.direction.x;
            updDirPkg.direction.y = player.direction.y;
            sendPacket(CMD_updateDirection, updDirPkg);
        });
        updateControllerTimer.start();
    }

    private function addMover(id:Number, mover:Mover):void {
        moverDict[id] = mover;
        dispatchEvent(new MoverEvent(MoverEvent.EVENT_NEW_MOVER, mover));
    }

    private function sendPacket(cmd:int, args:Message):void {
        var packet:Packet = new Packet();
        packet.Cmd = cmd;
        if (args) {
            args.writeTo(packet.Data);
        }
        ags.send(packet)
    }

    private function pkgToPoint(pkg:PointPkg):Point {
        return new Point(pkg.x, pkg.y);
    }

    private function onDataReceived(e:Packet):void {
        switch (e.Cmd) {
            case EVENT_JOIN:
                var joinPkg:JoinEventPkg = new JoinEventPkg();
                joinPkg.mergeFrom(e.Data);
                onJoin(joinPkg);
                break;
            case EVENT_update_mover:
                var updMoverPkg:UpdateMoverEventPkg = new UpdateMoverEventPkg();
                updMoverPkg.mergeFrom(e.Data);
                onUpdateMover(updMoverPkg);
                break;
        }
    }


    override public function updateDirectionRequestHandler(event:MoverDirectionUpdateEvent):void {
        super.updateDirectionRequestHandler(event);
    }
}
}