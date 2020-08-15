package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Stage:int = cmodule.lua_wrapper.exportSym("_AS3_Stage", new CProcTypemap(CTypemap.AS3ValType, []).createC(AS3_Stage)[0]);
}

