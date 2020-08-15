package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_unpack extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var f0:Number;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_luaB_unpack;
            _local_1 = new (FSM_luaB_unpack)();
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
                    this.i0 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = _luaO_nilobject_;
                    if (!(!(this.i0 == this.i2)))
                    {
                        
                    _label_2: 
                        this.i0 = 1;
                        goto _label_3;
                    };
                    this.i0 = li32(this.i0 + 8);
                    if (this.i0 < 1) goto _label_2;
                    this.i0 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    this.i2 = 3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = _luaO_nilobject_;
                    if (!(this.i2 == this.i3))
                    {
                        this.i2 = li32(this.i2 + 8);
                        if (this.i2 > 0) goto _label_4;
                    };
                    this.i2 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_objlen.start();
                    return;
                case 6:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i0 > this.i2) goto _label_10;
                    goto _label_5;
                    
                _label_4: 
                    this.i2 = 3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 7:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i0 > this.i2) goto _label_10;
                    
                _label_5: 
                    this.i3 = (this.i2 - this.i0);
                    this.i4 = (this.i3 + 1);
                    if (this.i4 < 1) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_checkstack.start();
                    return;
                case 8:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i5 == 0)) goto _label_7;
                    
                _label_6: 
                    this.i0 = __2E_str55345;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 0;
                    goto _label_11;
                    
                _label_7: 
                    this.i5 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 10:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 11:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i5);
                    sf64(this.f0, this.i6);
                    this.i5 = li32(this.i5 + 8);
                    si32(this.i5, (this.i6 + 8));
                    this.i5 = li32(this.i1 + 8);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, (this.i1 + 8));
                    this.i5 = (this.i1 + 8);
                    if (!(this.i0 < this.i2))
                    {
                        
                    _label_8: 
                        this.i0 = this.i4;
                        goto _label_11;
                    };
                    this.i2 = 0;
                    this.i0 = (this.i0 + 1);
                    
                _label_9: 
                    this.i6 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 12:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = (this.i0 + this.i2);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 13:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i5);
                    this.f0 = lf64(this.i6);
                    sf64(this.f0, this.i7);
                    this.i6 = li32(this.i6 + 8);
                    si32(this.i6, (this.i7 + 8));
                    this.i6 = li32(this.i5);
                    this.i6 = (this.i6 + 12);
                    si32(this.i6, this.i5);
                    this.i2 = (this.i2 + 1);
                    if (this.i2 == this.i3) goto _label_8;
                    goto _label_9;
                    
                _label_10: 
                    this.i0 = 0;
                    
                _label_11: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaB_unpack");
            };
        }


    }
}

