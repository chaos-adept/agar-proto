/**
 * Created by Julia on 27.09.2015.
 */
package datavalue {
public class MoverHistory {
    public var historyItems:Array = [];

    public var maxSize:Number;

    public function MoverHistory(maxSize:Number) {
        this.maxSize = maxSize;
    }

    public function get last():MoverHistoryItem {
        if (historyItems.length == 0) {
            return null;
        } else {
            return historyItems[historyItems.length-1]
        }

    }

    public function add(m:Mover, tickId:Number):void {
        if (historyItems.length == maxSize) {
            historyItems.shift();
        }

        var item:MoverHistoryItem = new MoverHistoryItem();
        item.moverCopy = m.clone();
        item.time = new Date().time;
        item.tickId = tickId;
        historyItems.push(item);
    }

    public function findAgoMilSec(milSec:int):Mover {
        var minTime:Number = new Date().time - milSec;
        for (var indx:Number = historyItems.length - 1; indx > 0; indx--) {
            if (historyItems[indx].time < minTime) {
                return historyItems[indx].moverCopy
            }
        }

        return null;
    }

    public function clone():MoverHistory {
        var mh:MoverHistory = new MoverHistory(maxSize);
        mh.historyItems = new Array().concat(mh.historyItems)
        return mh;
    }
}
}
