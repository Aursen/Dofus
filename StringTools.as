package 
{
    public class StringTools 
    {

        public function StringTools():void
        {
        }

        public static function replace(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            return (_arg_1.split(_arg_2).join(_arg_3));
        }


    }
}

