package com.cupcake.rockpaperscissors.services.navigation
{
    import com.core.domain.services.navigation.Screen;
    
    public class GameScreen extends Screen implements IMainContentScreen
    {
        function GameScreen(id:String, flag:uint = 0)
        {
            super(id, flag);
        }
        
    }
}
