package com.cupcake.rockpaperscissors.hud.controller
{
    import com.core.domain.services.controller.ScreenController;
    import com.core.domain.services.view.IHud;
    import com.core.domain.services.view.IView;
    import com.core.utils.Singleton;
    import com.cupcake.rockpaperscissors.hud.view.HudView;
    
    public class HudController extends ScreenController
    {
        static public var ME:HudController;
        
        function HudController(autoCreateView:Boolean = false)
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
            return HudView;
        }
        
        override public function toString():String
        {
            return "[HudController(view: " + super.getView() + ")]";
        }
        
        private var view:IHud;
        
        override public function getView():IView
        {
            return view = super.getView() as IHud;
        }
        
    }
}
