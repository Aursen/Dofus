package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_IntValue:int = cmodule.lua_wrapper.exportSym("_AS3_IntValue", new CProcTypemap(CTypemap.IntType, [CTypemap.AS3ValType]).createC(AS3_NOP)[0]);
} cmodule.lua_wrapper

