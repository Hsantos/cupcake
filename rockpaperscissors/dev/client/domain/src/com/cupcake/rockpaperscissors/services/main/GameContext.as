package com.cupcake.rockpaperscissors.services.main
{
    import com.core.domain.main.CoreContext;
    import com.core.utils.Singleton;
    
    public class GameContext extends CoreContext
    {
        static public const ME:GameContext = new GameContext();
        
        function GameContext()
        {
            Singleton.enforce(ME);
        }
        
    }
}
