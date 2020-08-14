package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Array:int = cmodule.lua_wrapper.exportSym("_AS3_Array", new CProcTypemap(CTypemap.AS3ValType, [CTypemap.StrType], true).createC(AS3_Array)[0]);
} cmodule.lua_wrapper

