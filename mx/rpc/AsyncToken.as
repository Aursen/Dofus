package mx.rpc
{
    import flash.events.EventDispatcher;
    import mx.messaging.messages.IMessage;
    import mx.core.mx_internal;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.events.PropertyChangeEvent;

    use namespace mx_internal;

    [Event(name="propertyChange", type="mx.events.PropertyChangeEvent")]
    public dynamic class AsyncToken extends EventDispatcher 
    {

        private var _message:IMessage;
        private var _responders:Array;
        private var _result:Object;

        public function AsyncToken(message:IMessage=null)
        {
            this._message = message;
        }

        public function get message():IMessage
        {
            return (this._message);
        }

        mx_internal function setMessage(message:IMessage):void
        {
            this._message = message;
        }

        public function get responders():Array
        {
            return (this._responders);
        }

        [Bindable(event="propertyChange")]
        public function get result():Object
        {
            return (this._result);
        }

        public function addResponder(responder:IResponder):void
        {
            if (this._responders == null)
            {
                this._responders = [];
            };
            this._responders.push(responder);
        }

        public function hasResponder():Boolean
        {
            return ((!(this._responders == null)) && (this._responders.length > 0));
        }

        mx_internal function applyFault(event:FaultEvent):void
        {
            var i:uint;
            var responder:IResponder;
            if (this._responders != null)
            {
                i = 0;
                while (i < this._responders.length)
                {
                    responder = this._responders[i];
                    if (responder != null)
                    {
                        responder.fault(event);
                    };
                    i++;
                };
            };
        }

        mx_internal function applyResult(event:ResultEvent):void
        {
            var i:uint;
            var responder:IResponder;
            this.setResult(event.result);
            if (this._responders != null)
            {
                i = 0;
                while (i < this._responders.length)
                {
                    responder = this._responders[i];
                    if (responder != null)
                    {
                        responder.result(event);
                    };
                    i++;
                };
            };
        }

        mx_internal function setResult(newResult:Object):void
        {
            var event:PropertyChangeEvent;
            if (this._result !== newResult)
            {
                event = PropertyChangeEvent.createUpdateEvent(this, "result", this._result, newResult);
                this._result = newResult;
                dispatchEvent(event);
            };
        }


    }
}

