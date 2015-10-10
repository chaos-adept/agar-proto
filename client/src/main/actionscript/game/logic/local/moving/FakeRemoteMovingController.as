/**
 * Created by Julia on 10.10.2015.
 */
package game.logic.local.moving {
import datavalue.Mover;
import datavalue.WorldHistoryItem;

public class FakeRemoteMovingController extends BasicGameLogicMovingController {
    public function FakeRemoteMovingController(tickTime:Number) {
        super(tickTime);
    }


    override public function updateMoverPositions(tickId:Number, timeDelta:Number):void {
        var lastHistory:WorldHistoryItem = worldHistories.last;

        for each (var mover:Mover in movers) {
            //check that we calculated correct positions for a mover
            //find first unsync
            var currentRemoteTickId:Number = remoteMoverTicks[mover.id];
            if (lastHistory) {
                var lastProcessedRemoteTickId:Number = lastHistory.remoteTicks[mover.id];
                trace(tickId + " " + currentRemoteTickId + " " + lastProcessedRemoteTickId);
            }

            var unsyncStatesNum = tickId - currentRemoteTickId - 1; //-1 because tickId is always for uncalc iteration
            if (unsyncStatesNum > 0) {
                //correct current position according to history
                var unSyncTime:Number = 0;
                var lastSyncHistory:WorldHistoryItem = worldHistories.getAgo(unsyncStatesNum);
                var lastSyncState:Mover = lastSyncHistory.movers[mover.id];
                for (var indx:Number = worldHistories.length-unsyncStatesNum-1; indx < worldHistories.length-1; indx++) {
                    unSyncTime += worldHistories.items[indx].deltaTime;
                }
                mover.position = newLinearPosition(lastSyncState.direction, lastSyncState.position, unSyncTime)
            }
                mover.position = calcNewMoverPosition(mover, timeDelta);



//            var countUnSyncHistories:int = 0;
//
//            //recalc mover positions from last unsync history state
//            for (var unSyncHistIndx:Number = worldHistories.length - countUnSyncHistories;
//                    unSyncHistIndx < worldHistories.length-1;
//                    unSyncHistIndx++) {
//
//            }



        }
    }
}
}
