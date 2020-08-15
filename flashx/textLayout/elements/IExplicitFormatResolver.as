package flashx.textLayout.elements
{
    import flashx.textLayout.formats.ITextLayoutFormat;

    public interface IExplicitFormatResolver extends IFormatResolver 
    {

        function resolveExplicitFormat(_arg_1:Object):ITextLayoutFormat;

    }
}

