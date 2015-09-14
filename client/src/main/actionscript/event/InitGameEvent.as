/**
 * Created by Julia on 14.09.2015.
 */
package event {
import flash.events.Event;

public class InitGameEvent extends Event {

    public static const EVENT_INITALIZATION_COMPLETED:String = "EVENT_INITALIZATION_COMPLETED";

    public function InitGameEvent() {
        super(EVENT_INITALIZATION_COMPLETED);
    }
}
}
