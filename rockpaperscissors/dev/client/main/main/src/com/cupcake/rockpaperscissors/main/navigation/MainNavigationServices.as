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
    import com.cupcake.rockpaperscissors.hud.controller.HudController;
    import com.cupcake.rockpaperscissors.lobby.controller.LobbyController;
    import com.cupcake.rockpaperscissors.main.controller.MainController;
    import com.cupcake.rockpaperscissors.services.navigation.IGenericScreen;
    import com.cupcake.rockpaperscissors.services.navigation.IHudScreen;
    import com.cupcake.rockpaperscissors.services.navigation.ILoaderScreen;
    import com.cupcake.rockpaperscissors.services.navigation.IMainContentScreen;
    import com.cupcake.rockpaperscissors.services.navigation.Screens;
    
    import flash.utils.describeType;
    import flash.utils.setTimeout;
    
    public class MainNavigationServices implements INavigationServices
    {
        
        public function initiate():void
        {
            
            Utils.print("MainNavigationServices.initiate()");
            
            Screens.HUD.setController(HudController);
            Screens.LOBBY.setController(LobbyController);
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
            
            for each(var node:XML in describeType(Screens)..constant)
            {
                var screen:Screen = Screens[node.@name];
                
                if (screen is IMainContentScreen) processState(screen, state, MainController.ME.containsMainContent, MainController.ME.addMainContent, IMainContent);
                if (screen is IHudScreen) processState(screen, state, MainController.ME.containsHud, MainController.ME.addHud, IHud);
                if (screen is ILoaderScreen) processState(screen, state, MainController.ME.containsLoader, MainController.ME.addLoader, ILoader);
                if (screen is IGenericScreen) processState(screen, state, MainController.ME.containsGeneric, MainController.ME.addGeneric, IGeneric);
            }
            
        }
        
        private function processState(screen:Screen, currentState:uint, containsFunc:Function, addFunc:Function, itype:Class):void
        {
            if (BitFlagUtils.isSet(currentState, screen.flag))
            {
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
