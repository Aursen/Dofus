package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_ArrayValue:int = cmodule.lua_wrapper.exportSym("_AS3_ArrayValue", new CProcTypemap(CTypemap.VoidType, [CTypemap.AS3ValType, CTypemap.StrType], true).createC(AS3_ArrayValue)[0]);
} cmodule.lua_wrapper

