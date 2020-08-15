package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaK_storevar extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_luaK_storevar;
            _local_1 = new (FSM_luaK_storevar)();
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
                    this.i0 = li32(public::mstate.ebp + 12);
                    this.i1 = li32(this.i0);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = li32(public::mstate.ebp + 16);
                    if (this.i1 > 7) goto _label_1;
                    if (this.i1 == 6) goto _label_3;
                    if (!(this.i1 == 7)) goto _label_11;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i3);
                    this.i4 = this.i3;
                    if (!(this.i1 == 12)) goto _label_5;
                    this.i1 = li32(this.i3 + 12);
                    this.i5 = li32(this.i3 + 16);
                    this.i6 = li32(this.i3 + 4);
                    this.i7 = (this.i3 + 4);
                    if (!(this.i1 == this.i5)) goto _label_4;
                    goto _label_6;
                    
                _label_1: 
                    if (this.i1 == 8) goto _label_8;
                    if (!(this.i1 == 9)) goto _label_11;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2RK.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i0 + 8);
                    this.i0 = li32(this.i0 + 4);
                    this.i5 = li32(this.i2 + 12);
                    this.i4 = (this.i4 << 23);
                    this.i0 = (this.i0 << 6);
                    this.i5 = li32(this.i5 + 8);
                    this.i0 = (this.i0 | this.i4);
                    this.i1 = (this.i1 << 14);
                    this.i0 = (this.i0 | this.i1);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i0 | 0x09);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i3);
                    if (!(!(this.i0 == 12)))
                    {
                        this.i3 = li32(this.i3 + 4);
                        this.i0 = (this.i3 & 0x0100);
                        if (!(!(this.i0 == 0)))
                        {
                            this.i0 = li8(this.i2 + 50);
                            if (!(this.i0 > this.i3))
                            {
                                this.i3 = li32(this.i2 + 36);
                                this.i3 = (this.i3 + -1);
                                si32(this.i3, (this.i2 + 36));
                            };
                        };
                    };
                    
                _label_2: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_3: 
                    this.i1 = li32(this.i3);
                    if (!(!(this.i1 == 12)))
                    {
                        this.i1 = li32(this.i3 + 4);
                        this.i4 = (this.i1 & 0x0100);
                        if (!(!(this.i4 == 0)))
                        {
                            this.i4 = li8(this.i2 + 50);
                            if (!(this.i4 > this.i1))
                            {
                                this.i1 = li32(this.i2 + 36);
                                this.i1 = (this.i1 + -1);
                                si32(this.i1, (this.i2 + 36));
                            };
                        };
                    };
                    this.i0 = li32(this.i0 + 4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exp2reg.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_2;
                    
                _label_4: 
                    this.i1 = li8(this.i2 + 50);
                    if (this.i6 < this.i1) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exp2reg.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i7);
                    goto _label_6;
                    
                _label_5: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i3 + 4);
                    
                _label_6: 
                    this.i1 = this.i6;
                    this.i0 = li32(this.i0 + 4);
                    this.i5 = li32(this.i2 + 12);
                    this.i5 = li32(this.i5 + 8);
                    this.i0 = (this.i0 << 23);
                    this.i1 = (this.i1 << 6);
                    this.i0 = (this.i1 | this.i0);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i0 | 0x08);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i4);
                    //unresolved if
                    this.i0 = li32(this.i3 + 4);
                    this.i3 = (this.i0 & 0x0100);
                    //unresolved if
                    this.i3 = li8(this.i2 + 50);
                    //unresolved if
                    
                _label_7: 
                    this.i0 = li32(this.i2 + 36);
                    this.i0 = (this.i0 + -1);
                    si32(this.i0, (this.i2 + 36));
                    //unresolved jump
                    
                _label_8: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i3);
                    this.i4 = this.i3;
                    if (!(this.i1 == 12)) goto _label_9;
                    this.i1 = li32(this.i3 + 12);
                    this.i5 = li32(this.i3 + 16);
                    this.i6 = li32(this.i3 + 4);
                    this.i7 = (this.i3 + 4);
                    if (!(!(this.i1 == this.i5))) goto _label_10;
                    this.i1 = li8(this.i2 + 50);
                    if (this.i6 < this.i1) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exp2reg.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i7);
                    goto _label_10;
                    
                _label_9: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i3 + 4);
                    
                _label_10: 
                    this.i1 = this.i6;
                    this.i0 = li32(this.i0 + 4);
                    this.i5 = li32(this.i2 + 12);
                    this.i5 = li32(this.i5 + 8);
                    this.i0 = (this.i0 << 14);
                    this.i1 = (this.i1 << 6);
                    this.i0 = (this.i1 | this.i0);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i0 | 0x07);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 11:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i4);
                    //unresolved if
                    this.i0 = li32(this.i3 + 4);
                    this.i3 = (this.i0 & 0x0100);
                    //unresolved if
                    this.i3 = li8(this.i2 + 50);
                    //unresolved if
                    do 
                    {
                        goto _label_7;
                        
                    _label_11: 
                        this.i0 = li32(this.i3);
                        //unresolved if
                        this.i0 = li32(this.i3 + 4);
                        this.i1 = (this.i0 & 0x0100);
                        //unresolved if
                        this.i1 = li8(this.i2 + 50);
                        //unresolved if
                    } while (true);
                default:
                    throw ("Invalid state in _luaK_storevar");
            };
        }


    }
}

