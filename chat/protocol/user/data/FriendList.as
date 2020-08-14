package chat.protocol.user.data
{
    import chat.protocol.common.JsonifiedMessage;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class FriendList extends JsonifiedMessage 
    {

        public var values:Vector.<Friend>;

        public function FriendList(values:Array)
        {
            this.values = Vector.<Friend>(values);
        }

        public function getFriendById(accountId:String):Friend
        {
            var item:Friend;
            if (this.values)
            {
                for each (item in this.values)
                {
                    if (item.user.userId == accountId)
                    {
                        return (item);
                    };
                };
            };
            return (null);
        }

        public function setFriendPresence(accountId:String, presence:String):void
        {
            var item:Friend;
            if (this.values)
            {
                for each (item in this.values)
                {
                    if (item.user.userId == accountId)
                    {
                        item.presence = presence;
                    };
                };
            };
        }

        public function setFriendStatus(userId:String, status:String):void
        {
            var item:Friend;
            if (this.values)
            {
                for each (item in this.values)
                {
                    if (item.user.userId == userId)
                    {
                        item.status = status;
                    };
                };
            };
        }

        public function setFriendActivities(userId:String, properties:Vector.<EndpointProperties>):void
        {
            var item:Friend;
            if (this.values)
            {
                for each (item in this.values)
                {
                    if (item.user.userId == userId)
                    {
                        item.activities = properties;
                    };
                };
            };
        }


    }
} chat.protocol.user.data

