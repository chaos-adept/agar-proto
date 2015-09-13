/**
 * Created by Julia on 13.09.2015.
 */
package {
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

public class GameLogic {

    private var movers:Array = [];
    private var speedKoef:Number = 9;
    private var tickTime:Number = 1000 / 30;
    private var timer:Timer;

    public function GameLogic() {
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
}
}
