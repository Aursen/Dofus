package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;

    public function importSym(s:String):int
    {
        var res:int;
        res = gstate.syms[s];
        if (!res)
        {
            log(3, ("Undefined sym: " + s));
            return (exportSym(s, regFunc(function ():*
            {
                throw ("Undefined sym: " + s);
            })));
        };
        return (res);
    }

}

