/**
 * Created by Julia on 16.09.2015.
 */
package utils {
public class Constants {

    public static const TARGET_FRAMES_PER_SEC:Number = 60;
    public static const FRAME_DURATION_IN_MILSEC:Number = 1000 / TARGET_FRAMES_PER_SEC;
    public static const ABOVE_FRAME_DURATION_IN_MILSEC:Number = FRAME_DURATION_IN_MILSEC * 3;

    public function Constants() {
    }
}
}
