package com.cupcake.rockpaperscissors.main.controller
{
    import com.core.domain.services.controller.ScreenController;
    import com.core.domain.services.view.IGame;
    import com.core.domain.services.view.IGeneric;
    import com.core.domain.services.view.IHud;
    import com.core.domain.services.view.ILoader;
    import com.core.domain.services.view.IView;
    import com.core.utils.Singleton;
    import com.cupcake.rockpaperscissors.main.view.MainView;
    
    public class MainController extends ScreenController
    {
        static public var ME:MainController;
        
        function MainController(autoCreateView:Boolean = false)
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
            return MainView;
        }
        
        override public function toString():String
        {
            return "[MainController(view: " + super.getView() + ")]";
        }
        
        private var view:MainView;
        
        override public function getView():IView
        {
            return view = super.getView() as MainView;
        }
        
        public function addGame(game:IGame):void
        {
            view.addGame(game);
        }
        
        public function addHud(hud:IHud):void
        {
            view.addHud(hud);
        }
        
        public function addGeneric(generic:IGeneric):void
        {
            view.addGeneric(generic);
        }
        
        public function addLoader(loader:ILoader):void
        {
            view.addLoader(loader);
        }
        
    }
}
