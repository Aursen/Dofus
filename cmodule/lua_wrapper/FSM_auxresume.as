package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_auxresume extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var f0:Number;
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
            var _local_1:FSM_auxresume;
            _local_1 = new (FSM_auxresume)();
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
                    public::mstate.esp = (public::mstate.esp - 176);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    if (!(!(this.i0 == this.i1)))
                    {
                        this.i3 = 0;
                        goto _label_2;
                    };
                    this.i3 = li8(this.i1 + 6);
                    if (!(this.i3 == 0))
                    {
                        if (!(this.i3 == 1)) goto _label_1;
                        this.i3 = 1;
                        goto _label_2;
                    };
                    this.i3 = (public::mstate.ebp + -176);
                    this.i4 = li32(this.i1 + 20);
                    this.i5 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = 0;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getstack390.start();
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i3 < 1))
                    {
                        this.i3 = 2;
                    }
                    else
                    {
                        this.i3 = li32(this.i1 + 8);
                        this.i4 = li32(this.i1 + 12);
                        this.i3 = (this.i3 - this.i4);
                        this.i3 = (this.i3 + 11);
                        this.i3 = ((uint(this.i3) < uint(23)) ? 3 : 1);
                        goto _label_2;
                        
                    _label_1: 
                        this.i3 = 3;
                    };
                    
                _label_2: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_checkstack.start();
                    return;
                case 2:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i4 == 0)) goto _label_3;
                    this.i4 = __2E_str64353;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    if (this.i3 == 1) goto _label_5;
                    this.i1 = _statnames;
                    this.i2 = (this.i3 << 2);
                    this.i1 = (this.i1 + this.i2);
                    this.i1 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = __2E_str65354;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_4: 
                    this.i0 = -1;
                    public::mstate.eax = this.i0;
                    goto _label_17;
                    
                _label_5: 
                    if (!(this.i0 == this.i1))
                    {
                        this.i3 = (0 - this.i2);
                        this.i4 = li32(this.i0 + 8);
                        this.i3 = (this.i3 * 12);
                        this.i3 = (this.i4 + this.i3);
                        si32(this.i3, (this.i0 + 8));
                        this.i3 = (this.i0 + 8);
                        if (!(this.i2 < 1))
                        {
                            this.i4 = 0;
                            this.i5 = (this.i1 + 8);
                            this.i6 = this.i4;
                            do 
                            {
                                this.i7 = li32(this.i5);
                                this.i8 = li32(this.i3);
                                this.i9 = (this.i7 + 12);
                                si32(this.i9, this.i5);
                                this.i8 = (this.i8 + this.i6);
                                this.f0 = lf64(this.i8);
                                sf64(this.f0, this.i7);
                                this.i8 = li32(this.i8 + 8);
                                si32(this.i8, (this.i7 + 8));
                                this.i6 = (this.i6 + 12);
                                this.i4 = (this.i4 + 1);
                            } while (!(this.i4 == this.i2));
                        };
                    };
                    this.i3 = li16(this.i0 + 52);
                    si16(this.i3, (this.i1 + 52));
                    this.i4 = li8(this.i1 + 6);
                    this.i5 = (this.i1 + 6);
                    this.i6 = (this.i1 + 52);
                    if (this.i4 == 1) goto _label_6;
                    this.i4 = (this.i4 & 0xFF);
                    if (!(!(this.i4 == 0)))
                    {
                        this.i4 = li32(this.i1 + 20);
                        this.i7 = li32(this.i1 + 40);
                        if (this.i4 == this.i7) goto _label_6;
                    };
                    this.i2 = __2E_str717;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_resume_error.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = 2;
                    goto _label_14;
                    
                _label_6: 
                    this.i4 = (this.i3 & 0xFFFF);
                    if (uint(this.i4) < uint(200)) goto _label_7;
                    this.i2 = __2E_str616;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_resume_error.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = 2;
                    goto _label_14;
                    
                _label_7: 
                    this.i4 = 0;
                    this.i3 = (this.i3 + 1);
                    si16(this.i3, this.i6);
                    si16(this.i3, (this.i1 + 54));
                    this.i3 = li32(this.i1 + 8);
                    si32(this.i4, (public::mstate.ebp + -12));
                    this.i4 = li32(this.i1 + 104);
                    this.i7 = (public::mstate.ebp + -64);
                    si32(this.i4, (public::mstate.ebp + -64));
                    si32(this.i7, (this.i1 + 104));
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i4 = (this.i7 + 4);
                    si32(this.i4, public::mstate.esp);
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[__setjmp]());
                    return;
                case 7:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i8 = (this.i1 + 104);
                    this.i9 = (this.i7 + 52);
                    this.i10 = (this.i1 + 8);
                    if (!(this.i4 == 0)) goto _label_8;
                    this.i2 = (0 - this.i2);
                    this.i2 = (this.i2 * 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i3 + this.i2);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_resume.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_8: 
                    this.i2 = li32(this.i7);
                    si32(this.i2, this.i8);
                    this.i2 = li32(this.i9);
                    if (this.i2 == 0) goto _label_13;
                    si8(this.i2, this.i5);
                    this.i5 = li32(this.i10);
                    this.i3 = (this.i2 + -2);
                    if (uint(this.i3) < uint(2)) goto _label_10;
                    if (this.i2 == 5) goto _label_9;
                    if (!(this.i2 == 4)) goto _label_11;
                    this.i3 = __2E_str111;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 17;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 9:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i5);
                    this.i3 = 4;
                    si32(this.i3, (this.i5 + 8));
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i10);
                    goto _label_12;
                    
                _label_9: 
                    this.i3 = __2E_str212;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 23;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 10:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i5);
                    this.i3 = 4;
                    si32(this.i3, (this.i5 + 8));
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i10);
                    goto _label_12;
                    
                _label_10: 
                    this.f0 = lf64(this.i5 + -12);
                    sf64(this.f0, this.i5);
                    this.i3 = li32(this.i5 + -4);
                    si32(this.i3, (this.i5 + 8));
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i10);
                    goto _label_12;
                    
                _label_11: 
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i10);
                    
                _label_12: 
                    this.i3 = li32(this.i1 + 20);
                    si32(this.i5, (this.i3 + 8));
                    this.i5 = li16(this.i6);
                    this.i5 = (this.i5 + -1);
                    si16(this.i5, this.i6);
                    goto _label_14;
                    
                _label_13: 
                    this.i2 = li16(this.i6);
                    this.i3 = li8(this.i5);
                    this.i2 = (this.i2 + -1);
                    si16(this.i2, this.i6);
                    this.i2 = this.i3;
                    
                _label_14: 
                    if (uint(this.i2) > uint(1)) goto _label_18;
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    this.i2 = (this.i2 - this.i3);
                    this.i3 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = (this.i3 + 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_checkstack.start();
                    return;
                case 11:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = (this.i1 + 8);
                    if (!(this.i4 == 0)) goto _label_15;
                    this.i4 = __2E_str66355;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i1 == this.i0))
                    {
                        this.i1 = (0 - this.i3);
                        this.i4 = li32(this.i5);
                        this.i1 = (this.i1 * 12);
                        this.i1 = (this.i4 + this.i1);
                        si32(this.i1, this.i5);
                        if (!(this.i2 < 12))
                        {
                            this.i1 = 0;
                            this.i0 = (this.i0 + 8);
                            this.i2 = this.i1;
                            do 
                            {
                                this.i4 = li32(this.i0);
                                this.i6 = li32(this.i5);
                                this.i7 = (this.i4 + 12);
                                si32(this.i7, this.i0);
                                this.i6 = (this.i6 + this.i2);
                                this.f0 = lf64(this.i6);
                                sf64(this.f0, this.i4);
                                this.i6 = li32(this.i6 + 8);
                                si32(this.i6, (this.i4 + 8));
                                this.i2 = (this.i2 + 12);
                                this.i1 = (this.i1 + 1);
                                if (this.i1 == this.i3) goto _label_16;
                            } while (true);
                            
                        _label_15: 
                            if (!(this.i1 == this.i0))
                            {
                                this.i1 = (0 - this.i3);
                                this.i4 = li32(this.i5);
                                this.i1 = (this.i1 * 12);
                                this.i1 = (this.i4 + this.i1);
                                si32(this.i1, this.i5);
                                if (!(this.i2 < 12))
                                {
                                    this.i1 = 0;
                                    this.i0 = (this.i0 + 8);
                                    this.i2 = this.i1;
                                    do 
                                    {
                                        this.i4 = li32(this.i0);
                                        this.i6 = li32(this.i5);
                                        this.i7 = (this.i4 + 12);
                                        si32(this.i7, this.i0);
                                        this.i6 = (this.i6 + this.i2);
                                        this.f0 = lf64(this.i6);
                                        sf64(this.f0, this.i4);
                                        this.i6 = li32(this.i6 + 8);
                                        si32(this.i6, (this.i4 + 8));
                                        this.i2 = (this.i2 + 12);
                                        this.i1 = (this.i1 + 1);
                                    } while (!(this.i1 == this.i3));
                                };
                            };
                        };
                    };
                    
                _label_16: 
                    public::mstate.eax = this.i3;
                    
                _label_17: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_18: 
                    if (this.i1 == this.i0) goto _label_4;
                    this.i2 = 0;
                    this.i3 = li32(this.i1 + 8);
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, (this.i1 + 8));
                    this.i0 = (this.i0 + 8);
                    this.i1 = (this.i1 + 8);
                    this.i3 = this.i2;
                    do 
                    {
                        this.i4 = li32(this.i0);
                        this.i5 = li32(this.i1);
                        this.i6 = (this.i4 + 12);
                        si32(this.i6, this.i0);
                        this.i5 = (this.i5 + this.i3);
                        this.f0 = lf64(this.i5);
                        sf64(this.f0, this.i4);
                        this.i5 = li32(this.i5 + 8);
                        si32(this.i5, (this.i4 + 8));
                        this.i3 = (this.i3 + 12);
                        this.i4 = (this.i2 + 1);
                        if (this.i2 == 0) goto _label_4;
                        this.i2 = this.i4;
                    } while (true);
                default:
                    throw ("Invalid state in _auxresume");
            };
        }


    }
} cmodule.lua_wrapper

