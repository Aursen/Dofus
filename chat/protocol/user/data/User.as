package chat.protocol.user.data
{
    import chat.protocol.common.JsonifiedMessage;

    public class User extends JsonifiedMessage 
    {

        public var userId:String;
        public var name:String;

        public function User(id:String, userName:String)
        {
            this.userId = id;
            this.name = userName;
        }

        public function toString():String
        {
            return (((("(" + this.name) + ":") + this.userId) + ")");
        }


    }
}

