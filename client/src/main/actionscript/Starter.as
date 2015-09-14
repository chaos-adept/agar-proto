package {

import event.InitGameEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.utils.Timer;

import game.logic.BaseGameLogic;

import game.logic.LocalGameLogic;

import game.GameRender;
import game.GameSetup;
import game.logic.RemoteGameLogic;


public class Starter extends Sprite {

    public var gameSetup:GameSetup;

    public var isRemote:Boolean = false;
    public var server:String;
    public var port:int;

    public function Starter() {
        gameSetup = new GameSetup(this, "user " + Math.random(), function ():BaseGameLogic {
            return isRemote ? new RemoteGameLogic(server, port) : new LocalGameLogic();
        });
        this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
        this.addEventListener(Event.ADDED_TO_STAGE, function (e:Event):void {
            gameSetup.addEventListener(InitGameEvent.EVENT_INITALIZATION_COMPLETED, function (e:Event):void {
                stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
            });
            gameSetup.setupGame();
        });

    }

    private function onEnterFrameHandler(event:Event):void {
    }

    private function onMouseMoveHandler(event:MouseEvent):void {
        //todo move to GameSetup?
        var player:Mover = gameSetup.player;
        var direction:Point = new Point(stage.mouseX - player.position.x, stage.mouseY - player.position.y);
        var norm:Point = new Point(direction.x / direction.length, direction.y / direction.length);
        gameSetup.playerInputController.updateDirection(norm);
    }

}
}
