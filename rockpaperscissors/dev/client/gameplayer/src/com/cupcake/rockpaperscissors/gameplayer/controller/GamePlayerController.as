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
    
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;
    
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
//            clearTimeout(checkResultDelay);
            clearTimeout(checkResultDelay);
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
        
        private var checkResultDelay:uint;
        private const RESULT_DELAY:int = 1000;
        
        public function checkResult():void
        {
            clearTimeout(checkResultDelay);
            
            checkResultDelay = setTimeout(function ():void
            {
                var finalResult:int = GamePlayerView(view).checkResult();
                Utils.print("DONE! - finalResult: " + finalResult);
                
                var descriptionToNotification:String;
                
                switch (finalResult)
                {
                case 0:
                    descriptionToNotification = "YOU LOSE!";
                    break;
                case 1:
                    descriptionToNotification = "YOU WIN!";
                    break;
                case 2:
                    descriptionToNotification = "DRAW!";
                    break;
                default:
                    throw new Error("finalResult unexpected: " + finalResult);
                }
    
                Utils.print(descriptionToNotification);
                
                GameContext.ME.navigator.state |= Screens.NOTIFICATION.flag;
                GamePlayerNotificationController.ME.updateDescription(descriptionToNotification);
                
            }, RESULT_DELAY);
        }
        
        public function backButtonClick():void
        {
//            GameContext.ME.navigator.state = Screens.HUD.flag | Screens.LOBBY.flag;
            GameContext.ME.navigator.state &= ~Screens.GAME_PLAYER.flag;
            GameContext.ME.navigator.state |= Screens.LOBBY.flag;
        }
        
    }
}
