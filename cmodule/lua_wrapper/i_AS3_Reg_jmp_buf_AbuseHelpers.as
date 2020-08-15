package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Reg_jmp_buf_AbuseHelpers:int = cmodule.lua_wrapper.exportSym("_AS3_Reg_jmp_buf_AbuseHelpers", new CProcTypemap(CTypemap.VoidType, [new CProcTypemap(CTypemap.PtrType, [CTypemap.IntType]), new CProcTypemap(CTypemap.VoidType, [CTypemap.PtrType])], false).createC(AS3_Reg_jmp_buf_AbuseHelpers)[0]);
}

