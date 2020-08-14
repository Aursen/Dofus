package com.ankamagames.tiphon.events
{
    import flash.events.Event;

    public class SwlEvent extends Event 
    {

        public static const SWL_LOADED:String = "onSwfLoaded";

        private var _url:String;

        public function SwlEvent(_arg_1:String, pUrl:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
            this._url = pUrl;
        }

        override public function clone():Event
        {
            return (new SwlEvent(type, this.url, bubbles, cancelable));
        }

        public function get url():String
        {
            return (this._url);
        }


    }
} com.ankamagames.tiphon.events

