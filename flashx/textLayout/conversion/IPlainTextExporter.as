package flashx.textLayout.conversion
{
    public interface IPlainTextExporter extends ITextExporter 
    {

        function get paragraphSeparator():String;
        function set paragraphSeparator(_arg_1:String):void;
        function get stripDiscretionaryHyphens():Boolean;
        function set stripDiscretionaryHyphens(_arg_1:Boolean):void;

    }
}

