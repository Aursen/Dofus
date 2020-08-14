package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Function:int = cmodule.lua_wrapper.exportSym("_AS3_Function", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.PtrType, new CProcTypemap(CTypemap.AS3ValType, [CTypemap.PtrType, CTypemap.AS3ValType])]).createC(AS3_Function)[0]);
} cmodule.lua_wrapper

