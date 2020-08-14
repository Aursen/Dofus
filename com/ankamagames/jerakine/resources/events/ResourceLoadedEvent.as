package com.ankamagames.jerakine.resources.events
{
    import com.ankamagames.jerakine.types.Uri;
    import flash.events.Event;

    public class ResourceLoadedEvent extends ResourceEvent 
    {

        public static const LOADED:String = "loaded";

        public var resource:*;
        public var resourceType:uint = 0xFF;
        public var uri:Uri;

        public function ResourceLoadedEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function clone():Event
        {
            var re:ResourceLoadedEvent = new ResourceLoadedEvent(type, bubbles, cancelable);
            re.resource = this.resource;
            re.resourceType = this.resourceType;
            re.uri = this.uri;
            return (re);
        }


    }
} com.ankamagames.jerakine.resources.events

