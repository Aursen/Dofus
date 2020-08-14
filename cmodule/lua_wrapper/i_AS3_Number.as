package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Number:int = cmodule.lua_wrapper.exportSym("_AS3_Number", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.DoubleType]).createC(AS3_NOP)[0]);
} cmodule.lua_wrapper

