package mx.messaging
{
    import flash.net.Responder;
    import flash.utils.Timer;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.messaging.messages.IMessage;
    import flash.events.TimerEvent;
    import mx.messaging.messages.ErrorMessage;

    public class MessageResponder extends Responder 
    {

        private var _requestTimedOut:Boolean;
        private var _requestTimer:Timer;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();
        private var _agent:MessageAgent;
        private var _channel:Channel;
        private var _message:IMessage;

        public function MessageResponder(agent:MessageAgent, message:IMessage, channel:Channel=null)
        {
            super(this.result, this.status);
            this._agent = agent;
            this._channel = channel;
            this._message = message;
            this._requestTimedOut = false;
        }

        public function get agent():MessageAgent
        {
            return (this._agent);
        }

        public function get channel():Channel
        {
            return (this._channel);
        }

        public function get message():IMessage
        {
            return (this._message);
        }

        public function set message(value:IMessage):void
        {
            this._message = value;
        }

        final public function startRequestTimeout(requestTimeout:int):void
        {
            this._requestTimer = new Timer((requestTimeout * 1000), 1);
            this._requestTimer.addEventListener(TimerEvent.TIMER, this.timeoutRequest);
            this._requestTimer.start();
        }

        final public function result(message:IMessage):void
        {
            if (!this._requestTimedOut)
            {
                if (this._requestTimer != null)
                {
                    this.releaseTimer();
                };
                this.resultHandler(message);
            };
        }

        final public function status(message:IMessage):void
        {
            if (!this._requestTimedOut)
            {
                if (this._requestTimer != null)
                {
                    this.releaseTimer();
                };
                this.statusHandler(message);
            };
        }

        protected function createRequestTimeoutErrorMessage():ErrorMessage
        {
            var errorMsg:ErrorMessage = new ErrorMessage();
            errorMsg.correlationId = this.message.messageId;
            errorMsg.faultCode = "Client.Error.RequestTimeout";
            errorMsg.faultString = this.resourceManager.getString("messaging", "requestTimedOut");
            errorMsg.faultDetail = this.resourceManager.getString("messaging", "requestTimedOut.details");
            return (errorMsg);
        }

        protected function resultHandler(message:IMessage):void
        {
        }

        protected function requestTimedOut():void
        {
        }

        protected function statusHandler(message:IMessage):void
        {
        }

        private function timeoutRequest(event:TimerEvent):void
        {
            this._requestTimedOut = true;
            this.releaseTimer();
            this.requestTimedOut();
        }

        private function releaseTimer():void
        {
            this._requestTimer.stop();
            this._requestTimer.removeEventListener(TimerEvent.TIMER, this.timeoutRequest);
            this._requestTimer = null;
        }


    }
}

