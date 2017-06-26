package com.cupcake.rockpaperscissors.assets
{
    import com.core.utils.Singleton;
    import com.core.utils.Statics;
    import com.core.utils.Utils;
    
    import flash.display.Bitmap;
    import flash.utils.describeType;
    import flash.utils.getQualifiedClassName;
    
    public class Assets
    {
        
        [Embed(source="../../../../../../domain/assets/sprites/rps.png")]
        static public const rpsBitmap:Class;
        
        static public var ME:Assets = new Assets();
        
        function Assets()
        {
            Singleton.enforce(ME);
        }
        
        public function getBitmap(name:String):Bitmap
        {
            var textures:Object = Statics.APPLICATION_DOMAIN.getDefinition(getQualifiedClassName(this)) as Class;
            for each (var node:XML in describeType(textures)..constant)
            {
                if (name + "Bitmap" != node.@name) continue;
                
                Utils.print("Assets.getBitmap: " + name);
                
                var clazz:Object = textures[node.@name] as Class;
                return new clazz() as Bitmap;
            }
            
            throw new Error("bitmap \"" + name + "\" is missing");
        }
        
    }
}
