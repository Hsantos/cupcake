package com.cupcake.rockpaperscissors.assets
{
    import flash.text.Font;
    
    public class Fonts
    {
        //ttc
        [Embed(source="../../../../../../domain/assets/fonts/Charter.ttc", mimeType="application/x-font-truetype", embedAsCFF="false", fontName="CharterBlack", fontWeight="bold")]
        static private const CharterBlackFont:Class;
        static public const CHARTER_BLACK:String = "CharterBlack";
        
        //ttf
        [Embed(source="../../../../../../domain/assets/fonts/Frijole-Regular.ttf", mimeType="application/x-font-truetype", embedAsCFF="false", fontName="FrijoleRegular", fontWeight="regular")]
        static private const FrijoleRegularFont:Class;
        static public const FRIJOLE_REGULAR:String = "FrijoleRegular";
        
        static public function initiate():void
        {
            Font.registerFont(CharterBlackFont);
            Font.registerFont(FrijoleRegularFont);
        }
        
    }
}
