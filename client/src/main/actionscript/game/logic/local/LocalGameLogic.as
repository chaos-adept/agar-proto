/**
 * Created by Julia on 13.09.2015.
 */
package game.logic.local {
import event.MoverDirectionUpdateEvent;
import event.MoverPositionUpdateEvent;

import flash.utils.Dictionary;

import game.logic.*;

import event.MoverEvent;

import flash.events.EventDispatcher;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

public class LocalGameLogic extends BaseGameLogic {

    private var moverCouner:Number;
    private var movers:Dictionary = new Dictionary();
    private var gameTotalTime:int;
    private var movingController:LocalGameLogicMovingController;

    public function LocalGameLogic() {
        movingController = new LocalGameLogicMovingController();
        movingController.addEventListener(MoverPositionUpdateEvent.EVENT_TYPE_UPDATE_POSITION, onUpdatePositonHandler);
    }

    public function registerMover(mover:Mover):void {
        movers[mover.id] = (mover);
        movingController.addMover(mover);
        dispatchEvent(new MoverEvent(MoverEvent.EVENT_NEW_MOVER, mover));
    }

    public function onUpdatePositonHandler(e:MoverPositionUpdateEvent):void {
        var mover:Mover = movers[e.moverId];
        mover.position = e.newPosition;
        mover.direction = e.newDirection;
    }

    override public function start(playerName:String):void {
        moverCouner = 0;
        var player:Mover = newMover();
        dispatchEvent( new MoverEvent(MoverEvent.PLAYER_LOGGED, player) );

        movingController.start();
        super.start(playerName)
    }

    private function newMover():Mover {
        var mover:Mover = new Mover();
        mover.direction = new Point(0, 0);
        mover.position = new Point(0, 0);
        moverCouner++;
        mover.id = moverCouner;
        registerMover(mover);

        return mover;
    }


    override public function updateDirectionRequestHandler(e:MoverDirectionUpdateEvent):void {
        movingController.requestNewMoverDirection(e.moverId, e.newDirection);
        super.updateDirectionRequestHandler(e);
    }
}
}
