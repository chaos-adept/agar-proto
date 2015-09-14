/**
 * Created by Julia on 13.09.2015.
 */
package game {
import com.awar.ags.api.base.Event;

import event.InitGameEvent;
import event.MoverEvent;

import flash.display.Sprite;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Point;

public class GameSetup extends EventDispatcher {

    private var gameLogic:LocalGameLogic;
    private var gameRender:GameRender;
    public var playerInputController:PlayerInputController;
    public var player:Mover;
    public var playerName:String;

    public var container:Sprite;

    public function GameSetup(container:Sprite, playerName:String) {
        this.container = container;
        this.playerName = playerName;
    }

    public function setupGame():void {
        gameRender = new GameRender();
        container.addChild(gameRender);

        gameLogic = new LocalGameLogic();
        gameLogic.addEventListener(MoverEvent.EVENT_NEW_MOVER, function (e:MoverEvent):void {
            gameRender.bindView(e.mover);
        });

        gameLogic.addEventListener(MoverEvent.PLAYER_LOGGED, function (e:MoverEvent):void {
            player = e.mover;
            playerInputController = new PlayerInputController(player);
            gameLogic.registerMover(player);

            dispatchEvent(new InitGameEvent())
        });

        gameLogic.start(playerName);
    }



}

}
