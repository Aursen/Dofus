package cmodule.lua_wrapper
{
    internal class RCValue 
    {

        public var rc:int = 1;
        public var value:*;
        public var id:int;

        public function RCValue(_arg_1:*, _arg_2:int)
        {
            this.value = _arg_1;
            this.id = _arg_2;
        }

    }
}

