package cmodule.lua_wrapper
{
    internal function AS3_NSGet(_arg_1:*, _arg_2:*):*
    {
        var _local_3:String;
        _local_3 = typeof(_arg_1);
        if (((_local_3 == "undefined") || (!(_arg_1 instanceof Namespace))))
        {
            if (_local_3 == "string")
            {
                _arg_1 = new Namespace(_arg_1);
            }
            else
            {
                _arg_1 = new Namespace();
            };
        };
        return (_arg_1::[String(_arg_2)]);
    }

}

