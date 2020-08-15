package flashx.textLayout.events
{
    import flash.events.EventDispatcher;
    import flashx.textLayout.tlf_internal;
    import flashx.textLayout.elements.FlowElement;
    import flashx.textLayout.elements.TextFlow;
    import flashx.textLayout.elements.ParagraphElement;

    use namespace tlf_internal;

    [ExcludeClass]
    public class FlowElementEventDispatcher extends EventDispatcher 
    {

        tlf_internal var _listenerCount:int = 0;
        tlf_internal var _element:FlowElement;

        public function FlowElementEventDispatcher(element:FlowElement)
        {
            this._element = element;
            super(null);
        }

        override public function addEventListener(_arg_1:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            var tf:TextFlow;
            var pg:ParagraphElement;
            super.addEventListener(_arg_1, listener, useCapture, priority, useWeakReference);
            this._listenerCount++;
            if (this._listenerCount == 1)
            {
                tf = this._element.getTextFlow();
                if (tf)
                {
                    tf.incInteractiveObjectCount();
                };
                pg = this._element.getParagraph();
                if (pg)
                {
                    pg.incInteractiveChildrenCount();
                };
            };
            this._element.modelChanged(ModelChange.ELEMENT_MODIFIED, this._element, 0, this._element.textLength);
        }

        override public function removeEventListener(_arg_1:String, listener:Function, useCapture:Boolean=false):void
        {
            var tf:TextFlow;
            var pg:ParagraphElement;
            super.removeEventListener(_arg_1, listener, useCapture);
            this._listenerCount--;
            if (this._listenerCount == 0)
            {
                tf = this._element.getTextFlow();
                if (tf)
                {
                    tf.decInteractiveObjectCount();
                };
                pg = this._element.getParagraph();
                if (pg)
                {
                    pg.decInteractiveChildrenCount();
                };
            };
            this._element.modelChanged(ModelChange.ELEMENT_MODIFIED, this._element, 0, this._element.textLength);
        }


    }
}

