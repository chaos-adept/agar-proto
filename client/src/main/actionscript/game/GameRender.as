/**
 * Created by Julia on 13.09.2015.
import datavalue.MoverHistory;
import datavalue.MoverHistoryItem;
 */
package game {
import datavalue.Mover;
import datavalue.MoverHistory;

import event.MoverPositionUpdateEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.utils.Dictionary;

import utils.Constants;

public class GameRender extends Sprite {

    private var movers:Dictionary = new Dictionary();
    private var moverHistories:Dictionary = new Dictionary();
    private var directionSize:Number = 10;

    public function GameRender() {
        this.addEventListener(Event.ENTER_FRAME, render)
    }

    public function render(e:Event):void {
        this.graphics.clear();

        for each (var mover:Mover in movers) {
            renderMover(mover);

            if (Constants.ENABLE_DEBUG_DRAW) {
                drawHistory(moverHistories[mover.id], mover.color, 10, true);
                drawHistory(mover.moverDebugInfo.approx_parent_mover_history, ~mover.color, 10, true);
            }
        }
    }

    private function renderMover(mover:Mover):void {

        var moverHistory:MoverHistory = moverHistories[mover.id];
        if (!moverHistory) {
            return;
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

    private function drawHistory(moverHistory:MoverHistory, color:Number, pointSize:Number, drawLine:Boolean):void {
        if (!moverHistory) {
            return
        }

        if (Constants.ENABLE_DEBUG_DRAW && moverHistory.historyItems.length > 1) {
            for ( var indx:Number = 1; indx < moverHistory.historyItems.length-1; indx++ ) {
                var alpha:Number = 1 + (indx / Constants.MAX_DRAW_POSITION_HISTORY);
                var prevState:Mover = moverHistory.historyItems[indx-1].moverCopy;
                var nextState:Mover = moverHistory.historyItems[indx].moverCopy;
                if (drawLine) {
                    this.graphics.lineStyle(1, color, alpha );
                    this.graphics.moveTo(prevState.position.x, prevState.position.y);
                    this.graphics.lineTo(nextState.position.x, nextState.position.y);
                }

                this.graphics.lineStyle(1, color, alpha );
                this.graphics.drawCircle(nextState.position.x, nextState.position.y, pointSize);

                if (drawLine) {
                    this.graphics.lineStyle(1, color, alpha/2);
                    this.graphics.lineTo(nextState.position.x + nextState.direction.x, nextState.position.y + nextState.direction.y);
                    this.graphics.lineTo(nextState.position.x + nextState.direction.x * directionSize, nextState.position.y + nextState.direction.y * directionSize);
                }

            }
        }
    }

    public function bindView(mover:Mover):void {
        mover.color = 0x111111 + Math.random() * 0xFFFFFF;
        var view:Sprite = new Sprite();
        view.graphics.beginFill(mover.color);
        view.graphics.drawCircle(0, 0, 10);
        view.graphics.endFill();
        mover.view = view;
        this.addChild(view);
        movers[mover.id] = mover
    }

    public function updateMoverPositionHandler(e:MoverPositionUpdateEvent):void {
        var mover:Mover = movers[e.moverId];
        mover.position = e.newPosition;
        mover.direction = e.newDirection;

        var moverHistory:MoverHistory = moverHistories[mover.id];
        if ( !moverHistory ) {
            moverHistory = new MoverHistory(Constants.MAX_DRAW_POSITION_HISTORY);
            moverHistories[mover.id] = moverHistory
        }
        moverHistory.add(mover, e.tickId);

    }
}

}