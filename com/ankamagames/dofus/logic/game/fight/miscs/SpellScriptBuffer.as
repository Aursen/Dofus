package com.ankamagames.dofus.logic.game.fight.miscs
{
    import com.ankamagames.dofus.logic.game.common.misc.ISpellCastProvider;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.sequencer.ISequencable;
    import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
    import __AS3__.vec.*;

    public class SpellScriptBuffer implements ISpellCastProvider 
    {

        private var _steps:Vector.<ISequencable> = new Vector.<ISequencable>();
        private var _castingSpell:CastingSpell;

        public function SpellScriptBuffer(__castingSpell:CastingSpell)
        {
            this._castingSpell = __castingSpell;
        }

        public function get castingSpell():CastingSpell
        {
            return (this._castingSpell);
        }

        public function get stepsBuffer():Vector.<ISequencable>
        {
            return (this._steps);
        }


    }
} com.ankamagames.dofus.logic.game.fight.miscs

