package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_String:int = cmodule.lua_wrapper.exportSym("_AS3_String", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.StrType]).createC(AS3_NOP)[0]);
}

