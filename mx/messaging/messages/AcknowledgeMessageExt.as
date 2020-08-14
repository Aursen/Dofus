package mx.messaging.messages
{
    import flash.utils.IExternalizable;
    import flash.utils.IDataOutput;

    public class AcknowledgeMessageExt extends AcknowledgeMessage implements IExternalizable 
    {

        private var _message:AcknowledgeMessage;

        public function AcknowledgeMessageExt(message:AcknowledgeMessage=null)
        {
            this._message = message;
        }

        override public function writeExternal(output:IDataOutput):void
        {
            if (this._message != null)
            {
                this._message.writeExternal(output);
            }
            else
            {
                super.writeExternal(output);
            };
        }

        override public function get messageId():String
        {
            if (this._message != null)
            {
                return (this._message.messageId);
            };
            return (super.messageId);
        }


    }
} mx.messaging.messages

