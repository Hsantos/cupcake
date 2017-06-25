package com.cupcake.rockpaperscissors.lobby.view
{
    import com.core.domain.services.view.IMainContent;
    import com.core.domain.services.view.IView;
    import com.core.utils.Statics;
    import com.core.utils.Utils;
    import com.cupcake.rockpaperscissors.assets.Fonts;
    
    import flash.geom.Point;
    
    import starling.core.Starling;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;
    import starling.text.TextFormat;
    import starling.text.TextOptions;
    import starling.utils.Align;
    
    public class LobbyView extends Sprite implements IMainContent
    {

//        function LobbyView()
//        {
////            Fonts.initiate();
//        }
        
        override public function dispose():void
        {
            gamesContainer.removeEventListener(TouchEvent.TOUCH, gamesContainerTouch);
            
            this.removeChildren(0, -1, true);
            this.removeFromParent();
            
            super.dispose();
        }
        
        private var gamesContainer:Sprite;
        private var gamePlayer:Sprite;
        private var gameCPU:Sprite;
        private var gameSoon:Sprite;
        
        public function draw():IView
        {
            
            // bg
            addChild(new Quad(Statics.VIEW_PORT.width, Statics.VIEW_PORT.height, 0x999999));
            
            var text:TextField = addChild(new TextField(200, 40, "LOBBY", new TextFormat(Fonts.FRIJOLE_REGULAR, 12, 0x313131))) as TextField;
            text.x = Statics.VIEW_PORT.width - text.width;
            text.y = Statics.VIEW_PORT.height - text.height - 40;
            text.autoScale = true;
            text.format.verticalAlign = Align.BOTTOM;
            text.format.horizontalAlign = Align.RIGHT;
            
            gamesContainer = addChild(new Sprite()) as Sprite;
            gamesContainer.name = "gamesContainer";
            
            var textOption:TextOptions = new TextOptions(false, true);
            var textFormat:TextFormat = new TextFormat(Fonts.FRIJOLE_REGULAR, 16, 0x333333);
            
            gamePlayer = gamesContainer.addChild(new Sprite()) as Sprite;
            gamePlayer.addChild(new Quad(200, 100, 0xe5e5e5));
            gamePlayer.addChild(new TextField(200, 100, "PLAYER.vs.CPU", textFormat, textOption));
            gamePlayer.name = "gamePlayer";
            
            gameCPU = gamesContainer.addChild(new Sprite()) as Sprite;
            gameCPU.addChild(new Quad(200, 100, 0xe5e5e5));
            gameCPU.x = 205;
            gameCPU.addChild(new TextField(200, 100, "CPU.vs.CPU", textFormat, textOption));
            gameCPU.name = "gameCPU";
            
            gameSoon = gamesContainer.addChild(new Sprite()) as Sprite;
            gameSoon.addChild(new Quad(200, 100, 0xa3a3a3));
            gameSoon.x = 410;
            textFormat.color = 0xd1d1d1;
            gameSoon.addChild(new TextField(200, 100, "SOON", textFormat, textOption));
            gameSoon.name = "gameSoon";
            
            gamesContainer.x = Statics.VIEW_PORT.width - gamesContainer.width >> 1;
            gamesContainer.y = 260;
            
            createActions();
            
            return this;
        }
        
        private function createActions():void
        {
            gamesContainer.addEventListener(TouchEvent.TOUCH, gamesContainerTouch);
            gamesContainer.touchGroup = false;
            gamesContainer.touchable = true;
        }
        
        private const DRAG_TOLERANCE:int = 20 / Starling.contentScaleFactor;
        private var origin:Point = new Point();
        private var toleranceFlag:Boolean = false;
        
        private function gamesContainerTouch(e:TouchEvent):void
        {
            gamePlayer.alpha = 1.0;
            gameCPU.alpha = 1.0;
            gameSoon.alpha = 1.0;
            
            for each (var t:Touch in e.getTouches(gamesContainer))
            {
                if (t.phase == TouchPhase.HOVER)
                {
                    gamePlayer.alpha = t.isTouching(gamePlayer) ? 0.8 : 1.0;
                    gameCPU.alpha = t.isTouching(gameCPU) ? 0.8 : 1.0;
                    gameSoon.alpha = t.isTouching(gameSoon) ? 0.8 : 1.0;
                }
                else if (t.phase == TouchPhase.BEGAN)
                {
                    origin.x = t.globalX;
                    origin.y = t.globalY;
                    
                    toleranceFlag = false;
                }
                else if (t.phase == TouchPhase.MOVED)
                {
                    if (!toleranceFlag) toleranceFlag = Math.abs(origin.x - t.globalX) >= DRAG_TOLERANCE || Math.abs(origin.y - t.globalY) >= DRAG_TOLERANCE;
                }
                else if (t.phase == TouchPhase.ENDED)
                {
                    if (toleranceFlag) continue;
                    
                    if (t.isTouching(gamePlayer))
                    {
                        Utils.print("goto:", gamePlayer.name);
                    }
                    if (t.isTouching(gameCPU))
                    {
                        Utils.print("goto:", gameCPU.name);
                    }
                    if (t.isTouching(gameSoon))
                    {
                        Utils.print("goto:", gameSoon.name);
                    }
                    
                }
                
            }
        }
        
        public function toString():String
        {
            return "[LobbyView()]";
        }
    }
}