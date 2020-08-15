package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_TypeOf:int = cmodule.lua_wrapper.exportSym("_AS3_TypeOf", new CProcTypemap(CTypemap.StrType, [CTypemap.AS3ValType]).createC(AS3_TypeOf)[0]);
}

