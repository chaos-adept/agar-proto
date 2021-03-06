/**
 * Created by Julia on 16.09.2015.
 */
package event {
import flash.events.Event;
import flash.geom.Point;

public class MoverPositionUpdateEvent extends Event {
    public static const EVENT_TYPE_UPDATE_POSITION:String = "EVENT_TYPE_UPDATE_POSITION";

    public var tickId:Number;
    public var moverId:Number;
    public var newPosition:Point;
    public var newDirection:Point;

    public function MoverPositionUpdateEvent(type:String, tickId:Number, moverId:Number, newPos:Point, newDirection:Point) {
        super(type);
        this.tickId = tickId;
        this.moverId = moverId;
        this.newDirection = newDirection;
        this.newPosition = newPos;
    }


    override public function clone():Event {
        return new MoverPositionUpdateEvent(type, tickId, moverId, newPosition, newDirection);
    }
}
}
