package com.cupcake.rockpaperscissors.services.navigation
{
    import com.core.domain.services.navigation.Screen;
    
    public class GenericScreen extends Screen implements IGenericScreen
    {
        function GenericScreen(id:String, flag:uint = 0)
        {
            super(id, flag);
        }
    }
}
