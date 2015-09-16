/**
 * Created by Julia on 16.09.2015.
 */
package event {
import com.awar.ags.api.base.Event;

import flash.geom.Point;

public class MoverDirectionUpdateEvent extends Event {

    public static const EVENT_TYPE_UPDATE:String = "EVENT_TYPE_UPDATE";

    public var moverId:Number;
    public var newDirection:Point;

    public function MoverDirectionUpdateEvent(moverId:Number, newDirection:Point) {
        super(EVENT_TYPE_UPDATE);
        this.moverId = moverId;
        this.newDirection = newDirection;
    }
}
}
