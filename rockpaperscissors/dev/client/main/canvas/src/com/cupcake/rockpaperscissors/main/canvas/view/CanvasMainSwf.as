package com.cupcake.rockpaperscissors.main.canvas.view
{
    import com.core.utils.Singleton;
    import com.core.utils.Statics;
    import com.core.view.starling.main.StarlingSprite;
    import com.cupcake.rockpaperscissors.main.MainSwf;
    import com.cupcake.rockpaperscissors.main.controller.MainController;
    import com.cupcake.rockpaperscissors.services.navigation.Screens;
    
    import flash.events.Event;
    import flash.geom.Rectangle;
    
    import starling.display.DisplayObject;
    
    [SWF(width="800", height="600", frameRate="60", backgroundColor="#e1e1e1")]
    public class CanvasMainSwf extends MainSwf
    {
        static internal var ME:CanvasMainSwf;
        
        public function CanvasMainSwf()
        {
            Statics.VIEW_PORT = getViewPortRectangle();
            
            super();
            
            ME = Singleton.enforce(ME, this);
        }
        
        override protected function preInitiate():void
        {
            super.preInitiate();
        }
        
        private var context3DCreateWasCalled:Boolean = false;
        
        override protected function callbackContext3DCreate(event:Event):void
        {
            starling.showStats = true;
            
            if (!context3DCreateWasCalled)
            {
                context3DCreateWasCalled = true;
                startControllers();
                super.callbackContext3DCreate(event);
            }
        }
        
        override protected function initiate():void
        {
            super.initiate();
        }
        
        override protected function starlingCallback(sprite:StarlingSprite):void
        {
            initiateMainContainers(sprite);
            super.starlingCallback(sprite);
        }
        
        private function initiateMainContainers(sprite:StarlingSprite):void
        {
            Screens.MAIN.setController(MainController, true);
            sprite.addChild(MainController.ME.getView() as DisplayObject);
        }
        
        override protected function getViewPortRectangle():Rectangle
        {
            return new Rectangle(0, 0, 800, 600);
        }
    }
}