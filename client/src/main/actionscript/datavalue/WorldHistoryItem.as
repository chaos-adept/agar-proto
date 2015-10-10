/**
 * Created by Julia on 10.10.2015.
 */
package datavalue {
import flash.utils.Dictionary;

public class WorldHistoryItem {

    public var movers:Dictionary;
    public var remoteTicks:Dictionary;

    public function WorldHistoryItem(targetMovers:Dictionary, targetRemoteTicks:Dictionary) {
        this.movers = new Dictionary();
        this.remoteTicks = new Dictionary();
        assignMovers(targetMovers);
        assignTicks(targetRemoteTicks);
    }

    public function assignMovers(targetMovers:Dictionary) {
        for (var moverId in targetMovers) {
            movers[moverId] = targetMovers[moverId].clone()
        }
    }

    public function assignTicks(remoteTicks:Dictionary):void {
        for (var moverId in remoteTicks) {
            this.remoteTicks[moverId] = remoteTicks[moverId]
        }
    }
}
}
