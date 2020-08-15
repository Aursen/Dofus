package flashx.textLayout.conversion
{
    import flashx.textLayout.elements.TextFlow;
    import __AS3__.vec.Vector;

    public interface ITextExporter 
    {

        function export(_arg_1:TextFlow, _arg_2:String):Object;
        function get errors():Vector.<String>;
        function get throwOnError():Boolean;
        function set throwOnError(_arg_1:Boolean):void;
        function get useClipboardAnnotations():Boolean;
        function set useClipboardAnnotations(_arg_1:Boolean):void;
        function get config():ImportExportConfiguration;
        function set config(_arg_1:ImportExportConfiguration):void;

    }
}

