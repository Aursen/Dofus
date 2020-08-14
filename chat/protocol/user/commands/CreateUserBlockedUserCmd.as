package chat.protocol.user.commands
{
    import chat.protocol.common.JsonifiedMessage;

    public class CreateUserBlockedUserCmd extends JsonifiedMessage 
    {

        public var userId:String;
        public var blockedUserId:String;

        public function CreateUserBlockedUserCmd(userId:String, blockedUserId:String)
        {
            this.userId = userId;
            this.blockedUserId = blockedUserId;
        }

    }
} chat.protocol.user.commands

