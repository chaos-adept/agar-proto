package {

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.utils.Timer;


public class Starter extends Sprite {

    private var gameLogic:GameLogic;
    private var gameRender:GameRender;
    private var player:Mover;
    private var playerInputController:PlayerInputController;

    public function Starter() {
        gameRender = new GameRender();
        gameLogic = new GameLogic();
        player = newMover();

        playerInputController = new PlayerInputController(player);
        gameLogic.registerMover(player);

        var bot:Mover = newMover();
        bot.direction.x = 1;
        gameLogic.registerMover(bot);

        this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
        this.addEventListener(Event.ADDED_TO_STAGE, function (e:Event):void {
            stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
        });
        this.addChild(gameRender);
    }

    private function newMover():Mover {
        var mover:Mover = new Mover();
        mover.direction = new Point(0, 0);
        mover.position = new Point(0, 0);

        gameRender.bindView(mover);

        this.addChild(mover.view);

        return mover;
    }

    private function onEnterFrameHandler(event:Event):void {

    }

    private function onMouseMoveHandler(event:MouseEvent):void {
        var direction:Point = new Point(stage.mouseX - player.position.x, stage.mouseY - player.position.y);
        var norm:Point = new Point(direction.x / direction.length, direction.y / direction.length);
        playerInputController.updateDirection(norm);
    }

}
}
