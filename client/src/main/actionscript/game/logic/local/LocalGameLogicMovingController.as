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
    private var tickTime:Number = Constants.FRAME_DURATION_IN_MILSEC;
    private var lastTickTime:Number;
    private var tickCouner:Number;

    public function LocalGameLogicMovingController() {
        timer = new Timer(tickTime);
        timer.addEventListener(TimerEvent.TIMER, onTickHandler);
    }

    public function onTickHandler(e:TimerEvent):void {
        var time:Number = new Date().time;
        var timeDelta:Number = time - lastTickTime;
        var tickId:Number = tickCouner++;

        for each (var mover:Mover in movers) {
            var direction:Point = mover.direction;
            if (direction.length > 0) {
                var newPos:Point = new Point();
                var timeMultVal = Constants.ENABLE_SPEED_BASED_ON_CYCLE_TIME ? timeDelta : 1 ;
                newPos.x = mover.position.x + direction.x * Constants.SPEED_KOEF * timeMultVal;
                newPos.y = mover.position.y + direction.y * Constants.SPEED_KOEF * timeMultVal;
                dispatchEvent(new MoverPositionUpdateEvent(MoverPositionUpdateEvent.EVENT_TYPE_UPDATE_POSITION, time, mover.id, newPos, mover.direction))
                mover.position = newPos;
            }
        }

        lastTickTime += timeDelta;
    }
    override public function requestNewMoverDirectionHandler(e:MoverDirectionUpdateEvent):void {
        requestNewMoverDirection(e.moverId, e.newDirection);
    }
    public function requestNewMoverDirection(moverId:Number, newDirection:Point):void {
        //todo async update in the tick
        var mover = getMover(moverId);
        if (!mover) {
            return;
        }

        mover.direction = newDirection
    }

    override public function start():void {
        lastTickTime = new Date().time;
        tickCouner = 0;
        timer.start();
        super.start();
    }


}
}
