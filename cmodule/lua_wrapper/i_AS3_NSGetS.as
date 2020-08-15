package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_NSGetS:int = cmodule.lua_wrapper.exportSym("_AS3_NSGetS", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.AS3ValType, CTypemap.StrType]).createC(AS3_NSGet)[0]);
}

