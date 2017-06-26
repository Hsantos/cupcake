package com.cupcake.rockpaperscissors.gameplayer.view
{
    import com.core.domain.services.view.IMainContent;
    import com.core.domain.services.view.IView;
    import com.core.utils.Statics;
    import com.cupcake.rockpaperscissors.assets.Assets;
    import com.cupcake.rockpaperscissors.assets.Fonts;
    import com.cupcake.rockpaperscissors.gameplayer.controller.GamePlayerController;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    import starling.animation.Transitions;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;
    import starling.text.TextFormat;
    import starling.text.TextOptions;
    import starling.textures.Texture;
    import starling.utils.Align;
    
    public class GamePlayerView extends Sprite implements IMainContent
    {

//        function GamePlayerView()
//        {
////            Fonts.initiate();
//        }
        
        override public function dispose():void
        {
            this.removeEventListener(TouchEvent.TOUCH, gameTouch);
            Starling.juggler.removeTweens(rockPlayer);
            
            baseBitmapForTextures.bitmapData.dispose();
            rockBmp.dispose();
            paperBmp.dispose();
            scissorsBmp.dispose();
            
            rockPlayerImage.texture.dispose();
            rockPlayerImage.dispose();
            rockCpuImage.texture.dispose();
            rockCpuImage.dispose();
            
            paperPlayerImage.texture.dispose();
            paperPlayerImage.dispose();
            paperCpuImage.texture.dispose();
            paperCpuImage.dispose();
            
            scissorsPlayerImage.texture.dispose();
            scissorsPlayerImage.dispose();
            scissorsCpuImage.texture.dispose();
            scissorsCpuImage.dispose();
            
            this.removeChildren(0, -1, true);
            this.removeFromParent();
            
            super.dispose();
        }
        
        public var baseBitmapForTextures:Bitmap;
        public var rockBmp:BitmapData;
        public var paperBmp:BitmapData;
        public var scissorsBmp:BitmapData;
        
        public var rockPlayer:Sprite;
        public var rockPlayerImage:Image;
        public var rockCpu:Sprite;
        public var rockCpuImage:Image;
        
        public var paperPlayer:Sprite;
        public var paperPlayerImage:Image;
        public var paperCpu:Sprite;
        public var paperCpuImage:Image;
        
        public var scissorsPlayer:Sprite;
        public var scissorsPlayerImage:Image;
        public var scissorsCpu:Sprite;
        public var scissorsCpuImage:Image;
        
        public var backButton:Sprite;
        
        public function draw():IView
        {
            
            // bg
            var bg:Quad = addChild(new Quad(Statics.VIEW_PORT.width, Statics.VIEW_PORT.height, 0xffff00)) as Quad;
            bg.alpha = 0.1;
            
            var text:TextField = addChild(new TextField(200, 40, "PLAYER vs CPU", new TextFormat(Fonts.FRIJOLE_REGULAR, 12, 0x313131))) as TextField;
            text.x = Statics.VIEW_PORT.width - text.width;
            text.y = Statics.VIEW_PORT.height - text.height - 40;
            text.autoScale = true;
            text.format.verticalAlign = Align.BOTTOM;
            text.format.horizontalAlign = Align.RIGHT;
            
            baseBitmapForTextures = Assets.ME.getBitmap("rps");
            
            rockBmp = new BitmapData(178, 196, true, 0x0);
            rockBmp.copyPixels(baseBitmapForTextures.bitmapData, new Rectangle(0, 0, 178, 196), new Point());
            
            rockPlayer = addChild(new Sprite()) as Sprite;
            rockPlayerImage = rockPlayer.addChild(new Image(Texture.fromBitmapData(rockBmp))) as Image;
            rockPlayer.name = "rockPlayer,0";
            
            rockCpu = addChild(new Sprite()) as Sprite;
            rockCpuImage = rockCpu.addChild(new Image(Texture.fromBitmapData(rockBmp))) as Image;
            rockCpu.name = "rockCpu,0";
            rockCpu.scaleY = rockCpu.scaleX = -1;
            
            paperBmp = new BitmapData(196, 196, true, 0x0);
            paperBmp.copyPixels(baseBitmapForTextures.bitmapData, new Rectangle(177, 0, 196, 196), new Point());
            
            paperPlayer = addChild(new Sprite()) as Sprite;
            paperPlayerImage = paperPlayer.addChild(new Image(Texture.fromBitmapData(paperBmp))) as Image;
            paperPlayer.name = "paperPlayer,1";
            
            paperCpu = addChild(new Sprite()) as Sprite;
            paperCpuImage = paperCpu.addChild(new Image(Texture.fromBitmapData(paperBmp))) as Image;
            paperCpu.name = "paperCpu,1";
            paperCpu.scaleY = paperCpu.scaleX = -1;
            
            scissorsBmp = new BitmapData(151, 196, true, 0x0);
            scissorsBmp.copyPixels(baseBitmapForTextures.bitmapData, new Rectangle(369, 0, 151, 196), new Point());
            
            scissorsPlayer = addChild(new Sprite()) as Sprite;
            scissorsPlayerImage = scissorsPlayer.addChild(new Image(Texture.fromBitmapData(scissorsBmp))) as Image;
            scissorsPlayer.name = "scissorsPlayer,2";
            
            scissorsCpu = addChild(new Sprite()) as Sprite;
            scissorsCpuImage = scissorsCpu.addChild(new Image(Texture.fromBitmapData(scissorsBmp))) as Image;
            scissorsCpu.name = "scissorsCpu,2";
            scissorsCpu.scaleY = scissorsCpu.scaleX = -1;
            
            // back
            backButton = addChild(new Sprite()) as Sprite;
            backButton.addChild(new Quad(200, 40, 0xffffff));
            var textOption:TextOptions = new TextOptions(false, true);
            var textFormat:TextFormat = new TextFormat(Fonts.FRIJOLE_REGULAR, 12, 0x333333);
            backButton.addChild(new TextField(200, 40, "BACK TO LOBBY", textFormat, textOption));
            backButton.x = 9;
            backButton.y = 90;
            
            // init
            setStartState();
            
            return this;
        }
        
        public function setStartState():void
        {
            rockCpu.visible = paperCpu.visible = scissorsCpu.visible = false;
            
            rockPlayer.x = 200;
            rockPlayer.y = 248;
            
            paperPlayer.x = 399;
            paperPlayer.y = 243;
            
            scissorsPlayer.x = 610;
            scissorsPlayer.y = 247;
            
            createActions();
        }
        
        public function createActions():void
        {
            this.addEventListener(TouchEvent.TOUCH, gameTouch);
            this.touchGroup = false;
            this.touchable = true;
        }
        
        public const DRAG_TOLERANCE:int = 20 / Starling.contentScaleFactor;
        public var origin:Point = new Point();
        public var toleranceFlag:Boolean = false;
        
        public var selectedPlayer:Sprite;
        public var selectedCpu:Sprite;
        
        public function gameTouch(e:TouchEvent):void
        {
            rockPlayer.alpha = 1.0;
            paperPlayer.alpha = 1.0;
            scissorsPlayer.alpha = 1.0;
            //
            backButton.alpha = 1.0;
            
            for each (var t:Touch in e.getTouches(this))
            {
                if (t.phase == TouchPhase.HOVER)
                {
                    rockPlayer.alpha = 0.3;
                    paperPlayer.alpha = 0.3;
                    scissorsPlayer.alpha = 0.3;
                    
                    if (t.isTouching(rockPlayer)) rockPlayer.alpha = 1.0;
                    if (t.isTouching(paperPlayer)) paperPlayer.alpha = 1.0;
                    if (t.isTouching(scissorsPlayer)) scissorsPlayer.alpha = 1.0;
                    //
                    if (t.isTouching(backButton)) backButton.alpha = 0.8;
                    
                }
                else if (t.phase == TouchPhase.BEGAN)
                {
                    rockPlayer.alpha = 0.3;
                    paperPlayer.alpha = 0.3;
                    scissorsPlayer.alpha = 0.3;
                    
                    origin.x = t.globalX;
                    origin.y = t.globalY;
                    
                    toleranceFlag = false;
                }
                else if (t.phase == TouchPhase.MOVED)
                {
                    rockPlayer.alpha = 0.3;
                    paperPlayer.alpha = 0.3;
                    scissorsPlayer.alpha = 0.3;
                    
                    if (!toleranceFlag) toleranceFlag = Math.abs(origin.x - t.globalX) >= DRAG_TOLERANCE || Math.abs(origin.y - t.globalY) >= DRAG_TOLERANCE;
                }
                else if (t.phase == TouchPhase.ENDED)
                {
                    if (toleranceFlag) continue;
                    
                    if (t.isTouching(rockPlayer))
                    {
                        selectedPlayer = rockPlayer;
                        GamePlayerController.ME.setChoseState();
                    }
                    if (t.isTouching(paperPlayer))
                    {
                        selectedPlayer = paperPlayer;
                        GamePlayerController.ME.setChoseState();
                    }
                    if (t.isTouching(scissorsPlayer))
                    {
                        selectedPlayer = scissorsPlayer;
                        GamePlayerController.ME.setChoseState();
                    }
                    //
                    if (t.isTouching(backButton))
                    {
                        GamePlayerController.ME.backButtonClick();
                        
                    }
                    
                }
                
            }
        }
        
        public function setChoseState():void
        {
            this.removeEventListener(TouchEvent.TOUCH, gameTouch);
            
            backButton.visible = false;
            
            rockPlayer.visible = true;
            paperPlayer.visible = false;
            scissorsPlayer.visible = false;
            
            rockPlayer.x = Statics.VIEW_PORT.width - rockPlayer.width >> 1;
            rockPlayer.y = 400;
            
            rockCpu.visible = true;
            rockCpu.x = Statics.VIEW_PORT.width + (rockCpu.width) >> 1;
            rockCpu.y = 280;
            
            Starling.juggler.removeTweens(rockPlayer);
            
            Starling.juggler.tween(rockPlayer, 0.200001, {
                y: 360, repeatCount: 4, reverse: true, onComplete: function ():void
                {
                    Starling.juggler.tween(rockPlayer, 0.200001, { //
                        x: Statics.VIEW_PORT.width - selectedPlayer.width >> 1, //
                        y: 320, //
                        transition: Transitions.EASE_OUT, //
                        onComplete: function ():void
                        {
                            rockPlayer.visible = false;
                            selectedPlayer.x = Statics.VIEW_PORT.width - rockPlayer.width >> 1;
                            selectedPlayer.y = rockPlayer.y;
                            selectedPlayer.visible = true;
                            
                            var random:int = Math.ceil(3.0 * Math.random());
                            if (random == 1)
                            {
                                rockCpu.visible = false;
                                paperCpu.visible = true;
                                paperCpu.x = Statics.VIEW_PORT.width + (paperCpu.width) >> 1;
                                paperCpu.y = 280;
                                selectedCpu = paperCpu;
                            }
                            else if (random == 2)
                            {
                                rockCpu.visible = false;
                                scissorsCpu.visible = true;
                                scissorsCpu.x = Statics.VIEW_PORT.width + (scissorsCpu.width) >> 1;
                                scissorsCpu.y = 280;
                                selectedCpu = scissorsCpu;
                            }
                            else selectedCpu = rockPlayer;
                            
                            GamePlayerController.ME.checkResult();
                            
                        }
                    });
                }
            });
            
        }
        
        public function checkResult():int
        {
            var playerResult:int = int(selectedPlayer.name.split(",")[1]);
            var cpuResult:int = int(selectedCpu.name.split(",")[1]);
            
            var finalResult:int;
            
            switch (playerResult)
            {
            case 0:
                finalResult = (cpuResult == 0) ? 2 : (cpuResult == 2) ? 1 : 0;
                break;
            case 1:
                finalResult = (cpuResult == 1) ? 2 : (cpuResult == 0) ? 1 : 0;
                break;
            case 2:
                finalResult = (cpuResult == 2) ? 2 : (cpuResult == 1) ? 1 : 0;
                break;
            }
            
            return finalResult;
        }
        
        public function toString():String
        {
            return "[GamePlayerView()]";
        }
        
    }
}