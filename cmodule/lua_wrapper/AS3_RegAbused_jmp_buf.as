package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.log;

    internal function AS3_RegAbused_jmp_buf(_arg_1:int):void
    {
        log(4, ("regAbused: " + _arg_1));
        log(1, "Can't RegAbused -- abuse support disabled");
    }

} cmodule.lua_wrapper

