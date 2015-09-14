/**
 * Created by Julia on 14.09.2015.
 */
package game.logic {
import event.InitGameEvent;
import event.MoverEvent;

import flash.events.GameInputEvent;
import flash.geom.Point;

public class RemoteGameLogic extends BaseGameLogic {

    private var server:String;
    private var port:int;

    public function RemoteGameLogic(server:String, port:int) {
        this.server = server;
        this.port = port;
    }


    override public function start(playerName:String):void {
        var mover:Mover = new Mover();
        mover.direction = new Point();
        mover.position = new Point();

        dispatchEvent(new MoverEvent(MoverEvent.EVENT_NEW_MOVER, mover));
        dispatchEvent(new MoverEvent(MoverEvent.PLAYER_LOGGED, mover));

        super.start(playerName);
    }
}
}
