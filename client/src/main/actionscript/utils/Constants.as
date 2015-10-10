/**
 * Created by Julia on 16.09.2015.
 */
package utils {
public class Constants {

    public static const IS_REMOTE_SERVER:Boolean = false;
//    public static const REMOTE_SERVER_HOST:String = "localhost";
    public static const REMOTE_SERVER_HOST:String = "176.112.192.126";
    public static const REMOTE_SERVER_PORT:int = 9999;

    public static const MAX_DRAW_POSITION_HISTORY:Number = 50;
    public static const MAX_REMOTE_POSITION_HISTORY:Number = MAX_DRAW_POSITION_HISTORY / 2;
    public static const RENDER_DELAY:Number = 50;
    public static const TARGET_FRAMES_PER_SEC:Number = 60;
    public static const FRAME_DURATION_IN_MILSEC:Number = 1000 / TARGET_FRAMES_PER_SEC;
    public static const POSITION_EVENT_PROXY_MIN_DELAY:Number = 80;
    public static const POSITION_EVENT_PROXY_MAX_DELAY:Number = 150;
    public static const ENABLE_SPEED_BASED_ON_CYCLE_TIME:Boolean = true;
    public static const ENABLE_DEBUG_DRAW:Boolean = true;
    public static const SPEED_KOEF:Number = 1 / 2;

    public static const LOCAL_GAME_IS_DELAYED_CONTROLLER:Boolean = true;

    public static const LOCAL_TICK_TIME_MILSEC:Number = FRAME_DURATION_IN_MILSEC;
    public static const REMOTE_TICK_TIME_MILSEC:Number = LOCAL_TICK_TIME_MILSEC * 3;

    public function Constants() {
    }
}
}
