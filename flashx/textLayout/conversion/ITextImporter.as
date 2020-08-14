package flashx.textLayout.conversion
{
    import flashx.textLayout.elements.TextFlow;
    import __AS3__.vec.Vector;
    import flashx.textLayout.elements.IConfiguration;

    public interface ITextImporter 
    {

        function importToFlow(_arg_1:Object):TextFlow;
        function get errors():Vector.<String>;
        function get throwOnError():Boolean;
        function set throwOnError(_arg_1:Boolean):void;
        function get useClipboardAnnotations():Boolean;
        function set useClipboardAnnotations(_arg_1:Boolean):void;
        function get configuration():IConfiguration;
        function set configuration(_arg_1:IConfiguration):void;

    }
} flashx.textLayout.conversion

