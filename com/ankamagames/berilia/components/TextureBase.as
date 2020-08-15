package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import flash.utils.Dictionary;
    import flash.geom.ColorTransform;
    import com.ankamagames.jerakine.types.Uri;
    import flash.display.BitmapData;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.berilia.BeriliaConstants;
    import flash.display.DisplayObject;
    import com.ankamagames.jerakine.resources.ResourceType;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;

    public class TextureBase extends GraphicContainer 
    {

        protected static var _bitmapCache:Dictionary = new Dictionary(true);
        protected static var _totalBitmapInCache:uint = 0;
        protected static var _textureReference:Dictionary = new Dictionary(true);
        protected static var _userColors:Array;
        protected static const NULL_COLOR:ColorTransform = new ColorTransform();
        private static var _init:Boolean;

        protected var _autoCenterBitmap:Boolean;
        protected var _smooth:Boolean = false;
        protected var _showLoadingError:Boolean = true;
        protected var _uri:Uri;
        protected var _useCache:Boolean = true;
        protected var _useCacheTmp:Boolean = _useCache;

        public function TextureBase()
        {
            _textureReference[this] = true;
        }

        public static function getBitmapCache():Dictionary
        {
            return (_bitmapCache);
        }

        public static function clearCache():void
        {
            var b:BitmapData;
            for each (b in _bitmapCache)
            {
                b.dispose();
            };
            _bitmapCache = new Dictionary(true);
            _totalBitmapInCache = 0;
        }

        private static function addBitmapToCache(uriPath:String, bitmapData:BitmapData):void
        {
            if (((uriPath) && (!(_bitmapCache[uriPath]))))
            {
                _bitmapCache[uriPath] = bitmapData;
                _totalBitmapInCache++;
            };
        }

        private static function initUserColor():void
        {
            var i:int;
            var rawData:Object;
            var uc:UserColor;
            if (_init)
            {
                return;
            };
            _init = true;
            var userSavedColors:Array = StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_UI_CSS, "userUiColor");
            if (userSavedColors)
            {
                _userColors = new Array();
                i = (userSavedColors.length - 1);
                while (i > -1)
                {
                    rawData = userSavedColors[i];
                    uc = new UserColor();
                    uc.filter = rawData.filter;
                    uc.exclude = rawData.exclude;
                    uc.colorTransform = new ColorTransform(rawData.redMultiplier, rawData.greenMultiplier, rawData.blueMultiplier, 1, rawData.redOffset, rawData.greenOffset, rawData.blueOffset);
                    _userColors.push(uc);
                    i--;
                };
            };
        }

        public static function colorize(filter:String, ct:ColorTransform):void
        {
            var t:*;
            var tb:TextureBase;
            if (!filter)
            {
                return;
            };
            var exclude:* = (filter.charAt(0) == "-");
            addUserColor(filter.substr(((exclude) ? 1 : 0)), ct, exclude);
            for (t in _textureReference)
            {
                tb = t;
                if ((((tb) && (tb.uri)) && (!(tb.uri.fileType == "swf"))))
                {
                    tb.transform.colorTransform = getUserColor(tb.uri.path);
                };
            };
        }

        public static function getUserColorList():Array
        {
            var uc:UserColor;
            var r:Array = new Array();
            for each (uc in _userColors)
            {
                r.push([uc.filter, uc.exclude, ((uc.colorTransform) ? (((((((((((uc.colorTransform.redMultiplier + " ") + uc.colorTransform.greenMultiplier) + " ") + uc.colorTransform.blueMultiplier) + " ") + uc.colorTransform.redOffset) + " ") + uc.colorTransform.greenOffset) + " ") + uc.colorTransform.blueOffset)) : (""))]);
            };
            return (r);
        }

        public static function resetColor():void
        {
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_CSS, "userUiColor", null);
        }

        public static function saveColor():void
        {
            var uc:UserColor;
            var path:String;
            var t:*;
            var ct:ColorTransform;
            var bd:BitmapData;
            var tb:TextureBase;
            var dataToSave:Array = [];
            for each (uc in _userColors)
            {
                dataToSave.push({
                    "filter":uc.filter,
                    "exclude":uc.exclude,
                    "redMultiplier":uc.colorTransform.redMultiplier,
                    "greenMultiplier":uc.colorTransform.greenMultiplier,
                    "blueMultiplier":uc.colorTransform.blueMultiplier,
                    "redOffset":uc.colorTransform.redOffset,
                    "greenOffset":uc.colorTransform.greenOffset,
                    "blueOffset":uc.colorTransform.blueOffset
                });
            };
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_CSS, "userUiColor", dataToSave, true);
            for (path in _bitmapCache)
            {
                ct = getUserColor(path);
                if (((ct) && (!(ct == NULL_COLOR))))
                {
                    bd = _bitmapCache[path];
                    bd.colorTransform(bd.rect, ct);
                };
            };
            for (t in _textureReference)
            {
                tb = t;
                if ((((tb) && (tb.uri)) && (tb is TextureBitmap)))
                {
                    tb.transform.colorTransform = NULL_COLOR;
                };
            };
        }

        protected static function applyUserColor(path:String, target:*):void
        {
            var ct:ColorTransform = getUserColor(path);
            if (((ct) && (!(ct == NULL_COLOR))))
            {
                if ((target is BitmapData))
                {
                    BitmapData(target).colorTransform(target.rect, ct);
                }
                else
                {
                    if ((target is DisplayObject))
                    {
                        DisplayObject(target).transform.colorTransform = ct;
                    };
                };
            };
        }

        private static function addUserColor(filter:String, ct:ColorTransform, exclude:Boolean=false):void
        {
            var uc:UserColor;
            var i:* = undefined;
            if (!_userColors)
            {
                _userColors = new Array();
            };
            for (i in _userColors)
            {
                uc = _userColors[i];
                if (uc.filter == filter)
                {
                    uc.colorTransform = ((ct) ? ct : NULL_COLOR);
                    uc.exclude = exclude;
                    if ((((!(exclude)) && (ct == NULL_COLOR)) || (ct == null)))
                    {
                        delete _userColors[i];
                        break;
                    };
                    return;
                };
            };
            uc = new UserColor();
            uc.filter = filter;
            uc.colorTransform = ct;
            uc.exclude = exclude;
            _userColors.push(uc);
            _userColors.sort(function (a:UserColor, b:UserColor):int
            {
                if (a.filter.length > b.filter.length)
                {
                    return (1);
                };
                if (a.filter.length < b.filter.length)
                {
                    return (-1);
                };
                return (0);
            });
        }

        private static function getUserColor(heystack:String):ColorTransform
        {
            var uc:UserColor;
            if (((_userColors) && (heystack)))
            {
                for each (uc in _userColors)
                {
                    if (((!(heystack.indexOf(uc.filter) == -1)) || (uc.filter == "*")))
                    {
                        if (uc.exclude)
                        {
                            return (NULL_COLOR);
                        };
                        return (uc.colorTransform);
                    };
                };
            };
            return (NULL_COLOR);
        }


        public function get useCache():Boolean
        {
            return (this._useCache);
        }

        public function set useCache(value:Boolean):void
        {
            this._useCache = value;
            this._useCacheTmp = value;
        }

        public function get showLoadingError():Boolean
        {
            return (this._showLoadingError);
        }

        public function set showLoadingError(value:Boolean):void
        {
            this._showLoadingError = value;
        }

        public function get autoCenterBitmap():Boolean
        {
            return (this._autoCenterBitmap);
        }

        public function set autoCenterBitmap(value:Boolean):void
        {
            this._autoCenterBitmap = value;
        }

        public function get smooth():Boolean
        {
            return (this._smooth);
        }

        public function set smooth(value:Boolean):void
        {
            this._smooth = value;
        }

        [Uri]
        public function get uri():Uri
        {
            return (this._uri);
        }

        [Uri]
        public function set uri(uri:Uri):void
        {
        }

        protected function getBitmapDataFromCache(uriPath:String):BitmapData
        {
            if ((((this._useCache) && (uriPath)) && (_bitmapCache[uriPath])))
            {
                return (_bitmapCache[uriPath]);
            };
            return (null);
        }

        public function loadBitmapData(bmpdt:BitmapData):void
        {
        }

        protected function onLoaded(event:ResourceLoadedEvent):void
        {
            if (((this._useCache) && (event.resourceType == ResourceType.RESOURCE_BITMAP)))
            {
                addBitmapToCache(event.uri.path, event.resource);
            };
        }

        protected function onFailed(event:ResourceErrorEvent):void
        {
        }


    }
}

import flash.geom.ColorTransform;

class UserColor 
{

    public var exclude:Boolean = false;
    public var filter:String;
    public var colorTransform:ColorTransform;


}


