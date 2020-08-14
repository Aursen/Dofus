package chat.protocol.common
{
    public final class MessageType 
    {

        public static const APPLICATION_MESSAGE:int = 0;
        public static const PING:int = 1;
        public static const PONG:int = 2;
        public static const HEART_BEAT:int = 3;


        public static function getMessageType(_arg_1:int):String
        {
            var toReturn:String;
            switch (_arg_1)
            {
                case APPLICATION_MESSAGE:
                    toReturn = "APPLICATION_MESSAGE";
                    break;
                case PING:
                    toReturn = "PING";
                    break;
                case PONG:
                    toReturn = "PONG";
                    break;
                case HEART_BEAT:
                    toReturn = "HEART_BEAT";
                    break;
            };
            return (toReturn);
        }


    }
} chat.protocol.common

