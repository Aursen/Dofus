package com.ankamagames.jerakine.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;
    import flash.display.MovieClip;
    import flash.display.BitmapData;
    import __AS3__.vec.Vector;
    import flash.geom.Point;
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.ui.MouseCursorData;
    import flash.display.DisplayObjectContainer;
    import __AS3__.vec.*;

    public class CursorSpriteManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CursorSpriteManager));
        private static const MAX_CURSOR_SIZE:int = 32;
        private static var _cursorDataByName:Dictionary = new Dictionary();


        public static function displaySpecificCursor(name:String, cursorSprite:*):void
        {
            if (!Mouse.supportsNativeCursor)
            {
                return;
            };
            if (Mouse.cursor == name)
            {
                return;
            };
            if (!_cursorDataByName[name])
            {
                registerSpecificCursor(name, cursorSprite);
            };
            Mouse.cursor = name;
        }

        public static function registerSpecificCursor(name:String, cursorSprite:*):void
        {
            if (!Mouse.supportsNativeCursor)
            {
                return;
            };
            if (_cursorDataByName[name])
            {
                return;
            };
            registerCursorData(name, cursorSprite);
        }

        public static function resetCursor(name:String=""):void
        {
            if (((!(name == "")) && (!(Mouse.cursor == name))))
            {
                return;
            };
            Mouse.cursor = MouseCursor.AUTO;
        }

        private static function registerCursorData(name:String, cursorSprite:*):void
        {
            var clip:MovieClip;
            var frameIndex:int;
            var cursorFrameBitmapData:BitmapData;
            var cursorBitmapDataList:Vector.<BitmapData> = new Vector.<BitmapData>();
            var cursorBitmapData:BitmapData = new BitmapData(MAX_CURSOR_SIZE, MAX_CURSOR_SIZE, true, 0);
            var hotSpot:Point = new Point();
            if (((cursorSprite.width > MAX_CURSOR_SIZE) || (cursorSprite.height > MAX_CURSOR_SIZE)))
            {
                _log.warn((((((((("Cursor is too big to be displayed, " + cursorSprite.width) + "x") + cursorSprite.height) + " instead of ") + MAX_CURSOR_SIZE) + "x") + MAX_CURSOR_SIZE) + ", it will be truncated."));
            };
            if ((cursorSprite is Bitmap))
            {
                cursorBitmapData = Bitmap(cursorSprite).bitmapData;
                cursorBitmapDataList.push(cursorBitmapData);
            }
            else
            {
                if ((cursorSprite is BitmapData))
                {
                    cursorBitmapData = cursorSprite;
                    cursorBitmapDataList.push(cursorBitmapData);
                }
                else
                {
                    if ((cursorSprite is MovieClip))
                    {
                        clip = cursorSprite;
                        hotSpot = getOrigin(cursorSprite);
                        frameIndex = 1;
                        while (frameIndex <= clip.totalFrames)
                        {
                            clip.gotoAndStop(frameIndex);
                            cursorFrameBitmapData = new BitmapData(MAX_CURSOR_SIZE, MAX_CURSOR_SIZE, true, 0);
                            cursorFrameBitmapData.draw(clip);
                            cursorBitmapDataList.push(cursorFrameBitmapData);
                            frameIndex++;
                        };
                    }
                    else
                    {
                        if ((cursorSprite is DisplayObject))
                        {
                            hotSpot = getOrigin(cursorSprite);
                            cursorBitmapData.draw(cursorSprite);
                            cursorBitmapDataList.push(cursorBitmapData);
                        }
                        else
                        {
                            return;
                        };
                    };
                };
            };
            var cursorData:MouseCursorData = new MouseCursorData();
            cursorData.data = cursorBitmapDataList;
            cursorData.hotSpot = hotSpot;
            cursorData.frameRate = 25;
            Mouse.registerCursor(name, cursorData);
            _cursorDataByName[name] = cursorData;
        }

        private static function getOrigin(target:DisplayObject):Point
        {
            var doc:DisplayObjectContainer;
            var i:uint;
            if ((target is DisplayObjectContainer))
            {
                doc = (target as DisplayObjectContainer);
                i = 0;
                while (i < doc.numChildren)
                {
                    if (doc.getChildAt(i).name.indexOf("origin") != -1)
                    {
                        return (new Point(doc.getChildAt(i).x, doc.getChildAt(i).y));
                    };
                    i++;
                };
            };
            return (new Point());
        }


    }
} com.ankamagames.jerakine.managers

