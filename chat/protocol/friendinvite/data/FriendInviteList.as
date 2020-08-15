package chat.protocol.friendinvite.data
{
    import chat.protocol.common.JsonifiedMessage;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class FriendInviteList extends JsonifiedMessage 
    {

        public var values:Vector.<FriendInvite>;

        public function FriendInviteList(values:Array)
        {
            this.values = Vector.<FriendInvite>(values);
        }

    }
}

