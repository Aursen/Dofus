package cmodule.lua_wrapper
{
    public function __adde(_arg_1:uint, _arg_2:uint):uint
    {
        var _local_3:uint;
        _local_3 = ((_arg_1 + _arg_2) + gstate.cf);
        gstate.cf = uint((_local_3 < _arg_1));
        return (_local_3);
    }

} cmodule.lua_wrapper

