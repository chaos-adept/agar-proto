/**
 * Created by Julia on 16.09.2015.
 */
package utils {
public class Constants {

    public static const TARGET_FRAMES_PER_SEC:Number = 60;
    public static const FRAME_DURATION_IN_MILSEC:Number = 1000 / TARGET_FRAMES_PER_SEC;
    public static const POSITION_EVENT_PROXY_DELAY:Number = 500;
    public static const ENABLE_SPEED_BASED_ON_CYCLE_TIME:Boolean = true;
    public static const SPEED_KOEF:Number = 1 / 2;

    public function Constants() {
    }
}
}
