/**
 * Created by Julia on 13.09.2015.
 */
package game {
import event.MoverEvent;

import flash.events.EventDispatcher;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

public class LocalGameLogic extends EventDispatcher {

    private var movers:Array = [];
    private var speedKoef:Number = 9;
    private var tickTime:Number = 1000 / 30;
    private var timer:Timer;

    public function LocalGameLogic() {
        timer = new Timer(tickTime);
        timer.addEventListener(TimerEvent.TIMER, onTickHandler);
        timer.start();
    }

    public function registerMover(mover:Mover):void {
        movers.push(mover)
    }

    public function onTickHandler(e:TimerEvent):void {
        movers.forEach( function (mover:Mover, indx:Number, arr:Array):void {
            var direction:Point = mover.direction;
            if (direction.length > 0) {
                mover.position.x += direction.x * speedKoef;
                mover.position.y += direction.y * speedKoef;
            }
        });
    }

    public function start(playerName:String):void {
        var player:Mover = newMover();
        dispatchEvent( new MoverEvent(MoverEvent.PLAYER_LOGGED, player) );
    }

    private function newMover():Mover {
        var mover:Mover = new Mover();
        mover.direction = new Point(0, 0);
        mover.position = new Point(0, 0);

        dispatchEvent(new MoverEvent(MoverEvent.EVENT_NEW_MOVER, mover));

        return mover;
    }
}
}
