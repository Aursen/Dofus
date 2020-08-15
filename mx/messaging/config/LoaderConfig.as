package mx.messaging.config
{
    import mx.core.mx_internal;
    import mx.utils.LoaderUtil;
    import flash.display.DisplayObject;

    use namespace mx_internal;

    [ExcludeClass]
    public class LoaderConfig 
    {

        mx_internal static const VERSION:String = "4.16.1.0";
        mx_internal static var _parameters:Object;
        mx_internal static var _swfVersion:uint;
        mx_internal static var _url:String = null;


        public static function init(root:DisplayObject):void
        {
            if (!_url)
            {
                _url = LoaderUtil.normalizeURL(root.loaderInfo);
                _parameters = root.loaderInfo.parameters;
                _swfVersion = root.loaderInfo.swfVersion;
            };
        }

        public static function get parameters():Object
        {
            return (_parameters);
        }

        public static function get swfVersion():uint
        {
            return (_swfVersion);
        }

        public static function get url():String
        {
            return (_url);
        }


    }
}

