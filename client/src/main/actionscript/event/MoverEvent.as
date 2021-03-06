/**
 * Created by Julia on 14.09.2015.
 */
package event {
import datavalue.Mover;

import flash.events.Event;

public class MoverEvent extends Event {
    public static const EVENT_NEW_MOVER:String = "join";
    public static const PLAYER_LOGGED:String = "logged";

    public var mover:Mover;


    public function MoverEvent(eventType:String, mover:Mover) {
        super(eventType);
        this.mover = mover;
    }


    override public function clone():Event {
        return new MoverEvent(type, mover);
    }
}
}
