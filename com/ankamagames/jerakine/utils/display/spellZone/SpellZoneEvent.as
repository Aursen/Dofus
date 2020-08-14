package com.ankamagames.jerakine.utils.display.spellZone
{
    import flash.events.Event;

    public class SpellZoneEvent extends Event 
    {

        public static const CELL_ROLLOVER:String = "cell_rollover";
        public static const CELL_ROLLOUT:String = "cell_rollout";

        public var cell:SpellZoneCell;

        public function SpellZoneEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

    }
} com.ankamagames.jerakine.utils.display.spellZone

