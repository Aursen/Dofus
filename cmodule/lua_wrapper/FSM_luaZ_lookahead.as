package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaZ_lookahead extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;


        public static function start():void
        {
            var _local_1:FSM_luaZ_lookahead;
            _local_1 = new (FSM_luaZ_lookahead)();
            gstate.gworker = _local_1;
        }


        final override public function work():void
        {
            switch (state)
            {
                case 0:
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(public::mstate.ebp, public::mstate.esp);
                    public::mstate.ebp = public::mstate.esp;
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0);
                    this.i2 = this.i0;
                    if (!(this.i1 == 0)) goto _label_1;
                    this.i1 = (public::mstate.ebp + -4);
                    this.i3 = li32(this.i0 + 16);
                    this.i4 = li32(this.i0 + 8);
                    this.i5 = li32(this.i0 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i4]());
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i1 == 0))
                    {
                        this.i3 = li32(public::mstate.ebp + -4);
                        if (!(this.i3 == 0))
                        {
                            this.i3 = (this.i3 + -1);
                            si32(this.i3, this.i2);
                            this.i1 = (this.i1 + 1);
                            si32(this.i1, (this.i0 + 4));
                            this.i1 = li32(this.i2);
                            this.i1 = (this.i1 + 1);
                            si32(this.i1, this.i2);
                            this.i1 = li32(this.i0 + 4);
                            this.i2 = (this.i1 + -1);
                            si32(this.i2, (this.i0 + 4));
                            this.i0 = li8(this.i1 + -1);
                            goto _label_2;
                            
                        _label_1: 
                            this.i0 = li32(this.i0 + 4);
                            this.i0 = li8(this.i0);
                            goto _label_2;
                        };
                    };
                    this.i0 = -1;
                    
                _label_2: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaZ_lookahead");
            };
        }


    }
}

