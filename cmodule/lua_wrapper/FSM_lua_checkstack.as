package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_checkstack extends Machine 
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
            var _local_1:FSM_lua_checkstack;
            _local_1 = new (FSM_lua_checkstack)();
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
                    if (!(this.i1 < 8001))
                    {
                        
                    _label_1: 
                        this.i0 = 0;
                        
                    _label_2: 
                        public::mstate.eax = this.i0;
                        goto _label_6;
                    };
                    this.i2 = li32(this.i0 + 8);
                    this.i3 = li32(this.i0 + 12);
                    this.i3 = (this.i2 - this.i3);
                    this.i4 = (this.i0 + 8);
                    this.i3 = (this.i3 / 12);
                    this.i3 = (this.i3 + this.i1);
                    if (this.i3 > 8000) goto _label_1;
                    if (!(this.i1 > 0))
                    {
                        
                    _label_3: 
                        this.i0 = 1;
                        goto _label_2;
                    };
                    this.i3 = li32(this.i0 + 28);
                    this.i5 = (this.i1 * 12);
                    this.i2 = (this.i3 - this.i2);
                    if (this.i2 > this.i5) goto _label_5;
                    this.i2 = li32(this.i0 + 44);
                    if (this.i2 < this.i1) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 << 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_5;
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 + this.i1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_5: 
                    this.i0 = li32(this.i0 + 20);
                    this.i2 = li32(this.i0 + 8);
                    this.i3 = li32(this.i4);
                    this.i1 = (this.i1 * 12);
                    this.i1 = (this.i3 + this.i1);
                    this.i0 = (this.i0 + 8);
                    if (uint(this.i2) >= uint(this.i1)) goto _label_3;
                    this.i2 = 1;
                    si32(this.i1, this.i0);
                    public::mstate.eax = this.i2;
                    
                _label_6: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _lua_checkstack");
            };
        }


    }
} cmodule.lua_wrapper

