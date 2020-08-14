package com.ankamagames.tiphon.types
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.geom.ColorTransform;

    public class ColoredSprite extends DynamicSprite 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ColoredSprite));
        private static const NEUTRAL_COLOR_TRANSFORM:ColorTransform = new ColorTransform();


        override public function init(handler:IAnimationSpriteHandler):void
        {
            var colorT:ColorTransform;
            var qualifiedClassName:String = getQualifiedClassName(this);
            var firstIndexOf:int = qualifiedClassName.indexOf("_");
            var secondIndexOf:int = qualifiedClassName.indexOf("_", (firstIndexOf + 1));
            var colorIndex:String = ((secondIndexOf < 0) ? qualifiedClassName.substring((firstIndexOf + 1)) : qualifiedClassName.substring((firstIndexOf + 1), secondIndexOf));
            var nColorIndex:uint = parseInt(colorIndex);
            colorT = handler.getColorTransform(nColorIndex);
            if (colorT)
            {
                this.colorize(colorT);
            };
            handler.registerColoredSprite(this, nColorIndex);
        }

        public function colorize(colorT:ColorTransform):void
        {
            if (colorT)
            {
                transform.colorTransform = colorT;
            }
            else
            {
                transform.colorTransform = NEUTRAL_COLOR_TRANSFORM;
            };
        }


    }
} com.ankamagames.tiphon.types

