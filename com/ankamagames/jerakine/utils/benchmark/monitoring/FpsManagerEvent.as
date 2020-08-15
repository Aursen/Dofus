package com.ankamagames.jerakine.utils.benchmark.monitoring
{
    import flash.events.Event;

    public class FpsManagerEvent extends Event 
    {

        public var data:Object;

        public function FpsManagerEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

    }
}

