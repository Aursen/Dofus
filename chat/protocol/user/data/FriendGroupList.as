package chat.protocol.user.data
{
    import chat.protocol.common.JsonifiedMessage;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class FriendGroupList extends JsonifiedMessage 
    {

        public var values:Vector.<FriendGroup>;

        public function FriendGroupList(values:Array)
        {
            this.values = Vector.<FriendGroup>(values);
        }

    }
}

