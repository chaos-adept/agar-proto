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
import com.netease.protobuf.Int64;
import com.netease.protobuf.Message;

import datavalue.Mover;

import event.MoverEvent;
import event.MoverPositionUpdateEvent;

import flash.events.EventDispatcher;
import flash.geom.Point;
import flash.utils.Dictionary;

public class RemoteGameServer extends EventDispatcher {

    private var playerName:String;

    private var host:String;
    private var port:int;
    private var ags:AgsEngine;
    public static const log:ILogger = Logging.getLogger(RemoteGameServer);

    public var CMD_Ping:uint = 1;
    public var CMD_login:uint = 2;
    public var CMD_updateDirection:uint = 3;
    public var EVENT_JOIN:uint = 4;
    public var EVENT_update_mover:uint = 5;

    private var moverDict:Dictionary; //fixme remove

    public function RemoteGameServer(host:String, port:int) {
        this.host = host;
        this.port = port;
        ags = new AgsEngine();

        var server:Server = new Server("server1");
        var availConn:AvailableConnection = new AvailableConnection(host, port, TransportType.TCP);
        server.addAvailableConnection(availConn);
        ags.addServer(server);
   }


    public function login(playerName:String):void {
        this.playerName = playerName;

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

    private function onUpdateMover(pkg:UpdateMoverEventPkg):void {
        var id:Number = pkg.id.toNumber();
        var tickId:Number = pkg.tickId.toNumber();

        var mover:Mover = (moverDict[id]);
        var isUnknown:Boolean = !mover;
        mover = isUnknown ? new Mover() : mover;

        mover.position = pkgToPoint(pkg.moverData.position);
        mover.direction = pkgToPoint(pkg.moverData.direction);
        mover.color = pkg.moverData.color;
        mover.id = pkg.id.toNumber();

        if (isUnknown) {
            log.error("unknown mover id: " + pkg.id);
            addMover(mover);
        }

        dispatchEvent(new MoverPositionUpdateEvent(MoverPositionUpdateEvent.EVENT_TYPE_UPDATE_POSITION,
                tickId, mover.id, mover.position, mover.direction));

    }

    private var player:Mover = new Mover();

    private function onJoin(joinPkg:JoinEventPkg):void {
        player.color = joinPkg.data.color;
        player.direction = pkgToPoint(joinPkg.data.direction);
        player.position = pkgToPoint(joinPkg.data.position);
        player.id = joinPkg.id.toNumber();
        addMover(player);

        dispatchEvent(new MoverEvent(MoverEvent.PLAYER_LOGGED, player));

    }

    public function updatePlayerDirection(tickId:Number, direction:Point):void {
        var updDirPkg:UpdateDirectionCmdPkg = new UpdateDirectionCmdPkg();
        updDirPkg.direction = new PointPkg();
        updDirPkg.direction.x = direction.x;
        updDirPkg.direction.y = direction.y;
        updDirPkg.tickId = Int64.fromNumber(tickId);

        sendPacket(CMD_updateDirection, updDirPkg);
    }

    private function addMover(mover:Mover):void {
        moverDict[mover.id] = mover;
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
}
}