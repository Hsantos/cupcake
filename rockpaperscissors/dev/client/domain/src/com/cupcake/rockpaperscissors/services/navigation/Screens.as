package com.cupcake.rockpaperscissors.services.navigation
{
    import com.core.domain.services.navigation.Screen;
    
    public class Screens
    {
        
        static public const MAIN:Screen = new Screen("MAIN");
        
        // main content
        static public const LOBBY:MainContentScreen = new MainContentScreen("LOBBY", 1 << 0);
        static public const GAME_PLAYER:MainContentScreen = new MainContentScreen("GAME_PLAYER", 1 << 1);
        static public const GAME_CPU:MainContentScreen = new MainContentScreen("GAME_CPU", 1 << 2);
        
        // huds
        static public const HUD:HudScreen = new HudScreen("HUD", 1 << 3);
        
        // loaders
        static public const LOADER:LoaderScreen = new LoaderScreen("LOADER_LOOBY", 1 << 4);
        
        // generics
        static public const WELCOME:GenericScreen = new GenericScreen("WELCOME", 1 << 5);
        static public const NOTIFICATION:GenericScreen = new GenericScreen("NOTIFICATION", 1 << 6);
        static public const ERROR:GenericScreen = new GenericScreen("ERROR", 1 << 7);
        
    }
}