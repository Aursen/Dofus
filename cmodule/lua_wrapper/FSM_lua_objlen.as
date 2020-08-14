package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_objlen extends Machine 
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
            var _local_1:FSM_lua_objlen;
            _local_1 = new (FSM_lua_objlen)();
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
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i2 + 8);
                    this.i4 = (this.i2 + 8);
                    if (!(this.i3 > 4))
                    {
                        if (this.i3 == 3) goto _label_3;
                        if (!(this.i3 == 4))
                        {
                            goto _label_4;
                        };
                        
                    _label_1: 
                        this.i0 = li32(this.i2);
                        this.i0 = li32(this.i0 + 12);
                        
                    _label_2: 
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    if (!(this.i3 == 5))
                    {
                        if (!(this.i3 == 7)) goto _label_4;
                        this.i0 = li32(this.i2);
                        this.i0 = li32(this.i0 + 16);
                        goto _label_2;
                    };
                    this.i0 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getn.start();
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    goto _label_2;
                    
                _label_3: 
                    this.i3 = __2E_str1166;
                    this.f0 = lf64(this.i2);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (public::mstate.ebp + -32);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    sf64(this.f0, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li8(public::mstate.ebp + -32);
                    if (!(this.i3 == 0))
                    {
                        this.i3 = this.i0;
                        do 
                        {
                            this.i6 = li8(this.i3 + 1);
                            this.i3 = (this.i3 + 1);
                            this.i7 = this.i3;
                            if (this.i6 == 0) goto _label_5;
                            this.i3 = this.i7;
                        } while (true);
                        
                    _label_4: 
                        this.i0 = 0;
                        goto _label_2;
                    };
                    this.i3 = this.i5;
                    
                _label_5: 
                    this.i6 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i3 - this.i0);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    si32(this.i6, this.i4);
                    goto _label_1;
                default:
                    throw ("Invalid state in _lua_objlen");
            };
        }


    }
} cmodule.lua_wrapper

