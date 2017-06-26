package com.cupcake.rockpaperscissors.lobby.controller
{
    import com.core.domain.services.controller.ScreenController;
    import com.core.domain.services.navigation.IScreen;
    import com.core.domain.services.view.IMainContent;
    import com.core.domain.services.view.IView;
    import com.core.utils.Singleton;
    import com.core.utils.Utils;
    import com.cupcake.rockpaperscissors.lobby.view.LobbyView;
    import com.cupcake.rockpaperscissors.services.main.GameContext;
    import com.cupcake.rockpaperscissors.services.navigation.GameScreen;
    import com.cupcake.rockpaperscissors.services.navigation.Screens;
    
    public class LobbyController extends ScreenController
    {
        static public var ME:LobbyController;
        
        function LobbyController(autoCreateView:Boolean = false)
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
            return LobbyView;
        }
        
        override public function toString():String
        {
            return "[LobbyController(view: " + super.getView() + ")]";
        }
        
        private var view:IMainContent;
        
        override public function getView():IView
        {
            return view = super.getView() as IMainContent;
        }
        
        public function gotoGame(game:GameScreen):void
        {
            Utils.print("LobbyController.gotoGame: " + game, IScreen(game).flag);
    
            GameContext.ME.navigator.state &= ~Screens.LOBBY.flag;
            GameContext.ME.navigator.state |= IScreen(game).flag;
        }
        
    }
}
