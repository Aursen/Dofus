package chat.protocol.channel.data
{
    import chat.protocol.common.JsonifiedMessage;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class ChannelMessageList extends JsonifiedMessage 
    {

        public var values:Vector.<ChannelMessage>;

        public function ChannelMessageList(values:Array)
        {
            this.values = Vector.<ChannelMessage>(values);
        }

    }
}

