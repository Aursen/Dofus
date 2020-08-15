package chat.protocol.channel.events
{
    import chat.protocol.common.JsonifiedMessage;
    import chat.protocol.channel.data.ChannelMessage;

    public class ChannelMessageCreatedEvt extends JsonifiedMessage 
    {

        public var message:ChannelMessage;

        public function ChannelMessageCreatedEvt(message:ChannelMessage)
        {
            this.message = message;
        }

    }
}

