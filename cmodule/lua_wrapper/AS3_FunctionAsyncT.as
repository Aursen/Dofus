package cmodule.lua_wrapper
{
    internal function AS3_FunctionAsyncT(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:Boolean):Function
    {
        var _local_6:CTypemap;
        _local_6 = new CProcTypemap(CTypemap.getTypeByName(_arg_3), CTypemap.getTypesByNames(_arg_4), _arg_5, true);
        return (AS3_FunctionAsync(_arg_1, _local_6.fromC([_arg_2])));
    }

}

