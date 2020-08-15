package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_gc extends Machine 
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
            var _local_1:FSM_lua_gc;
            _local_1 = new (FSM_lua_gc)();
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
                    this.i1 = li32(this.i0 + 16);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(public::mstate.ebp + 16);
                    if (!(this.i2 > 3))
                    {
                        if (!(this.i2 > 1))
                        {
                            if (this.i2 == 0) goto _label_5;
                            if (!(this.i2 == 1)) goto _label_4;
                            this.i0 = 0;
                            this.i3 = li32(this.i1 + 68);
                            
                        _label_1: 
                            si32(this.i3, (this.i1 + 64));
                            
                        _label_2: 
                            goto _label_17;
                        };
                        if (this.i2 == 2) goto _label_6;
                        if (!(this.i2 == 3)) goto _label_4;
                        this.i0 = li32(this.i1 + 68);
                        this.i0 = (this.i0 >>> 10);
                        goto _label_2;
                    };
                    if (!(this.i2 > 5))
                    {
                        if (this.i2 == 4) goto _label_11;
                        if (!(this.i2 == 5)) goto _label_4;
                        this.i2 = li32(this.i1 + 68);
                        this.i4 = (this.i1 + 68);
                        this.i3 = (this.i3 << 10);
                        if (uint(this.i2) < uint(this.i3)) goto _label_12;
                        this.i3 = (this.i2 - this.i3);
                        si32(this.i3, (this.i1 + 64));
                        if (uint(this.i3) <= uint(this.i2)) goto _label_13;
                        
                    _label_3: 
                        this.i0 = 0;
                        goto _label_17;
                    };
                    if (this.i2 == 6) goto _label_15;
                    if (this.i2 == 7) goto _label_16;
                    
                _label_4: 
                    this.i0 = -1;
                    goto _label_17;
                    
                _label_5: 
                    this.i0 = -3;
                    si32(this.i0, (this.i1 + 64));
                    this.i0 = 0;
                    goto _label_17;
                    
                _label_6: 
                    this.i3 = li8(this.i1 + 21);
                    this.i2 = (this.i1 + 21);
                    if (uint(this.i3) > uint(1)) goto _label_8;
                    this.i3 = 0;
                    si32(this.i3, (this.i1 + 24));
                    this.i4 = (this.i1 + 28);
                    si32(this.i4, (this.i1 + 32));
                    si32(this.i3, (this.i1 + 36));
                    si32(this.i3, (this.i1 + 40));
                    si32(this.i3, (this.i1 + 44));
                    this.i3 = 2;
                    si8(this.i3, this.i2);
                    
                _label_7: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_singlestep.start();
                    return;
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_8: 
                    this.i3 = li8(this.i2);
                    if (!(this.i3 == 4)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_markroot.start();
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = li8(this.i2);
                    if (this.i3 == 0) goto _label_10;
                    
                _label_9: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_singlestep.start();
                    return;
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = li8(this.i2);
                    if (!(this.i3 == 0)) goto _label_9;
                    
                _label_10: 
                    this.i0 = 0;
                    this.i3 = li32(this.i1 + 72);
                    this.i2 = li32(this.i1 + 80);
                    this.i3 = (uint(this.i3) / uint(100));
                    this.i3 = (this.i2 * this.i3);
                    goto _label_1;
                    
                _label_11: 
                    this.i0 = li32(this.i1 + 68);
                    this.i0 = (this.i0 & 0x03FF);
                    goto _label_2;
                    
                _label_12: 
                    this.i3 = 0;
                    si32(this.i3, (this.i1 + 64));
                    
                _label_13: 
                    this.i3 = (this.i1 + 64);
                    this.i1 = (this.i1 + 21);
                    
                _label_14: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = li8(this.i1);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i0 = 1;
                    }
                    else
                    {
                        this.i2 = li32(this.i3);
                        this.i5 = li32(this.i4);
                        if (uint(this.i2) > uint(this.i5)) goto _label_3;
                        goto _label_14;
                        
                    _label_15: 
                        this.i0 = li32(this.i1 + 80);
                        si32(this.i3, (this.i1 + 80));
                        goto _label_2;
                        
                    _label_16: 
                        this.i0 = li32(this.i1 + 84);
                        si32(this.i3, (this.i1 + 84));
                    };
                    
                _label_17: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _lua_gc");
            };
        }


    }
}

