package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_NSGet:int = cmodule.lua_wrapper.exportSym("_AS3_NSGet", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.AS3ValType, CTypemap.AS3ValType]).createC(AS3_NSGet)[0]);
}

