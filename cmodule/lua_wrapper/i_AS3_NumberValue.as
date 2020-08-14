package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_NumberValue:int = cmodule.lua_wrapper.exportSym("_AS3_NumberValue", new CProcTypemap(CTypemap.DoubleType, [CTypemap.AS3ValType]).createC(AS3_NOP)[0]);
} cmodule.lua_wrapper

