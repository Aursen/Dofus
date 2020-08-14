package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_auxupvalue extends Machine 
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
            var _local_1:FSM_auxupvalue;
            _local_1 = new (FSM_auxupvalue)();
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
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = _luaO_nilobject_;
                    if (!(this.i2 == this.i4))
                    {
                        this.i2 = li32(this.i2 + 8);
                        if (this.i2 == 6) goto _label_1;
                    };
                    this.i2 = 6;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tag_error.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    this.i2 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i2 + 8);
                    if (!(!(this.i4 == 6)))
                    {
                        this.i2 = li32(this.i2);
                        this.i2 = li8(this.i2 + 6);
                        if (!(this.i2 == 0)) goto _label_6;
                    };
                    this.i2 = _luaO_nilobject_;
                    this.i4 = li32(this.i1 + 12);
                    this.i5 = li32(this.i1 + 8);
                    this.i2 = ((uint(this.i5) > uint(this.i4)) ? this.i4 : this.i2);
                    this.i4 = (this.i1 + 8);
                    if (this.i3 == 0) goto _label_2;
                    this.i5 = (public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_aux_upvalue.start();
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i0 == 0) goto _label_6;
                    this.i2 = li32(public::mstate.ebp + -4);
                    this.i5 = li32(this.i4);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i5);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i5 + 8));
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    goto _label_5;
                    
                _label_2: 
                    this.i5 = (public::mstate.ebp + -8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_aux_upvalue.start();
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i0 == 0) goto _label_6;
                    this.i5 = li32(this.i4);
                    this.i6 = (this.i5 + -12);
                    si32(this.i6, this.i4);
                    this.i6 = li32(public::mstate.ebp + -8);
                    this.f0 = lf64(this.i5 + -12);
                    sf64(this.f0, this.i6);
                    this.i5 = li32(this.i5 + -4);
                    si32(this.i5, (this.i6 + 8));
                    this.i4 = li32(this.i4);
                    this.i5 = li32(this.i4 + 8);
                    if (this.i5 < 4) goto _label_4;
                    this.i4 = li32(this.i4);
                    this.i5 = li8(this.i4 + 5);
                    this.i5 = (this.i5 & 0x03);
                    if (this.i5 == 0) goto _label_4;
                    this.i2 = li32(this.i2);
                    this.i5 = li8(this.i2 + 5);
                    this.i2 = (this.i2 + 5);
                    this.i6 = (this.i5 & 0x04);
                    if (this.i6 == 0) goto _label_4;
                    this.i6 = li32(this.i1 + 16);
                    this.i7 = li8(this.i6 + 21);
                    if (!(this.i7 == 1)) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_4;
                    
                _label_3: 
                    this.i4 = li8(this.i6 + 20);
                    this.i5 = (this.i5 & 0xFFFFFFF8);
                    this.i4 = (this.i4 & 0x03);
                    this.i4 = (this.i4 | this.i5);
                    si8(this.i4, this.i2);
                    
                _label_4: 
                    if (this.i0 == 0) goto _label_6;
                    
                _label_5: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (this.i3 ^ 0xFFFFFFFF);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 9:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.i1 = (this.i1 + 8);
                    this.i4 = this.i2;
                    if (!(uint(this.i2) <= uint(this.i0)))
                    {
                        this.i5 = 0;
                        do 
                        {
                            this.i6 = (this.i5 ^ 0xFFFFFFFF);
                            this.i6 = (this.i6 * 12);
                            this.i6 = (this.i4 + this.i6);
                            this.f0 = lf64(this.i6);
                            sf64(this.f0, this.i2);
                            this.i7 = li32(this.i6 + 8);
                            si32(this.i7, (this.i2 + 8));
                            this.i2 = (this.i2 + -12);
                            this.i5 = (this.i5 + 1);
                        } while (!(uint(this.i6) <= uint(this.i0)));
                    };
                    this.i1 = li32(this.i1);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, this.i0);
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i0 + 8));
                    this.i0 = (this.i3 + 1);
                    goto _label_7;
                    
                _label_6: 
                    this.i0 = 0;
                    
                _label_7: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _auxupvalue");
            };
        }


    }
} cmodule.lua_wrapper

