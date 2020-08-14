package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Get:int = cmodule.lua_wrapper.exportSym("_AS3_Get", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.AS3ValType, CTypemap.AS3ValType]).createC(AS3_Get)[0]);
} cmodule.lua_wrapper

