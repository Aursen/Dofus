package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_UnregAbused_jmp_buf:int = cmodule.lua_wrapper.exportSym("_AS3_UnregAbused_jmp_buf", new CProcTypemap(CTypemap.VoidType, [CTypemap.PtrType], false).createC(AS3_UnregAbused_jmp_buf)[0]);
} cmodule.lua_wrapper

