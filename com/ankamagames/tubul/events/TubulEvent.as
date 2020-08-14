package com.ankamagames.tubul.events
{
    import flash.events.Event;

    public class TubulEvent extends Event 
    {

        public static const ACTIVATION:String = "activation";

        public var activated:Boolean;

        public function TubulEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function clone():Event
        {
            var e:TubulEvent = new TubulEvent(this.type, this.bubbles, this.cancelable);
            e.activated = this.activated;
            return (e);
        }


    }
} com.ankamagames.tubul.events

