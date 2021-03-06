package flashx.textLayout.elements
{
    import flashx.textLayout.compose.IFlowComposer;
    import flashx.textLayout.tlf_internal;

    use namespace tlf_internal;

    public class ContainerFormattedElement extends ParagraphFormattedElement 
    {


        public function get flowComposer():IFlowComposer
        {
            return (null);
        }

        override tlf_internal function formatChanged(notifyModelChanged:Boolean=true):void
        {
            var idx:int;
            super.formatChanged(notifyModelChanged);
            if (this.flowComposer)
            {
                idx = 0;
                while (idx < this.flowComposer.numControllers)
                {
                    this.flowComposer.getControllerAt(idx).formatChanged();
                    idx++;
                };
            };
        }

        tlf_internal function preCompose():void
        {
        }

        override tlf_internal function normalizeRange(normalizeStart:uint, normalizeEnd:uint):void
        {
            var p:ParagraphElement;
            super.normalizeRange(normalizeStart, normalizeEnd);
            if (this.numChildren == 0)
            {
                p = new ParagraphElement();
                if (this.canOwnFlowElement(p))
                {
                    p.replaceChildren(0, 0, new SpanElement());
                    replaceChildren(0, 0, p);
                    p.normalizeRange(0, p.textLength);
                };
            };
        }


    }
}

