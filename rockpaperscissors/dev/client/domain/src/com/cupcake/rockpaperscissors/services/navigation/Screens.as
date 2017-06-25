package com.cupcake.rockpaperscissors.services.navigation
{
    import com.core.domain.services.navigation.Screen;
    
    public class Screens
    {
        
        static public const MAIN:Screen = new Screen("MAIN");
    
        // lobby
        static public const LOBBY:MainContentScreen = new MainContentScreen("LOBBY", 1 << 0);
        
        // games
        static public const GAME_PLAYER:MainContentScreen = new MainContentScreen("GAME_PLAYER", 1 << 0);
        static public const GAME_CPU:MainContentScreen = new MainContentScreen("GAME_CPU", 1 << 1);
        
        // huds
        static public const HUD:HudScreen = new HudScreen("HUD", 1 << 0);
        
        // loaders
        static public const LOADER_LOBBY:LoaderScreen = new LoaderScreen("LOADER_LOOBY", 1 << 0);
        static public const LOADER_GAME:LoaderScreen = new LoaderScreen("LOADER_GAME", 1 << 1);
        
        // generics
        static public const WELCOME:Screen = new Screen("WELCOME", 1 << 0);
        static public const NOTIFICATION:Screen = new Screen("NOTIFICATION", 1 << 1);
        static public const ERROR:Screen = new Screen("ERROR", 1 << 2);
        
    }
}