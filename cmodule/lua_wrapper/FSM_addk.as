package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_addk extends Machine 
    {

        public static const intRegCount:int = 10;
        public static const NumberRegCount:int = 2;

        public var f0:Number;
        public var f1:Number;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;
        public var i8:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_addk;
            _local_1 = new (FSM_addk)();
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
                    this.i0 = 0;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 16);
                    this.i3 = li32(this.i1 + 4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = li32(public::mstate.ebp + 12);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_get.start();
                case 1:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si8(this.i0, (this.i3 + 6));
                    this.i0 = li32(public::mstate.ebp + 16);
                    this.i6 = _luaO_nilobject_;
                    if (!(this.i5 == this.i6))
                    {
                        this.i3 = this.i5;
                        goto _label_3;
                    };
                    this.i5 = li32(this.i4 + 8);
                    if (this.i5 == 3) goto _label_1;
                    if (!(this.i5 == 0)) goto _label_2;
                    this.i5 = __2E_str3127;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_3;
                    
                _label_1: 
                    this.f0 = 0;
                    this.f1 = lf64(this.i4);
                    if ((!(this.f1 == Number.NaN)) && (!(this.f0 == Number.NaN))) goto _label_2;
                    this.i5 = __2E_str4128;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 5:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_3;
                    
                _label_2: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 6:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    this.i4 = li32(this.i1);
                    this.i5 = li32(this.i4 + 40);
                    this.i6 = li32(this.i3 + 8);
                    this.i7 = (this.i3 + 8);
                    this.i8 = (this.i4 + 40);
                    if (!(!(this.i6 == 3)))
                    {
                        this.f0 = lf64(this.i3);
                        this.i0 = int(this.f0);
                        
                    _label_4: 
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i6 = 3;
                    this.i9 = li32(this.i1 + 40);
                    this.f0 = Number(this.i9);
                    sf64(this.f0, this.i3);
                    si32(this.i6, this.i7);
                    this.i3 = li32(this.i1 + 40);
                    this.i6 = li32(this.i8);
                    this.i1 = (this.i1 + 40);
                    this.i3 = (this.i3 + 1);
                    if (!(this.i3 > this.i6)) goto _label_6;
                    this.i3 = __2E_str32256;
                    this.i6 = li32(this.i4 + 8);
                    public::mstate.esp = (public::mstate.esp - 24);
                    this.i7 = 0x3FFFF;
                    this.i9 = 12;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i9, (public::mstate.esp + 12));
                    si32(this.i7, (public::mstate.esp + 16));
                    si32(this.i3, (public::mstate.esp + 20));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_growaux_.start();
                    return;
                case 7:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 24);
                    si32(this.i3, (this.i4 + 8));
                    this.i6 = li32(this.i8);
                    if (!(this.i6 > this.i5))
                    {
                        this.i5 = this.i3;
                        goto _label_7;
                        
                    _label_5: 
                        this.i3 = this.i6;
                    };
                    this.i6 = 0;
                    this.i7 = (this.i5 * 12);
                    this.i3 = (this.i3 + this.i7);
                    si32(this.i6, (this.i3 + 8));
                    this.i5 = (this.i5 + 1);
                    
                _label_6: 
                    this.i3 = li32(this.i8);
                    this.i6 = li32(this.i4 + 8);
                    if (this.i3 > this.i5) goto _label_5;
                    this.i5 = this.i6;
                    
                _label_7: 
                    this.i3 = this.i5;
                    this.i5 = li32(this.i1);
                    this.f0 = lf64(this.i0);
                    this.i5 = (this.i5 * 12);
                    this.i3 = (this.i3 + this.i5);
                    sf64(this.f0, this.i3);
                    this.i5 = li32(this.i0 + 8);
                    si32(this.i5, (this.i3 + 8));
                    this.i3 = li32(this.i0 + 8);
                    //unresolved if
                    this.i0 = li32(this.i0);
                    this.i3 = li8(this.i0 + 5);
                    this.i3 = (this.i3 & 0x03);
                    //unresolved if
                    this.i3 = li8(this.i4 + 5);
                    this.i4 = (this.i4 + 5);
                    this.i5 = (this.i3 & 0x04);
                    //unresolved if
                    this.i2 = li32(this.i2 + 16);
                    this.i5 = li8(this.i2 + 21);
                    if (!(this.i5 == 1)) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_9;
                    
                _label_8: 
                    this.i0 = li8(this.i2 + 20);
                    this.i2 = (this.i3 & 0xFFFFFFF8);
                    this.i0 = (this.i0 & 0x03);
                    this.i0 = (this.i0 | this.i2);
                    si8(this.i0, this.i4);
                    do 
                    {
                        
                    _label_9: 
                        this.i0 = li32(this.i1);
                        this.i2 = (this.i0 + 1);
                        si32(this.i2, this.i1);
                        goto _label_4;
                    } while (true);
                default:
                    throw ("Invalid state in _addk");
            };
        }


    }
} cmodule.lua_wrapper

