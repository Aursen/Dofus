package flash
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.display.Stage;
    import flash.utils.getQualifiedClassName;
    import flash.utils.ByteArray;
    import flash.utils.Endian;
    import flash.events.Event;
    import flash.utils.setTimeout;

    public class Boot extends MovieClip 
    {

        public static var tf:TextField;
        public static var lines:Array;
        public static var lastError:Error;
        public static var skip_constructor:Boolean = false;
        public static var IN_E:int = 0;

        public function Boot():void
        {
        }

        public static function enum_to_string(_arg_1:Object):String
        {
            var _local_3:int;
            var _local_4:* = (null as Array);
            var _local_5:* = null;
            if (_arg_1.params == null)
            {
                return (_arg_1.tag);
            };
            var _local_2:Array = [];
            if (Boot.IN_E > 15)
            {
                _local_2.push("...");
            }
            else
            {
                Boot.IN_E = (Boot.IN_E + 1);
                _local_3 = 0;
                _local_4 = _arg_1.params;
                while (_local_3 < _local_4.length)
                {
                    _local_5 = _local_4[_local_3];
                    _local_3++;
                    _local_2.push(Boot.__string_rec(_local_5, ""));
                };
                Boot.IN_E = (Boot.IN_E - 1);
            };
            return (((_arg_1.tag + "(") + _local_2.join(",")) + ")");
        }

        public static function __instanceof(_arg_1:*, _arg_2:*):Boolean
        {
            var _local_4:* = null;
            try
            {
                if (_arg_2 == Dynamic)
                {
                    return (true);
                };
                return (_arg_1 is _arg_2);
            }
            catch(_unnamedErr)
            {
                _local_4 = _unnamedErr;
            };
            return (false);
        }

        public static function __clear_trace():void
        {
            if (Boot.tf == null)
            {
                return;
            };
            Boot.tf.parent.removeChild(Boot.tf);
            Boot.tf = null;
            Boot.lines = null;
        }

        public static function __set_trace_color(_arg_1:uint):void
        {
            var _local_2:TextField = Boot.getTrace();
            _local_2.textColor = _arg_1;
            _local_2.filters = [];
        }

        public static function getTrace():TextField
        {
            var _local_2:* = (null as TextFormat);
            var _local_1:MovieClip = Lib.current;
            if (Boot.tf == null)
            {
                Boot.tf = new TextField();
                _local_2 = Boot.tf.getTextFormat();
                _local_2.font = "_sans";
                Boot.tf.defaultTextFormat = _local_2;
                Boot.tf.selectable = false;
                Boot.tf.width = ((_local_1.stage == null) ? 800 : _local_1.stage.stageWidth);
                Boot.tf.autoSize = TextFieldAutoSize.LEFT;
                Boot.tf.mouseEnabled = false;
            };
            if (_local_1.stage == null)
            {
                _local_1.addChild(Boot.tf);
            }
            else
            {
                _local_1.stage.addChild(Boot.tf);
            };
            return (Boot.tf);
        }

        public static function __trace(_arg_1:*, _arg_2:Object):void
        {
            var _local_6:int;
            var _local_7:* = (null as Array);
            var _local_8:* = null;
            var _local_3:TextField = Boot.getTrace();
            var _local_4:String = ((_arg_2 == null) ? "(null)" : ((_arg_2.fileName + ":") + _arg_2.lineNumber));
            if (Boot.lines == null)
            {
                Boot.lines = [];
            };
            var _local_5:String = ((_local_4 + ": ") + Boot.__string_rec(_arg_1, ""));
            if (((_arg_2 != (null)) && (!(_arg_2.customParams == null))))
            {
                _local_6 = 0;
                _local_7 = _arg_2.customParams;
                while (_local_6 < _local_7.length)
                {
                    _local_8 = _local_7[_local_6];
                    _local_6++;
                    _local_5 = (_local_5 + ("," + Boot.__string_rec(_local_8, "")));
                };
            };
            Boot.lines = Boot.lines.concat(_local_5.split("\n"));
            _local_3.text = Boot.lines.join("\n");
            var _local_9:Stage = Lib.current.stage;
            if (_local_9 == null)
            {
                return;
            };
            while (((Boot.lines.length > (1)) && (_local_3.height > _local_9.stageHeight)))
            {
                Boot.lines.shift();
                _local_3.text = Boot.lines.join("\n");
            };
        }

        public static function __string_rec(_arg_1:*, _arg_2:String):String
        {
            var _local_5:* = (null as String);
            var _local_6:* = (null as String);
            var _local_7:* = null;
            var _local_8:Boolean;
            var _local_9:* = (null as Array);
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:* = (null as Array);
            var _local_14:* = (null as String);
            var _local_4:String = getQualifiedClassName(_arg_1);
            _local_5 = _local_4;
            if (_local_5 == "Array")
            {
                if (_arg_1 == Array)
                {
                    return ("#Array");
                };
                _local_6 = "[";
                _local_8 = true;
                _local_9 = _arg_1;
                _local_10 = 0;
                _local_11 = _local_9.length;
                while (_local_10 < _local_11)
                {
                    _local_12 = _local_10++;
                    if (_local_8)
                    {
                        _local_8 = false;
                    }
                    else
                    {
                        _local_6 = (_local_6 + ",");
                    };
                    _local_6 = (_local_6 + Boot.__string_rec(_local_9[_local_12], _arg_2));
                };
                return (_local_6 + "]");
            };
            if (_local_5 == "Object")
            {
                _local_10 = 0;
                _local_13 = [];
                _local_7 = _arg_1;
                for (var _temp_1 in _arg_1)
                {
                    _local_13.push(_temp_1);
                };
                _local_9 = _local_13;
                _local_6 = "{";
                _local_8 = true;
                _local_10 = 0;
                _local_11 = _local_9.length;
                while (_local_10 < _local_11)
                {
                    _local_12 = _local_10++;
                    _local_14 = _local_9[_local_12];
                    if (_local_14 == "toString")
                    {
                        try
                        {
                            return (_arg_1.toString());
                        }
                        catch(_unnamedErr)
                        {
                            _local_7 = _unnamedErr;
                        };
                    };
                    if (_local_8)
                    {
                        _local_8 = false;
                    }
                    else
                    {
                        _local_6 = (_local_6 + ",");
                    };
                    _local_6 = (_local_6 + (((" " + _local_14) + " : ") + Boot.__string_rec(_arg_1[_local_14], _arg_2)));
                };
                if (!_local_8)
                {
                    _local_6 = (_local_6 + " ");
                };
                return (_local_6 + "}");
            };
            _local_5 = typeof(_arg_1);
            if (_local_5 == "function")
            {
                return ("<function>");
            };
            if (_local_5 == "undefined")
            {
                return ("null");
            };
            return (new String(_arg_1));
        }

        public static function fromCodePoint(_arg_1:int):String
        {
            var _local_2:ByteArray = new ByteArray();
            _local_2.endian = Endian.LITTLE_ENDIAN;
            _local_2.writeShort(((_arg_1 >> 10) + 55232));
            _local_2.writeShort(((_arg_1 & 0x03FF) + 0xDC00));
            _local_2.position = 0;
            return (_local_2.readMultiByte(4, "unicode"));
        }

        public static function __unprotect__(_arg_1:String):String
        {
            return (_arg_1);
        }

        public static function mapDynamic(_arg_1:*, _arg_2:*):*
        {
            if ((_arg_1 is Array))
            {
                return (_arg_1["mapHX"](_arg_2));
            };
            return (_arg_1["map"](_arg_2));
        }

        public static function filterDynamic(_arg_1:*, _arg_2:*):*
        {
            if ((_arg_1 is Array))
            {
                return (_arg_1["filterHX"](_arg_2));
            };
            return (_arg_1["filter"](_arg_2));
        }


        public function start():void
        {
            var _local_3:* = null;
            var _local_2:MovieClip = Lib.current;
            try
            {
                if ((((_local_2 == (this)) && (!(_local_2.stage == null))) && (_local_2.stage.align == "")))
                {
                    _local_2.stage.align = "TOP_LEFT";
                };
            }
            catch(_unnamedErr)
            {
                _local_3 = _unnamedErr;
            };
            if (_local_2.stage == null)
            {
                _local_2.addEventListener(Event.ADDED_TO_STAGE, doInitDelay);
            }
            else
            {
                if (((_local_2.stage.stageWidth == (0)) || (_local_2.stage.stageHeight == 0)))
                {
                    setTimeout(start, 1);
                }
                else
                {
                    init();
                };
            };
        }

        public function init():void
        {
            throw ("assert");
        }

        public function doInitDelay(_arg_1:*):void
        {
            Lib.current.removeEventListener(Event.ADDED_TO_STAGE, doInitDelay);
            start();
        }


    }
} flash
var _local_1:* = Array.prototype;
_local_1.copy = function ():*
{
    return (this.slice());
};
_local_1.insert = function (_arg_1:*, _arg_2:*):void
{
    this.splice(_arg_1, 0, _arg_2);
};
_local_1.remove = function (_arg_1:*):Boolean
{
    var _local_2:int = this.indexOf(_arg_1);
    if (_local_2 == -1)
    {
        return (false);
    };
    this.splice(_local_2, 1);
    return (true);
};
_local_1.iterator = function ():Object
{
    var cur:int;
    var arr:Array = this;
    return ({
        "hasNext":function ():Boolean
        {
            return (cur < arr.length);
        },
        "next":function ():*
        {
            cur = (cur + 1);
            return (arr[(cur - 1)]);
        }
    });
};
_local_1.resize = function (_arg_1:*):void
{
    this.length = _arg_1;
};
_local_1.setPropertyIsEnumerable("copy", false);
_local_1.setPropertyIsEnumerable("insert", false);
_local_1.setPropertyIsEnumerable("remove", false);
_local_1.setPropertyIsEnumerable("iterator", false);
_local_1.setPropertyIsEnumerable("resize", false);
_local_1["filter"] = function (_arg_1:Function):Array
{
    var _local_2:Array = [];
    var _local_3:int;
    var _local_4:int = this.length;
    while (_local_3 < _local_4)
    {
        if (_arg_1(this[_local_3]))
        {
            _local_2.push(this[_local_3]);
        };
        _local_3++;
    };
    return (_local_2);
};
_local_1["map"] = function (_arg_1:Function):Array
{
    var _local_2:Array = [];
    var _local_3:int;
    var _local_4:int = this.length;
    while (_local_3 < _local_4)
    {
        _local_2.push(_arg_1(this[_local_3]));
        _local_3++;
    };
    return (_local_2);
};
_local_1.setPropertyIsEnumerable("map", false);
_local_1.setPropertyIsEnumerable("filter", false);
String.prototype.charCodeAt = function (_arg_1:*):Object
{
    var _local_2:String = this;
    var _local_3:Number = _local_2.charCodeAt(_arg_1);
    if (isNaN(_local_3))
    {
        return (null);
    };
    return (_local_3);
};

