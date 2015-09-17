/**
 * Created by Julia on 18.09.2015.
 */
package game.logic.local {
import event.MoverPositionUpdateEvent;

import flash.events.IEventDispatcher;

public interface IUserSessionManager extends IEventDispatcher {
    function onUpdatePositionHandler(e:MoverPositionUpdateEvent):void;
}
}
