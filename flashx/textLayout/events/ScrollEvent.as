package flashx.textLayout.events
{
    import flash.events.Event;

    public class ScrollEvent extends TextLayoutEvent 
    {

        public var delta:Number;
        public var direction:String;

        public function ScrollEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false, direction:String=null, delta:Number=NaN)
        {
            super(_arg_1, bubbles, cancelable);
            this.direction = direction;
            this.delta = delta;
        }

        override public function clone():Event
        {
            return (new ScrollEvent(type, bubbles, cancelable, this.direction, this.delta));
        }


    }
} flashx.textLayout.events

