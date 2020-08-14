package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_cocreate extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_luaB_cocreate;
            _local_1 = new (FSM_luaB_cocreate)();
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
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    this.i3 = (this.i0 + 16);
                    if (uint(this.i2) < uint(this.i1)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i1 = 112;
                    this.i2 = li32(this.i3);
                    this.i4 = li32(this.i2 + 12);
                    this.i5 = li32(this.i2 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = 0;
                    si32(this.i5, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i4]());
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i1 == 0)) goto _label_2;
                    this.i4 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i4 = 8;
                    this.i5 = li32(this.i2 + 68);
                    this.i5 = (this.i5 + 112);
                    si32(this.i5, (this.i2 + 68));
                    this.i2 = li32(this.i3);
                    this.i5 = li32(this.i2 + 28);
                    si32(this.i5, this.i1);
                    si32(this.i1, (this.i2 + 28));
                    this.i2 = li8(this.i2 + 20);
                    this.i2 = (this.i2 & 0x03);
                    si8(this.i2, (this.i1 + 5));
                    si8(this.i4, (this.i1 + 4));
                    this.i2 = li32(this.i3);
                    si32(this.i2, (this.i1 + 16));
                    this.i2 = 0;
                    si32(this.i2, (this.i1 + 32));
                    si32(this.i2, (this.i1 + 44));
                    si32(this.i2, (this.i1 + 104));
                    si32(this.i2, (this.i1 + 68));
                    si8(this.i2, (this.i1 + 56));
                    si32(this.i2, (this.i1 + 60));
                    this.i3 = 1;
                    si8(this.i3, (this.i1 + 57));
                    this.i5 = li32(this.i1 + 60);
                    si32(this.i5, (this.i1 + 64));
                    si32(this.i2, (this.i1 + 96));
                    si32(this.i2, (this.i1 + 48));
                    si16(this.i2, (this.i1 + 54));
                    si16(this.i2, (this.i1 + 52));
                    si8(this.i2, (this.i1 + 6));
                    si32(this.i2, (this.i1 + 20));
                    si32(this.i2, (this.i1 + 40));
                    si32(this.i2, (this.i1 + 24));
                    si32(this.i2, (this.i1 + 108));
                    si32(this.i2, (this.i1 + 80));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_stack_init.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.f0 = lf64(this.i0 + 72);
                    sf64(this.f0, (this.i1 + 72));
                    this.i2 = li32(this.i0 + 80);
                    si32(this.i2, (this.i1 + 80));
                    this.i2 = li8(this.i0 + 56);
                    si8(this.i2, (this.i1 + 56));
                    this.i2 = li32(this.i0 + 60);
                    si32(this.i2, (this.i1 + 60));
                    this.i5 = li32(this.i0 + 68);
                    si32(this.i5, (this.i1 + 68));
                    si32(this.i2, (this.i1 + 64));
                    this.i2 = li32(this.i0 + 8);
                    si32(this.i1, this.i2);
                    si32(this.i4, (this.i2 + 8));
                    this.i2 = li32(this.i0 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i0 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = (this.i0 + 8);
                    this.i4 = _luaO_nilobject_;
                    if (this.i2 == this.i4) goto _label_3;
                    this.i2 = li32(this.i2 + 8);
                    if (!(this.i2 == 6)) goto _label_3;
                    this.i2 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 6:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i2 + 8);
                    if (!(this.i4 == 6)) goto _label_4;
                    this.i2 = li32(this.i2);
                    this.i2 = li8(this.i2 + 6);
                    if (this.i2 == 0) goto _label_4;
                    
                _label_3: 
                    this.i2 = __2E_str67356;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 8:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i3);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i4);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i4 + 8));
                    this.i2 = li32(this.i3);
                    this.i4 = (this.i2 + 12);
                    si32(this.i4, this.i3);
                    if (this.i1 == this.i0) goto _label_5;
                    this.i0 = 0;
                    si32(this.i2, this.i3);
                    this.i1 = (this.i1 + 8);
                    this.i2 = this.i0;
                    do 
                    {
                        this.i4 = li32(this.i1);
                        this.i5 = li32(this.i3);
                        this.i6 = (this.i4 + 12);
                        si32(this.i6, this.i1);
                        this.i5 = (this.i5 + this.i2);
                        this.f0 = lf64(this.i5);
                        sf64(this.f0, this.i4);
                        this.i5 = li32(this.i5 + 8);
                        si32(this.i5, (this.i4 + 8));
                        this.i2 = (this.i2 + 12);
                        this.i4 = (this.i0 + 1);
                        if (this.i0 == 0) goto _label_5;
                        this.i0 = this.i4;
                    } while (true);
                    
                _label_4: 
                    this.i2 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 9:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i3);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i4);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i4 + 8));
                    this.i2 = li32(this.i3);
                    this.i4 = (this.i2 + 12);
                    si32(this.i4, this.i3);
                    if (!(this.i1 == this.i0))
                    {
                        this.i0 = 0;
                        si32(this.i2, this.i3);
                        this.i1 = (this.i1 + 8);
                        this.i2 = this.i0;
                        do 
                        {
                            this.i4 = li32(this.i1);
                            this.i5 = li32(this.i3);
                            this.i6 = (this.i4 + 12);
                            si32(this.i6, this.i1);
                            this.i5 = (this.i5 + this.i2);
                            this.f0 = lf64(this.i5);
                            sf64(this.f0, this.i4);
                            this.i5 = li32(this.i5 + 8);
                            si32(this.i5, (this.i4 + 8));
                            this.i2 = (this.i2 + 12);
                            this.i4 = (this.i0 + 1);
                            if ((this.i0 == 0)) break;
                            this.i0 = this.i4;
                        } while (true);
                    };
                    
                _label_5: 
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaB_cocreate");
            };
        }


    }
} cmodule.lua_wrapper

