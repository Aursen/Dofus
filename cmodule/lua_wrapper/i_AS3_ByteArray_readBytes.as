package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_ByteArray_readBytes:int = cmodule.lua_wrapper.exportSym("_AS3_ByteArray_readBytes", new CProcTypemap(CTypemap.IntType, [CTypemap.IntType, CTypemap.AS3ValType, CTypemap.IntType], false).createC(AS3_ByteArray_readBytes)[0]);
}

