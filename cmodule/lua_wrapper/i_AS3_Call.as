package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Call:int = cmodule.lua_wrapper.exportSym("_AS3_Call", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.AS3ValType, CTypemap.AS3ValType, CTypemap.AS3ValType]).createC(AS3_Call)[0]);
}

