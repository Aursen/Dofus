package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM__sseek extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM__sseek;
            _local_1 = new (FSM__sseek)();
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
                    this.i0 = 0;
                    this.i1 = li32(_val_2E_1440);
                    this.i2 = li32(public::mstate.ebp + 8);
                    si32(this.i0, _val_2E_1440);
                    this.i0 = li32(this.i2 + 40);
                    this.i3 = li32(this.i2 + 28);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = li32(public::mstate.ebp + 20);
                    this.i5 = li32(public::mstate.ebp + 12);
                    this.i6 = li32(public::mstate.ebp + 16);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i0]());
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    this.i3 = public::mstate.edx;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i7 = li32(_val_2E_1440);
                    if (!(!(this.i7 == 0)))
                    {
                        si32(this.i1, _val_2E_1440);
                    };
                    this.i1 = (this.i2 + 12);
                    if (this.i3 > -1) goto _label_8;
                    if (this.i7 == 29) goto _label_4;
                    if (!(this.i7 == 0)) goto _label_7;
                    if (!(!(this.i4 == 1)))
                    {
                        this.i0 = (this.i5 | this.i6);
                        if (this.i0 == 0) goto _label_3;
                    };
                    this.i0 = li32(this.i2 + 48);
                    this.i3 = (this.i2 + 48);
                    if (this.i0 == 0) goto _label_2;
                    this.i4 = (this.i2 + 64);
                    if (this.i0 == this.i4) goto _label_1;
                    this.i4 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i0 = 0;
                    si32(this.i0, this.i3);
                    
                _label_2: 
                    this.i0 = 0;
                    this.i3 = li32(this.i2 + 16);
                    si32(this.i3, this.i2);
                    si32(this.i0, (this.i2 + 4));
                    this.i0 = li16(this.i1);
                    this.i0 = (this.i0 & 0xFFFFFFDF);
                    si16(this.i0, this.i1);
                    
                _label_3: 
                    this.i0 = 22;
                    this.i2 = li16(this.i1);
                    this.i2 = (this.i2 | 0x40);
                    si16(this.i2, this.i1);
                    si32(this.i0, _val_2E_1440);
                    this.i0 = li16(this.i1);
                    this.i0 = (this.i0 & 0xFFFFEFFF);
                    si16(this.i0, this.i1);
                    this.i0 = -1;
                    goto _label_5;
                    
                _label_4: 
                    this.i0 = -1;
                    this.i2 = li16(this.i1);
                    this.i2 = (this.i2 & 0xFFFFEEFF);
                    do 
                    {
                        si16(this.i2, this.i1);
                        
                    _label_5: 
                        public::mstate.edx = this.i0;
                        
                    _label_6: 
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_7: 
                        this.i0 = -1;
                        this.i2 = li16(this.i1);
                        this.i2 = (this.i2 & 0xFFFFEFFF);
                    } while (true);
                    
                _label_8: 
                    this.i4 = li16(this.i1);
                    this.i5 = (this.i4 & 0x0400);
                    if (!(this.i5 == 0))
                    {
                        this.i4 = (this.i4 | 0x1000);
                        si16(this.i4, this.i1);
                        si32(this.i0, (this.i2 + 80));
                        si32(this.i3, (this.i2 + 84));
                    };
                    public::mstate.edx = this.i3;
                    goto _label_6;
                default:
                    throw ("Invalid state in __sseek");
            };
        }


    }
}

