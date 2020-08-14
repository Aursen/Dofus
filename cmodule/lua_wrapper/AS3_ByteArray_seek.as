package cmodule.lua_wrapper
{
    import flash.utils.ByteArray;

    internal function AS3_ByteArray_seek(_arg_1:ByteArray, _arg_2:int, _arg_3:int):int
    {
        if (_arg_3 == 0)
        {
            _arg_1.position = _arg_2;
        }
        else
        {
            if (_arg_3 == 1)
            {
                _arg_1.position = (_arg_1.position + _arg_2);
            }
            else
            {
                if (_arg_3 == 2)
                {
                    _arg_1.position = (_arg_1.length + _arg_2);
                }
                else
                {
                    return (-1);
                };
            };
        };
        return (_arg_1.position);
    }

} cmodule.lua_wrapper

