package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;

    public function exportSym(_arg_1:String, _arg_2:int):int
    {
        gstate.syms[_arg_1] = _arg_2;
        return (_arg_2);
    }

}

