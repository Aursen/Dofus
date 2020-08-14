package 
{
    public class Reflect 
    {

        public function Reflect():void
        {
        }

        public static function field(_arg_1:*, _arg_2:String):*
        {
            var _local_4:* = null;
            try
            {
                return (_arg_1[_arg_2]);
            }
            catch(_unnamedErr)
            {
                _local_4 = _unnamedErr;
                return (null);
            };
        }

        public static function fields(_arg_1:*):Array
        {
            var _local_4:* = (null as String);
            if (_arg_1 == null)
            {
                return ([]);
            };
            var _local_2:int;
            var _local_3:Array = [];
            for (_local_4 in _arg_1)
            {
                if (_arg_1.hasOwnProperty(_local_4))
                {
                    _local_3.push(_local_4);
                };
            };
            return (_local_3);
        }

        public static function isFunction(_arg_1:*):Boolean
        {
            return (typeof(_arg_1) == "function");
        }


    }
} 

