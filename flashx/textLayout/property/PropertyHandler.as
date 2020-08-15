package flashx.textLayout.property
{
    [ExcludeClass]
    public class PropertyHandler 
    {


        public static function createRange(rest:Array):Object
        {
            var range:Object = new Object();
            var i:int;
            while (i < rest.length)
            {
                range[rest[i]] = null;
                i++;
            };
            return (range);
        }


        public function get customXMLStringHandler():Boolean
        {
            return (false);
        }

        public function toXMLString(val:Object):String
        {
            return (null);
        }

        public function owningHandlerCheck(newVal:*):*
        {
            return (undefined);
        }

        public function setHelper(newVal:*):*
        {
            return (newVal);
        }


    }
}

