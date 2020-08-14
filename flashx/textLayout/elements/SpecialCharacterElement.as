package flashx.textLayout.elements
{
    import flashx.textLayout.formats.WhiteSpaceCollapse;
    import flashx.textLayout.tlf_internal;
    import flashx.textLayout.formats.TextLayoutFormat;

    use namespace tlf_internal;

    public class SpecialCharacterElement extends SpanElement 
    {

        public function SpecialCharacterElement()
        {
            whiteSpaceCollapse = WhiteSpaceCollapse.PRESERVE;
        }

        override tlf_internal function mergeToPreviousIfPossible():Boolean
        {
            var myidx:int;
            var newSib:SpanElement;
            var sib:SpanElement;
            var siblingInsertPosition:int;
            if (parent)
            {
                myidx = parent.getChildIndex(this);
                if (myidx != 0)
                {
                    sib = (parent.getChildAt((myidx - 1)) as SpanElement);
                    if ((((!(sib == null)) && (sib is SpanElement)) && (TextLayoutFormat.isEqual(sib.format, format))))
                    {
                        siblingInsertPosition = sib.textLength;
                        sib.replaceText(siblingInsertPosition, siblingInsertPosition, this.text);
                        parent.replaceChildren(myidx, (myidx + 1));
                        return (true);
                    };
                };
                newSib = new SpanElement();
                newSib.text = this.text;
                newSib.format = format;
                parent.replaceChildren(myidx, (myidx + 1), newSib);
                newSib.normalizeRange(0, newSib.textLength);
                return (false);
            };
            return (false);
        }


    }
} flashx.textLayout.elements

