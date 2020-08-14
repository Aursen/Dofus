package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaS_resize extends Machine 
    {

        public static const intRegCount:int = 13;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;
        public var i8:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_luaS_resize;
            _local_1 = new (FSM_luaS_resize)();
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
                    this.i1 = li32(this.i0 + 16);
                    this.i2 = li8(this.i1 + 21);
                    this.i3 = (this.i0 + 16);
                    this.i4 = li32(public::mstate.ebp + 12);
                    if (this.i2 == 2) goto _label_8;
                    this.i2 = (this.i4 + 1);
                    if (uint(this.i2) > uint(1073741823)) goto _label_4;
                    this.i2 = 0;
                    this.i5 = li32(this.i1 + 12);
                    this.i6 = li32(this.i1 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = (this.i4 << 2);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i5]());
                    return;
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i2 == 0)) goto _label_1;
                    if (this.i7 == 0) goto _label_1;
                    this.i5 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i0 = li32(this.i1 + 68);
                    this.i0 = (this.i7 + this.i0);
                    si32(this.i0, (this.i1 + 68));
                    this.i0 = li32(this.i3);
                    this.i1 = this.i2;
                    if (!(this.i4 > 0))
                    {
                        
                    _label_2: 
                        this.i2 = this.i1;
                        this.i1 = this.i0;
                        this.i5 = li32(this.i1 + 8);
                        this.i0 = (this.i1 + 8);
                        if (!(this.i5 > 0)) goto _label_7;
                        this.i5 = 0;
                        this.i6 = (this.i4 + -1);
                        this.i7 = this.i1;
                        this.i8 = this.i5;
                        
                    _label_3: 
                        this.i9 = li32(this.i7);
                        this.i9 = (this.i9 + this.i8);
                        this.i9 = li32(this.i9);
                        if (this.i9 == 0) goto _label_6;
                        do 
                        {
                            this.i10 = li32(this.i9 + 8);
                            this.i10 = (this.i10 & this.i6);
                            this.i10 = (this.i10 << 2);
                            this.i10 = (this.i2 + this.i10);
                            this.i11 = li32(this.i9);
                            this.i12 = li32(this.i10);
                            si32(this.i12, this.i9);
                            si32(this.i9, this.i10);
                            if (this.i11 == 0) goto _label_6;
                            this.i9 = this.i11;
                        } while (true);
                    };
                    goto _label_5;
                    
                _label_4: 
                    this.i1 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i3);
                    if (!(this.i4 > 0))
                    {
                        this.i1 = 0;
                        goto _label_2;
                    };
                    this.i1 = 0;
                    
                _label_5: 
                    this.i2 = 0;
                    this.i5 = this.i1;
                    do 
                    {
                        this.i6 = 0;
                        si32(this.i6, this.i5);
                        this.i5 = (this.i5 + 4);
                        this.i2 = (this.i2 + 1);
                        if (!(this.i2 < this.i4)) goto _label_2;
                    } while (true);
                    
                _label_6: 
                    this.i9 = li32(this.i0);
                    this.i8 = (this.i8 + 4);
                    this.i5 = (this.i5 + 1);
                    if (this.i9 > this.i5) goto _label_9;
                    this.i5 = this.i9;
                    
                _label_7: 
                    this.i6 = 0;
                    this.i3 = li32(this.i3);
                    this.i7 = li32(this.i1);
                    this.i8 = li32(this.i3 + 12);
                    this.i9 = li32(this.i3 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (this.i5 << 2);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 4:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i6 = li32(this.i3 + 68);
                    this.i5 = (this.i6 - this.i5);
                    si32(this.i5, (this.i3 + 68));
                    si32(this.i4, this.i0);
                    si32(this.i2, this.i1);
                    
                _label_8: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_9: 
                    goto _label_3;
                default:
                    throw ("Invalid state in _luaS_resize");
            };
        }


    }
} cmodule.lua_wrapper

