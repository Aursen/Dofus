package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.log;
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal function shellExit(res:int):void
    {
        var ns:Namespace;
        var nativeApp:Object;
        var nativeAppClass:Object;
        ns = new Namespace("flash.desktop");
        try
        {
            nativeAppClass = ns::["NativeApplication"];
            nativeApp = nativeAppClass.nativeApplication;
        }
        catch(e)
        {
            log(3, ("No nativeApplication: " + e));
        };
        if (nativeApp)
        {
            nativeApp.exit(res);
            return;
        };
        throw (new AlchemyExit(res));
    }

}

