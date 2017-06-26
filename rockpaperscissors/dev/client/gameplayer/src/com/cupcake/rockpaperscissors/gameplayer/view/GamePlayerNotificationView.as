package com.cupcake.rockpaperscissors.gameplayer.view
{
    import com.core.domain.services.view.IGeneric;
    import com.core.domain.services.view.IView;
    import com.core.utils.Statics;
    import com.cupcake.rockpaperscissors.assets.Fonts;
    import com.cupcake.rockpaperscissors.gameplayer.controller.GamePlayerNotificationController;
    
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
    
    public class GamePlayerNotificationView extends Sprite implements IGeneric
    {

//        function GamePlayerNotificationView()
//        {
////            Fonts.initiate();
//        }
        
        override public function dispose():void
        {
            this.removeEventListener(TouchEvent.TOUCH, screenTouch);
            
            this.removeChildren(0, -1, true);
            this.removeFromParent();
            
            super.dispose();
        }
        
        private var description:TextField;
        
        private var backToGame:Sprite;
        private var backToLobby:Sprite;
        
        public function draw():IView
        {
            
            // bg
            var bg:Quad = addChild(new Quad(Statics.VIEW_PORT.width, Statics.VIEW_PORT.height, 0xe1e1e1)) as Quad;
            bg.alpha = 0.95;
            
            var textFooter:TextField = addChild(new TextField(200, 40, "GAME::NOTIFICATION", new TextFormat(Fonts.FRIJOLE_REGULAR, 12, 0x313131))) as TextField;
            textFooter.x = Statics.VIEW_PORT.width - textFooter.width;
            textFooter.y = Statics.VIEW_PORT.height - textFooter.height;
            textFooter.autoScale = true;
            textFooter.format.verticalAlign = Align.BOTTOM;
            textFooter.format.horizontalAlign = Align.RIGHT;
            
            description = addChild(new TextField(200, 200, "DRAW", new TextFormat(Fonts.CHARTER_BLACK, 36, 0x313131))) as TextField;
            description.x = Statics.VIEW_PORT.width - description.width >> 1;
            description.y = 173;
            description.autoScale = true;
            description.wordWrap = false;
            
            var textOption:TextOptions = new TextOptions(false, true);
            var textFormat:TextFormat = new TextFormat(Fonts.FRIJOLE_REGULAR, 12, 0x333333);
            
            // back
            backToGame = addChild(new Sprite()) as Sprite;
            backToGame.addChild(new Quad(200, 40, 0xffffff));
            backToGame.addChild(new TextField(200, 40, "PLAY AGAIN", textFormat, textOption));
            backToGame.x = 261;
            backToGame.y = 342;
            
            // back
            backToLobby = addChild(new Sprite()) as Sprite;
            backToLobby.addChild(new Quad(200, 40, 0xffffff));
            backToLobby.addChild(new TextField(200, 40, "BACK TO LOBBY", textFormat, textOption));
            backToLobby.x = 489;
            backToLobby.y = 342;
            
            createActions();
            
            return this;
        }
        
        public function toString():String
        {
            return "[GamePlayerNotificationView()]";
        }
        
        private function createActions():void
        {
            this.addEventListener(TouchEvent.TOUCH, screenTouch);
            this.touchGroup = false;
            this.touchable = true;
        }
        
        private const DRAG_TOLERANCE:int = 20 / Starling.contentScaleFactor;
        private var origin:Point = new Point();
        private var toleranceFlag:Boolean = false;
        
        public var selectedPlayer:Sprite;
        private var selectedCpu:Sprite;
        
        private function screenTouch(e:TouchEvent):void
        {
            backToGame.alpha = 1.0;
            backToLobby.alpha = 1.0;
            
            for each (var t:Touch in e.getTouches(this))
            {
                if (t.phase == TouchPhase.HOVER)
                {
                    if (t.isTouching(backToGame)) backToGame.alpha = 0.8;
                    if (t.isTouching(backToLobby)) backToLobby.alpha = 0.8;
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
                    
                    if (t.isTouching(backToGame))
                    {
                        GamePlayerNotificationController.ME.backToGame();
                    }
                    if (t.isTouching(backToLobby))
                    {
                        GamePlayerNotificationController.ME.backToLobby();
                    }
                    
                }
                
            }
        }
        
        public function updateDescription(text:String):void
        {
            description.text = text;
        }
        
    }
}