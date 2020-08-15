package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Shim:int = cmodule.lua_wrapper.exportSym("_AS3_Shim", new CProcTypemap(CTypemap.PtrType, [CTypemap.AS3ValType, CTypemap.AS3ValType, CTypemap.StrType, CTypemap.StrType, CTypemap.IntType]).createC(AS3_Shim)[0]);
}

