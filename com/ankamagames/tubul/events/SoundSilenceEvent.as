package com.ankamagames.tubul.events
{
    import flash.events.Event;

    public class SoundSilenceEvent extends Event 
    {

        public static const START:String = "start";
        public static const COMPLETE:String = "complete";

        public function SoundSilenceEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function clone():Event
        {
            var e:SoundSilenceEvent = new SoundSilenceEvent(this.type, this.bubbles, this.cancelable);
            return (e);
        }


    }
} com.ankamagames.tubul.events

