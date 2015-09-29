/**
 * Created by Julia on 29.09.2015.
 */
package game.logic {
import game.logic.local.LocalGameLogic;
import game.logic.local.moving.ApproxProxyMovingController;
import game.logic.local.moving.BaseGameMovingController;
import game.logic.local.moving.DelayedProxyMovingController;
import game.logic.local.moving.LocalGameLogicMovingController;
import game.logic.local.user.UserController;
import game.logic.remote.RemoteGameLogic;

import utils.Constants;

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
            var localMoverController:BaseGameMovingController = new LocalGameLogicMovingController(Constants.REMOTE_TICK_TIME_MILSEC);
            var movingController:BaseGameMovingController = !Constants.LOCAL_GAME_IS_DELAYED_CONTROLLER ? localMoverController :
                    new ApproxProxyMovingController(
                            new DelayedProxyMovingController(
                                    Constants.POSITION_EVENT_PROXY_MIN_DELAY,
                                    Constants.POSITION_EVENT_PROXY_MAX_DELAY, localMoverController),
                            Constants.LOCAL_TICK_TIME_MILSEC
                    );
            return new LocalGameLogic(new UserController(), movingController);
        }
    }
}
}
