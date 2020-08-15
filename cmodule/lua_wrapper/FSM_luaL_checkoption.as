package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaL_checkoption extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var i7:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_luaL_checkoption;
            _local_1 = new (FSM_luaL_checkoption)();
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
                    public::mstate.esp = (public::mstate.esp - 0);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = li32(public::mstate.ebp + 20);
                    this.i4 = this.i3;
                    if (this.i2 == 0) goto _label_3;
                    this.i5 = 0;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_optlstring.start();
                    return;
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i3);
                    if (!(this.i3 == 0)) goto _label_4;
                    
                _label_1: 
                    this.i3 = this.i2;
                    this.i2 = __2E_str12187330;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 2:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = 0;
                    
                _label_2: 
                    public::mstate.eax = this.i3;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_3: 
                    this.i2 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 4:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i3);
                    if (!(this.i3 == 0))
                    {
                        
                    _label_4: 
                        this.i3 = 0;
                        this.i5 = li8(this.i2);
                        this.i6 = this.i2;
                        do 
                        {
                            this.i7 = li32(this.i4);
                            this.i8 = li8(this.i7);
                            this.i9 = (this.i5 & 0xFF);
                            if (!(this.i8 == this.i9))
                            {
                                this.i7 = this.i2;
                            }
                            else
                            {
                                this.i9 = 0;
                                do 
                                {
                                    this.i10 = (this.i6 + this.i9);
                                    this.i10 = (this.i10 + 1);
                                    this.i8 = (this.i8 & 0xFF);
                                    if (this.i8 == 0) goto _label_2;
                                    this.i8 = (this.i7 + this.i9);
                                    this.i8 = li8(this.i8 + 1);
                                    this.i10 = li8(this.i10);
                                    this.i9 = (this.i9 + 1);
                                } while (!(!(this.i8 == this.i10)));
                                this.i7 = (this.i6 + this.i9);
                            };
                            this.i7 = li8(this.i7);
                            this.i8 = (this.i8 & 0xFF);
                            if (this.i8 == this.i7) goto _label_2;
                            this.i7 = li32(this.i4 + 4);
                            this.i3 = (this.i3 + 1);
                            this.i4 = (this.i4 + 4);
                            if (this.i7 == 0) goto _label_1;
                        } while (true);
                    };
                    goto _label_1;
                default:
                    throw ("Invalid state in _luaL_checkoption");
            };
        }


    }
}

