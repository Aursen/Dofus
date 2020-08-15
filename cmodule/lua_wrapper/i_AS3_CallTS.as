package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_CallTS:int = cmodule.lua_wrapper.exportSym("_AS3_CallTS", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.StrType, CTypemap.AS3ValType, CTypemap.StrType], true).createC(AS3_CallTS)[0]);
}

