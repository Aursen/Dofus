package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal class CAS3ValTypemap extends CTypemap 
    {

        private var values:ValueTracker = new ValueTracker();


        override public function fromC(_arg_1:Array):*
        {
            return (this.values.get(_arg_1[0]));
        }

        override public function createC(_arg_1:*, _arg_2:int=0):Array
        {
            return ([this.values.acquire(_arg_1)]);
        }

        override public function destroyC(_arg_1:Array):void
        {
            this.values.release(_arg_1[0]);
        }

        public function get valueTracker():ValueTracker
        {
            return (this.values);
        }


    }
} cmodule.lua_wrapper

