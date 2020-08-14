package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.gstate;
    import flash.utils.ByteArray;

    internal function AS3_ByteArray_readBytes(_arg_1:int, _arg_2:ByteArray, _arg_3:int):int
    {
        if (_arg_3 > 0)
        {
            if (_arg_2.bytesAvailable < _arg_3)
            {
                _arg_3 = _arg_2.bytesAvailable;
            };
            _arg_2.readBytes(gstate.ds, _arg_1, _arg_3);
            return (_arg_3);
        };
        return (0);
    }

} cmodule.lua_wrapper

