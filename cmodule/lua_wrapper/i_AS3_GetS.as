package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_GetS:int = cmodule.lua_wrapper.exportSym("_AS3_GetS", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.AS3ValType, CTypemap.StrType]).createC(AS3_Get)[0]);
}

