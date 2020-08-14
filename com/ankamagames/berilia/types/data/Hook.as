package com.ankamagames.berilia.types.data
{
    import com.ankamagames.berilia.utils.errors.BeriliaError;

    public class Hook 
    {

        private static var _hookNameList:Array;

        private var _name:String;

        public function Hook(name:String)
        {
            if (!_hookNameList)
            {
                _hookNameList = new Array();
            };
            _hookNameList[name] = this;
            this._name = name;
        }

        public static function create(name:String):Hook
        {
            var h:Hook = _hookNameList[name];
            if (h)
            {
                throw (new BeriliaError((("Hook name (" + name) + ") aleardy used, please rename it.")));
            };
            return (new Hook(name));
        }

        public static function getHookByName(name:String):Hook
        {
            return (_hookNameList[name]);
        }


        public function get name():String
        {
            return (this._name);
        }


    }
} com.ankamagames.berilia.types.data

