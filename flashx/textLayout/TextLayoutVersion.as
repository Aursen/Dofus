package flashx.textLayout
{
    public class TextLayoutVersion 
    {

        public static const CURRENT_VERSION:uint = 0x3000000;
        public static const VERSION_3_0:uint = 0x3000000;
        public static const VERSION_2_0:uint = 0x2000000;
        public static const VERSION_1_0:uint = 0x1000000;
        public static const VERSION_1_1:uint = 16842752;
        tlf_internal static const BUILD_NUMBER:String = "31 (763429)";
        tlf_internal static const BRANCH:String = "main";
        public static const AUDIT_ID:String = "<AdobeIP 0000486>";


        tlf_internal static function getVersionString(version:uint):String
        {
            var major:uint = ((version >> 24) & 0xFF);
            var minor:uint = ((version >> 16) & 0xFF);
            var update:uint = (version & 0xFFFF);
            return ((((major.toString() + ".") + minor.toString()) + ".") + update.toString());
        }


        public function dontStripAuditID():String
        {
            return (AUDIT_ID);
        }


    }
} flashx.textLayout

