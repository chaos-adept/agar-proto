package {

import com.furusystems.dconsole2.DConsole;

import event.InitGameEvent;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
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
import game.logic.remote.RemoteGameLogic;


public class Starter extends Sprite {

    public var gameSetup:GameSetup;

    public var isRemote:Boolean = true;
    public var server:String = "localhost";
    public var port:int = 8899;

    public function Starter() {

        gameSetup = new GameSetup(this, "user " + Math.random(), function ():BaseGameLogic {
            return isRemote ? new RemoteGameLogic(server, port) : new LocalGameLogic();
        });

        this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
        this.addEventListener(Event.ADDED_TO_STAGE, function (e:Event):void {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

            addChild(DConsole.view);

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
