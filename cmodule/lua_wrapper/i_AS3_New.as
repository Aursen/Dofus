package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_New:int = cmodule.lua_wrapper.exportSym("_AS3_New", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.AS3ValType, CTypemap.AS3ValType]).createC(AS3_New)[0]);
} cmodule.lua_wrapper

