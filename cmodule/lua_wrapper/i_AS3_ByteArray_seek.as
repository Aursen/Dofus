package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_ByteArray_seek:int = cmodule.lua_wrapper.exportSym("_AS3_ByteArray_seek", new CProcTypemap(CTypemap.IntType, [CTypemap.AS3ValType, CTypemap.IntType, CTypemap.IntType], false).createC(AS3_ByteArray_seek)[0]);
} cmodule.lua_wrapper

