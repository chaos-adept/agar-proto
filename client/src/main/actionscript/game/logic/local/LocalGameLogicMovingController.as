/**
 * Created by Julia on 16.09.2015.
 */
package game.logic.local {
import event.MoverDirectionUpdateEvent;
import event.MoverEvent;
import event.MoverPositionUpdateEvent;

import flash.events.EventDispatcher;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Dictionary;
import flash.utils.Timer;

import utils.Constants;

public class LocalGameLogicMovingController extends BaseGameMovingController {

    private var timer:Timer;
    private var tickTime:Number = Constants.ABOVE_FRAME_DURATION_IN_MILSEC;
    private var lastTickTime:Number;
    private var speedKoef:Number = 1 / 3;

    public function LocalGameLogicMovingController() {
        timer = new Timer(tickTime);
        timer.addEventListener(TimerEvent.TIMER, onTickHandler);
    }

    public function onTickHandler(e:TimerEvent):void {
        var timeDelta:Number = new Date().time - lastTickTime;

        for each (var mover:Mover in movers) {
            var direction:Point = mover.direction;
            if (direction.length > 0) {
                var newPos:Point = new Point();
                newPos.x = mover.position.x + direction.x * speedKoef * timeDelta;
                newPos.y = mover.position.y + direction.y * speedKoef * timeDelta;
                dispatchEvent(new MoverPositionUpdateEvent(MoverPositionUpdateEvent.EVENT_TYPE_UPDATE_POSITION, mover.id, mover.direction, newPos))
            }
        }

        lastTickTime += timeDelta;
    }
    override public function requestNewMoverDirectionHandler(e:MoverDirectionUpdateEvent):void {
        requestNewMoverDirection(e.moverId, e.newDirection);
    }
    public function requestNewMoverDirection(moverId:Number, newDirection:Point):void {
        //todo async update in the tick
        getMover(moverId).direction = newDirection
    }

    override public function start():void {
        lastTickTime = new Date().time;
        timer.start();
        super.start();
    }


}
}
