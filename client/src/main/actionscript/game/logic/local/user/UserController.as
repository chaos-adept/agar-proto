/**
 * Created by Julia on 29.09.2015.
 */
package game.logic.local.user {
import datavalue.Mover;
import datavalue.MoverDebugInfo;

import event.MoverEvent;

import flash.events.EventDispatcher;
import flash.geom.Point;
import flash.utils.Dictionary;

public class UserController extends EventDispatcher {

    private var moverCouner:Number = 0;
    private var movers:Dictionary = new Dictionary();

    public function UserController() {
    }

    public function login(playerName:String):void {
        var player:Mover = newMover(moverCouner++);
        dispatchEvent(new MoverEvent(MoverEvent.PLAYER_LOGGED, player) );
    }

    private function newMover(id:Number):Mover {
        var mover:Mover = new Mover();
        mover.direction = new Point(0, 0);
        mover.position = new Point(0, 0);
        mover.moverDebugInfo = new MoverDebugInfo();
        mover.id = id * -1;
        registerMover(mover);

        return mover;
    }

    public function getMover(id:Number):Mover {
        return movers[id]
    }

    private function registerMover(mover:Mover):void {
        movers[mover.id] = (mover);
        dispatchEvent(new MoverEvent(MoverEvent.EVENT_NEW_MOVER, mover));
    }

}
}
