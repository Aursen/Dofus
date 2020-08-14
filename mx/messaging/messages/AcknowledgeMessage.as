package mx.messaging.messages
{
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;

    public class AcknowledgeMessage extends AsyncMessage implements ISmallMessage 
    {

        public static const ERROR_HINT_HEADER:String = "DSErrorHint";


        override public function getSmallMessage():IMessage
        {
            var o:Object = this;
            if (o.constructor == AcknowledgeMessage)
            {
                return (new AcknowledgeMessageExt(this));
            };
            return (null);
        }

        override public function readExternal(input:IDataInput):void
        {
            var flags:uint;
            var reservedPosition:uint;
            var j:uint;
            super.readExternal(input);
            var flagsArray:Array = readFlags(input);
            var i:uint;
            while (i < flagsArray.length)
            {
                flags = (flagsArray[i] as uint);
                reservedPosition = 0;
                if ((flags >> reservedPosition) != 0)
                {
                    j = reservedPosition;
                    while (j < 6)
                    {
                        if (((flags >> j) & 0x01) != 0)
                        {
                            input.readObject();
                        };
                        j++;
                    };
                };
                i++;
            };
        }

        override public function writeExternal(output:IDataOutput):void
        {
            super.writeExternal(output);
            var flags:uint;
            output.writeByte(flags);
        }


    }
} mx.messaging.messages

