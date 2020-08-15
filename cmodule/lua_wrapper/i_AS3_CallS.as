package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_CallS:int = cmodule.lua_wrapper.exportSym("_AS3_CallS", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.StrType, CTypemap.AS3ValType, CTypemap.AS3ValType]).createC(AS3_CallS)[0]);
}

