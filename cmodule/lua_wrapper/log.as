package cmodule.lua_wrapper
{
    public function log(_arg_1:int, _arg_2:String):void
    {
        if (_arg_1 < glogLvl)
        {
            trace(_arg_2);
        };
    }

} cmodule.lua_wrapper

