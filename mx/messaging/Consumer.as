package mx.messaging
{
    import mx.events.PropertyChangeEvent;
    import mx.messaging.messages.AsyncMessage;
    import mx.messaging.messages.CommandMessage;
    import mx.messaging.messages.IMessage;
    import mx.core.mx_internal;

    use namespace mx_internal;

    [Event(name="message", type="mx.messaging.events.MessageEvent")]
    public class Consumer extends AbstractConsumer 
    {

        private var _selector:String = "";
        private var _subtopic:String = "";

        public function Consumer(messageType:String="flex.messaging.messages.AsyncMessage")
        {
        }

        [Bindable(event="propertyChange")]
        [Inspectable(category="General", verbose="1")]
        public function get selector():String
        {
            return (this._selector);
        }

        public function set selector(value:String):void
        {
            var event:PropertyChangeEvent;
            var resetSubscription:Boolean;
            if (this._selector !== value)
            {
                event = PropertyChangeEvent.createUpdateEvent(this, "selector", this._selector, value);
                resetSubscription = false;
                if (subscribed)
                {
                    unsubscribe();
                    resetSubscription = true;
                };
                this._selector = value;
                if (resetSubscription)
                {
                    subscribe(clientId);
                };
                dispatchEvent(event);
            };
        }

        [Bindable(event="propertyChange")]
        public function get subtopic():String
        {
            return (this._subtopic);
        }

        public function set subtopic(value:String):void
        {
            var resetSubscription:Boolean;
            if (this.subtopic != value)
            {
                resetSubscription = false;
                if (subscribed)
                {
                    unsubscribe();
                    resetSubscription = true;
                };
                this._subtopic = value;
                if (resetSubscription)
                {
                    subscribe();
                };
            };
        }

        override protected function internalSend(message:IMessage, waitForClientId:Boolean=true):void
        {
            if (this.subtopic.length > 0)
            {
                message.headers[AsyncMessage.SUBTOPIC_HEADER] = this.subtopic;
            };
            if (this._selector.length > 0)
            {
                message.headers[CommandMessage.SELECTOR_HEADER] = this._selector;
            };
            super.internalSend(message, waitForClientId);
        }


    }
} mx.messaging

