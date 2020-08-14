package com.ankamagames.tubul.events
{
    import flash.events.Event;
    import com.ankamagames.tubul.interfaces.ISound;

    public class PlaylistEvent extends Event 
    {

        public static const COMPLETE:String = "complete";
        public static const NEW_SOUND:String = "new_sound";
        public static const SOUND_ENDED:String = "sound_ended";

        public var newSound:ISound;

        public function PlaylistEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function clone():Event
        {
            var pe:PlaylistEvent = new PlaylistEvent(type, bubbles, cancelable);
            pe.newSound = this.newSound;
            return (pe);
        }


    }
} com.ankamagames.tubul.events

