package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_main385 extends Machine 
    {

        public static const intRegCount:int = 4;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_main385;
            _local_1 = new (FSM_main385)();
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
                    this.i0 = __2E_str4134;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_NSGetS]());
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i0, _Number_class);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = __2E_str5135;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_NSGetS]());
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i0, _int_class);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = __2E_str6136;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_NSGetS]());
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i0, _String_class);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = __2E_str7137;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_NSGetS]());
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i0, _Boolean_class);
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = __2E_str8138;
                    si32(this.i0, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_String]());
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = __2E_str9139;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_NSGetS]());
                    return;
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i0, _getQualifiedClassName_method);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = __2E_str10140;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_NSGetS]());
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i0, _Array_class);
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = __2E_str45;
                    si32(this.i0, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Object]());
                    return;
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i0, _gg_lib);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = _thunk_luaInitializeState;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Function]());
                    return;
                case 9:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = __2E_str19118;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_SetS]());
                    return;
                case 10:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(_gg_lib);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = _thunk_luaClose;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Function]());
                    return;
                case 12:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = __2E_str20119;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_SetS]());
                    return;
                case 13:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(_gg_lib);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = _thunk_doFile;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Function]());
                    return;
                case 15:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = __2E_str21120;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_SetS]());
                    return;
                case 16:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(_gg_lib);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = _thunk_doFileAsync;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_FunctionAsync]());
                    return;
                case 18:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = __2E_str22121;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_SetS]());
                    return;
                case 19:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(_gg_lib);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = _thunk_luaDoString;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Function]());
                    return;
                case 21:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = __2E_str23122;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_SetS]());
                    return;
                case 22:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(_gg_lib);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = _thunk_luaDoStringAsync;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_FunctionAsync]());
                    return;
                case 24:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = __2E_str24123;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_SetS]());
                    return;
                case 25:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(_gg_lib);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = _thunk_setGlobal;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Function]());
                    return;
                case 27:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = __2E_str25124;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_SetS]());
                    return;
                case 28:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 29:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(_gg_lib);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = _thunk_setGlobalLuaValue;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Function]());
                    return;
                case 30:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = __2E_str26125;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_SetS]());
                    return;
                case 31:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(_gg_lib);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = _thunk_callGlobal;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Function]());
                    return;
                case 33:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = __2E_str27126;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_SetS]());
                    return;
                case 34:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 35:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = li32(_gg_lib);
                    this.i2 = 1;
                    this.i0 = this.i2;
                    state = 36;
                case 36:
                    if (this.i0)
                    {
                        this.i0 = 0;
                        throw (new AlchemyLibInit(this.i1));
                    };
                    public::mstate.eax = this.i2;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _main385");
            };
        }


    }
}

