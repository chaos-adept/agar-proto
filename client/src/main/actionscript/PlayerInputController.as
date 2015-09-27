/**
 * Created by Julia on 13.09.2015.
 */
package {
import datavalue.Mover;

import event.MoverDirectionUpdateEvent;

import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.geom.Point;

public class PlayerInputController extends EventDispatcher{
    private var player:Mover;

    public function PlayerInputController(player:Mover) {
        this.player = player;
    }

    public function updateDirectionByMouse(stageMousePos:Point):void {
        //player.direction = newDirection;
        var direction:Point = new Point(stageMousePos.x - player.position.x, stageMousePos.y - player.position.y);
        var norm:Point = new Point(direction.x / direction.length, direction.y / direction.length);
        dispatchEvent(new MoverDirectionUpdateEvent(MoverDirectionUpdateEvent.EMPTY_TICK_ID, player.id, norm));
    }
}
}
