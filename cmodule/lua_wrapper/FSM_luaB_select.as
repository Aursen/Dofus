package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_select extends Machine 
    {

        public static const intRegCount:int = 5;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var f0:Number;
        public var i4:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_luaB_select;
            _local_1 = new (FSM_luaB_select)();
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
                    this.i0 = 1;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    this.i2 = (this.i2 - this.i3);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = (this.i2 / 12);
                    this.i3 = (this.i1 + 8);
                    this.i4 = _luaO_nilobject_;
                    if (this.i0 == this.i4) goto _label_1;
                    this.i0 = li32(this.i0 + 8);
                    if (!(this.i0 == 4)) goto _label_1;
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li8(this.i0);
                    if (!(!(this.i0 == 35)))
                    {
                        this.i1 = 3;
                        this.i2 = (this.i2 + -1);
                        this.i0 = li32(this.i3);
                        this.f0 = Number(this.i2);
                        sf64(this.f0, this.i0);
                        si32(this.i1, (this.i0 + 8));
                        this.i1 = li32(this.i3);
                        this.i1 = (this.i1 + 12);
                        si32(this.i1, this.i3);
                        this.i1 = 1;
                        public::mstate.eax = this.i1;
                        goto _label_4;
                    };
                    
                _label_1: 
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i0 > -1))
                    {
                        this.i0 = (this.i0 + this.i2);
                        if (!(this.i0 > 0)) goto _label_2;
                        goto _label_3;
                    };
                    this.i0 = ((this.i0 > this.i2) ? this.i2 : this.i0);
                    //unresolved if
                    
                _label_2: 
                    this.i3 = __2E_str56346;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 12);
                    do 
                    {
                        
                    _label_3: 
                        this.i0 = (this.i2 - this.i0);
                        public::mstate.eax = this.i0;
                        
                    _label_4: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    } while (true);
                default:
                    throw ("Invalid state in _luaB_select");
            };
        }


    }
} cmodule.lua_wrapper

