/**
 * Created by Julia on 27.09.2015.
 */
package game.logic.local {
import event.MoverDirectionUpdateEvent;
import event.MoverEvent;
import event.MoverPositionUpdateEvent;

import flash.utils.Dictionary;

public class ApproxProxyMovingController extends BaseGameMovingController implements IUserSessionManager {

    public var parent:BaseGameMovingController;
    private var moverParentLastState:Dictionary = new Dictionary();
    private var localTickId:Number;

    public function ApproxProxyMovingController(parent:BaseGameMovingController) {
        this.parent = parent;
        this.parent.attach(this)
    }

    public function onUpdatePositionHandler(e:MoverPositionUpdateEvent):void {
        moverParentLastState[e.moverId] = e.clone();
        dispatchEvent(e);
    }

    public function getParentLastState(moverId:int):MoverPositionUpdateEvent {
        return moverParentLastState[moverId]
    }

    override public function requestNewMoverDirectionHandler(e:MoverDirectionUpdateEvent):void {
        var parentEvent:MoverDirectionUpdateEvent = MoverDirectionUpdateEvent(e.clone());
        var lastParentState:MoverPositionUpdateEvent = getParentLastState(e.moverId);

        if (lastParentState) {
            parentEvent.tickId = lastParentState.tickId;
            dispatchEvent(parentEvent);
        }
    }


    override public function newMoverHandler(e:MoverEvent):void {
        super.newMoverHandler(e);
        dispatchEvent(e);
    }


    override public function start():void {
        super.start();
        parent.start();
    }
}
}
