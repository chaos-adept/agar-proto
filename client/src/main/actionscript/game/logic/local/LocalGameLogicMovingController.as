/**
 * Created by Julia on 16.09.2015.
 */
package game.logic.local {
import datavalue.Mover;

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
    private var lastTickTime:Number;
    private var tickCouner:Number;
    private var remoteMoverTicks:Dictionary = new Dictionary();

    public function LocalGameLogicMovingController(tickTime:Number) {
        timer = new Timer(tickTime);
        timer.addEventListener(TimerEvent.TIMER, onTickHandler);
    }

    public function onTickHandler(e:TimerEvent):void {
        var time:Number = new Date().time;
        var timeDelta:Number = time - lastTickTime;
        var tickId:Number = tickCouner++;

        for each (var mover:Mover in movers) {
            //reCalcMoverPosition
            trace(this + ": " + mover.position + " " + mover.direction );
            var newPos:Point = calcNewMoverPosition(mover, getCorrectedTimeDelta(timeDelta));
            dispatchEvent(new MoverPositionUpdateEvent(MoverPositionUpdateEvent.EVENT_TYPE_UPDATE_POSITION, tickId, mover.id, newPos, mover.direction))
            mover.position = newPos;
        }

        lastTickTime += timeDelta;
    }

    protected function getCorrectedTimeDelta(timeDelta:Number):Number {
        return Constants.ENABLE_SPEED_BASED_ON_CYCLE_TIME ? timeDelta : 1 ;
    }

    protected function calcNewMoverPosition(mover:Mover, timeDelta:Number):Point {
        var direction:Point = mover.direction;
        var newPos:Point =  new Point();
        var timeMultVal =  timeDelta;
        newPos.x = mover.position.x + direction.x * Constants.SPEED_KOEF * timeMultVal;
        newPos.y = mover.position.y + direction.y * Constants.SPEED_KOEF * timeMultVal;
        return newPos;
    }


    override public function requestNewMoverDirectionHandler(e:MoverDirectionUpdateEvent):void {
        var lastMoverLocalTick = remoteMoverTicks[e.moverId];
        if (lastMoverLocalTick > e.tickId) {
            return;
        }
        remoteMoverTicks[e.moverId] = e.tickId;
        requestNewMoverDirection(e.moverId, e.newDirection);
    }
    public function requestNewMoverDirection(moverId:Number, newDirection:Point):void {
        //todo async update in the tick
        var mover:Mover = getMover(moverId);
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
