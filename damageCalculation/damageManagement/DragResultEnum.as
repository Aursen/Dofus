package damageCalculation.damageManagement
{
    import flash.Boot;

    public final class DragResultEnum 
    {

        public static var ACTIVE_OBJECT:DragResultEnum = new DragResultEnum("ACTIVE_OBJECT", 2, null);
        public static var COLLISION:DragResultEnum = new DragResultEnum("COLLISION", 1, null);
        public static var COMPLETE:DragResultEnum = new DragResultEnum("COMPLETE", 0, null);
        public static var PORTAL:DragResultEnum = new DragResultEnum("PORTAL", 3, null);
        public static var __constructs__:Array = ["COMPLETE", "COLLISION", "ACTIVE_OBJECT", "PORTAL"];
        public static const __isenum:Boolean = true;

        public const __enum__:Boolean = true;

        public var tag:String;
        public var index:int;
        public var params:Array;

        public function DragResultEnum(_arg_1:String, _arg_2:int, _arg_3:Array):void
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
} damageCalculation.damageManagement

