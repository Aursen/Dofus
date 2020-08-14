package com.ankamagames.jerakine.utils.display
{
    import flash.utils.Dictionary;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;

    public class MovieClipUtils 
    {

        private static var _asynchClip:Dictionary = new Dictionary(true);
        private static var _isAsync:Boolean;
        public static var asynchStopCount:uint;
        public static var asynchStopDoneCount:uint;


        public static function isSingleFrame(mc:DisplayObjectContainer):Boolean
        {
            var i:int;
            var num:int;
            var child:DisplayObjectContainer;
            var movieClip:MovieClip = (mc as MovieClip);
            if (((movieClip) && (movieClip.totalFrames > 1)))
            {
                return (false);
            };
            i = -1;
            num = mc.numChildren;
            while (++i < num)
            {
                child = (mc.getChildAt(i) as DisplayObjectContainer);
                if (((child) && (!(isSingleFrame(child)))))
                {
                    return (false);
                };
            };
            return (true);
        }

        public static function stopMovieClip(clip:DisplayObjectContainer):void
        {
            var child:DisplayObject;
            if ((clip is MovieClip))
            {
                MovieClip(clip).stop();
                if (((_isAsync) && (MovieClip(clip).totalFrames > 1)))
                {
                    asynchStopDoneCount++;
                };
            };
            var i:int = -1;
            var num:int = clip.numChildren;
            while (++i < num)
            {
                child = clip.getChildAt(i);
                if ((child is DisplayObjectContainer))
                {
                    stopMovieClip((child as DisplayObjectContainer));
                };
            };
        }


    }
} com.ankamagames.jerakine.utils.display

