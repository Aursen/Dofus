package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_InstanceOf:int = cmodule.lua_wrapper.exportSym("_AS3_InstanceOf", new CProcTypemap(CTypemap.IntType, [CTypemap.AS3ValType, CTypemap.AS3ValType]).createC(AS3_InstanceOf)[0]);
} cmodule.lua_wrapper

