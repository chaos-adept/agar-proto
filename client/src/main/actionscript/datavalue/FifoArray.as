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

    public function get last():MoverHistoryItem {
        if (items.length == 0) {
            return null;
        } else {
            return items[items.length-1]
        }

    }
}
}
