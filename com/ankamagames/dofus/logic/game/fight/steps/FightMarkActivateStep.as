package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.types.entities.Glyph;
    import com.ankamagames.dofus.logic.game.fight.frames.FightTurnFrame;
    import com.ankamagames.jerakine.types.positions.PathElement;
    import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
    import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
    import tools.enumeration.GameActionMarkTypeEnum;
    import com.ankamagames.dofus.types.enums.PortalAnimationEnum;
    import com.ankamagames.dofus.kernel.Kernel;
    import __AS3__.vec.Vector;

    public class FightMarkActivateStep extends AbstractSequencable implements IFightStep 
    {

        private var _markId:int;
        private var _activate:Boolean;

        public function FightMarkActivateStep(markId:int, activate:Boolean)
        {
            this._markId = markId;
            this._activate = activate;
        }

        public function get stepType():String
        {
            return ("markActivate");
        }

        override public function start():void
        {
            var glyph:Glyph;
            var ftf:FightTurnFrame;
            var pe:PathElement;
            var updatePath:Boolean;
            var mark:MarkInstance = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
            if (mark)
            {
                mark.active = this._activate;
                glyph = MarkedCellsManager.getInstance().getGlyph(mark.markId);
                if (glyph)
                {
                    if (mark.markType == GameActionMarkTypeEnum.PORTAL)
                    {
                        glyph.setAnimation(((this._activate) ? PortalAnimationEnum.STATE_NORMAL : PortalAnimationEnum.STATE_DISABLED));
                    };
                };
                ftf = (Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame);
                if ((((ftf) && (ftf.myTurn)) && (ftf.lastPath)))
                {
                    for each (pe in ftf.lastPath.path)
                    {
                        if (mark.cells.indexOf(pe.cellId) != -1)
                        {
                            updatePath = true;
                            break;
                        };
                    };
                    if (updatePath)
                    {
                        ftf.updatePath();
                    };
                };
            };
            executeCallbacks();
        }

        public function get targets():Vector.<Number>
        {
            return (new <Number>[(this._markId as Number)]);
        }


    }
}

