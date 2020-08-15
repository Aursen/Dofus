package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_CallT:int = cmodule.lua_wrapper.exportSym("_AS3_CallT", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.AS3ValType, CTypemap.AS3ValType, CTypemap.StrType], true).createC(AS3_CallT)[0]);
}

