/**
 * Created by Julia on 13.09.2015.
 */
package {
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.geom.Point;

public class PlayerInputController {
    private var player:Mover;

    public function PlayerInputController(player:Mover) {
        this.player = player;
    }

    public function updateDirection(newDirection:Point):void {
        player.direction = newDirection;
    }
}
}
