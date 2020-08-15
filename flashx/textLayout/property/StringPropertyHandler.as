package flashx.textLayout.property
{
    [ExcludeClass]
    public class StringPropertyHandler extends PropertyHandler 
    {


        override public function owningHandlerCheck(newVal:*):*
        {
            return ((newVal is String) ? newVal : undefined);
        }


    }
}

