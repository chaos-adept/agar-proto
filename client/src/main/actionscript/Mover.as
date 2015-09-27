/**
 * Created by Julia on 13.09.2015.
 */
package {
import flash.display.Sprite;
import flash.geom.Point;

public class Mover {
    public var id:Number;
    public var color:Number;
    public var direction:Point;
    public var position:Point;
    public var view:Sprite;

    public function Mover() {

    }


    public function clone():Mover {
        var m:Mover = new Mover();
        m.color = this.color;
        m.direction = this.direction.clone();
        m.position = this.position.clone();
        m.id = this.id;
        m.view = this.view;
        return m;
    }
}
}
