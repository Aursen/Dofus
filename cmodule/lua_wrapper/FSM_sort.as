package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_sort extends Machine 
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
            var _local_1:FSM_sort;
            _local_1 = new (FSM_sort)();
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
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = _luaO_nilobject_;
                    if (!(this.i0 == this.i2))
                    {
                        this.i0 = li32(this.i0 + 8);
                        if (this.i0 == 5) goto _label_1;
                    };
                    this.i0 = 5;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tag_error.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_objlen.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 40;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_checkstack.start();
                    return;
                case 4:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i2 == 0)) goto _label_2;
                    this.i2 = __2E_str10185328;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = __2E_str45;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    this.i2 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 6:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = _luaO_nilobject_;
                    if (this.i2 == this.i3) goto _label_6;
                    this.i2 = li32(this.i2 + 8);
                    if (this.i2 < 1) goto _label_6;
                    this.i2 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 7:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = _luaO_nilobject_;
                    if (!(this.i2 == this.i3))
                    {
                        this.i2 = li32(this.i2 + 8);
                        if (this.i2 == 6) goto _label_3;
                    };
                    this.i2 = 6;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tag_error.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    this.i2 = li32(this.i1 + 12);
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = (this.i1 + 12);
                    this.i5 = (this.i1 + 8);
                    this.i6 = (this.i2 + 24);
                    if (!(uint(this.i3) < uint(this.i6)))
                    {
                        this.i3 = this.i2;
                        goto _label_5;
                    };
                    
                _label_4: 
                    this.i2 = 0;
                    si32(this.i2, (this.i3 + 8));
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i2 = li32(this.i4);
                    this.i6 = (this.i2 + 24);
                    if (uint(this.i3) < uint(this.i6)) goto _label_4;
                    this.i3 = this.i2;
                    
                _label_5: 
                    this.i2 = this.i3;
                    this.i3 = 1;
                    this.i2 = (this.i2 + 24);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_auxsort.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_6: 
                    this.i2 = li32(this.i1 + 12);
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = (this.i1 + 12);
                    this.i5 = (this.i1 + 8);
                    this.i6 = (this.i2 + 24);
                    if (!(uint(this.i3) < uint(this.i6)))
                    {
                        this.i3 = this.i2;
                        goto _label_8;
                    };
                    
                _label_7: 
                    this.i2 = 0;
                    si32(this.i2, (this.i3 + 8));
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i2 = li32(this.i4);
                    this.i6 = (this.i2 + 24);
                    if (uint(this.i3) < uint(this.i6)) goto _label_7;
                    this.i3 = this.i2;
                    
                _label_8: 
                    goto _label_5;
                default:
                    throw ("Invalid state in _sort");
            };
        }


    }
} cmodule.lua_wrapper

