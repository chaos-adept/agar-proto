/**
 * Created by Julia on 18.09.2015.
 */
package game.logic.local.moving {
import event.MoverPositionUpdateEvent;

import flash.events.IEventDispatcher;

public interface IMoverMovingListener extends IEventDispatcher {
    function onUpdatePositionHandler(e:MoverPositionUpdateEvent):void;
}
}
