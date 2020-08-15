package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_ObjectValue:int = cmodule.lua_wrapper.exportSym("_AS3_ObjectValue", new CProcTypemap(CTypemap.VoidType, [CTypemap.AS3ValType, CTypemap.StrType], true).createC(AS3_ObjectValue)[0]);
}

