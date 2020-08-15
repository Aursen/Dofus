package com.ankamagames.jerakine.resources.events
{
    import com.ankamagames.jerakine.types.Uri;
    import flash.events.Event;

    public class ResourceLoaderProgressEvent extends ResourceEvent 
    {

        public static const LOADER_PROGRESS:String = "loaderProgress";
        public static const LOADER_COMPLETE:String = "loaderComplete";

        public var uri:Uri;
        public var filesLoaded:uint;
        public var filesTotal:uint;

        public function ResourceLoaderProgressEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function clone():Event
        {
            var re:ResourceLoaderProgressEvent = new ResourceLoaderProgressEvent(type, bubbles, cancelable);
            re.uri = this.uri;
            re.filesLoaded = this.filesLoaded;
            re.filesTotal = this.filesTotal;
            return (re);
        }


    }
}

