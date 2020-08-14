package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Trace:int = cmodule.lua_wrapper.exportSym("_AS3_Trace", new CProcTypemap(CTypemap.VoidType, [CTypemap.AS3ValType], false).createC(trace)[0]);
} cmodule.lua_wrapper

