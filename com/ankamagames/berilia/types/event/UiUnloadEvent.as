package com.ankamagames.berilia.types.event
{
    import flash.events.Event;

    public class UiUnloadEvent extends Event 
    {

        public static const UNLOAD_UI_STARTED:String = "unloadUiStarted";
        public static const UNLOAD_UI_COMPLETE:String = "unloadUiComplete";

        private var _name:String;

        public function UiUnloadEvent(_arg_1:String, name:String)
        {
            super(_arg_1, false, false);
            this._name = name;
        }

        public function get name():String
        {
            return (this._name);
        }


    }
}

