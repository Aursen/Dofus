package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal function AS3_CallTS(_arg_1:String, _arg_2:Object, _arg_3:String, _arg_4:int):*
    {
        return (_arg_2[_arg_1].apply(_arg_2, AS3_Array(_arg_3, _arg_4)));
    }

} cmodule.lua_wrapper

