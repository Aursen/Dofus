package mx.core
{
    import flash.display.DisplayObject;
    import mx.utils.Platform;
    import flash.system.Capabilities;
    import mx.managers.SystemManager;

    use namespace mx_internal;

    public class RuntimeDPIProvider 
    {

        mx_internal static const IPAD_MAX_EXTENT:int = 0x0400;
        mx_internal static const IPAD_RETINA_MAX_EXTENT:int = 0x0800;


        mx_internal static function classifyDPI(dpi:Number):Number
        {
            if (dpi <= 140)
            {
                return (DPIClassification.DPI_120);
            };
            if (dpi <= 200)
            {
                return (DPIClassification.DPI_160);
            };
            if (dpi <= 280)
            {
                return (DPIClassification.DPI_240);
            };
            if (dpi <= 400)
            {
                return (DPIClassification.DPI_320);
            };
            if (dpi <= 560)
            {
                return (DPIClassification.DPI_480);
            };
            return (DPIClassification.DPI_640);
        }


        public function get runtimeDPI():Number
        {
            var scX:Number;
            var scY:Number;
            var root:DisplayObject;
            if (Platform.isIOS)
            {
                scX = Capabilities.screenResolutionX;
                scY = Capabilities.screenResolutionY;
                if (Capabilities.isDebugger)
                {
                    root = SystemManager.getSWFRoot(this);
                    if (((root) && (root.stage)))
                    {
                        scX = root.stage.fullScreenWidth;
                        scY = root.stage.fullScreenHeight;
                    };
                };
                if (((scX == IPAD_MAX_EXTENT) || (scY == IPAD_MAX_EXTENT)))
                {
                    return (DPIClassification.DPI_160);
                };
                if (((scX == IPAD_RETINA_MAX_EXTENT) || (scY == IPAD_RETINA_MAX_EXTENT)))
                {
                    return (DPIClassification.DPI_320);
                };
            };
            return (classifyDPI(Capabilities.screenDPI));
        }


    }
}

