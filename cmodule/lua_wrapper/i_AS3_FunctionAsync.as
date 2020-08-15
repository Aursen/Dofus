package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_FunctionAsync:int = cmodule.lua_wrapper.exportSym("_AS3_FunctionAsync", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.PtrType, new CProcTypemap(CTypemap.AS3ValType, [CTypemap.PtrType, CTypemap.AS3ValType], false, true)]).createC(AS3_FunctionAsync)[0]);
}

