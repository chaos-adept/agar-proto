/**
 * Created by Julia on 18.09.2015.
 */
package game.logic.local {
import datavalue.Mover;

import event.MoverDirectionUpdateEvent;
import event.MoverEvent;
import event.MoverPositionUpdateEvent;

import flash.events.Event;

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.utils.Dictionary;

public class BaseGameMovingController extends EventDispatcher {

    protected var movers:Dictionary = new Dictionary();

    public function BaseGameMovingController() {
    }

    public function attach(sessionManager:IUserSessionManager) {
        addEventListener(MoverPositionUpdateEvent.EVENT_TYPE_UPDATE_POSITION, sessionManager.onUpdatePositionHandler);
        sessionManager.addEventListener(MoverEvent.EVENT_NEW_MOVER, newMoverHandler);
        sessionManager.addEventListener(MoverDirectionUpdateEvent.EVENT_TYPE_UPDATE_DIRECTION, requestNewMoverDirectionHandler);
    }

    public function requestNewMoverDirectionHandler(e:MoverDirectionUpdateEvent):void {

    }

    public function start():void {

    }

    public function getMover(moverId:Number):Mover {
        return movers[moverId]
    }

    public function addMover(mover:Mover):void {
        movers[mover.id] = mover.clone()
    }

    public function newMoverHandler(e:MoverEvent):void {
        addMover(e.mover);
    }
}
}
