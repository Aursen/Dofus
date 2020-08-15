package gs.plugins
{
    import flash.filters.BevelFilter;
    import gs.TweenLite;
    import gs.*;

    public class BevelFilterPlugin extends FilterPlugin 
    {

        public static const API:Number = 1;
        private static var _propNames:Array = ["distance", "angle", "highlightColor", "highlightAlpha", "shadowColor", "shadowAlpha", "blurX", "blurY", "strength", "quality"];

        public function BevelFilterPlugin()
        {
            this.propName = "bevelFilter";
            this.overwriteProps = ["bevelFilter"];
        }

        override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean
        {
            _target = target;
            _type = BevelFilter;
            initFilter(value, new BevelFilter(0, 0, 0xFFFFFF, 0.5, 0, 0.5, 2, 2, 0, ((value.quality) || (2))), _propNames);
            return (true);
        }


    }
}

