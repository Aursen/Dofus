package flashx.textLayout.elements
{
    import flashx.textLayout.tlf_internal;

    use namespace tlf_internal;

    public final class DivElement extends ContainerFormattedElement 
    {


        override protected function get abstract():Boolean
        {
            return (false);
        }

        override tlf_internal function get defaultTypeName():String
        {
            return ("div");
        }


    }
}

