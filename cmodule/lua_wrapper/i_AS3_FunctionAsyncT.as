package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_FunctionAsyncT:int = cmodule.lua_wrapper.exportSym("_AS3_FunctionAsyncT", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.PtrType, CTypemap.PtrType, CTypemap.StrType, CTypemap.StrType, CTypemap.IntType]).createC(AS3_FunctionAsyncT)[0]);
} cmodule.lua_wrapper

