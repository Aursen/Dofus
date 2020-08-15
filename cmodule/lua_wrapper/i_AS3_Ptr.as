package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Ptr:int = cmodule.lua_wrapper.exportSym("_AS3_Ptr", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.PtrType]).createC(AS3_NOP)[0]);
}

