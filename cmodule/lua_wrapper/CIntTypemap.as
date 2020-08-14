package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal class CIntTypemap extends CTypemap 
    {


        override public function fromC(_arg_1:Array):*
        {
            return (int(_arg_1[0]));
        }

        override public function createC(_arg_1:*, _arg_2:int=0):Array
        {
            return ([int(_arg_1)]);
        }


    }
} cmodule.lua_wrapper

