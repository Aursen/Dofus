package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_replace extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_lua_replace;
            _local_1 = new (FSM_lua_replace)();
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
                    if (!(this.i1 == -10001)) goto _label_1;
                    this.i2 = li32(this.i0 + 20);
                    this.i3 = li32(this.i0 + 40);
                    if (!(this.i2 == this.i3)) goto _label_1;
                    this.i2 = __2E_str1250;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i1 == -10001)) goto _label_4;
                    this.i1 = li32(this.i0 + 20);
                    this.i1 = li32(this.i1 + 4);
                    this.i2 = li32(this.i0 + 8);
                    this.i1 = li32(this.i1);
                    this.i2 = li32(this.i2 + -12);
                    si32(this.i2, (this.i1 + 12));
                    this.i2 = li32(this.i0 + 8);
                    this.i3 = li32(this.i2 + -4);
                    this.i4 = (this.i0 + 8);
                    if (this.i3 < 4) goto _label_8;
                    this.i2 = li32(this.i2 + -12);
                    this.i3 = li8(this.i2 + 5);
                    this.i3 = (this.i3 & 0x03);
                    if (this.i3 == 0) goto _label_8;
                    this.i3 = li8(this.i1 + 5);
                    this.i1 = (this.i1 + 5);
                    this.i5 = (this.i3 & 0x04);
                    if (this.i5 == 0) goto _label_8;
                    this.i0 = li32(this.i0 + 16);
                    this.i5 = li8(this.i0 + 21);
                    if (!(this.i5 == 1)) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_3;
                    
                _label_2: 
                    this.i0 = li8(this.i0 + 20);
                    this.i2 = (this.i3 & 0xFFFFFFF8);
                    this.i0 = (this.i0 & 0x03);
                    this.i0 = (this.i0 | this.i2);
                    si8(this.i0, this.i1);
                    
                _label_3: 
                    this.i0 = li32(this.i4);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i4);
                    goto _label_7;
                    
                _label_4: 
                    this.i3 = li32(this.i0 + 8);
                    this.f0 = lf64(this.i3 + -12);
                    sf64(this.f0, this.i2);
                    this.i3 = li32(this.i3 + -4);
                    si32(this.i3, (this.i2 + 8));
                    this.i2 = (this.i0 + 8);
                    if (this.i1 > -10003) goto _label_8;
                    this.i1 = li32(this.i2);
                    this.i3 = li32(this.i1 + -4);
                    if (this.i3 < 4) goto _label_8;
                    this.i1 = li32(this.i1 + -12);
                    this.i3 = li8(this.i1 + 5);
                    this.i3 = (this.i3 & 0x03);
                    if (this.i3 == 0) goto _label_8;
                    this.i3 = li32(this.i0 + 20);
                    this.i3 = li32(this.i3 + 4);
                    this.i3 = li32(this.i3);
                    this.i4 = li8(this.i3 + 5);
                    this.i3 = (this.i3 + 5);
                    this.i5 = (this.i4 & 0x04);
                    if (this.i5 == 0) goto _label_8;
                    this.i0 = li32(this.i0 + 16);
                    this.i5 = li8(this.i0 + 21);
                    if (!(this.i5 == 1)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_6;
                    
                _label_5: 
                    this.i0 = li8(this.i0 + 20);
                    this.i1 = (this.i4 & 0xFFFFFFF8);
                    this.i0 = (this.i0 & 0x03);
                    this.i0 = (this.i0 | this.i1);
                    si8(this.i0, this.i3);
                    
                _label_6: 
                    this.i0 = li32(this.i2);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i2);
                    do 
                    {
                        
                    _label_7: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_8: 
                        this.i1 = li32(this.i0 + 8);
                        this.i1 = (this.i1 + -12);
                        si32(this.i1, (this.i0 + 8));
                    } while (true);
                default:
                    throw ("Invalid state in _lua_replace");
            };
        }


    }
} cmodule.lua_wrapper

