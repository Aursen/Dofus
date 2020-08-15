package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Acquire:int = cmodule.lua_wrapper.exportSym("_AS3_Acquire", new CProcTypemap(CTypemap.VoidType, [CTypemap.PtrType]).createC(CTypemap.AS3ValType.valueTracker.acquireId)[0]);
}

