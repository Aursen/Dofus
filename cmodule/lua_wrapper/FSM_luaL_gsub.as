package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaL_gsub extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var i7:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_luaL_gsub;
            _local_1 = new (FSM_luaL_gsub)();
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
                    public::mstate.esp = (public::mstate.esp - 1040);
                    this.i0 = li32(public::mstate.ebp + 16);
                    this.i1 = li8(this.i0);
                    this.i2 = li32(public::mstate.ebp + 20);
                    this.i3 = li32(public::mstate.ebp + 8);
                    this.i4 = li32(public::mstate.ebp + 12);
                    this.i5 = this.i0;
                    this.i6 = this.i2;
                    if (this.i1 == 0) goto _label_5;
                    this.i1 = this.i5;
                    do 
                    {
                        this.i7 = li8(this.i1 + 1);
                        this.i1 = (this.i1 + 1);
                        this.i8 = this.i1;
                        if (this.i7 == 0) goto _label_6;
                        this.i1 = this.i8;
                    } while (true);
                    
                _label_1: 
                    this.i0 = this.i4;
                    goto _label_4;
                    
                _label_2: 
                    this.i4 = this.i2;
                    
                _label_3: 
                    this.i8 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i4 - this.i6);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = (this.i5 + this.i1);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strstr.start();
                case 2:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i5 == 0)) goto _label_7;
                    this.i0 = this.i4;
                    
                _label_4: 
                    this.i1 = li8(this.i0);
                    this.i2 = this.i0;
                    if (this.i1 == 0) goto _label_8;
                    this.i1 = this.i2;
                    do 
                    {
                        this.i4 = li8(this.i1 + 1);
                        this.i1 = (this.i1 + 1);
                        this.i5 = this.i1;
                        if (this.i4 == 0) goto _label_9;
                        this.i1 = this.i5;
                    } while (true);
                    
                _label_5: 
                    this.i1 = this.i0;
                    
                _label_6: 
                    this.i7 = (public::mstate.ebp + -1040);
                    si32(this.i3, (public::mstate.ebp + -1032));
                    this.i8 = (this.i7 + 12);
                    si32(this.i8, (public::mstate.ebp + -1040));
                    this.i8 = 0;
                    si32(this.i8, (public::mstate.ebp + -1036));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strstr.start();
                case 3:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = (this.i7 + 4);
                    this.i7 = (this.i7 + 8);
                    this.i1 = (this.i1 - this.i5);
                    if (this.i8 == 0) goto _label_1;
                    this.i5 = this.i8;
                    
                _label_7: 
                    this.i8 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = (this.i5 - this.i4);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = li8(this.i2);
                    if (this.i4 == 0) goto _label_2;
                    this.i4 = this.i6;
                    do 
                    {
                        this.i8 = li8(this.i4 + 1);
                        this.i4 = (this.i4 + 1);
                        this.i10 = this.i4;
                        if (this.i8 == 0) goto _label_3;
                        this.i4 = this.i10;
                    } while (true);
                    
                _label_8: 
                    this.i1 = this.i0;
                    
                _label_9: 
                    this.i4 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 - this.i2);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i9);
                    this.i1 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 1;
                    si32(this.i0, this.i9);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = -1;
                    this.i1 = 0;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaL_gsub");
            };
        }


    }
} cmodule.lua_wrapper

