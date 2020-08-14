package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal function AS3_CallS(_arg_1:String, _arg_2:Object, _arg_3:Array):*
    {
        return (_arg_2[_arg_1].apply(_arg_2, _arg_3));
    }

} cmodule.lua_wrapper

