package mx.messaging.messages
{
    import flash.utils.IExternalizable;
    import flash.utils.IDataOutput;

    public class AsyncMessageExt extends AsyncMessage implements IExternalizable 
    {

        private var _message:AsyncMessage;

        public function AsyncMessageExt(message:AsyncMessage=null)
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
}

