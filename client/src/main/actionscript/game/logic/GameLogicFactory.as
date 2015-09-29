/**
 * Created by Julia on 29.09.2015.
 */
package game.logic {
import game.logic.local.LocalGameLogic;
import game.logic.remote.RemoteGameLogic;

public class GameLogicFactory {

    public var isRemote:Boolean = false;
    public var server:String = "176.112.192.126";
    public var port:int = 9999;

    public function GameLogicFactory() {
    }

    public function create():BaseGameLogic {
        if (isRemote) {
            return new RemoteGameLogic(server, port)
        } else {
            return new LocalGameLogic();
        }
    }
}
}
