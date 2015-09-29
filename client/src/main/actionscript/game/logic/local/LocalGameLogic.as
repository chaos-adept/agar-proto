/**
 * Created by Julia on 13.09.2015.
 */
package game.logic.local {
import datavalue.Mover;

import event.MoverDirectionUpdateEvent;
import event.MoverEvent;
import event.MoverPositionUpdateEvent;

import game.logic.*;
import game.logic.local.moving.BaseGameMovingController;
import game.logic.local.moving.IMoverMovingListener;
import game.logic.local.user.UserController;

public class LocalGameLogic extends BaseGameLogic implements IMoverMovingListener {

    private var movingController:BaseGameMovingController;
    private var lastTickId:Number;
    private var userController:UserController;

    public function LocalGameLogic(userController:UserController, movingController:BaseGameMovingController) {
        this.userController = userController;
        this.movingController = movingController;
        userController.addEventListener(MoverEvent.PLAYER_LOGGED, onPlayerLoggedHandler);
        userController.addEventListener(MoverEvent.EVENT_NEW_MOVER, onNewMoverHandler);

        this.movingController = movingController;

        movingController.attach(this);
    }

    private function onNewMoverHandler(e:MoverEvent):void {
        dispatchEvent(e)
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
