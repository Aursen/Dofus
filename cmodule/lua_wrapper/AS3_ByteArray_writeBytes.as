package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.log;
    import cmodule.lua_wrapper.gstate;
    import flash.utils.ByteArray;

    internal function AS3_ByteArray_writeBytes(_arg_1:ByteArray, _arg_2:int, _arg_3:int):int
    {
        log(5, ((("--- wrteBytes: ba length = " + _arg_1.length) + " / ") + _arg_3));
        if (_arg_3 > 0)
        {
            _arg_1.writeBytes(gstate.ds, _arg_2, _arg_3);
            return (_arg_3);
        };
        return (0);
    }

} cmodule.lua_wrapper

