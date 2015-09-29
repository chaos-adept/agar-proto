package {

import com.furusystems.dconsole2.DConsole;

import event.InitGameEvent;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import game.GameSetup;
import game.logic.BaseGameLogic;
import game.logic.GameLogicFactory;
import game.logic.local.LocalGameLogic;
import game.logic.remote.RemoteGameServer;

[SWF(backgroundColor="#cccccc", frameRate="60", width="1600", height="800")]
public class Starter extends Sprite {

    public var gameSetup:GameSetup;



    public function Starter() {
        gameSetup = new GameSetup(this, "user " + Math.random(), new GameLogicFactory());

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
        if (!gameSetup.playerInputController) {
            return
        }

        var stageMousePosition:Point = new Point(stage.mouseX, stage.mouseY);
        gameSetup.playerInputController.updateDirectionByMouse(stageMousePosition);
    }

    private function onMouseMoveHandler(event:MouseEvent):void {
        //todo move to GameSetup?

    }

}
}
