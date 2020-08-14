package 
{
    import flash.utils.getQualifiedClassName;
    import flash.utils.getDefinitionByName;
    import flash.utils.describeType;

    public class Type 
    {

        public function Type():void
        {
        }

        public static function getClass(_arg_1:Object):Class
        {
            var _local_2:String = getQualifiedClassName(_arg_1);
            if ((((((_local_2 == ("null")) || (_local_2 == "Object")) || (_local_2 == "int")) || (_local_2 == "Number")) || (_local_2 == "Boolean")))
            {
                return (null);
            };
            if (_arg_1.hasOwnProperty("prototype"))
            {
                return (null);
            };
            var _local_3:* = (getDefinitionByName(_local_2) as Class);
            if (_local_3.__isenum)
            {
                return (null);
            };
            return (_local_3);
        }

        public static function describe(_arg_1:*, _arg_2:Boolean):Array
        {
            var _local_8:int;
            var _local_3:Array = [];
            var _local_4:XML = describeType(_arg_1);
            if (_arg_2)
            {
                _local_4 = _local_4.factory[0];
            };
            var _local_5:XMLList = _local_4.child("method");
            var _local_6:int;
            var _local_7:int = _local_5.length();
            while (_local_6 < _local_7)
            {
                _local_8 = _local_6++;
                _local_3.push(Std.string(_local_5[_local_8].attribute("name")));
            };
            var _local_9:XMLList = _local_4.child("variable");
            _local_6 = 0;
            _local_7 = _local_9.length();
            while (_local_6 < _local_7)
            {
                _local_8 = _local_6++;
                _local_3.push(Std.string(_local_9[_local_8].attribute("name")));
            };
            var _local_10:XMLList = _local_4.child("accessor");
            _local_6 = 0;
            _local_7 = _local_10.length();
            while (_local_6 < _local_7)
            {
                _local_8 = _local_6++;
                _local_3.push(Std.string(_local_10[_local_8].attribute("name")));
            };
            return (_local_3);
        }

        public static function getInstanceFields(_arg_1:Class):Array
        {
            return (Type.describe(_arg_1, true));
        }


    }
} 

