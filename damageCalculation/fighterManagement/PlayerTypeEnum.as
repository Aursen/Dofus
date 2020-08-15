package damageCalculation.fighterManagement
{
    import flash.Boot;

    public final class PlayerTypeEnum 
    {

        public static var HUMAN:PlayerTypeEnum = new PlayerTypeEnum("HUMAN", 1, null);
        public static var MONSTER:PlayerTypeEnum = new PlayerTypeEnum("MONSTER", 3, null);
        public static var SIDEKICK:PlayerTypeEnum = new PlayerTypeEnum("SIDEKICK", 2, null);
        public static var UNKNOWN:PlayerTypeEnum = new PlayerTypeEnum("UNKNOWN", 0, null);
        public static var __constructs__:Array = ["UNKNOWN", "HUMAN", "SIDEKICK", "MONSTER"];
        public static const __isenum:Boolean = true;

        public const __enum__:Boolean = true;

        public var tag:String;
        public var index:int;
        public var params:Array;

        public function PlayerTypeEnum(_arg_1:String, _arg_2:int, _arg_3:Array):void
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

