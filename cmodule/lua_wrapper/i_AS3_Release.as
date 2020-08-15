package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Release:int = cmodule.lua_wrapper.exportSym("_AS3_Release", new CProcTypemap(CTypemap.VoidType, [CTypemap.PtrType]).createC(CTypemap.AS3ValType.valueTracker.release)[0]);
}

