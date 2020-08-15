package com.ankamagames.berilia.types.event
{
    import flash.events.Event;

    public class BeriliaEvent extends Event 
    {

        public static const REMOVE_COMPONENT:String = "Berilia_remove_component";

        public function BeriliaEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

    }
}

