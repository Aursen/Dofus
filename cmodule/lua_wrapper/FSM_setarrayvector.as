package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_setarrayvector extends Machine 
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
            var _local_1:FSM_setarrayvector;
            _local_1 = new (FSM_setarrayvector)();
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
                    this.i1 = li32(public::mstate.ebp + 16);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = (this.i0 + 28);
                    this.i0 = (this.i0 + 12);
                    this.i4 = (this.i1 + 1);
                    if (uint(this.i4) > uint(357913941)) goto _label_2;
                    this.i4 = li32(this.i2 + 16);
                    this.i5 = li32(this.i3);
                    this.i6 = li32(this.i0);
                    this.i7 = li32(this.i4 + 12);
                    this.i8 = li32(this.i4 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (this.i5 * 12);
                    this.i9 = (this.i1 * 12);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i9, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i7]());
                    return;
                case 1:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i6 == 0)) goto _label_1;
                    if (this.i9 == 0) goto _label_1;
                    this.i7 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i2 = li32(this.i4 + 68);
                    this.i5 = (this.i9 - this.i5);
                    this.i2 = (this.i5 + this.i2);
                    si32(this.i2, (this.i4 + 68));
                    si32(this.i6, this.i0);
                    this.i2 = li32(this.i3);
                    if (this.i2 >= this.i1) goto _label_4;
                    goto _label_3;
                    
                _label_2: 
                    this.i4 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = 0;
                    si32(this.i2, this.i0);
                    this.i2 = li32(this.i3);
                    if (!(this.i2 >= this.i1))
                    {
                        
                    _label_3: 
                        this.i4 = (this.i2 * 12);
                        this.i4 = (this.i4 + 8);
                        do 
                        {
                            this.i5 = 0;
                            this.i6 = li32(this.i0);
                            this.i6 = (this.i6 + this.i4);
                            si32(this.i5, this.i6);
                            this.i4 = (this.i4 + 12);
                            this.i2 = (this.i2 + 1);
                        } while (!(this.i2 >= this.i1));
                    };
                    
                _label_4: 
                    si32(this.i1, this.i3);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _setarrayvector");
            };
        }


    }
} cmodule.lua_wrapper

