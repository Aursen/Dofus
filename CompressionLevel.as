package 
{
    import flash.Boot;

    public final class CompressionLevel 
    {

        public static var FAST:CompressionLevel = new CompressionLevel("FAST", 1, null);
        public static var GOOD:CompressionLevel = new CompressionLevel("GOOD", 3, null);
        public static var NORMAL:CompressionLevel = new CompressionLevel("NORMAL", 2, null);
        public static var UNCOMPRESSED:CompressionLevel = new CompressionLevel("UNCOMPRESSED", 0, null);
        public static var __constructs__:* = ["UNCOMPRESSED", "FAST", "NORMAL", "GOOD"];
        public static const __isenum:Boolean = true;

        public const __enum__:Boolean = true;

        public var tag:String;
        public var index:int;
        public var params:Array;

        public function CompressionLevel(_arg_1:String, _arg_2:int, _arg_3:*):void
        {
            tag = _arg_1;
            index = _arg_2;
            params = _arg_3;
        }

        final public function toString():String
        {
            return (Boot.enum_to_string(this));
        }


    }
} 

