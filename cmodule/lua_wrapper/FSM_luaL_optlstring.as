package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaL_optlstring extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;


        public static function start():void
        {
            var _local_1:FSM_luaL_optlstring;
            _local_1 = new (FSM_luaL_optlstring)();
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
                    this.i0 = _luaO_nilobject_;
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
                    this.i4 = li32(public::mstate.ebp + 16);
                    this.i5 = li32(public::mstate.ebp + 20);
                    this.i6 = this.i4;
                    if (!(this.i3 == this.i0))
                    {
                        this.i0 = li32(this.i3 + 8);
                        if (this.i0 > 0) goto _label_1;
                    };
                    if (this.i5 == 0) goto _label_2;
                    if (!(this.i4 == 0))
                    {
                        this.i1 = li8(this.i4);
                        if (this.i1 == 0) goto _label_3;
                        this.i1 = this.i6;
                        do 
                        {
                            this.i2 = li8(this.i1 + 1);
                            this.i1 = (this.i1 + 1);
                            this.i0 = this.i1;
                            if (this.i2 == 0) goto _label_4;
                            this.i1 = this.i0;
                        } while (true);
                    };
                    this.i1 = 0;
                    goto _label_5;
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 2:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    do 
                    {
                        
                    _label_2: 
                        public::mstate.eax = this.i4;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_3: 
                        this.i1 = this.i4;
                        
                    _label_4: 
                        this.i1 = (this.i1 - this.i6);
                        
                    _label_5: 
                        si32(this.i1, this.i5);
                    } while (true);
                default:
                    throw ("Invalid state in _luaL_optlstring");
            };
        }


    }
} cmodule.lua_wrapper

