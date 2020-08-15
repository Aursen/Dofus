package org.flintparticles.common.events
{
    import flash.events.Event;

    public class UpdateEvent extends Event 
    {

        public static var UPDATE:String = "update";

        public var time:Number;

        public function UpdateEvent(_arg_1:String, time:Number=NaN, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
            this.time = time;
        }

    }
}

