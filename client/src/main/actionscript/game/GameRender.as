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

        if (moverHistory.movers.length > 1) {


            for ( var indx:Number = 1; indx < moverHistory.movers.length-1; indx++ ) {
                var alpha:Number = (indx/maxHistory)
                this.graphics.lineStyle(1, mover.color, alpha );
                this.graphics.moveTo(moverHistory.movers[indx-1].position.x, moverHistory.movers[indx-1].position.y);
                this.graphics.lineTo(moverHistory.movers[indx].position.x, moverHistory.movers[indx].position.y);

                this.graphics.drawCircle(moverHistory.movers[indx].position.x, moverHistory.movers[indx].position.y, 3);
                this.graphics.lineStyle(1, ~mover.color, alpha);
                this.graphics.lineTo(moverHistory.movers[indx].position.x + moverHistory.movers[indx].direction.x, moverHistory.movers[indx].position.y + moverHistory.movers[indx].direction.y);
                this.graphics.lineTo(moverHistory.movers[indx].position.x + moverHistory.movers[indx].direction.x * directionSize, moverHistory.movers[indx].position.y + moverHistory.movers[indx].direction.y * directionSize);
            }
        }

        this.graphics.lineStyle(1, mover.color);
        this.graphics.drawCircle(mover.position.x, mover.position.y, 3);

        this.graphics.lineTo(mover.position.x + mover.direction.x, mover.position.y + mover.direction.y);
        this.graphics.lineTo(mover.position.x + mover.direction.x * directionSize, mover.position.y + mover.direction.y * directionSize);

        mover.view.x = mover.position.x;
        mover.view.y = mover.position.y;
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

class MoverHistory {
    public var movers:Array = [];

    public var maxSize:Number;

    public function MoverHistory(maxSize:Number) {
        this.maxSize = maxSize;
    }

    public function add(m:Mover):void {
        if (movers.length == maxSize) {
            movers.shift();
        }
        movers.push(m.clone())
    }
}
