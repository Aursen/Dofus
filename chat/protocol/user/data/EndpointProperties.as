package chat.protocol.user.data
{
    import chat.protocol.common.JsonifiedMessage;
    import __AS3__.vec.Vector;
    import flash.utils.Dictionary;

    public class EndpointProperties extends JsonifiedMessage 
    {

        public var applicationId:int;
        public var activities:Vector.<String>;
        public var metadata:Dictionary;

        public function EndpointProperties(applicationId:int, activities:Vector.<String>, metadata:Dictionary)
        {
            this.applicationId = applicationId;
            this.activities = activities;
            this.metadata = metadata;
        }

    }
} chat.protocol.user.data

