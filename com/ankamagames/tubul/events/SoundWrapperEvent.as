package com.ankamagames.tubul.events
{
    import flash.events.Event;

    public class SoundWrapperEvent extends Event 
    {

        public static const SOON_END_OF_FILE:String = "soon_end_of_file";

        public function SoundWrapperEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function clone():Event
        {
            var e:SoundWrapperEvent = new SoundWrapperEvent(this.type, this.bubbles, this.cancelable);
            return (e);
        }


    }
}

