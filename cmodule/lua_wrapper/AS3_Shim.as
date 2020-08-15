package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal function AS3_Shim(func:Function, thiz:Object, rt:String, tt:String, varargs:Boolean):int
    {
        var retType:CTypemap;
        var argTypes:Array;
        var tm:CTypemap;
        var id:int;
        retType = CTypemap.getTypeByName(rt);
        argTypes = CTypemap.getTypesByNames(tt);
        tm = new CProcTypemap(retType, argTypes, varargs);
        id = tm.createC(function (... _args):*
        {
            return (func.apply(thiz, _args));
        })[0];
        return (id);
    }

}

