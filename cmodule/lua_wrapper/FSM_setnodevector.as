package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_setnodevector extends Machine 
    {

        public static const intRegCount:int = 10;
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
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_setnodevector;
            _local_1 = new (FSM_setnodevector)();
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
                    this.i2 = li32(public::mstate.ebp + 16);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i0 = _dummynode_;
                        si32(this.i0, (this.i1 + 16));
                        this.i0 = 0;
                        
                    _label_1: 
                        si8(this.i0, (this.i1 + 7));
                        this.i0 = li32(this.i1 + 16);
                        this.i2 = (this.i2 * 28);
                        this.i0 = (this.i0 + this.i2);
                        si32(this.i0, (this.i1 + 20));
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i2 = (this.i2 + -1);
                    if (!(uint(this.i2) > uint(0xFF)))
                    {
                        this.i3 = -1;
                    }
                    else
                    {
                        this.i3 = -1;
                        do 
                        {
                            this.i3 = (this.i3 + 1);
                            this.i2 = (this.i2 >>> 8);
                        } while (!(uint(this.i2) < uint(0x0100)));
                        this.i3 = (this.i3 << 3);
                        this.i3 = (this.i3 | 0x07);
                    };
                    this.i4 = _log_2_2E_3461;
                    this.i2 = (this.i4 + this.i2);
                    this.i2 = li8(this.i2);
                    this.i2 = (this.i2 + this.i3);
                    this.i3 = (this.i2 + 1);
                    if (this.i3 < 27) goto _label_2;
                    this.i2 = __2E_str2126;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i2 = 1;
                    this.i2 = (this.i2 << this.i3);
                    this.i4 = (this.i1 + 16);
                    this.i5 = (this.i2 + 1);
                    if (uint(this.i5) > uint(153391689)) goto _label_5;
                    this.i5 = 0;
                    this.i6 = li32(this.i0 + 16);
                    this.i7 = li32(this.i6 + 12);
                    this.i8 = li32(this.i6 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (this.i2 * 28);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i9, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i7]());
                    return;
                case 2:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i5 == 0)) goto _label_3;
                    if (this.i9 == 0) goto _label_3;
                    this.i7 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    this.i0 = li32(this.i6 + 68);
                    this.i0 = (this.i9 + this.i0);
                    si32(this.i0, (this.i6 + 68));
                    si32(this.i5, this.i4);
                    if (this.i2 > 0) goto _label_6;
                    
                _label_4: 
                    this.i0 = this.i3;
                    goto _label_1;
                    
                _label_5: 
                    this.i5 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 0;
                    si32(this.i0, this.i4);
                    if (!(this.i2 > 0)) goto _label_4;
                    
                _label_6: 
                    this.i0 = 0;
                    this.i5 = this.i0;
                    do 
                    {
                        this.i6 = 0;
                        this.i7 = li32(this.i4);
                        this.i7 = (this.i7 + this.i5);
                        si32(this.i6, (this.i7 + 24));
                        si32(this.i6, (this.i7 + 20));
                        si32(this.i6, (this.i7 + 8));
                        this.i5 = (this.i5 + 28);
                        this.i0 = (this.i0 + 1);
                        if (this.i0 >= this.i2) goto _label_4;
                    } while (true);
                default:
                    throw ("Invalid state in _setnodevector");
            };
        }


    }
}

