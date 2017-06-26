package com.cupcake.rockpaperscissors.gameplayer.controller
{
    import com.core.domain.services.controller.ScreenController;
    import com.core.domain.services.view.IMainContent;
    import com.core.domain.services.view.IView;
    import com.core.utils.Singleton;
    import com.core.utils.Utils;
    import com.cupcake.rockpaperscissors.gameplayer.view.GamePlayerView;
    import com.cupcake.rockpaperscissors.services.main.GameContext;
    import com.cupcake.rockpaperscissors.services.navigation.Screens;
    
    public class GamePlayerController extends ScreenController
    {
        static public var ME:GamePlayerController;
        
        function GamePlayerController(autoCreateView:Boolean = false)
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
            return GamePlayerView;
        }
        
        override public function toString():String
        {
            return "[GamePlayerController(view: " + super.getView() + ")]";
        }
        
        private var view:IMainContent;
        
        override public function getView():IView
        {
            return view = super.getView() as IMainContent;
        }
        
        public function setStartState():void
        {
            GamePlayerView(view).setStartState();
        }
        
        public function setChoseState():void
        {
            Utils.print("you chose: " + GamePlayerView(view).selectedPlayer.name);
            GamePlayerView(view).setChoseState();
        }
        
        public function checkResult():void
        {
            var finalResult:int = GamePlayerView(view).checkResult();
            Utils.print("DONE! - finalResult: " + finalResult);
            switch (finalResult)
            {
            case 0:
                Utils.print("YOU LOSE!");
                break;
            case 1:
                Utils.print("YOU WIN!");
                break;
            case 2:
                Utils.print("DRAW!");
                break;
            default:
                throw new Error("finalResult unexpected: " + finalResult);
            }
        }
        
        public function backButtonClick():void
        {
//            GameContext.ME.navigator.state = Screens.HUD.flag | Screens.LOBBY.flag;
            GameContext.ME.navigator.state &= ~Screens.GAME_PLAYER.flag;
            GameContext.ME.navigator.state |= Screens.LOBBY.flag;
        }
        
    }
}
