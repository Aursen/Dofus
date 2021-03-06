package flashx.textLayout.property
{
    import flashx.textLayout.tlf_internal;

    use namespace tlf_internal;

    [ExcludeClass]
    public class UintPropertyHandler extends PropertyHandler 
    {


        override public function get customXMLStringHandler():Boolean
        {
            return (true);
        }

        override public function toXMLString(val:Object):String
        {
            var result:String = val.toString(16);
            if (result.length < 6)
            {
                result = ("000000".substr(0, (6 - result.length)) + result);
            };
            result = ("#" + result);
            return (result);
        }

        override public function owningHandlerCheck(newVal:*):*
        {
            var newRslt:Number;
            var str:String;
            if ((newVal is uint))
            {
                return (newVal);
            };
            if ((newVal is String))
            {
                str = String(newVal);
                if (str.substr(0, 1) == "#")
                {
                    str = ("0x" + str.substr(1, (str.length - 1)));
                };
                newRslt = ((str.toLowerCase().substr(0, 2) == "0x") ? parseInt(str) : NaN);
            }
            else
            {
                if (((newVal is Number) || (newVal is int)))
                {
                    newRslt = Number(newVal);
                }
                else
                {
                    return (undefined);
                };
            };
            if (isNaN(newRslt))
            {
                return (undefined);
            };
            if (((newRslt < 0) || (newRslt > 0xFFFFFFFF)))
            {
                return (undefined);
            };
            return (newRslt);
        }


    }
}

