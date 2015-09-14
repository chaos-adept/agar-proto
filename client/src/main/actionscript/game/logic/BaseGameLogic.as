/**
 * Created by Julia on 14.09.2015.
 */
package game.logic {
import flash.events.EventDispatcher;

public class BaseGameLogic extends EventDispatcher {

    public var playerName:String;

    public function start(playerName:String):void {
        this.playerName = playerName
    }
}

}
