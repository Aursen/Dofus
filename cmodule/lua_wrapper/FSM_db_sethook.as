package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_db_sethook extends Machine 
    {

        public static const intRegCount:int = 10;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var f0:Number;
        public var i7:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_db_sethook;
            _local_1 = new (FSM_db_sethook)();
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
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getthread.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = _luaO_nilobject_;
                    if (!(!(this.i2 == this.i3)))
                    {
                        this.i2 = 1;
                    }
                    else
                    {
                        this.i2 = li32(this.i2 + 8);
                        this.i2 = ((this.i2 < 1) ? 1 : 0);
                    };
                    this.i3 = li32(public::mstate.ebp + -4);
                    this.i2 = (this.i2 ^ 0x01);
                    this.i2 = (this.i2 & 0x01);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i2 = li32(this.i1 + 8);
                        this.i4 = (this.i1 + 8);
                        this.i5 = (this.i3 + 1);
                        if (!(this.i5 < 0))
                        {
                            this.i3 = li32(this.i1 + 12);
                            this.i6 = (this.i1 + 12);
                            this.i7 = (this.i5 * 12);
                            this.i7 = (this.i3 + this.i7);
                            if (!(uint(this.i2) < uint(this.i7)))
                            {
                                this.i2 = this.i3;
                                goto _label_2;
                            };
                            
                        _label_1: 
                            this.i3 = 0;
                            si32(this.i3, (this.i2 + 8));
                            this.i2 = (this.i2 + 12);
                            si32(this.i2, this.i4);
                            this.i3 = li32(this.i6);
                            this.i7 = (this.i5 * 12);
                            this.i7 = (this.i3 + this.i7);
                            if (uint(this.i2) < uint(this.i7)) goto _label_1;
                            this.i2 = this.i3;
                            
                        _label_2: 
                            this.i3 = (this.i5 * 12);
                            this.i2 = (this.i2 + this.i3);
                        }
                        else
                        {
                            this.i3 = (this.i3 * 12);
                            this.i2 = (this.i3 + this.i2);
                            this.i2 = (this.i2 + 24);
                        };
                        this.i3 = this.i2;
                        this.i2 = 0;
                        si32(this.i3, this.i4);
                        this.i3 = this.i2;
                        this.i4 = this.i2;
                        goto _label_12;
                    };
                    this.i2 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 + 2);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = this.i2;
                    this.i6 = _luaO_nilobject_;
                    if (!(this.i4 == this.i6))
                    {
                        this.i4 = li32(this.i4 + 8);
                        if (this.i4 == 6) goto _label_3;
                    };
                    this.i4 = 6;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tag_error.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    this.i3 = _luaO_nilobject_;
                    this.i4 = li32(public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = (this.i4 + 3);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 6:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(!(this.i6 == this.i3)))
                    {
                        
                    _label_4: 
                        this.i4 = 0;
                        goto _label_5;
                    };
                    this.i3 = li32(this.i6 + 8);
                    if (this.i3 < 1) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 7:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_5: 
                    this.i3 = this.i4;
                    this.i4 = li8(this.i2);
                    if (this.i4 == 99) goto _label_13;
                    this.i6 = this.i5;
                    do 
                    {
                        this.i7 = li8(this.i6);
                        if (!(!(this.i7 == 0)))
                        {
                            this.i6 = 0;
                            goto _label_14;
                        };
                        this.i7 = li8(this.i6 + 1);
                        this.i6 = (this.i6 + 1);
                        this.i8 = this.i6;
                        if (this.i7 == 99) goto _label_14;
                        this.i6 = this.i8;
                    } while (true);
                    
                _label_6: 
                    this.i7 = this.i2;
                    do 
                    {
                        
                    _label_7: 
                        this.i7 = ((this.i7 == 0) ? 0 : 2);
                        this.i4 = (this.i4 & 0xFF);
                        if (this.i4 == 108) goto _label_8;
                        this.i2 = this.i5;
                        continue;
                    } while ((this.i4 = li8(this.i2)), if (!(this.i4 == 0)) goto _label_10;
, (this.i2 = 0), goto _label_9, (this.i8 = li8(this.i7 + 1)), (this.i7 = (this.i7 + 1)), (this.i9 = this.i7), (this.i8 == 114));
                    this.i7 = this.i9;
                    goto _label_15;
                    
                _label_8: 
                    do 
                    {
                        
                    _label_9: 
                        this.i2 = ((this.i2 == 0) ? 0 : 4);
                        this.i4 = (this.i7 | this.i6);
                        this.i2 = (this.i4 | this.i2);
                        if (this.i3 > 0) goto _label_11;
                        this.i5 = _hookf;
                        this.i4 = this.i2;
                        this.i2 = this.i3;
                        this.i3 = this.i5;
                        goto _label_12;
                        
                    _label_10: 
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                    } while ((this.i4 == 108));
                    this.i2 = this.i5;
                    //unresolved jump
                    
                _label_11: 
                    this.i5 = _hookf;
                    this.i2 = (this.i2 | 0x08);
                    this.i4 = this.i2;
                    this.i2 = this.i3;
                    this.i3 = this.i5;
                    
                _label_12: 
                    this.i5 = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_gethooktable.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i6 = li32(this.i1 + 8);
                    si32(this.i0, this.i6);
                    si32(this.i5, (this.i6 + 8));
                    this.i5 = li32(this.i1 + 8);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, (this.i1 + 8));
                    this.i5 = li32(public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = (this.i5 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 9:
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
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawset.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = ((this.i3 == 0) ? 1 : 0);
                    this.i6 = ((this.i4 == 0) ? 1 : 0);
                    this.i7 = li32(this.i1 + 8);
                    this.i5 = (this.i6 | this.i5);
                    this.i5 = (this.i5 & 0x01);
                    this.i6 = (this.i7 + -12);
                    si32(this.i6, (this.i1 + 8));
                    this.i1 = ((this.i5 != 0) ? 0 : this.i3);
                    si32(this.i1, (this.i0 + 68));
                    si32(this.i2, (this.i0 + 60));
                    si32(this.i2, (this.i0 + 64));
                    this.i1 = ((this.i5 != 0) ? 0 : this.i4);
                    si8(this.i1, (this.i0 + 56));
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_13: 
                    this.i6 = this.i2;
                    
                _label_14: 
                    this.i6 = ((this.i6 != 0) ? 1 : 0);
                    this.i6 = (this.i6 & 0x01);
                    this.i7 = (this.i4 & 0xFF);
                    if (this.i7 == 114) goto _label_6;
                    this.i7 = this.i5;
                    
                _label_15: 
                    this.i8 = li8(this.i7);
                    //unresolved if
                    this.i7 = 0;
                    goto _label_7;
                default:
                    throw ("Invalid state in _db_sethook");
            };
        }


    }
}

