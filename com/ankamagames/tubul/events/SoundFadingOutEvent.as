package com.ankamagames.tubul.events
{
    import flash.events.Event;
    import com.ankamagames.tubul.interfaces.ISound;

    public class SoundFadingOutEvent extends Event 
    {

        public static const SOUND_FADING_OUT:String = "sound_fading_out";

        public var sound:ISound;

        public function SoundFadingOutEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function clone():Event
        {
            var sfoe:SoundFadingOutEvent = new SoundFadingOutEvent(type, bubbles, cancelable);
            sfoe.sound = this.sound;
            return (sfoe);
        }


    }
}

