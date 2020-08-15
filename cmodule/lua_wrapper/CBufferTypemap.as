package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal class CBufferTypemap extends CTypemap 
    {


        override public function destroyC(_arg_1:Array):void
        {
            CBuffer.free(_arg_1[0]);
        }

        override public function createC(_arg_1:*, _arg_2:int=0):Array
        {
            var _local_3:CBuffer;
            _local_3 = _arg_1;
            _local_3.reset();
            return ([_local_3.ptr]);
        }


    }
}

