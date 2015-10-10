/**
 * Created by Julia on 27.09.2015.
 */
package datavalue {
public class MoverHistory {

    private var dataContainer:FifoArray;

    public function get historyItems():Array {
        return dataContainer.items;
    }

    public function MoverHistory(maxSize:Number) {
        dataContainer = new FifoArray(maxSize)
    }

    public function get last():MoverHistoryItem {
        return dataContainer.last
    }

    public function add(m:Mover, tickId:Number):void {
        var item:MoverHistoryItem = new MoverHistoryItem();
        item.moverCopy = m.clone();
        item.time = new Date().time;
        item.tickId = tickId;
        dataContainer.push(item);
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
}
}
