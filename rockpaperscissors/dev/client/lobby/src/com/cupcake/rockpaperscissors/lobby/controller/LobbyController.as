package com.cupcake.rockpaperscissors.lobby.controller
{
    import com.core.domain.services.controller.ScreenController;
    import com.core.domain.services.view.IMainContent;
    import com.core.domain.services.view.IView;
    import com.core.utils.Singleton;
    import com.cupcake.rockpaperscissors.lobby.view.LobbyView;
    
    public class LobbyController extends ScreenController
    {
        static public var ME:LobbyController;
        
        function LobbyController(autoCreateView:Boolean = false)
        {
            ME = Singleton.enforce(ME, this);
            if (autoCreateView) createView();
        }
        
        override public function dispose():void
        {
            ME = null;
            super.dispose();
        }
        
        override public function getViewClass():Class
        {
            return LobbyView;
        }
        
        override public function toString():String
        {
            return "[LobbyController(view: " + super.getView() + ")]";
        }
        
        private var view:IMainContent;
        
        override public function getView():IView
        {
            return view = super.getView() as IMainContent;
        }
        
    }
}
