package cmodule.lua_wrapper
{
    public function _brk(_arg_1:int):int
    {
        var _local_2:int;
        _local_2 = _arg_1;
        gstate.ds.length = _local_2;
        return (0);
    }

} cmodule.lua_wrapper

