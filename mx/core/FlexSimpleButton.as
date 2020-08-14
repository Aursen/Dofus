package mx.core
{
    import flash.display.SimpleButton;
    import mx.utils.NameUtil;

    public class FlexSimpleButton extends SimpleButton 
    {

        mx_internal static const VERSION:String = "4.16.1.0";

        public function FlexSimpleButton()
        {
            try
            {
                name = NameUtil.createUniqueName(this);
            }
            catch(e:Error)
            {
            };
        }

        override public function toString():String
        {
            return (NameUtil.displayObjectToString(this));
        }


    }
} mx.core

