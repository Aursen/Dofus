package com.ankamagames.jerakine.resources.events
{
    import flash.events.Event;

    public class ResourceEvent extends Event 
    {

        public function ResourceEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function clone():Event
        {
            return (new ResourceEvent(type, bubbles, cancelable));
        }


    }
}

