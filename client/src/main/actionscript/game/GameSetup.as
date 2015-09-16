/**
 * Created by Julia on 13.09.2015.
 */
package game {
import event.InitGameEvent;
import event.MoverDirectionUpdateEvent;
import event.MoverEvent;

import flash.display.Sprite;
import flash.events.EventDispatcher;

import game.logic.BaseGameLogic;

public class GameSetup extends EventDispatcher {

    private var gameLogic:BaseGameLogic;
    private var gameRender:GameRender;
    public var playerInputController:PlayerInputController;
    public var player:Mover;
    public var playerName:String;
    public var container:Sprite;
    public var gameLogicFactory:Function;

    public function GameSetup(container:Sprite, playerName:String, gameLogicFactory:Function) {
        this.container = container;
        this.playerName = playerName;
        this.gameLogicFactory = gameLogicFactory;
    }

    public function setupGame():void {
        gameRender = new GameRender();
        container.addChild(gameRender);

        gameLogic = gameLogicFactory();
        gameLogic.addEventListener(MoverEvent.EVENT_NEW_MOVER, function (e:MoverEvent):void {
            gameRender.bindView(e.mover);
        });

        gameLogic.addEventListener(MoverEvent.PLAYER_LOGGED, function (e:MoverEvent):void {
            player = e.mover;
            playerInputController = new PlayerInputController(player);
            playerInputController.addEventListener(MoverDirectionUpdateEvent.EVENT_TYPE_UPDATE, updateDirectionRequest);
            dispatchEvent(new InitGameEvent())
        });

        gameLogic.start(playerName);
    }

    private function updateDirectionRequest(event:MoverDirectionUpdateEvent):void {
        gameLogic.updateDirectionRequestHandler(event);
    }



}

}
