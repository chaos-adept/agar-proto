/**
 * Created by Julia on 13.09.2015.
 */
package game {
import flash.display.Sprite;
import flash.events.Event;

public class GameRender extends Sprite {

    private var movers:Array = [];

    public function GameRender() {
        this.addEventListener(Event.ENTER_FRAME, render)
    }

    public function render(e:Event):void {
        movers.forEach(function (mover:Mover, indx:Number, arr:Array):void {
            updateMover(mover);
        }, this);
    }

    private function updateMover(mover:Mover):void {
        this.graphics.moveTo(mover.view.x, mover.view.y);
        this.graphics.lineStyle(1, mover.color);
        this.graphics.lineTo(mover.position.x, mover.position.y);

        mover.view.x = mover.position.x;
        mover.view.y = mover.position.y;
    }

    public function bindView(mover:Mover):void {
        mover.color = Math.random() * 0xFFFFFF;
        var view:Sprite = new Sprite();
        view.graphics.beginFill(mover.color);
        view.graphics.drawCircle(0, 0, 5);
        view.graphics.endFill();
        mover.view = view;
        this.addChild(view);
        movers.push(mover)
    }
}
}
