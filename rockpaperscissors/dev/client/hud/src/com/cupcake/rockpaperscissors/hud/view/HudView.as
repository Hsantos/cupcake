package com.cupcake.rockpaperscissors.hud.view
{
    import com.core.domain.services.view.IHud;
    import com.core.domain.services.view.IView;
    import com.core.utils.Statics;
    import com.cupcake.rockpaperscissors.hud.assets.Fonts;
    
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.text.TextFormat;
    import starling.utils.Align;
    
    public class HudView extends Sprite implements IHud
    {
        
        function HudView()
        {
            Fonts.initiate();
        }
        
        override public function dispose():void
        {
            this.removeChildren(0, -1, true);
            this.removeFromParent();
            
            super.dispose();
        }
        
        private var top:Sprite;
        private var footer:Sprite;
        
        public function draw():IView
        {
            top = addChild(new Sprite()) as Sprite;
            top.addChild(new Quad(Statics.VIEW_PORT.width, 80, 0xffffff));
            
            var textTop:TextField = top.addChild(new TextField(200, 80, "HUD::TOP", new TextFormat(Fonts.FRIJOLE_REGULAR, 12, 0x313131))) as TextField;
            textTop.x = Statics.VIEW_PORT.width - textTop.width;
            textTop.autoScale = true;
            textTop.format.verticalAlign = Align.BOTTOM;
            textTop.format.horizontalAlign = Align.RIGHT;
            
            footer = addChild(new Sprite()) as Sprite;
            footer.addChild(new Quad(Statics.VIEW_PORT.width, 40, 0xffffff));
            footer.y = Statics.VIEW_PORT.height - footer.height;
            
            var textFooter:TextField = footer.addChild(new TextField(200, 40, "HUD::FOOTER", new TextFormat(Fonts.FRIJOLE_REGULAR, 12, 0x313131))) as TextField;
            textFooter.x = Statics.VIEW_PORT.width - textFooter.width;
            textFooter.autoScale = true;
            textFooter.format.verticalAlign = Align.BOTTOM;
            textFooter.format.horizontalAlign = Align.RIGHT;
            
            return this;
        }
        
        public function toString():String
        {
            return "[HudView()]";
        }
    }
}