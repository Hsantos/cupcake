package com.cupcake.rockpaperscissors.services.navigation
{
    import com.core.domain.services.navigation.Screen;
    
    public class MainContentScreen extends Screen implements IMainContentScreen
    {
        function MainContentScreen(id:String, state:uint = 0)
        {
            super(id, state);
        }
    
        public function reload():void
        {
        }
    }
}
