package mx.events
{
    import flash.events.ProgressEvent;
    import mx.core.mx_internal;
    import flash.display.LoaderInfo;
    import flash.net.URLRequest;
    import flash.events.Event;

    use namespace mx_internal;

    public class RSLEvent extends ProgressEvent 
    {

        mx_internal static const VERSION:String = "4.16.1.0";
        public static const RSL_ADD_PRELOADED:String = "rslAddPreloaded";
        public static const RSL_COMPLETE:String = "rslComplete";
        public static const RSL_ERROR:String = "rslError";
        public static const RSL_PROGRESS:String = "rslProgress";

        public var errorText:String;
        public var isResourceModule:Boolean;
        public var loaderInfo:LoaderInfo;
        public var rslIndex:int;
        public var rslTotal:int;
        public var url:URLRequest;

        public function RSLEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false, bytesLoaded:int=-1, bytesTotal:int=-1, rslIndex:int=-1, rslTotal:int=-1, url:URLRequest=null, errorText:String=null, isResourceModule:Boolean=false, loaderInfo:LoaderInfo=null)
        {
            super(_arg_1, bubbles, cancelable, bytesLoaded, bytesTotal);
            this.rslIndex = rslIndex;
            this.rslTotal = rslTotal;
            this.url = url;
            this.errorText = errorText;
            this.isResourceModule = isResourceModule;
            this.loaderInfo = loaderInfo;
        }

        override public function clone():Event
        {
            return (new RSLEvent(type, bubbles, cancelable, bytesLoaded, bytesTotal, this.rslIndex, this.rslTotal, this.url, this.errorText, this.isResourceModule, this.loaderInfo));
        }


    }
} mx.events

