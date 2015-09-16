package
{
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Vector3D;

/**
 * ...
 * @author Asfel
 */
public class InterpolationTest extends Sprite
{
    private var endPoint:Point = new Point();
    private var startPoint:Point = new Point();

    public function InterpolationTest()
    {
        super();

        startPoint.setTo(stage.stageWidth / 2, stage.stageHeight / 2);
        endPoint.setTo(stage.stageWidth / 2, stage.stageHeight / 2);

        stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        stage.addEventListener(Event.ENTER_FRAME, onUpdate);

        abs = Math.abs;
    }

    private function onMouseDown(e:Event):void
    {
        endPoint.setTo(mouseX, mouseY);
        this.graphics.clear();
    }

    private var speed:Number = 10;
    private var deltaCalculator:Vector3D = new Vector3D();

    private function onUpdate(e:Event):void
    {
        this.graphics.lineStyle(2, 0x0000FF, 0.8);
        this.graphics.drawCircle(endPoint.x, endPoint.y, 4);

        this.graphics.lineStyle(2, 0xFF0000, 0.8);
        this.graphics.drawCircle(startPoint.x, startPoint.y, 4);

        this.graphics.moveTo(startPoint.x, startPoint.y);

        var addX:Number = 0;
        var addY:Number = 0

        for (var i:int = 0; i < 10000; i++)
        {
            var deltaX:Number = (endPoint.x - startPoint.x);
            var deltaY:Number = (endPoint.y - startPoint.y);

            var length:Number = (deltaX * deltaX) + (deltaY * deltaY) + (1);
            length = Math.sqrt(length);

            addX = interpolate(deltaX, speed, length);
            addY = interpolate(deltaY, speed, length);
        }

        if (endPoint.x != startPoint.x)
            startPoint.x += addX

        if (endPoint.y != startPoint.y)
            startPoint.y += addY

        this.graphics.lineTo(startPoint.x, startPoint.y);

    }

    public static var abs:Function;

    public static function interpolate(delta:Number, interpolationFactor:Number, length:Number):Number
    {
        var add:Number = interpolationFactor * delta / length;

        if (Math.abs(add) > Math.abs(delta))
            return delta;

        return add;
    }

}

}