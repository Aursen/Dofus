package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.log;

    internal function AS3_UnregAbused_jmp_buf(_arg_1:int):void
    {
        log(4, ("unregAbused: " + _arg_1));
        log(1, "Can't UnregAbused -- abuse support disabled");
    }

} cmodule.lua_wrapper

