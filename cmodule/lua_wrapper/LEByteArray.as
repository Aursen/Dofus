package cmodule.lua_wrapper
{
    import flash.utils.ByteArray;

    internal class LEByteArray extends ByteArray 
    {

        public function LEByteArray()
        {
            super.endian = "littleEndian";
        }

        override public function set endian(_arg_1:String):void
        {
            throw ("LEByteArray endian set attempted");
        }


    }
}

