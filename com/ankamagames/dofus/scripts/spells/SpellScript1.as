package com.ankamagames.dofus.scripts.spells
{
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.scripts.api.FxApi;
    import com.ankamagames.dofus.scripts.api.SpellFxApi;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.scripts.SpellFxRunner;

    public class SpellScript1 extends SpellScriptBase 
    {

        public function SpellScript1(spellFxRunner:SpellFxRunner)
        {
            var targetGfxId:uint;
            var entryPortalCell:MapPoint;
            var exitPortalCell:MapPoint;
            super(spellFxRunner);
            var targetCell:MapPoint = FxApi.GetCurrentTargetedCell(runner);
            var casterCell:MapPoint = FxApi.GetEntityCell(caster);
            var portalsCells:Vector.<MapPoint> = SpellFxApi.GetPortalCells(runner);
            if (((portalsCells) && (portalsCells.length > 1)))
            {
                entryPortalCell = portalsCells[0];
                exitPortalCell = portalsCells[(portalsCells.length - 1)];
            };
            var tmpTargetCell:MapPoint = ((entryPortalCell) ? entryPortalCell : targetCell);
            var tmpCasterCell:MapPoint = ((exitPortalCell) ? exitPortalCell : casterCell);
            addCasterSetDirectionStep(tmpTargetCell);
            addCasterAnimationStep();
            if (SpellFxApi.HasSpellParam(spell, "casterGfxId"))
            {
                addNewGfxEntityStep(casterCell, casterCell, tmpTargetCell, PREFIX_CASTER, "", caster);
            };
            if (entryPortalCell)
            {
                addPortalAnimationSteps(SpellFxApi.GetPortalIds(runner));
            };
            var prefix:String = "";
            if (SpellFxApi.HasSpellParam(spell, "targetGfxId"))
            {
                prefix = PREFIX_TARGET;
                targetGfxId = SpellFxApi.GetSpellParam(spell, "targetGfxId");
            }
            else
            {
                targetGfxId = spell.defaultTargetGfxId;
            };
            if (targetGfxId)
            {
                addNewGfxEntityStep(targetCell, tmpCasterCell, targetCell, prefix, "", null, targetGfxId);
            };
            if (SpellFxApi.HasSpellParam(spell, "targetGfxId2"))
            {
                addNewGfxEntityStep(targetCell, tmpCasterCell, targetCell, PREFIX_TARGET, "2");
            };
            addAnimHitSteps();
            addFBackgroundSteps();
            destroy();
        }

    }
}

