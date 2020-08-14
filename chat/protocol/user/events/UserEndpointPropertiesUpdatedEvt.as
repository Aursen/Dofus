package chat.protocol.user.events
{
    import chat.protocol.common.JsonifiedMessage;
    import __AS3__.vec.Vector;
    import chat.protocol.user.data.EndpointProperties;
    import __AS3__.vec.*;

    public class UserEndpointPropertiesUpdatedEvt extends JsonifiedMessage 
    {

        public var userId:String;
        public var properties:Vector.<EndpointProperties>;

        public function UserEndpointPropertiesUpdatedEvt(userId:String, properties:Array)
        {
            this.userId = userId;
            this.properties = Vector.<EndpointProperties>(properties);
        }

    }
} chat.protocol.user.events

