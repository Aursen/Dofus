package chat.protocol.user.data
{
    import chat.protocol.common.JsonifiedMessage;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class Friend extends JsonifiedMessage 
    {

        public var user:User;
        public var group:FriendGroup;
        public var presence:String;
        public var status:String;
        public var activities:Vector.<EndpointProperties>;

        public function Friend(user:User, group:FriendGroup)
        {
            this.user = user;
            this.group = group;
            this.presence = UserPresence.OFFLINE;
            this.status = "";
            this.activities = new Vector.<EndpointProperties>(0);
        }

        public function toString():String
        {
            return (this.user.toString() + ((this.group != null) ? (("[group:" + this.group.toString()) + "]") : ""));
        }


    }
} chat.protocol.user.data

