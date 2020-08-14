package com.ankamagames.berilia.types.tooltip.event
{
    import flash.events.Event;

    public class TooltipEvent extends Event 
    {

        public static const TOOLTIPS_ORDERED:String = "TooltipEvent.TOOLTIPS_ORDERED";

        public function TooltipEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

    }
} com.ankamagames.berilia.types.tooltip.event

