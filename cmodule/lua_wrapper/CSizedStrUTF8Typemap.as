package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal class CSizedStrUTF8Typemap extends CTypemap 
    {


        override public function fromC(_arg_1:Array):*
        {
            mstate.ds.position = _arg_1[0];
            return (mstate.ds.readUTFBytes(_arg_1[1]));
        }

        override public function get typeSize():int
        {
            return (8);
        }


    }
} cmodule.lua_wrapper

