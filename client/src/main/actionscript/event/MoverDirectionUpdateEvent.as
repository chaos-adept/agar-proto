/**
 * Created by Julia on 16.09.2015.
 */
package event {
import flash.events.Event;
import flash.geom.Point;

public class MoverDirectionUpdateEvent extends Event {

    public static const EVENT_TYPE_UPDATE_DIRECTION:String = "EVENT_TYPE_UPDATE_DIRECTION";

    public var tickId:Number;
    public var moverId:Number;
    public var newDirection:Point;

    public static const EMPTY_TICK_ID:Number = -1;

    public function get isTickIdUnknown():Boolean {
        return tickId == EMPTY_TICK_ID;
    }

    public function MoverDirectionUpdateEvent(tickId:Number, moverId:Number, newDirection:Point) {
        super(EVENT_TYPE_UPDATE_DIRECTION);
        this.tickId = tickId;
        this.moverId = moverId;
        this.newDirection = newDirection;
    }

    override public function clone():Event {
        return new MoverDirectionUpdateEvent(tickId, moverId, newDirection);
    }
}
}
