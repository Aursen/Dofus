package luaAlchemy
{
    import cmodule.lua_wrapper.CLibInit;
    import flash.utils.ByteArray;

    public class LuaAlchemy 
    {

        public static const libInit:CLibInit = new CLibInit();
        private static const _luaAssetInit:* = LuaAssets.init(libInit);

        private var luaState:uint = 0;
        private var vfsRoot:String = "builtin://";

        public function LuaAlchemy(_arg_1:*=null, _arg_2:Boolean=true)
        {
            this.init(_arg_1, _arg_2);
        }

        public function init(_arg_1:*=null, _arg_2:Boolean=true):void
        {
            var _local_3:Array;
            if (this.luaState != 0)
            {
                this.close();
            };
            if (_arg_1)
            {
                this.vfsRoot = _arg_1;
            };
            this.luaState = lua_wrapper.luaInitializeState();
            lua_wrapper.setGlobalLuaValue(this.luaState, "_LUA_ALCHEMY_FILESYSTEM_ROOT", this.vfsRoot);
            if (_arg_2)
            {
                _local_3 = lua_wrapper.doFile(this.luaState, "builtin://lua_alchemy.lua");
                if (_local_3.shift() == false)
                {
                    this.close();
                    throw (new Error(("LuaAlchemy.init() to call 'lua_alchemy.lua' failed: " + _local_3.toString())));
                };
            };
        }

        public function close():void
        {
            if (this.luaState != 0)
            {
                lua_wrapper.luaClose(this.luaState);
                this.luaState = 0;
            };
        }

        public function doFile(_arg_1:String):Array
        {
            if (this.luaState == 0)
            {
                this.init();
            };
            return (lua_wrapper.doFile(this.luaState, _arg_1));
        }

        public function doFileAsync(_arg_1:String, _arg_2:Function):void
        {
            if (this.luaState == 0)
            {
                this.init();
            };
            lua_wrapper.doFileAsync(_arg_2, this.luaState, _arg_1);
        }

        public function doString(_arg_1:String):Array
        {
            if (this.luaState == 0)
            {
                this.init();
            };
            return (lua_wrapper.luaDoString(this.luaState, _arg_1));
        }

        public function doStringAsync(_arg_1:String, _arg_2:Function):void
        {
            if (this.luaState == 0)
            {
                this.init();
            };
            lua_wrapper.luaDoStringAsync(_arg_2, this.luaState, _arg_1);
        }

        public function setGlobal(_arg_1:String, _arg_2:*):void
        {
            if (this.luaState == 0)
            {
                this.init();
            };
            lua_wrapper.setGlobal(this.luaState, _arg_1, _arg_2);
        }

        public function setGlobalLuaValue(_arg_1:String, _arg_2:*):void
        {
            if (this.luaState == 0)
            {
                this.init();
            };
            lua_wrapper.setGlobalLuaValue(this.luaState, _arg_1, _arg_2);
        }

        public function callGlobal(_arg_1:String, ... _args):Array
        {
            if (this.luaState == 0)
            {
                this.init();
            };
            return (lua_wrapper.callGlobal(this.luaState, _arg_1, _args));
        }

        public function supplyFile(_arg_1:String, _arg_2:ByteArray):void
        {
            libInit.supplyFile(_arg_1, _arg_2);
        }


    }
}

