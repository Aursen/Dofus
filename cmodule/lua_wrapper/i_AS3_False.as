package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_False:int = cmodule.lua_wrapper.exportSym("_AS3_False", new CProcTypemap(CTypemap.AS3ValType, []).createC(function ():Boolean
    {
        return (false);
    })[0]);
} cmodule.lua_wrapper

