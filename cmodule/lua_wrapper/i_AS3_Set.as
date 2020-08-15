package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Set:int = cmodule.lua_wrapper.exportSym("_AS3_Set", new CProcTypemap(CTypemap.VoidType, [CTypemap.AS3ValType, CTypemap.AS3ValType, CTypemap.AS3ValType]).createC(AS3_Set)[0]);
}

