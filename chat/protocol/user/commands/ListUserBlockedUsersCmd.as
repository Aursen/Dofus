package chat.protocol.user.commands
{
    import chat.protocol.common.JsonifiedMessage;

    public class ListUserBlockedUsersCmd extends JsonifiedMessage 
    {

        public var userId:String;

        public function ListUserBlockedUsersCmd(userId:String)
        {
            this.userId = userId;
        }

    }
} chat.protocol.user.commands

