package org.openapitools.event
{
    import flash.events.Event;

    public class ApiClientEvent extends Event 
    {

        public static const FAILURE_EVENT:String = "unsuccesfulInvocation";
        public static const SUCCESS_EVENT:String = "successfulInvocation";

        public var response:Response;
        public var message:String;

        public function ApiClientEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

    }
} org.openapitools.event

