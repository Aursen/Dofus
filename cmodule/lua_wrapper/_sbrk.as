package cmodule.lua_wrapper
{
    public function _sbrk(_arg_1:int):int
    {
        var _local_2:int;
        var _local_3:int;
        _local_2 = gstate.ds.length;
        _local_3 = (_local_2 + _arg_1);
        gstate.ds.length = _local_3;
        return (_local_2);
    }

} cmodule.lua_wrapper

