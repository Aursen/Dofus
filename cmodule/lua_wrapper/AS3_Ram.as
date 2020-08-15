package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.gstate;
    import flash.utils.ByteArray;

    internal function AS3_Ram():ByteArray
    {
        return (gstate.ds);
    }

}

