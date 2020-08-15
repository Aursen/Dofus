package com.ankamagames.dofus.logic.common.managers
{
    import flash.utils.Timer;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import flash.geom.Rectangle;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.dofus.datacenter.spells.SpellPair;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import com.ankamagames.berilia.types.data.TextTooltipInfo;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.dofus.datacenter.servers.ServerTemporisSeason;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;

    public class HyperlinkSpellManager 
    {

        public static var lastSpellTooltipId:int = -1;
        private static var _zoneTimer:Timer;


        public static function showSpell(spellId:int, spellLevel:int):void
        {
            var spellWrapper:SpellWrapper = SpellWrapper.create(spellId, spellLevel);
            var target:Rectangle = new Rectangle(420, 220, 0, 0);
            TooltipManager.show(spellWrapper, target, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, "standard", 6, 2, 50, true, null, null, {"pinnable":true}, null, true);
        }

        public static function showSpellNoLevel(spellId:int, spellLevel:int=1):void
        {
            var spellWrapper:SpellWrapper = SpellWrapper.create(spellId, spellLevel);
            var target:Rectangle = new Rectangle(420, 220, 0, 0);
            TooltipManager.show(spellWrapper, target, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, "standard", 6, 2, 50, true, null, null, {
                "smallSpell":true,
                "header":false,
                "effects":false,
                "currentCC_EC":false,
                "baseCC_EC":false,
                "spellTab":false,
                "pinnable":true
            }, null, true);
        }

        public static function showSpellPair(spellPairId:int):void
        {
            var spellPair:SpellPair = SpellPair.getSpellPairById(spellPairId);
            TooltipManager.show(spellPair, new Rectangle(StageShareManager.stage.mouseX, StageShareManager.stage.mouseY, 10, 10), UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, "standard", 6, 2, 50, true, null, null, {
                "smallSpell":true,
                "header":false,
                "effects":false,
                "currentCC_EC":false,
                "baseCC_EC":false,
                "spellTab":false,
                "pinnable":true
            }, null, true);
        }

        public static function getSpellLevelName(spellId:int, spellLevel:int):String
        {
            var spell:Spell = Spell.getSpellById(spellId);
            return ((((("[" + spell.name) + " ") + I18n.getUiText("ui.common.short.level")) + spellLevel) + "]");
        }

        public static function getSpellName(spellId:int, spellLevel:int):String
        {
            var spell:Spell = Spell.getSpellById(spellId);
            if (spell)
            {
                return (("[" + spell.name) + "]");
            };
            return (("[spell " + spellId) + "]");
        }

        public static function showSpellArea(casterId:Number, targetCellId:int, sourceCellId:int, spellId:int, spellLevelId:int):void
        {
            if (Kernel.getWorker().getFrame(FightContextFrame))
            {
                SpellZoneManager.getInstance().displaySpellZone(casterId, targetCellId, sourceCellId, spellId, spellLevelId);
                if (!_zoneTimer)
                {
                    _zoneTimer = new Timer(2000);
                    _zoneTimer.addEventListener(TimerEvent.TIMER, onStopZoneTimer);
                };
                _zoneTimer.reset();
                _zoneTimer.start();
            };
        }

        private static function onStopZoneTimer(e:Event):void
        {
            if (_zoneTimer)
            {
                _zoneTimer.removeEventListener(TimerEvent.TIMER, onStopZoneTimer);
                _zoneTimer.stop();
                _zoneTimer = null;
            };
            SpellZoneManager.getInstance().removeSpellZone();
        }

        public static function rollOver(pX:int, pY:int, casterId:Number, targetCellId:int, sourceCellId:int, spellId:int, spellLevelId:int):void
        {
            var target:Rectangle = new Rectangle(pX, pY, 10, 10);
            var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.showSpellZone"));
            TooltipManager.show(info, target, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "PinnedHyperlink", 6, 2, 3, true, null, null, {"pinnable":true}, null, false, StrataEnum.STRATA_TOOLTIP, 1);
        }

        public static function showSpellsUI():void
        {
            var data:Object = {};
            data.forceOpen = true;
            if (ServerTemporisSeason.isTemporisSpellsUi)
            {
                KernelEventsManager.getInstance().processCallback(HookList.OpenBook, "temporisSpellsUi", data);
            }
            else
            {
                data[0] = "spellList";
                data[1] = {"variantsListTab":true};
                KernelEventsManager.getInstance().processCallback(HookList.OpenBook, "spellBase", data);
            };
        }


    }
}

