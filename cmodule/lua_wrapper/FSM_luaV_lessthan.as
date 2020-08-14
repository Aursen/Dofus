package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaV_lessthan extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 2;

        public var f1:Number;
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
            var _local_1:FSM_luaV_lessthan;
            _local_1 = new (FSM_luaV_lessthan)();
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
                    this.i1 = li32(public::mstate.ebp + 16);
                    this.i2 = li32(this.i0 + 8);
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = (this.i1 + 8);
                    this.i5 = (this.i0 + 8);
                    this.i6 = li32(public::mstate.ebp + 8);
                    if (this.i2 == this.i3) goto _label_3;
                    this.i0 = _luaT_typenames;
                    this.i1 = (this.i3 << 2);
                    this.i2 = (this.i2 << 2);
                    this.i1 = (this.i0 + this.i1);
                    this.i0 = (this.i0 + this.i2);
                    this.i0 = li32(this.i0);
                    this.i1 = li32(this.i1);
                    this.i2 = li8(this.i0 + 2);
                    this.i4 = li8(this.i1 + 2);
                    if (!(this.i2 == this.i4)) goto _label_4;
                    
                _label_1: 
                    this.i1 = __2E_str16273;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    this.i0 = 0;
                    do 
                    {
                        goto _label_6;
                        
                    _label_3: 
                        if (this.i2 == 4) goto _label_5;
                        if ((!(this.i2 == 3))) break;
                        this.f0 = lf64(this.i0);
                        this.f1 = lf64(this.i1);
                        this.i0 = ((this.f0 < this.f1) ? 1 : 0);
                        this.i0 = (this.i0 & 0x01);
                    } while (true);
                    this.i2 = 13;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_call_orderTM.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i0 == -1)) goto _label_6;
                    this.i0 = _luaT_typenames;
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 << 2);
                    this.i1 = (this.i1 << 2);
                    this.i2 = (this.i0 + this.i2);
                    this.i0 = (this.i0 + this.i1);
                    this.i0 = li32(this.i0);
                    this.i1 = li32(this.i2);
                    this.i2 = li8(this.i0 + 2);
                    this.i3 = li8(this.i1 + 2);
                    if (!(!(this.i2 == this.i3))) goto _label_1;
                    
                _label_4: 
                    this.i2 = __2E_str17274;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 16);
                    goto _label_2;
                    
                _label_5: 
                    this.i1 = li32(this.i1);
                    this.i0 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_l_strcmp.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = (this.i0 >>> 31);
                    
                _label_6: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaV_lessthan");
            };
        }


    }
} cmodule.lua_wrapper

