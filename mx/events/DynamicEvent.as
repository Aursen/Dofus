package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal;

    use namespace mx_internal;

    public dynamic class DynamicEvent extends Event 
    {

        mx_internal static const VERSION:String = "4.16.1.0";

        public function DynamicEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function clone():Event
        {
            var p:String;
            var event:DynamicEvent = new DynamicEvent(type, bubbles, cancelable);
            for (p in this)
            {
                event[p] = this[p];
            };
            return (event);
        }


    }
}

