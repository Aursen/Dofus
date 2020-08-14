package com.ankamagames.berilia.types.event
{
    import flash.events.Event;
    import com.ankamagames.berilia.types.data.ExtendedStyleSheet;

    public class CssEvent extends Event 
    {

        public static const CSS_PARSED:String = "event_css_parsed";

        private var _stylesheet:ExtendedStyleSheet;

        public function CssEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false, stylesheet:ExtendedStyleSheet=null)
        {
            super(_arg_1, bubbles, cancelable);
            this._stylesheet = stylesheet;
        }

        public function get stylesheet():ExtendedStyleSheet
        {
            return (this._stylesheet);
        }


    }
} com.ankamagames.berilia.types.event

