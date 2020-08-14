package cmodule.lua_wrapper
{
    import flash.utils.Dictionary;
    import cmodule.lua_wrapper.log;
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal class ValueTracker 
    {

        private var snum:int = 1;
        private var val2rcv:Dictionary = new Dictionary();
        private var id2key:Object = {};


        public function acquireId(_arg_1:int):int
        {
            var _local_2:Object;
            if (_arg_1)
            {
                _local_2 = this.id2key[_arg_1];
                this.val2rcv[_local_2].rc++;
            };
            return (_arg_1);
        }

        public function get(_arg_1:int):*
        {
            var _local_2:Object;
            var _local_3:RCValue;
            if (_arg_1)
            {
                _local_2 = this.id2key[_arg_1];
                _local_3 = this.val2rcv[_local_2];
                return (_local_3.value);
            };
            return (undefined);
        }

        public function release(_arg_1:int):*
        {
            var _local_2:Object;
            var _local_3:RCValue;
            if (_arg_1)
            {
                _local_2 = this.id2key[_arg_1];
                _local_3 = this.val2rcv[_local_2];
                if (_local_3)
                {
                    if (!--_local_3.rc)
                    {
                        delete this.id2key[_arg_1];
                        delete this.val2rcv[_local_2];
                    };
                    return (_local_3.value);
                };
                log(1, ("ValueTracker extra release!: " + _arg_1));
            };
            return (undefined);
        }

        public function acquire(_arg_1:*):int
        {
            var _local_2:Object;
            var _local_3:*;
            var _local_4:int;
            if (typeof(_arg_1) == "undefined")
            {
                return (0);
            };
            _local_2 = Object(_arg_1);
            if ((_local_2 instanceof QName))
            {
                _local_2 = ("*VT*QName*/" + _local_2.toString());
            };
            _local_3 = this.val2rcv[_local_2];
            if (typeof(_local_3) == "undefined")
            {
                while (((!(this.snum)) || (!(typeof(this.id2key[this.snum]) == "undefined"))))
                {
                    this.snum++;
                };
                _local_4 = this.snum;
                this.val2rcv[_local_2] = new RCValue(_arg_1, _local_4);
                this.id2key[_local_4] = _local_2;
            }
            else
            {
                _local_4 = _local_3.id;
                this.val2rcv[_local_2].rc++;
            };
            return (_local_4);
        }


    }
} cmodule.lua_wrapper

