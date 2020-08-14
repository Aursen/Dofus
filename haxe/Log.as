package haxe
{
    public class Log 
    {

        public static var trace:Function = function (_arg_1:*, _arg_2:Object=undefined):void
    {
        var _local_3:String = Log.formatOutput(_arg_1, _arg_2);
        trace(_local_3);
    };

        public function Log():void
        {
        }

        public static function formatOutput(_arg_1:*, _arg_2:Object):String
        {
            var _local_5:int;
            var _local_6:* = (null as Array);
            var _local_7:* = null;
            var _local_3:String = Std.string(_arg_1);
            if (_arg_2 == null)
            {
                return (_local_3);
            };
            var _local_4:String = ((_arg_2.fileName + ":") + _arg_2.lineNumber);
            if (((_arg_2 != (null)) && (!(_arg_2.customParams == null))))
            {
                _local_5 = 0;
                _local_6 = _arg_2.customParams;
                while (_local_5 < _local_6.length)
                {
                    _local_7 = _local_6[_local_5];
                    _local_5++;
                    _local_3 = (_local_3 + (", " + Std.string(_local_7)));
                };
            };
            return ((_local_4 + ": ") + _local_3);
        }


    }
} haxe
import haxe.Log;

[OP_NEWCLASS ClassInfo:6458 base:Object].trace = function (_arg_1:*, _arg_2:Object=undefined):void
{
    var _local_3:String = Log.formatOutput(_arg_1, _arg_2);
    trace(_local_3);
};

