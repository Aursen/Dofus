package mx.events
{
    import flash.events.ProgressEvent;
    import mx.core.mx_internal;
    import flash.events.Event;

    use namespace mx_internal;

    public class StyleEvent extends ProgressEvent 
    {

        mx_internal static const VERSION:String = "4.16.1.0";
        public static const COMPLETE:String = "complete";
        public static const ERROR:String = "error";
        public static const PROGRESS:String = "progress";

        public var errorText:String;

        public function StyleEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false, bytesLoaded:uint=0, bytesTotal:uint=0, errorText:String=null)
        {
            super(_arg_1, bubbles, cancelable, bytesLoaded, bytesTotal);
            this.errorText = errorText;
        }

        override public function clone():Event
        {
            return (new StyleEvent(type, bubbles, cancelable, bytesLoaded, bytesTotal, this.errorText));
        }


    }
}

