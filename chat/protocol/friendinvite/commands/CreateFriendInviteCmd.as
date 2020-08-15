package chat.protocol.friendinvite.commands
{
    import chat.protocol.common.JsonifiedMessage;

    public class CreateFriendInviteCmd extends JsonifiedMessage 
    {

        public var inviterUserId:String;
        public var recipientUserId:String;
        public var recipientUserName:String;

        public function CreateFriendInviteCmd(inviterUserId:String, recipientUserId:String, recipientUserName:String)
        {
            this.inviterUserId = inviterUserId;
            this.recipientUserId = recipientUserId;
            this.recipientUserName = recipientUserName;
        }

    }
}

