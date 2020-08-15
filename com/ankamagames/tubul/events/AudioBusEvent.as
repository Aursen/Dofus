package com.ankamagames.tubul.events
{
    import flash.events.Event;
    import com.ankamagames.tubul.interfaces.ISound;

    public class AudioBusEvent extends Event 
    {

        public static const ADD_SOUND_IN_BUS:String = "add_sound_in_bus";
        public static const REMOVE_SOUND_IN_BUS:String = "remove_sound_in_bus";

        public var sound:ISound;

        public function AudioBusEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function clone():Event
        {
            var abe:AudioBusEvent = new AudioBusEvent(type, bubbles, cancelable);
            abe.sound = this.sound;
            return (abe);
        }


    }
}

