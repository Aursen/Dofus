package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaD_poscall extends Machine 
    {

        public static const intRegCount:int = 9;
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


        public static function start():void
        {
            var _local_1:FSM_luaD_poscall;
            _local_1 = new (FSM_luaD_poscall)();
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
                    this.i1 = li8(this.i0 + 56);
                    this.i2 = (this.i0 + 56);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i1 = (this.i1 & 0x02);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i2 = this.i3;
                        goto _label_4;
                    };
                    this.i1 = -1;
                    this.i4 = li32(this.i0 + 32);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_callhook.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i0 + 20);
                    this.i1 = li32(this.i1 + 4);
                    this.i1 = li32(this.i1);
                    this.i1 = li8(this.i1 + 6);
                    this.i5 = (this.i0 + 20);
                    this.i3 = (this.i3 - this.i4);
                    this.i4 = (this.i0 + 32);
                    if (this.i1 == 0) goto _label_2;
                    goto _label_3;
                    
                _label_1: 
                    this.i1 = -1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 4;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_callhook.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    this.i1 = li8(this.i2);
                    this.i1 = (this.i1 & 0x02);
                    if (!(this.i1 == 0))
                    {
                        this.i1 = li32(this.i5);
                        this.i6 = li32(this.i1 + 20);
                        this.i7 = (this.i6 + -1);
                        si32(this.i7, (this.i1 + 20));
                        if (!(this.i6 == 0)) goto _label_1;
                    };
                    
                _label_3: 
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + this.i3);
                    
                _label_4: 
                    this.i1 = this.i2;
                    this.i2 = li32(this.i0 + 20);
                    this.i3 = (this.i2 + -24);
                    si32(this.i3, (this.i0 + 20));
                    this.i3 = li32(this.i2 + 4);
                    this.i4 = li32(this.i2 + 16);
                    this.i5 = li32(this.i2 + -24);
                    si32(this.i5, (this.i0 + 12));
                    this.i2 = li32(this.i2 + -12);
                    si32(this.i2, (this.i0 + 24));
                    this.i2 = this.i3;
                    if (!(!(this.i4 == 0)))
                    {
                        this.i1 = this.i2;
                        this.i3 = this.i4;
                        goto _label_7;
                        
                    _label_5: 
                        this.i6 = (this.i1 + this.i7);
                        this.f0 = lf64(this.i6);
                        this.i8 = (this.i3 + this.i7);
                        sf64(this.f0, this.i8);
                        this.i6 = li32(this.i6 + 8);
                        si32(this.i6, (this.i8 + 8));
                        this.i6 = (this.i7 + 12);
                        this.i7 = (this.i2 + -1);
                        if (!(this.i7 == 0))
                        {
                            this.i2 = this.i6;
                            this.i6 = this.i7;
                            goto _label_6;
                        };
                        this.i1 = (this.i3 + this.i6);
                        this.i3 = this.i7;
                        goto _label_7;
                    };
                    this.i2 = 0;
                    this.i5 = (this.i0 + 8);
                    this.i6 = this.i4;
                    
                _label_6: 
                    this.i7 = this.i2;
                    this.i2 = this.i6;
                    this.i6 = li32(this.i5);
                    this.i8 = (this.i1 + this.i7);
                    if (uint(this.i6) > uint(this.i8)) goto _label_5;
                    this.i1 = (this.i3 + this.i7);
                    this.i3 = this.i2;
                    
                _label_7: 
                    this.i2 = this.i3;
                    this.i3 = this.i1;
                    if ((this.i2 > 0))
                    {
                        this.i5 = 0;
                        this.i3 = (this.i3 + 8);
                        do 
                        {
                            this.i6 = 0;
                            si32(this.i6, this.i3);
                            this.i3 = (this.i3 + 12);
                            this.i2 = (this.i2 + -1);
                            this.i5 = (this.i5 + 1);
                        } while (!(this.i2 < 1));
                        this.i2 = (this.i5 * 12);
                        this.i1 = (this.i1 + this.i2);
                    };
                    si32(this.i1, (this.i0 + 8));
                    this.i0 = (this.i4 + 1);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaD_poscall");
            };
        }


    }
}

