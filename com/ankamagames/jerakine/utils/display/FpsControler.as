package com.ankamagames.jerakine.utils.display
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import flash.display.DisplayObjectContainer;
    import __AS3__.vec.*;

    public class FpsControler 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FpsControler));
        private static var ScriptedAnimation:Class;
        private static var _clipList:Vector.<MovieClip> = new Vector.<MovieClip>();
        private static var _garbageTimer:Timer;


        public static function Init(scriptedAnimation:Class):void
        {
            ScriptedAnimation = scriptedAnimation;
            if (!_garbageTimer)
            {
                _garbageTimer = new Timer(10000);
                _garbageTimer.addEventListener(TimerEvent.TIMER, onGarbageTimer);
                _garbageTimer.start();
            };
        }

        private static function onGarbageTimer(E:Event):void
        {
            var movieClip:MovieClip;
            var i:int;
            while (i < _clipList.length)
            {
                movieClip = _clipList[i];
                if (!movieClip.stage)
                {
                    uncontrolFps(movieClip, false);
                };
                i++;
            };
        }

        public static function controlFps(clip:MovieClip, framerate:uint, forbidRecursivity:Boolean=false):MovieClip
        {
            if (!MovieClipUtils.isSingleFrame(clip))
            {
                controlSingleClip(clip, framerate, forbidRecursivity);
            };
            return (clip);
        }

        public static function uncontrolFps(displayObject:DisplayObjectContainer, group:Boolean=true):void
        {
            var i:int;
            var child:MovieClip;
            if (!displayObject)
            {
                return;
            };
            MovieClipUtils.stopMovieClip(displayObject);
            var movieClip:MovieClip = (displayObject as MovieClip);
            if (((group) && (movieClip)))
            {
                if (_clipList.indexOf(movieClip) != -1)
                {
                    i = 0;
                    while (i < movieClip.numChildren)
                    {
                        child = (movieClip.getChildAt(i) as MovieClip);
                        if (child)
                        {
                            uncontrolFps(child, group);
                        };
                        i++;
                    };
                };
            };
            removeClip(movieClip);
        }

        public static function containsFps(clip:DisplayObjectContainer):Boolean
        {
            if ((clip is MovieClip))
            {
                return (!(_clipList.indexOf(clip) == -1));
            };
            return (false);
        }

        private static function removeClip(mc:MovieClip):void
        {
            var index:int = _clipList.indexOf(mc);
            if (index != -1)
            {
                _clipList.splice(index, 1);
            };
        }

        private static function controlSingleClip(clip:DisplayObjectContainer, framerate:uint, forbidRecursivity:Boolean=false, recursive:Boolean=false):void
        {
            var i:int;
            var numChildren:int;
            var child:DisplayObjectContainer;
            if (((clip) && (!(forbidRecursivity))))
            {
                i = -1;
                numChildren = clip.numChildren;
                while (++i < numChildren)
                {
                    child = (clip.getChildAt(i) as DisplayObjectContainer);
                    if (child)
                    {
                        controlSingleClip(child, framerate, true, true);
                    };
                };
            };
            if (((recursive) && (clip is ScriptedAnimation)))
            {
                return;
            };
            var movieClip:MovieClip = (clip as MovieClip);
            if ((((!(movieClip)) || (movieClip.totalFrames == 1)) || (!(_clipList.indexOf(movieClip) == -1))))
            {
                return;
            };
            var startFrame:int = ((movieClip.currentFrame > 0) ? movieClip.currentFrame : 1);
            movieClip.gotoAndStop(startFrame);
            if ((movieClip is ScriptedAnimation))
            {
                movieClip.playEventAtFrame(startFrame);
            };
            _clipList.push(movieClip);
        }

        public static function nextFrame():void
        {
            var movieClip:MovieClip;
            var frame:int;
            var diff:int;
            var num:int = _clipList.length;
            var i:int = -1;
            while (++i < num)
            {
                movieClip = _clipList[i];
                frame = (movieClip.currentFrame + 1);
                if (frame > movieClip.totalFrames)
                {
                    frame = 1;
                };
                movieClip.gotoAndStop(frame);
                if ((movieClip is ScriptedAnimation))
                {
                    movieClip.playEventAtFrame(frame);
                };
                diff = (num - _clipList.length);
                if (diff)
                {
                    num = (num - diff);
                    i = (i - diff);
                    if (i < 0)
                    {
                        i = 0;
                    };
                };
            };
        }


    }
} com.ankamagames.jerakine.utils.display

