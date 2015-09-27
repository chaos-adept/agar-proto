/**
 * Created by Julia on 13.09.2015.
 */
package game {
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.Dictionary;

import utils.Constants;

public class GameRender extends Sprite {

    private var movers:Array = [];
    private var moverHistories:Dictionary = new Dictionary();


    public function GameRender() {
        this.addEventListener(Event.ENTER_FRAME, render)
    }

    public function render(e:Event):void {
        movers.forEach(function (mover:Mover, indx:Number, arr:Array):void {
            updateMover(mover);
        }, this);
    }

    private function updateMover(mover:Mover):void {
        this.graphics.clear();

        var directionSize:Number = 20;
        var maxHistory:Number = Constants.MAX_DRAW_POSITION_HISTORY;

        var moverHistory:MoverHistory = moverHistories[mover.id];
        if ( !moverHistory ) {
            moverHistory = new MoverHistory(maxHistory);
            moverHistories[mover.id] = moverHistory
        }
        moverHistory.add(mover);

        if (moverHistory.historyItems.length > 1 && Constants.ENABLE_DEBUG_DRAW) {
            for ( var indx:Number = 1; indx < moverHistory.historyItems.length-1; indx++ ) {
                var alpha:Number = (indx/maxHistory);
                var prevState:Mover = moverHistory.historyItems[indx-1].moverCopy;
                var nextState:Mover = moverHistory.historyItems[indx].moverCopy;
                this.graphics.lineStyle(1, mover.color, alpha );
                this.graphics.moveTo(prevState.position.x, prevState.position.y);
                this.graphics.lineTo(nextState.position.x, nextState.position.y);

                this.graphics.drawCircle(nextState.position.x, nextState.position.y, 3);
                this.graphics.lineStyle(1, ~nextState.color, alpha);
                this.graphics.lineTo(nextState.position.x + nextState.direction.x, nextState.position.y + nextState.direction.y);
                this.graphics.lineTo(nextState.position.x + nextState.direction.x * directionSize, nextState.position.y + nextState.direction.y * directionSize);
            }
        }
        var drawMover:Mover = moverHistory.findAgoMilSec(Constants.RENDER_DELAY);
        if (drawMover) {
            this.graphics.lineStyle(1, drawMover.color);
            this.graphics.drawCircle(drawMover.position.x, drawMover.position.y, 3);

            this.graphics.lineTo(drawMover.position.x + drawMover.direction.x, drawMover.position.y + drawMover.direction.y);
            this.graphics.lineTo(drawMover.position.x + drawMover.direction.x * directionSize, drawMover.position.y + drawMover.direction.y * directionSize);

            drawMover.view.x = drawMover.position.x;
            drawMover.view.y = drawMover.position.y;
        }
    }

    public function bindView(mover:Mover):void {
        mover.color = 0xBBBBBB + Math.random() * 0xFFFFFF;
        var view:Sprite = new Sprite();
        view.graphics.beginFill(mover.color);
        view.graphics.drawCircle(0, 0, 10);
        view.graphics.endFill();
        mover.view = view;
        this.addChild(view);
        movers.push(mover)
    }
}

}

class MoverHistoryItem {
    public var time:Number;
    public var moverCopy:Mover;
}

class MoverHistory {
    public var historyItems:Array = [];

    public var maxSize:Number;

    public function MoverHistory(maxSize:Number) {
        this.maxSize = maxSize;
    }

    public function add(m:Mover):void {
        if (historyItems.length == maxSize) {
            historyItems.shift();
        }

        var item:MoverHistoryItem = new MoverHistoryItem();
        item.moverCopy = m.clone();
        item.time = new Date().time;
        historyItems.push(item);
    }

    public function findAgoMilSec(milSec:int):Mover {
        var minTime:Number = new Date().time - milSec;
        for (var indx:Number = historyItems.length-1; indx > 0; indx--) {
            if (historyItems[indx].time < minTime) {
                return historyItems[indx].moverCopy
            }
        }

        return null;
    }
}
