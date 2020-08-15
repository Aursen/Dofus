package org.audiofx.mp3
{
    import flash.events.Event;
    import flash.media.Sound;

    public class MP3SoundEvent extends Event 
    {

        public static const COMPLETE:String = "complete";

        public var sound:Sound;
        public var channels:uint;

        public function MP3SoundEvent(_arg_1:String, sound:Sound, channels:uint, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
            this.sound = sound;
            this.channels = channels;
        }

    }
}

