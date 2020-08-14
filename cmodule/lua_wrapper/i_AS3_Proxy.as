package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Proxy:int = cmodule.lua_wrapper.exportSym("_AS3_Proxy", new CProcTypemap(CTypemap.AS3ValType, [], false).createC(AS3_Proxy)[0]);
} cmodule.lua_wrapper

