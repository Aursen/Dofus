package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal class CRefTypemap extends CTypemap 
    {

        private var subtype:CTypemap;

        public function CRefTypemap(_arg_1:CTypemap)
        {
            this.subtype = _arg_1;
        }

        override public function fromC(_arg_1:Array):*
        {
            var _local_2:int;
            var _local_3:int;
            _local_2 = _arg_1[0];
            _local_3 = 0;
            while (_local_3 < this.subtype.ptrLevel)
            {
                mstate.ds.position = _local_2;
                _local_2 = mstate.ds.readInt();
                _local_3++;
            };
            return (this.subtype.readValue(_local_2));
        }

        override public function createC(_arg_1:*, _arg_2:int=0):Array
        {
            return (null);
        }


    }
}

