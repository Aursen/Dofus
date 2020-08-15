package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Ram:int = cmodule.lua_wrapper.exportSym("_AS3_Ram", new CProcTypemap(CTypemap.AS3ValType, [], false).createC(AS3_Ram)[0]);
}

