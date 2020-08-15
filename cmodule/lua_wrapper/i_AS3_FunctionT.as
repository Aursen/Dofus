package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_FunctionT:int = cmodule.lua_wrapper.exportSym("_AS3_FunctionT", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.PtrType, CTypemap.PtrType, CTypemap.StrType, CTypemap.StrType, CTypemap.IntType]).createC(AS3_FunctionT)[0]);
}

