package flashx.textLayout.conversion
{
    public interface IHTMLImporter extends ITextImporter 
    {

        function get imageSourceResolveFunction():Function;
        function set imageSourceResolveFunction(_arg_1:Function):void;
        function get preserveBodyElement():Boolean;
        function set preserveBodyElement(_arg_1:Boolean):void;
        function get preserveHTMLElement():Boolean;
        function set preserveHTMLElement(_arg_1:Boolean):void;

    }
} flashx.textLayout.conversion

