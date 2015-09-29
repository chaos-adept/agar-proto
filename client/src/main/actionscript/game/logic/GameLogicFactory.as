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
import game.logic.remote.RemoteGameMovingController;
import game.logic.remote.RemoteGameServer;
import game.logic.remote.RemoteUserController;

import utils.Constants;

public class GameLogicFactory {

    public var isRemote:Boolean = Constants.IS_REMOTE_SERVER;
    public var server:String = Constants.REMOTE_SERVER_HOST;
    public var port:int = Constants.REMOTE_SERVER_PORT;

    public function GameLogicFactory() {
    }

    public function create():BaseGameLogic {
        if (isRemote) {
            var remoteGameServer:RemoteGameServer = new RemoteGameServer(server, port);
            var remoteUserCtrl:UserController = new RemoteUserController(remoteGameServer);
            var remoteMovingCtrl:BaseGameMovingController = new ApproxProxyMovingController(
                                                        new RemoteGameMovingController(remoteGameServer),
                                                        Constants.FRAME_DURATION_IN_MILSEC);

            return new LocalGameLogic(remoteUserCtrl, remoteMovingCtrl);
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
