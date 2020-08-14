package 
{
    import flash.Boot;

    public class Std 
    {

        public function Std():void
        {
        }

        public static function _SafeStr_1(_arg_1:*, _arg_2:*):Boolean
        {
            return (Boot.__instanceof(_arg_1, _arg_2));
        }

        public static function string(_arg_1:*):String
        {
            return (Boot.__string_rec(_arg_1, ""));
        }

        public static function parseInt(_arg_1:String):Object
        {
            var _local_2:Object = parseInt(_arg_1);
            if (isNaN(_local_2))
            {
                return (null);
            };
            return (_local_2);
        }


    }
} 

// _SafeStr_1 = "is" (String#109200)


