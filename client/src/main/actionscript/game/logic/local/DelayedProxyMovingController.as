/**
 * Created by Julia on 18.09.2015.
 */
package game.logic.local {
import event.MoverDirectionUpdateEvent;
import event.MoverEvent;
import event.MoverPositionUpdateEvent;

public class DelayedProxyMovingController extends BaseGameMovingController implements IUserSessionManager {

    private var target:BaseGameMovingController;

    public function DelayedProxyMovingController(target:BaseGameMovingController) {
        this.target = target;
        this.target.attach(this);
    }

    public function onUpdatePositionHandler(e:MoverPositionUpdateEvent):void {
        dispatchEvent(e); //pass event to down stream session manager
    }

    override public function newMoverHandler(e:MoverEvent):void {
        dispatchEvent(e); //pass event to up stream controller
    }

    override public function requestNewMoverDirectionHandler(e:MoverDirectionUpdateEvent):void {
        trace(e.newDirection);
        dispatchEvent(e); //pass event to up stream controller
    }


    override public function start():void {
        target.start();
        super.start();
    }
}
}
