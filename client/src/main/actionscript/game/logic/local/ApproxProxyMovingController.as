/**
 * Created by Julia on 27.09.2015.
 */
package game.logic.local {
import datavalue.Mover;
import datavalue.MoverHistory;
import datavalue.MoverHistoryItem;

import event.MoverDirectionUpdateEvent;
import event.MoverEvent;
import event.MoverPositionUpdateEvent;

import flash.geom.Point;

import flash.utils.Dictionary;

import utils.Constants;

public class ApproxProxyMovingController extends LocalGameLogicMovingController implements IUserSessionManager {

    public var parent:BaseGameMovingController;
    private var moverHistories:Dictionary = new Dictionary();
    private var maxHistory:Number = Constants.MAX_DRAW_POSITION_HISTORY;



    public function ApproxProxyMovingController(parent:BaseGameMovingController) {
        this.parent = parent;
        this.parent.attach(this)
    }

    override protected function calcNewMoverPosition(mover:Mover, timeDelta:Number):Point {
        var history:MoverHistory = getParentHistory(mover.id);
        if (!(history && history.historyItems.length > 1)) {
            return mover.position;
        }

        var p1:MoverHistoryItem = history.historyItems[history.historyItems.length-2];
        var p2:MoverHistoryItem = history.historyItems[history.historyItems.length-1];
        var possibleMovingDir:Point = p2.moverCopy.position.subtract(p1.moverCopy.position);

        trace("possible moving dir " + possibleMovingDir , p1.moverCopy.position, p2.moverCopy.position);
        if (possibleMovingDir.length == 0) {
            return mover.position;
        }

        var norm:Point = new Point(possibleMovingDir.x / possibleMovingDir.length, possibleMovingDir.y / possibleMovingDir.length);
        var newPos:Point = new Point();
        newPos.x = mover.position.x + norm.x * Constants.SPEED_KOEF * timeDelta;
        newPos.y = mover.position.y + norm.y * Constants.SPEED_KOEF * timeDelta;
        return newPos;
    }

    public function onUpdatePositionHandler(e:MoverPositionUpdateEvent):void {
        var moverHistory:MoverHistory = getParentHistory(e.moverId);
        if ( !moverHistory ) {

        } else {
            if (moverHistory.last && (moverHistory.last.tickId > e.tickId)) {
                return; //ignore missed
            }
        }

        var mover:Mover = getMover(e.moverId).clone();
        mover.position = e.newPosition;
        mover.direction = e.newDirection;
        moverHistory.add(mover, e.tickId);
    }

    public function getParentHistory(moverId:int):MoverHistory {
        var moverHistory:MoverHistory = moverHistories[moverId];
        if (!moverHistory) {
            moverHistory = new MoverHistory(maxHistory);
            moverHistories[moverId] = moverHistory;
            getMover(moverId).moverDebugInfo.approx_parent_mover_history = moverHistory;
        }
        return moverHistories[moverId]
    }

    override public function requestNewMoverDirectionHandler(e:MoverDirectionUpdateEvent):void {
        var parentEvent:MoverDirectionUpdateEvent = MoverDirectionUpdateEvent(e.clone());
        var lastParentState:MoverHistory = getParentHistory(e.moverId);

        if (lastParentState && lastParentState.last) {
            parentEvent.tickId = lastParentState.last.tickId;
            dispatchEvent(parentEvent);
        }

        getMover(e.moverId).direction = e.newDirection;
    }


    override public function newMoverHandler(e:MoverEvent):void {
        super.newMoverHandler(e);
        dispatchEvent(e);
    }


    override public function addMover(mover:Mover):void {
        super.addMover(mover);

    }

    override public function start():void {
        super.start();
        parent.start();
    }
}
}
