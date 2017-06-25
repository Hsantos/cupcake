package com.cupcake.rockpaperscissors.main
{
    import com.core.view.starling.main.Startup;
    import com.cupcake.rockpaperscissors.main.navigation.MainNavigationServices;
    import com.cupcake.rockpaperscissors.services.main.GameContext;
    
    public class MainSwf extends Startup
    {
        public function MainSwf(lateStart:Boolean = false)
        {
            super(lateStart);
        }
        
        protected function startControllers():void
        {
            GameContext.ME.navigator.initiate();
        }
        
        override protected function initiate():void
        {
            GameContext.ME.navigator = new MainNavigationServices();
        }
        
    }
}