package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_StringN:int = cmodule.lua_wrapper.exportSym("_AS3_StringN", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.SizedStrType]).createC(AS3_NOP)[0]);
} cmodule.lua_wrapper

