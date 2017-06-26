package com.cupcake.rockpaperscissors.gameplayer.controller
{
    import com.core.domain.services.controller.ScreenController;
    import com.core.domain.services.view.IGeneric;
    import com.core.domain.services.view.IView;
    import com.core.utils.Singleton;
    import com.core.utils.Utils;
    import com.cupcake.rockpaperscissors.gameplayer.view.GamePlayerNotificationView;
    import com.cupcake.rockpaperscissors.services.main.GameContext;
    import com.cupcake.rockpaperscissors.services.navigation.Screens;
    
    public class GamePlayerNotificationController extends ScreenController
    {
        static public var ME:GamePlayerNotificationController;
        
        function GamePlayerNotificationController(autoCreateView:Boolean = false)
        {
            ME = Singleton.enforce(ME, this);
            if (autoCreateView) createView();
        }
        
        override public function dispose():void
        {
            ME = null;
            super.dispose();
        }
        
        override public function getViewClass():Class
        {
            return GamePlayerNotificationView;
        }
        
        override public function toString():String
        {
            return "[GamePlayerNotificationController(view: " + super.getView() + ")]";
        }
        
        private var view:IGeneric;
        
        override public function getView():IView
        {
            return view = super.getView() as IGeneric;
        }
        
        public function updateDescription(text:String):void
        {
            GamePlayerNotificationView(view).updateDescription(text);
        }
        
        public function backToGame():void
        {
            Utils.print("GamePlayerNotificationController.backToGame");
            
            GameContext.ME.navigator.state &= ~Screens.NOTIFICATION.flag;
            GameContext.ME.navigator.state &= ~Screens.GAME_PLAYER.flag;
            GameContext.ME.navigator.state |= Screens.GAME_PLAYER.flag;
        }
        
        public function backToLobby():void
        {
            Utils.print("GamePlayerNotificationController.backToLobby");
            
            GameContext.ME.navigator.state &= ~Screens.NOTIFICATION.flag;
            GameContext.ME.navigator.state &= ~Screens.GAME_PLAYER.flag;
            GameContext.ME.navigator.state |= Screens.LOBBY.flag;
        }
        
    }
}
