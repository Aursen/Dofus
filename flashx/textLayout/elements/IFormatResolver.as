package flashx.textLayout.elements
{
    import flashx.textLayout.formats.ITextLayoutFormat;

    public interface IFormatResolver 
    {

        function invalidateAll(_arg_1:TextFlow):void;
        function invalidate(_arg_1:Object):void;
        function resolveFormat(_arg_1:Object):ITextLayoutFormat;
        function resolveUserFormat(_arg_1:Object, _arg_2:String):*;
        function getResolverForNewFlow(_arg_1:TextFlow, _arg_2:TextFlow):IFormatResolver;

    }
} flashx.textLayout.elements

