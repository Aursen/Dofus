package 
{
    import flash.Boot;
    import flash.Lib;
    import flash.display.MovieClip;

    public class haxe extends Boot 
    {

        public function haxe():void
        {
        }

        public static function initSwc(_arg_1:MovieClip):void
        {
            Lib.current = _arg_1;
            new haxe().init();
        }


        override public function init():void
        {
        }


    }
} 
var _local_1:* = Date;
_local_1.now = function ():*
{
    return (new (Date)());
};
_local_1.fromTime = function (_arg_1:*):Date
{
    var _local_2:Date = new (Date)();
    _local_2.setTime(_arg_1);
    return (_local_2);
};
_local_1.fromString = function (_arg_1:String):Date
{
    var _local_2:* = (null as Array);
    var _local_3:* = (null as Date);
    var _local_4:* = (null as Array);
    var _local_5:* = (null as Array);
    switch (_arg_1.length)
    {
        default:
            throw ("Invalid date format : " + _arg_1);
        case 8:
            _local_2 = _arg_1.split(":");
            _local_3 = new (Date)();
            _local_3.setTime(0);
            _local_3.setUTCHours(_local_2[0]);
            _local_3.setUTCMinutes(_local_2[1]);
            _local_3.setUTCSeconds(_local_2[2]);
            return (_local_3);
        case 10:
            _local_2 = _arg_1.split("-");
            return (new Date(_local_2[0], (_local_2[1] - 1), _local_2[2], 0, 0, 0));
        case 19:
            _local_2 = _arg_1.split(" ");
            _local_4 = _local_2[0].split("-");
            _local_5 = _local_2[1].split(":");
            return (new Date(_local_4[0], (_local_4[1] - 1), _local_4[2], _local_5[0], _local_5[1], _local_5[2]));
            return; //dead code
    };
};
_local_1.prototype["toString"] = function ():String
{
    var _local_1:Date = this;
    var _local_2:* = (_local_1.getMonth() + 1);
    var _local_3:int = _local_1.getDate();
    var _local_4:int = _local_1.getHours();
    var _local_5:int = _local_1.getMinutes();
    var _local_6:int = _local_1.getSeconds();
    return ((((((((((_local_1.getFullYear() + "-") + ((_local_2 < 10) ? ("0" + _local_2) : ("" + _local_2))) + "-") + ((_local_3 < 10) ? ("0" + _local_3) : ("" + _local_3))) + " ") + ((_local_4 < 10) ? ("0" + _local_4) : ("" + _local_4))) + ":") + ((_local_5 < 10) ? ("0" + _local_5) : ("" + _local_5))) + ":") + ((_local_6 < 10) ? ("0" + _local_6) : ("" + _local_6)));
};
Math.NaN = Number.NaN;
Math.NEGATIVE_INFINITY = Number.NEGATIVE_INFINITY;
Math.POSITIVE_INFINITY = Number.POSITIVE_INFINITY;
Math.isFinite = function (_arg_1:Number):Boolean
{
    return (isFinite(_arg_1));
};
Math.isNaN = function (_arg_1:Number):Boolean
{
    return (isNaN(_arg_1));
};

