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
import game.logic.local.moving.ApproxProxyMovingController;
import game.logic.local.moving.BaseGameMovingController;
import game.logic.local.moving.DelayedProxyMovingController;
import game.logic.local.moving.IMoverMovingListener;
import game.logic.local.moving.LocalGameLogicMovingController;
import game.logic.local.user.UserController;

import utils.Constants;

public class LocalGameLogic extends BaseGameLogic implements IMoverMovingListener {

    private var isDelayedController:Boolean = Constants.LOCAL_GAME_IS_DELAYED_CONTROLLER;
    private var movingController:BaseGameMovingController;
    private var lastTickId:Number;
    private var userController:UserController;

    public function LocalGameLogic() {
        userController = new UserController();
        userController.addEventListener(MoverEvent.PLAYER_LOGGED, onPlayerLoggedHandler);
        userController.addEventListener(MoverEvent.EVENT_NEW_MOVER, onNewMoverHandler);

        var localMoverController:BaseGameMovingController = new LocalGameLogicMovingController(Constants.REMOTE_TICK_TIME_MILSEC);
        movingController = !isDelayedController ? localMoverController :
                new ApproxProxyMovingController(
                        new DelayedProxyMovingController(
                                Constants.POSITION_EVENT_PROXY_MIN_DELAY,
                                Constants.POSITION_EVENT_PROXY_MAX_DELAY, localMoverController),
                        Constants.LOCAL_TICK_TIME_MILSEC
                );

        movingController.attach(this);
    }

    private function onNewMoverHandler(event:MoverEvent):void {
        dispatchEvent(event)
    }

    public function onUpdatePositionHandler(e:MoverPositionUpdateEvent):void {
        if (lastTickId > e.tickId) {
            trace(e.tickId);
            return;
        }
        lastTickId = e.tickId;
        var mover:Mover = userController.getMover(e.moverId);
        mover.position = e.newPosition;
        mover.direction = e.newDirection;

        dispatchEvent(e);
    }

    override public function start(playerName:String):void {
        userController.login(playerName);
        movingController.start();
        super.start(playerName)
    }

    private function onPlayerLoggedHandler(event:MoverEvent):void {
        dispatchEvent(event);
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
