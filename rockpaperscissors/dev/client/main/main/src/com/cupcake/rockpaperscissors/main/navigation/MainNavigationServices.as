package com.cupcake.rockpaperscissors.main.navigation
{
    
    import com.core.domain.services.navigation.INavigationServices;
    import com.core.domain.services.navigation.Screen;
    import com.core.domain.services.view.IHud;
    import com.core.utils.BitFlagUtils;
    import com.core.utils.Utils;
    import com.cupcake.rockpaperscissors.hud.controller.HudController;
    import com.cupcake.rockpaperscissors.main.controller.MainController;
    import com.cupcake.rockpaperscissors.services.navigation.HudScreen;
    import com.cupcake.rockpaperscissors.services.navigation.Screens;
    
    import flash.utils.describeType;
    
    public class MainNavigationServices implements INavigationServices
    {
        
        public function initiate():void
        {
            
            Utils.print("MainNavigationServices.initiate()");
            
            Screens.HUD.setController(HudController);
            //TODO more screens
            
            // init
            state = Screens.HUD.flag;
            
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

//                if (screen is MainContentScreen)
//                {
//                    screen.dispose();
//                    if (BitFlagUtils.isSet(value, screen.flag))
//                    {
//                        screen.setController(screen.controllerClass, true);
//                        MainController.ME.addHud(screen.controller.getView() as IHud);
//                    }
//                }
                
                if (screen is HudScreen)
                {
                    screen.dispose();
                    if (BitFlagUtils.isSet(value, screen.flag))
                    {
                        screen.setController(screen.controllerClass, true);
                        MainController.ME.addHud(screen.controller.getView() as IHud);
                    }
                }
                
            }

//            for (var screen:Screen in Screens)
//            {
//                Utils.print(screen);
//            }

//            reset();

//            for each (var screen:Screen in Screens.SCREEN_LIST)
//            {
//                if (BitFlagUtils.isSet(value, screen.state))
//                {
//                    if (screen.id == "HUD")
//                    {
//                        screen.dispose();
//                        screen.setController(HudController, true);
//                        MainController.ME.addHud(HudController.ME.getView() as IHud);
//                    }
//
//                }
//            }

//            if (BitFlagUtils.isSet(value, MainNavigationStates.HUD))
//            {
//                Screens.HUD.setController(HudController, true);
//                MainController.ME.addHud(HudController.ME.getView() as IHud);
//            }
//
//            if (BitFlagUtils.isSet(value, MainNavigationStates.GAME))
//            {
////                Screens.GAME.dispose();
////                Screens.GAME.setController(GameController, true);
////                MainController.ME.addGame(GameController.ME.getView() as IGame);
//            }
        }

//        public function resetAll():void
//        {
//            for each (var screen:Screen in Screens.SCREEN_LIST)  screen.dispose();
//        }
        
    }
}
