package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Int:int = cmodule.lua_wrapper.exportSym("_AS3_Int", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.IntType]).createC(AS3_NOP)[0]);
}

