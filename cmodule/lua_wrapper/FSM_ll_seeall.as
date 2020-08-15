package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_ll_seeall extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_ll_seeall;
            _local_1 = new (FSM_ll_seeall)();
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
                    public::mstate.esp = (public::mstate.esp - 32);
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = _luaO_nilobject_;
                    if (!(this.i0 == this.i2))
                    {
                        this.i0 = li32(this.i0 + 8);
                        if (this.i0 == 5) goto _label_1;
                    };
                    this.i0 = 5;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tag_error.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getmetatable.start();
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i0 == 0)) goto _label_3;
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_createtable.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i3);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(this.i1 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setmetatable.start();
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -10002;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i2);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str11139;
                    this.i3 = (this.i1 + 8);
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str11139;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 9:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -16));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -8));
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i4 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i3);
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i3);
                    this.i1 = 0;
                    public::mstate.eax = this.i1;
                    
                _label_2: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_3: 
                    this.i0 = -10002;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 11:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i2);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 12:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str11139;
                    this.i3 = (this.i1 + 8);
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str11139;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 13:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -32));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -24));
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i4 = (public::mstate.ebp + -32);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    goto _label_2;
                default:
                    throw ("Invalid state in _ll_seeall");
            };
        }


    }
}

