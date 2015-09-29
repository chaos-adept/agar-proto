/**
 * Created by Julia on 18.09.2015.
 */
package game.logic.local.moving {
import game.logic.local.*;

import event.MoverDirectionUpdateEvent;
import event.MoverEvent;
import event.MoverPositionUpdateEvent;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class DelayedProxyMovingController extends BaseGameMovingController implements IMoverMovingListener {

    private var target:BaseGameMovingController;
    private var minDelay:Number;
    private var maxDelay:Number;

    public function DelayedProxyMovingController(minDelay:Number, maxDelay:Number, target:BaseGameMovingController) {
        this.target = target;
        this.minDelay = minDelay;
        this.maxDelay = maxDelay;
        this.target.attach(this);
    }


    [cppcall]
    override public function dispatchEvent(targetEvent:Event):Boolean {
        var delay:Number = Math.random() * (maxDelay - minDelay) + minDelay;
        var timer:Timer = new Timer(delay, 1);
        var doDispatchEvent:Function = super.dispatchEvent;
        var timerHandler:Function = function (timerEvent:Event):void {
            doDispatchEvent(targetEvent);
            timer.removeEventListener(TimerEvent.TIMER, timerHandler);
            timer.stop();
        };
        timer.addEventListener(TimerEvent.TIMER, timerHandler);
        timer.start();

        return true;
        //return super.dispatchEvent(event);
    }

    public function onUpdatePositionHandler(e:MoverPositionUpdateEvent):void {
        dispatchEvent(e); //pass event to down stream session manager
    }

    override public function newMoverHandler(e:MoverEvent):void {
        dispatchEvent(e); //pass event to up stream controller
    }

    override public function requestNewMoverDirectionHandler(e:MoverDirectionUpdateEvent):void {
        dispatchEvent(e); //pass event to up stream controller
    }


    override public function start():void {
        target.start();
        super.start();
    }
}
}
