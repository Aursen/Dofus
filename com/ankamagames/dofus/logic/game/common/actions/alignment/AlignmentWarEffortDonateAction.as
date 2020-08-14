package com.ankamagames.dofus.logic.game.common.actions.alignment
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AlignmentWarEffortDonateAction implements Action 
    {

        public var donation:Number;


        public static function create(donation:Number):AlignmentWarEffortDonateAction
        {
            var a:AlignmentWarEffortDonateAction = new (AlignmentWarEffortDonateAction)();
            a.donation = donation;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.alignment

