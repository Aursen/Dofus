package flashx.textLayout.property
{
    [ExcludeClass]
    public class BooleanPropertyHandler extends PropertyHandler 
    {


        override public function owningHandlerCheck(newVal:*):*
        {
            if ((newVal is Boolean))
            {
                return (newVal);
            };
            if (((newVal == "true") || (newVal == "false")))
            {
                return (newVal == "true");
            };
            return (undefined);
        }


    }
} flashx.textLayout.property

