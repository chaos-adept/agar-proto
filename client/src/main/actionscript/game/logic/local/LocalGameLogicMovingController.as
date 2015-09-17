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

public class LocalGameLogicMovingController extends EventDispatcher {

    private var timer:Timer;
    private var tickTime:Number = Constants.ABOVE_FRAME_DURATION_IN_MILSEC;
    private var lastTickTime:Number;
    private var speedKoef:Number = 1 / 3;
    private var movers:Dictionary = new Dictionary();

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
    public function requestNewMoverDirectionHandler(e:MoverDirectionUpdateEvent):void {
        requestNewMoverDirection(e.moverId, e.newDirection);
    }
    public function requestNewMoverDirection(moverId:Number, newDirection:Point):void {
        //todo async update in the tick
        getMover(moverId).direction = newDirection
    }

    public function getMover(moverId:Number):Mover {
        return movers[moverId]
    }

    public function start():void {
        lastTickTime = new Date().time;
        timer.start();
    }

    public function addMover(mover:Mover):void {
        movers[mover.id] = mover
    }
}
}
