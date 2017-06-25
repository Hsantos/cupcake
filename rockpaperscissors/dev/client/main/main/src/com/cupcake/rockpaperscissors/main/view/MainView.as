package com.cupcake.rockpaperscissors.main.view
{
    import com.core.domain.services.view.IMainContent;
    import com.core.domain.services.view.IGeneric;
    import com.core.domain.services.view.IHud;
    import com.core.domain.services.view.ILoader;
    import com.core.domain.services.view.IView;
    
    import starling.display.DisplayObject;
    import starling.display.Sprite;
    
    public class MainView extends Sprite implements IView
    {
        
        private var gameContainer:Sprite;
        private var hudContainer:Sprite;
        private var genericContainer:Sprite;
        private var loaderContainer:Sprite;
        
        public function draw():IView
        {
            
            touchable = true;
            
            gameContainer = addChild(new Sprite()) as Sprite;
            gameContainer.touchable = true;
            
            hudContainer = addChild(new Sprite()) as Sprite;
            hudContainer.touchable = true;
            
            loaderContainer = addChild(new Sprite()) as Sprite;
            loaderContainer.touchable = true;
            
            genericContainer = addChild(new Sprite()) as Sprite;
            genericContainer.touchable = true;
            
            return this;
        }
        
        public function addMainContent(mainContent:IMainContent):void
        {
            gameContainer.removeChildren(0, -1, true);
            gameContainer.addChild(mainContent as DisplayObject);
        }
        
        public function addHud(hud:IHud):void
        {
            hudContainer.removeChildren(0, -1, true);
            hudContainer.addChild(hud as DisplayObject);
        }
        
        public function addLoader(loader:ILoader):void
        {
            loaderContainer.removeChildren(0, -1, true);
            loaderContainer.addChild(loader as DisplayObject);
        }
        
        public function addGeneric(generic:IGeneric):void
        {
            //TODO to review
            genericContainer.removeChildren(0, -1, true);
            
            genericContainer.addChild(generic as DisplayObject);
        }
        
        public function toString():String
        {
            return "[MainView()]";
        }
    }
}