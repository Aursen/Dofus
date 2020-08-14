package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaX_token2str extends Machine 
    {

        public static const intRegCount:int = 4;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_luaX_token2str;
            _local_1 = new (FSM_luaX_token2str)();
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
                    if (this.i1 > 0x0100) goto _label_4;
                    this.i0 = (this.i0 + 40);
                    if (uint(this.i1) < uint(0x0100)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM____runetype.start();
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i0);
                    this.i2 = (this.i2 & 0x0200);
                    if (this.i2 == 0) goto _label_3;
                    goto _label_2;
                    
                _label_1: 
                    this.i2 = li32(__CurrentRuneLocale);
                    this.i3 = (this.i1 << 2);
                    this.i2 = (this.i2 + this.i3);
                    this.i2 = li32(this.i2 + 52);
                    this.i0 = li32(this.i0);
                    this.i2 = (this.i2 & 0x0200);
                    if (this.i2 == 0) goto _label_7;
                    
                _label_2: 
                    this.i2 = __2E_str3246;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_5;
                    
                _label_3: 
                    this.i2 = __2E_str19367;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.eax = this.i1;
                    goto _label_6;
                    
                _label_4: 
                    this.i0 = _luaX_tokens;
                    this.i1 = (this.i1 << 2);
                    this.i0 = (this.i1 + this.i0);
                    this.i0 = li32(this.i0 + -1028);
                    
                _label_5: 
                    public::mstate.eax = this.i0;
                    
                _label_6: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_7: 
                    goto _label_3;
                default:
                    throw ("Invalid state in _luaX_token2str");
            };
        }


    }
} cmodule.lua_wrapper

