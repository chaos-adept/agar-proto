/**
 * Created by Julia on 13.09.2015.
 */
package game.logic.local {
import datavalue.Mover;

import event.MoverDirectionUpdateEvent;
import event.MoverEvent;
import event.MoverPositionUpdateEvent;

import flash.geom.Point;
import flash.utils.Dictionary;

import game.logic.*;

import utils.Constants;

public class LocalGameLogic extends BaseGameLogic implements IUserSessionManager {

    private var moverCouner:Number;
    private var movers:Dictionary = new Dictionary();
    private var isDelayedController:Boolean = Constants.LOCAL_GAME_IS_DELAYED_CONTROLLER;
    private var movingController:BaseGameMovingController;
    private var lastTickId:Number;


    public function LocalGameLogic() {
        var localMoverController:BaseGameMovingController = new LocalGameLogicMovingController();
        movingController = !isDelayedController ? localMoverController :
                new ApproxProxyMovingController(
                        new DelayedProxyMovingController(
                                Constants.POSITION_EVENT_PROXY_MIN_DELAY,
                                Constants.POSITION_EVENT_PROXY_MAX_DELAY, localMoverController));

        movingController.attach(this);
    }

    public function registerMover(mover:Mover):void {
        movers[mover.id] = (mover);
        dispatchEvent(new MoverEvent(MoverEvent.EVENT_NEW_MOVER, mover));
    }

    public function onUpdatePositionHandler(e:MoverPositionUpdateEvent):void {
        if (lastTickId > e.tickId) {
            trace(e.tickId);
            return;
        }
        lastTickId = e.tickId;
        var mover:Mover = movers[e.moverId];
        mover.position = e.newPosition;
        mover.direction = e.newDirection;

        dispatchEvent(e);
    }

    override public function start(playerName:String):void {
        moverCouner = 0;
        var player:Mover = newMover();
        dispatchEvent(new MoverEvent(MoverEvent.PLAYER_LOGGED, player) );

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
        if (e.isTickIdUnknown) {
            e.tickId = lastTickId;
        }
        super.updateDirectionRequestHandler(e);
        dispatchEvent(e);
    }
}
}
