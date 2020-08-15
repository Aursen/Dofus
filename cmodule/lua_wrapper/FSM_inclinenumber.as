package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_inclinenumber extends Machine 
    {

        public static const intRegCount:int = 9;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_inclinenumber;
            _local_1 = new (FSM_inclinenumber)();
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
                    public::mstate.esp = (public::mstate.esp - 100);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 44);
                    this.i2 = li32(this.i1);
                    this.i3 = li32(this.i0);
                    this.i4 = (this.i2 + -1);
                    si32(this.i4, this.i1);
                    this.i1 = li32(this.i0 + 44);
                    this.i4 = (this.i0 + 44);
                    this.i5 = this.i0;
                    if (!(this.i2 == 0))
                    {
                        this.i2 = li32(this.i1 + 4);
                        this.i6 = li8(this.i2);
                        this.i2 = (this.i2 + 1);
                        si32(this.i2, (this.i1 + 4));
                        si32(this.i6, this.i5);
                        if (!(this.i6 == 10))
                        {
                            if (!(this.i6 == 13)) goto _label_6;
                        };
                        this.i1 = this.i6;
                        goto _label_3;
                    };
                    this.i2 = (public::mstate.ebp + -100);
                    this.i6 = li32(this.i1 + 16);
                    this.i7 = li32(this.i1 + 8);
                    this.i8 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i7]());
                    return;
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i2 == 0)))
                    {
                        
                    _label_1: 
                        this.i1 = -1;
                        goto _label_2;
                    };
                    this.i6 = li32(public::mstate.ebp + -100);
                    if (this.i6 == 0) goto _label_1;
                    this.i6 = (this.i6 + -1);
                    si32(this.i6, this.i1);
                    si32(this.i2, (this.i1 + 4));
                    this.i6 = li8(this.i2);
                    this.i2 = (this.i2 + 1);
                    si32(this.i2, (this.i1 + 4));
                    this.i1 = this.i6;
                    
                _label_2: 
                    si32(this.i1, this.i5);
                    if (!(this.i1 == 10))
                    {
                        if (!(this.i1 == 13)) goto _label_6;
                    };
                    
                _label_3: 
                    if (this.i1 == this.i3) goto _label_6;
                    this.i1 = li32(this.i4);
                    this.i2 = li32(this.i1);
                    this.i3 = (this.i2 + -1);
                    si32(this.i3, this.i1);
                    this.i1 = li32(this.i4);
                    if (!(this.i2 == 0))
                    {
                        this.i2 = li32(this.i1 + 4);
                        this.i3 = li8(this.i2);
                        this.i2 = (this.i2 + 1);
                        si32(this.i2, (this.i1 + 4));
                        si32(this.i3, this.i5);
                        goto _label_6;
                    };
                    this.i2 = (public::mstate.ebp + -4);
                    this.i3 = li32(this.i1 + 16);
                    this.i4 = li32(this.i1 + 8);
                    this.i6 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i4]());
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i2 == 0)))
                    {
                        
                    _label_4: 
                        this.i1 = -1;
                        goto _label_5;
                    };
                    this.i3 = li32(public::mstate.ebp + -4);
                    if (this.i3 == 0) goto _label_4;
                    this.i3 = (this.i3 + -1);
                    si32(this.i3, this.i1);
                    si32(this.i2, (this.i1 + 4));
                    this.i3 = li8(this.i2);
                    this.i2 = (this.i2 + 1);
                    si32(this.i2, (this.i1 + 4));
                    this.i1 = this.i3;
                    
                _label_5: 
                    si32(this.i1, this.i5);
                    
                _label_6: 
                    this.i1 = li32(this.i0 + 4);
                    this.i1 = (this.i1 + 1);
                    si32(this.i1, (this.i0 + 4));
                    this.i2 = (this.i0 + 4);
                    if (this.i1 < 2147483645) goto _label_11;
                    this.i1 = 80;
                    this.i3 = li32(this.i0 + 52);
                    this.i4 = li32(this.i0 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (public::mstate.ebp + -96);
                    this.i3 = (this.i3 + 16);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 3:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i2);
                    this.i2 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i3 = __2E_str15272;
                    this.i6 = __2E_str3747;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i6, (public::mstate.esp + 16));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 4:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = (this.i0 + 40);
                    if (this.i4 == 0) goto _label_8;
                    this.i3 = (this.i4 + -284);
                    if (uint(this.i3) > uint(2)) goto _label_7;
                    this.i4 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i0 + 48);
                    this.i0 = li32(this.i0);
                    this.i4 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = __2E_str35292;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = 3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    goto _label_10;
                    
                _label_7: 
                    this.i3 = __2E_str35292;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaX_token2str.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 3;
                    si32(this.i2, public::mstate.esp);
                    goto _label_9;
                    
                _label_8: 
                    this.i0 = 3;
                    this.i1 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    
                _label_9: 
                    si32(this.i0, (public::mstate.esp + 4));
                    
                _label_10: 
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_11: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _inclinenumber");
            };
        }


    }
}

