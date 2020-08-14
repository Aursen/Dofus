package chat.protocol.user.commands
{
    import chat.protocol.common.JsonifiedMessage;

    public class ListUserFriendGroupsCmd extends JsonifiedMessage 
    {

        public var userId:String;

        public function ListUserFriendGroupsCmd(userId:String)
        {
            this.userId = userId;
        }

    }
} chat.protocol.user.commands

