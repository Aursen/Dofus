package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Object:int = cmodule.lua_wrapper.exportSym("_AS3_Object", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.StrType], true).createC(AS3_Object)[0]);
} cmodule.lua_wrapper

