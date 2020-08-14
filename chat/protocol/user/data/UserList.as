package chat.protocol.user.data
{
    import chat.protocol.common.JsonifiedMessage;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class UserList extends JsonifiedMessage 
    {

        public var values:Vector.<User>;

        public function UserList(values:Array)
        {
            this.values = Vector.<User>(values);
        }

        public function toString():String
        {
            var result:String;
            var i:int;
            while (i < this.values.length)
            {
                result = (result + this.values[i].toString());
                if ((i + 1) < this.values.length)
                {
                    result = (result + ", ");
                };
                i++;
            };
            return (result);
        }


    }
} chat.protocol.user.data

