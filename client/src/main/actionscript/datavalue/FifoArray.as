/**
 * Created by Julia on 10.10.2015.
 */
package datavalue {
public class FifoArray {

    public var items:Array;
    private var maxSize:uint;

    public function FifoArray(maxSize:uint) {
        this.maxSize = maxSize;
        this.items = [];
    }

    public function push(item:*):void {
        if (items.length == maxSize) {
            items.shift();
        }
        items.push(item)
    }

    public function get last():* {
        if (items.length == 0) {
            return null;
        } else {
            return items[items.length-1]
        }

    }

    public function get length():Number {
        return Math.min(items.length, maxSize);
    }

    public function getAgo(prevNum:Number):WorldHistoryItem {
        return items[items.length - prevNum - 1];
    }
}
}
