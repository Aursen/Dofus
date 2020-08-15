package com.ankamagames.tubul.events
{
    import flash.events.Event;
    import com.ankamagames.tubul.interfaces.ISound;

    public class MP3SoundEvent extends Event 
    {

        public static const SOON_END_OF_FILE:String = "SOON_END_OF_FILE";

        public var sound:ISound;

        public function MP3SoundEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function clone():Event
        {
            var mse:MP3SoundEvent = new MP3SoundEvent(type, bubbles, cancelable);
            mse.sound = this.sound;
            return (mse);
        }


    }
}

