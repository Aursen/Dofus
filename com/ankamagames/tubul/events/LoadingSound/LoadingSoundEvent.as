package com.ankamagames.tubul.events.LoadingSound
{
    import flash.events.Event;

    public class LoadingSoundEvent extends Event 
    {

        public static const LOADED:String = "loaded";
        public static const LOADING_FAILED:String = "loading_failed";
        public static const ON_PROGRESS:String = "on_progress";

        public var data:*;

        public function LoadingSoundEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function clone():Event
        {
            var lse:LoadingSoundEvent = new LoadingSoundEvent(type, bubbles, cancelable);
            lse.data = this.data;
            return (lse);
        }


    }
} com.ankamagames.tubul.events.LoadingSound

