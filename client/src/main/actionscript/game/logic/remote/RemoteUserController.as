/**
 * Created by Julia on 29.09.2015.
 */
package game.logic.remote {
import event.MoverEvent;

import game.logic.local.user.UserController;

public class RemoteUserController extends UserController {
    private var remoteServer:RemoteGameServer;

    public function RemoteUserController(remoteServer:RemoteGameServer) {
        this.remoteServer = remoteServer;
        this.remoteServer.addEventListener(MoverEvent.EVENT_NEW_MOVER, onNewMoverHandler);
    }

    private function onNewMoverHandler(e:MoverEvent):void {
        this.registerMover(e.mover);
    }


    override protected function doLogin(playerName:String, resultHandler:Function):void {
        remoteServer.addEventListener(MoverEvent.PLAYER_LOGGED, function (e:MoverEvent) {
            resultHandler(e.mover);
        });
        remoteServer.login(playerName);

    }
}
}
