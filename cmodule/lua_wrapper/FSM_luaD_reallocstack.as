package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaD_reallocstack extends Machine 
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
            var _local_1:FSM_luaD_reallocstack;
            _local_1 = new (FSM_luaD_reallocstack)();
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
                    this.i0 = li32(public::mstate.ebp + 12);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 32);
                    this.i3 = (this.i0 + 6);
                    this.i4 = (this.i1 + 32);
                    this.i5 = (this.i0 + 7);
                    if (uint(this.i5) > uint(357913941)) goto _label_2;
                    this.i5 = li32(this.i1 + 16);
                    this.i6 = li32(this.i1 + 44);
                    this.i7 = li32(this.i5 + 12);
                    this.i8 = li32(this.i5 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = (this.i6 * 12);
                    this.i9 = (this.i3 * 12);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i9, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i7]());
                    return;
                case 1:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i7 == 0)) goto _label_1;
                    if (this.i9 == 0) goto _label_1;
                    this.i8 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i8 = li32(this.i5 + 68);
                    this.i6 = (this.i9 - this.i6);
                    this.i6 = (this.i6 + this.i8);
                    si32(this.i6, (this.i5 + 68));
                    this.i5 = this.i7;
                    goto _label_3;
                    
                _label_2: 
                    this.i5 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = 0;
                    
                _label_3: 
                    this.i0 = (this.i0 * 12);
                    si32(this.i5, this.i4);
                    si32(this.i3, (this.i1 + 44));
                    this.i0 = (this.i5 + this.i0);
                    si32(this.i0, (this.i1 + 28));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 - this.i2);
                    this.i0 = (this.i0 / 12);
                    this.i0 = (this.i0 * 12);
                    this.i0 = (this.i5 + this.i0);
                    si32(this.i0, (this.i1 + 8));
                    this.i0 = li32(this.i1 + 96);
                    if (!(this.i0 == 0))
                    {
                        do 
                        {
                            this.i3 = li32(this.i0 + 8);
                            this.i3 = (this.i3 - this.i2);
                            this.i3 = (this.i3 / 12);
                            this.i5 = li32(this.i4);
                            this.i3 = (this.i3 * 12);
                            this.i3 = (this.i5 + this.i3);
                            si32(this.i3, (this.i0 + 8));
                            this.i0 = li32(this.i0);
                        } while (!(this.i0 == 0));
                    };
                    this.i0 = li32(this.i1 + 40);
                    this.i3 = li32(this.i1 + 20);
                    this.i5 = li32(this.i4);
                    this.i6 = (this.i1 + 20);
                    if (!(uint(this.i3) < uint(this.i0)))
                    {
                        do 
                        {
                            this.i3 = li32(this.i0 + 8);
                            this.i3 = (this.i3 - this.i2);
                            this.i3 = (this.i3 / 12);
                            this.i3 = (this.i3 * 12);
                            this.i5 = (this.i5 + this.i3);
                            si32(this.i5, (this.i0 + 8));
                            this.i5 = li32(this.i0);
                            this.i5 = (this.i5 - this.i2);
                            this.i5 = (this.i5 / 12);
                            this.i3 = li32(this.i4);
                            this.i5 = (this.i5 * 12);
                            this.i5 = (this.i3 + this.i5);
                            si32(this.i5, this.i0);
                            this.i5 = li32(this.i0 + 4);
                            this.i5 = (this.i5 - this.i2);
                            this.i5 = (this.i5 / 12);
                            this.i3 = li32(this.i4);
                            this.i5 = (this.i5 * 12);
                            this.i5 = (this.i3 + this.i5);
                            si32(this.i5, (this.i0 + 4));
                            this.i5 = li32(this.i6);
                            this.i3 = li32(this.i4);
                            this.i0 = (this.i0 + 24);
                            if ((uint(this.i5) < uint(this.i0))) break;
                            this.i5 = this.i3;
                        } while (true);
                        this.i0 = this.i3;
                        
                    _label_4: 
                        this.i3 = li32(this.i1 + 12);
                        this.i2 = (this.i3 - this.i2);
                        this.i2 = (this.i2 / 12);
                        this.i2 = (this.i2 * 12);
                        this.i0 = (this.i0 + this.i2);
                        si32(this.i0, (this.i1 + 12));
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i0 = this.i5;
                    goto _label_4;
                default:
                    throw ("Invalid state in _luaD_reallocstack");
            };
        }


    }
} cmodule.lua_wrapper

