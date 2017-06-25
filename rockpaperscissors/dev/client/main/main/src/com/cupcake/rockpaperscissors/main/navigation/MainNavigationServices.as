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
    import com.cupcake.rockpaperscissors.main.controller.MainController;
    import com.cupcake.rockpaperscissors.services.navigation.IGenericScreen;
    import com.cupcake.rockpaperscissors.services.navigation.IHudScreen;
    import com.cupcake.rockpaperscissors.services.navigation.ILoaderScreen;
    import com.cupcake.rockpaperscissors.services.navigation.IMainContentScreen;
    import com.cupcake.rockpaperscissors.services.navigation.Screens;
    
    import flash.utils.describeType;
    
    public class MainNavigationServices implements INavigationServices
    {
        
        public function initiate():void
        {
            
            Utils.print("MainNavigationServices.initiate()");
            
            Screens.HUD.setController(HudController);
            //TODO more screens
    
            //TODO to fix
            state = Screens.HUD.flag;
            state |= Screens.HUD.flag;
            
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
                
                if (screen is IMainContentScreen)
                {
                    if (BitFlagUtils.isSet(value, screen.flag))
                    {
                        screen.dispose();
                        screen.setController(screen.controllerClass, true);
                        MainController.ME.addMainContent(screen.controller.getView() as IMainContent);
                    }
                }
                
                if (screen is IHudScreen)
                {
                    if (BitFlagUtils.isSet(value, screen.flag))
                    {
                        screen.dispose();
                        screen.setController(screen.controllerClass, true);
                        MainController.ME.addHud(screen.controller.getView() as IHud);
                    }
                }
                
                if (screen is ILoaderScreen)
                {
                    if (BitFlagUtils.isSet(value, screen.flag))
                    {
                        screen.dispose();
                        screen.setController(screen.controllerClass, true);
                        MainController.ME.addLoader(screen.controller.getView() as ILoader);
                    }
                }
                
                if (screen is IGenericScreen)
                {
                    if (BitFlagUtils.isSet(value, screen.flag))
                    {
                        screen.dispose();
                        screen.setController(screen.controllerClass, true);
                        MainController.ME.addGeneric(screen.controller.getView() as IGeneric);
                    }
                }
                
            }
            
        }

//        public function resetAll():void
//        {
//            for each (var screen:Screen in Screens.SCREEN_LIST)  screen.dispose();
//        }
        
    }
}
