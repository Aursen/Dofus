package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_str_byte extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_str_byte;
            _local_1 = new (FSM_str_byte)();
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
                    this.i0 = (public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = _luaO_nilobject_;
                    if (!(!(this.i3 == this.i4)))
                    {
                        
                    _label_1: 
                        this.i3 = 1;
                        goto _label_2;
                    };
                    this.i3 = li32(this.i3 + 8);
                    if (this.i3 < 1) goto _label_1;
                    this.i3 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    if (!(this.i3 > -1))
                    {
                        this.i3 = (this.i3 + this.i2);
                        this.i3 = (this.i3 + 1);
                        this.i3 = ((this.i3 > -1) ? this.i3 : 0);
                    }
                    else
                    {
                        this.i3 = ((this.i3 > -1) ? this.i3 : 0);
                    };
                    this.i2 = this.i3;
                    this.i3 = 3;
                    this.i4 = li32(public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = _luaO_nilobject_;
                    if (!(!(this.i3 == this.i5)))
                    {
                        
                    _label_3: 
                        this.i3 = this.i2;
                        goto _label_4;
                    };
                    this.i3 = li32(this.i3 + 8);
                    if (this.i3 < 1) goto _label_3;
                    this.i3 = 3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 5:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_4: 
                    if (!(this.i3 > -1))
                    {
                        this.i3 = (this.i3 + this.i4);
                        this.i3 = (this.i3 + 1);
                        this.i3 = ((this.i3 > -1) ? this.i3 : 0);
                    }
                    else
                    {
                        this.i3 = ((this.i3 > -1) ? this.i3 : 0);
                    };
                    this.i4 = li32(public::mstate.ebp + -4);
                    this.i2 = ((this.i2 < 1) ? 1 : this.i2);
                    this.i3 = ((uint(this.i3) > uint(this.i4)) ? this.i4 : this.i3);
                    if (!(this.i2 <= this.i3))
                    {
                        this.i0 = 0;
                        
                    _label_5: 
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i4 = (this.i3 - this.i2);
                    this.i4 = (this.i4 + 1);
                    this.i5 = (this.i4 + this.i2);
                    if (this.i5 > this.i3) goto _label_8;
                    this.i3 = __2E_str16446;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_checkstack.start();
                    return;
                case 7:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i3 == 0)) goto _label_6;
                    this.i3 = __2E_str10185328;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = __2E_str16446;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_6: 
                    if (this.i4 > 0) goto _label_10;
                    
                _label_7: 
                    this.i0 = this.i4;
                    goto _label_5;
                    
                _label_8: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_checkstack.start();
                    return;
                case 9:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i3 == 0)) goto _label_9;
                    this.i3 = __2E_str10185328;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = __2E_str16446;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_9: 
                    if (this.i4 < 1) goto _label_7;
                    
                _label_10: 
                    this.i3 = 0;
                    this.i0 = (this.i2 + this.i0);
                    this.i1 = (this.i1 + 8);
                    this.i2 = this.i3;
                    do 
                    {
                        this.i3 = 3;
                        this.i5 = (this.i0 + this.i2);
                        this.i5 = li8(this.i5 + -1);
                        this.i6 = li32(this.i1);
                        this.f0 = Number(this.i5);
                        sf64(this.f0, this.i6);
                        si32(this.i3, (this.i6 + 8));
                        this.i3 = li32(this.i1);
                        this.i3 = (this.i3 + 12);
                        si32(this.i3, this.i1);
                        this.i2 = (this.i2 + 1);
                        if (this.i2 >= this.i4) goto _label_7;
                    } while (true);
                default:
                    throw ("Invalid state in _str_byte");
            };
        }


    }
}

