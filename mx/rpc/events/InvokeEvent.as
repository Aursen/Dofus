package mx.rpc.events
{
    import mx.rpc.AsyncToken;
    import mx.messaging.messages.IMessage;
    import flash.events.Event;

    public class InvokeEvent extends AbstractEvent 
    {

        public static const INVOKE:String = "invoke";

        public function InvokeEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false, token:AsyncToken=null, message:IMessage=null)
        {
            super(_arg_1, bubbles, cancelable, token, message);
        }

        public static function createEvent(token:AsyncToken=null, message:IMessage=null):InvokeEvent
        {
            return (new InvokeEvent(InvokeEvent.INVOKE, false, false, token, message));
        }


        override public function clone():Event
        {
            return (new InvokeEvent(type, bubbles, cancelable, token, message));
        }

        override public function toString():String
        {
            return (formatToString("InvokeEvent", "messageId", "type", "bubbles", "cancelable", "eventPhase"));
        }


    }
}

