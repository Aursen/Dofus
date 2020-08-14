package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_db_setmetatable extends Machine 
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
            var _local_1:FSM_db_setmetatable;
            _local_1 = new (FSM_db_setmetatable)();
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
                    this.i0 = 2;
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
                    if (!(!(this.i0 == this.i2)))
                    {
                        this.i0 = -1;
                    }
                    else
                    {
                        this.i0 = li32(this.i0 + 8);
                    };
                    if (this.i0 == 0) goto _label_4;
                    if (this.i0 == 5) goto _label_4;
                    this.i0 = __2E_str36236;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i1 + 12);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = (this.i1 + 12);
                    this.i4 = (this.i1 + 8);
                    this.i5 = (this.i0 + 24);
                    if (!(uint(this.i2) < uint(this.i5)))
                    {
                        this.i2 = this.i0;
                        goto _label_2;
                    };
                    
                _label_1: 
                    this.i0 = 0;
                    si32(this.i0, (this.i2 + 8));
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    this.i0 = li32(this.i3);
                    this.i5 = (this.i0 + 24);
                    if (uint(this.i2) < uint(this.i5)) goto _label_1;
                    this.i2 = this.i0;
                    
                _label_2: 
                    this.i0 = this.i2;
                    this.i2 = 1;
                    this.i0 = (this.i0 + 24);
                    si32(this.i0, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setmetatable.start();
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i4);
                    si32(this.i2, this.i1);
                    si32(this.i2, (this.i1 + 8));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    
                _label_3: 
                    public::mstate.eax = this.i2;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_4: 
                    this.i0 = li32(this.i1 + 12);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = (this.i1 + 12);
                    this.i4 = (this.i1 + 8);
                    this.i5 = (this.i0 + 24);
                    if (!(uint(this.i2) < uint(this.i5)))
                    {
                        this.i2 = this.i0;
                        goto _label_6;
                    };
                    
                _label_5: 
                    this.i0 = 0;
                    si32(this.i0, (this.i2 + 8));
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    this.i0 = li32(this.i3);
                    this.i5 = (this.i0 + 24);
                    if (uint(this.i2) < uint(this.i5)) goto _label_5;
                    this.i2 = this.i0;
                    
                _label_6: 
                    this.i0 = this.i2;
                    this.i2 = 1;
                    this.i0 = (this.i0 + 24);
                    si32(this.i0, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setmetatable.start();
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i4);
                    si32(this.i2, this.i0);
                    si32(this.i2, (this.i0 + 8));
                    this.i0 = li32(this.i4);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i4);
                    goto _label_3;
                default:
                    throw ("Invalid state in _db_setmetatable");
            };
        }


    }
} cmodule.lua_wrapper

