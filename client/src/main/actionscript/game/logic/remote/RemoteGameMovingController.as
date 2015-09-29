/**
 * Created by Julia on 29.09.2015.
 */
package game.logic.remote {
import event.MoverDirectionUpdateEvent;
import event.MoverEvent;
import event.MoverPositionUpdateEvent;

import game.logic.local.moving.BaseGameMovingController;

public class RemoteGameMovingController extends BaseGameMovingController {

    private var remoteGameServer:RemoteGameServer;

    public function RemoteGameMovingController(remoteGameServer:RemoteGameServer) {
        super();
        this.remoteGameServer = remoteGameServer;
        this.remoteGameServer.addEventListener(MoverPositionUpdateEvent.EVENT_TYPE_UPDATE_POSITION, onRemotePositionUpdatedHandler);
    }

    private function onRemotePositionUpdatedHandler(e:MoverPositionUpdateEvent):void {
        dispatchEvent(e);
    }


    override public function requestNewMoverDirectionHandler(e:MoverDirectionUpdateEvent):void {
        super.requestNewMoverDirectionHandler(e);
        remoteGameServer.updatePlayerDirection(e.tickId, e.newDirection);
    }
}
}
