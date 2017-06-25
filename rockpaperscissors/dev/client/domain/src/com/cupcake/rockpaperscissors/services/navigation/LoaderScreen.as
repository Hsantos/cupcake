package com.cupcake.rockpaperscissors.services.navigation
{
    import com.core.domain.services.navigation.Screen;
    
    public class LoaderScreen extends Screen implements ILoaderScreen
    {
        function LoaderScreen(id:String, flag:uint = 0)
        {
            super(id, flag);
        }
    }
}
