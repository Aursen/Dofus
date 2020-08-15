package org.flintparticles.common.events
{
    import flash.events.Event;

    public class EmitterEvent extends Event 
    {

        public static var EMITTER_EMPTY:String = "emitterEmpty";
        public static var EMITTER_UPDATED:String = "emitterUpdated";

        public function EmitterEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

    }
}

