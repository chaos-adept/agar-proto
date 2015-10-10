/**
 * Created by Julia on 16.09.2015.
 */
package game.logic.local.moving {
import datavalue.FifoArray;
import datavalue.Mover;
import datavalue.WorldHistoryItem;

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
    private var worldHistories:FifoArray = new FifoArray(Constants.MAX_REMOTE_POSITION_HISTORY);


    public function LocalGameLogicMovingController(tickTime:Number) {
        timer = new Timer(tickTime);
        timer.addEventListener(TimerEvent.TIMER, onTickHandler);
    }

    public function onTickHandler(e:TimerEvent):void {
        var time:Number = new Date().time;
        var timeDelta:Number = time - lastTickTime;
        timeDelta = getCorrectedTimeDelta(timeDelta);

        var tickId:Number = tickCouner++;

        //update positions
        updateMoverPositions(tickId, timeDelta);

        //make world copy
        var worldHistoryItem = new WorldHistoryItem(this.movers, this.remoteMoverTicks);
        worldHistories.push(worldHistoryItem);


        //send update
        for each (var mover:Mover in movers) {
            dispatchEvent(new MoverPositionUpdateEvent(MoverPositionUpdateEvent.EVENT_TYPE_UPDATE_POSITION,
                    tickId, mover.id, mover.position, mover.direction));
        }

        lastTickTime += timeDelta;


    }

    private function updateMoverPositions(tickId:Number, timeDelta:Number):void {
        for each (var mover:Mover in movers) {
            //reCalcMoverPosition
            var newPos:Point = calcNewMoverPosition(mover, timeDelta);
            mover.position = newPos;
        }
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
