package com.cupcake.rockpaperscissors.main.navigation
{
    
    import com.core.domain.services.navigation.INavigationServices;
    import com.core.domain.services.navigation.Screen;
    import com.core.domain.services.view.IGeneric;
    import com.core.domain.services.view.IHud;
    import com.core.domain.services.view.ILoader;
    import com.core.domain.services.view.IMainContent;
    import com.core.utils.BitFlagUtils;
    import com.core.utils.Utils;
    import com.cupcake.rockpaperscissors.gameplayer.controller.GamePlayerController;
    import com.cupcake.rockpaperscissors.gameplayer.controller.GamePlayerNotificationController;
    import com.cupcake.rockpaperscissors.hud.controller.HudController;
    import com.cupcake.rockpaperscissors.lobby.controller.LobbyController;
    import com.cupcake.rockpaperscissors.main.controller.MainController;
    import com.cupcake.rockpaperscissors.services.navigation.GameScreen;
    import com.cupcake.rockpaperscissors.services.navigation.GenericScreen;
    import com.cupcake.rockpaperscissors.services.navigation.HudScreen;
    import com.cupcake.rockpaperscissors.services.navigation.IGenericScreen;
    import com.cupcake.rockpaperscissors.services.navigation.LoaderScreen;
    import com.cupcake.rockpaperscissors.services.navigation.MainContentScreen;
    import com.cupcake.rockpaperscissors.services.navigation.Screens;
    
    import flash.utils.describeType;
    
    public class MainNavigationServices implements INavigationServices
    {
        
        public function initiate():void
        {
            
            Utils.print("MainNavigationServices.initiate()");
            
            Screens.HUD.setController(HudController);
            Screens.LOBBY.setController(LobbyController);
            Screens.GAME_PLAYER.setController(GamePlayerController);
            Screens.NOTIFICATION.setController(GamePlayerNotificationController);
            //TODO more screens
            
            // init
            state = Screens.HUD.flag | Screens.LOBBY.flag;
            
        }
        
        private var statee:uint;
        
        public function get state():uint
        {
            return this.statee;
        }
        
        public function set state(value:uint):void
        {
            this.statee = value;
            
            stateCounter = new <uint>[0, 0, 0, 0];
            
            for each(var node:XML in describeType(Screens)..constant)
            {
                var screen:Screen = Screens[node.@name];
                
                if (screen is MainContentScreen || screen is GameScreen) processState(screen, state, MainController.ME.containsMainContent, MainController.ME.addMainContent, IMainContent, 0);
                if (screen is HudScreen) processState(screen, state, MainController.ME.containsHud, MainController.ME.addHud, IHud, 1);
                if (screen is LoaderScreen) processState(screen, state, MainController.ME.containsLoader, MainController.ME.addLoader, ILoader, 2);
                if (screen is GenericScreen) processState(screen, state, MainController.ME.containsGeneric, MainController.ME.addGeneric, IGeneric, 3);
            }
            
        }
        
        private var stateCounter:Vector.<uint> = null;
        
        private function processState(screen:Screen, currentState:uint, containsFunc:Function, addFunc:Function, itype:Class, stateCounterIndex:uint):void
        {
            
            if (BitFlagUtils.isSet(currentState, screen.flag))
            {
                
                if (++stateCounter[stateCounterIndex] > 1)
                {
                    if (!(screen is IGenericScreen)) this.statee &= ~screen.flag;
                    return;
                }
                
                if (screen.controller && containsFunc(screen.controller.getView() as itype)) return;
                screen.dispose();
                screen.setController(screen.controllerClass, true);
                addFunc(screen.controller.getView() as itype);
            }
            else screen.dispose();
        }

//        public function resetAll():void
//        {
//            for each (var screen:Screen in Screens.SCREEN_LIST)  screen.dispose();
//        }
        
    }
}
