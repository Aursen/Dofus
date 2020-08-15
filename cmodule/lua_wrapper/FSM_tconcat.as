package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_tconcat extends Machine 
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
            var _local_1:FSM_tconcat;
            _local_1 = new (FSM_tconcat)();
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
                    public::mstate.esp = (public::mstate.esp - 1044);
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
                    if (!(this.i0 == this.i2))
                    {
                        this.i0 = li32(this.i0 + 8);
                        if (this.i0 > 0) goto _label_1;
                    };
                    this.i0 = 0;
                    si32(this.i0, (public::mstate.ebp + -1044));
                    this.i0 = __2E_str45;
                    goto _label_2;
                    
                _label_1: 
                    this.i0 = (public::mstate.ebp + -1044);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    this.i2 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = _luaO_nilobject_;
                    if (!(this.i2 == this.i3))
                    {
                        this.i2 = li32(this.i2 + 8);
                        if (this.i2 == 5) goto _label_3;
                    };
                    this.i2 = 5;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tag_error.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    this.i2 = 3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = _luaO_nilobject_;
                    if (!(!(this.i2 == this.i3)))
                    {
                        
                    _label_4: 
                        this.i2 = 1;
                        goto _label_5;
                    };
                    this.i2 = li32(this.i2 + 8);
                    if (this.i2 < 1) goto _label_4;
                    this.i2 = 3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 6:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_5: 
                    this.i3 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 7:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = _luaO_nilobject_;
                    if (!(this.i3 == this.i4))
                    {
                        this.i3 = li32(this.i3 + 8);
                        if (this.i3 > 0) goto _label_7;
                    };
                    this.i3 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_objlen.start();
                    return;
                case 8:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = (public::mstate.ebp + -1040);
                    si32(this.i1, (public::mstate.ebp + -1032));
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, (public::mstate.ebp + -1040));
                    this.i4 = 0;
                    si32(this.i4, (public::mstate.ebp + -1036));
                    if (!(this.i2 < this.i3))
                    {
                        this.i0 = this.i3;
                        goto _label_8;
                    };
                    
                _label_6: 
                    this.i4 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_addfield.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(public::mstate.ebp + -1044);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = (this.i2 + 1);
                    if (this.i2 < this.i3) goto _label_11;
                    this.i0 = this.i3;
                    goto _label_8;
                    
                _label_7: 
                    this.i3 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 11:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = (public::mstate.ebp + -1040);
                    si32(this.i1, (public::mstate.ebp + -1032));
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, (public::mstate.ebp + -1040));
                    this.i4 = 0;
                    si32(this.i4, (public::mstate.ebp + -1036));
                    if (this.i2 < this.i3) goto _label_6;
                    this.i0 = this.i3;
                    
                _label_8: 
                    if (!(this.i2 == this.i0)) goto _label_9;
                    this.i0 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_addfield.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_10;
                    
                _label_9: 
                    this.i0 = (public::mstate.ebp + -1040);
                    
                _label_10: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 13:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(public::mstate.ebp + -1036);
                    this.i1 = li32(public::mstate.ebp + -1032);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_11: 
                    goto _label_6;
                default:
                    throw ("Invalid state in _tconcat");
            };
        }


    }
}

