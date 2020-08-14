package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_tolstring extends Machine 
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
            var _local_1:FSM_lua_tolstring;
            _local_1 = new (FSM_lua_tolstring)();
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
                    public::mstate.esp = (public::mstate.esp - 32);
                    this.i0 = (public::mstate.ebp + -32);
                    this.i1 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = li32(public::mstate.ebp + 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i3 + 8);
                    this.i5 = (this.i3 + 8);
                    this.i6 = li32(public::mstate.ebp + 16);
                    if (!(this.i4 == 3))
                    {
                        if (!(this.i4 == 4)) goto _label_2;
                        this.i0 = this.i3;
                        
                    _label_1: 
                        this.i1 = li32(this.i0);
                        if (this.i6 == 0) goto _label_3;
                        this.i1 = li32(this.i1 + 12);
                        si32(this.i1, this.i6);
                        this.i1 = li32(this.i0);
                        this.i1 = (this.i1 + 16);
                        public::mstate.eax = this.i1;
                        goto _label_5;
                    };
                    this.i4 = __2E_str1166;
                    this.f0 = lf64(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = (public::mstate.ebp + -32);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    sf64(this.f0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i4 = li8(public::mstate.ebp + -32);
                    if (!(this.i4 == 0))
                    {
                        this.i4 = this.i0;
                        do 
                        {
                            this.i8 = li8(this.i4 + 1);
                            this.i4 = (this.i4 + 1);
                            this.i9 = this.i4;
                            if (this.i8 == 0) goto _label_6;
                            this.i4 = this.i9;
                        } while (true);
                        
                    _label_2: 
                        if (!(this.i6 == 0))
                        {
                            this.i0 = 0;
                            si32(this.i0, this.i6);
                            goto _label_4;
                            
                        _label_3: 
                            this.i0 = (this.i1 + 16);
                            
                        _label_4: 
                            public::mstate.eax = this.i0;
                            
                        _label_5: 
                            public::mstate.esp = public::mstate.ebp;
                            public::mstate.ebp = li32(public::mstate.esp);
                            public::mstate.esp = (public::mstate.esp + 4);
                            public::mstate.esp = (public::mstate.esp + 4);
                            public::mstate.gworker = caller;
                            return;
                        };
                        this.i0 = 0;
                        goto _label_4;
                    };
                    this.i4 = this.i7;
                    
                _label_6: 
                    this.i8 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i4 - this.i0);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    si32(this.i8, this.i5);
                    this.i0 = li32(this.i1 + 16);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_1;
                default:
                    throw ("Invalid state in _lua_tolstring");
            };
        }


    }
} cmodule.lua_wrapper

