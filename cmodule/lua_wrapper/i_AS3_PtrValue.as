package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_PtrValue:int = cmodule.lua_wrapper.exportSym("_AS3_PtrValue", new CProcTypemap(CTypemap.PtrType, [CTypemap.AS3ValType]).createC(AS3_NOP)[0]);
}

