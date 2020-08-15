package mx.rpc.events
{
    import mx.messaging.events.MessageEvent;
    import mx.rpc.AsyncToken;
    import mx.messaging.messages.IMessage;
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class AbstractEvent extends MessageEvent 
    {

        private var _token:AsyncToken;

        public function AbstractEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=true, token:AsyncToken=null, message:IMessage=null)
        {
            super(_arg_1, bubbles, cancelable, message);
            this._token = token;
        }

        public function get token():AsyncToken
        {
            return (this._token);
        }

        mx_internal function setToken(t:AsyncToken):void
        {
            this._token = t;
        }

        mx_internal function callTokenResponders():void
        {
        }


    }
}

