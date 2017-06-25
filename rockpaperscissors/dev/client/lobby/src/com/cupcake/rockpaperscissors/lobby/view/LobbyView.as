package com.cupcake.rockpaperscissors.lobby.view
{
    import com.core.domain.services.view.IMainContent;
    import com.core.domain.services.view.IView;
    
    import starling.display.Quad;
    import starling.display.Sprite;
    
    public class LobbyView extends Sprite implements IMainContent
    {

//        function LobbyView()
//        {
////            Fonts.initiate();
//        }
        
        override public function dispose():void
        {
            this.removeChildren(0, -1, true);
            this.removeFromParent();
            
            super.dispose();
        }
        
        public function draw():IView
        {
            
            addChild(new Quad(300, 300, 0xff0000));
            
            return this;
        }
        
        public function toString():String
        {
            return "[LobbyView()]";
        }
    }
}