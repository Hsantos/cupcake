package com.cupcake.rockpaperscissors.hud.view
{
    import com.core.domain.services.view.IHud;
    import com.core.domain.services.view.IView;
    import com.cupcake.rockpaperscissors.services.navigation.Screens;
    
    import starling.display.Quad;
    import starling.display.Sprite;
    
    public class HudView extends Sprite implements IHud
    {
        
        public function draw():IView
        {
            //TODO
            addChild(new Quad(200, 200, 0xffffff * Math.random()));
            
            return this;
        }
        
        public function toString():String
        {
            return "[HudView()]";
        }
    }
}