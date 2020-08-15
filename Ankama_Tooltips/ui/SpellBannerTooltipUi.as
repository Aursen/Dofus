package Ankama_Tooltips.ui
{
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
    import com.ankamagames.dofus.modules.utils.SpellTooltipSettings;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;

    public class SpellBannerTooltipUi extends TooltipPinableBaseUi 
    {

        private static var _shortcutColor:String;

        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        public var lbl_content:Object;
        private var _spellWrapper:Object;
        private var _shortcutKey:String;
        protected var _timerShowSpellTooltip:Timer;


        override public function main(oParam:Object=null):void
        {
            if (!_shortcutColor)
            {
                _shortcutColor = sysApi.getConfigEntry("colors.shortcut");
                _shortcutColor = _shortcutColor.replace("0x", "#");
            };
            this._spellWrapper = oParam.data.spellWrapper;
            this._shortcutKey = oParam.data.shortcutKey;
            this.lbl_content.text = this._spellWrapper.name;
            if (((this._shortcutKey) && (!(this._shortcutKey == ""))))
            {
                this.lbl_content.text = (this.lbl_content.text + ((((" <font color='" + _shortcutColor) + "'>(") + this._shortcutKey) + ")</font>"));
            };
            this.lbl_content.multiline = false;
            this.lbl_content.wordWrap = false;
            this.lbl_content.fullWidthAndHeight();
            backgroundCtr.width = (this.lbl_content.textfield.width + 12);
            backgroundCtr.height = (this.lbl_content.textfield.height + 12);
            this.tooltipApi.place(oParam.position, oParam.showDirectionalArrow, oParam.point, oParam.relativePoint, oParam.offset);
            var delay:int = sysApi.getOption("largeTooltipDelay", "dofus");
            this._timerShowSpellTooltip = new Timer(delay, 1);
            this._timerShowSpellTooltip.addEventListener(TimerEvent.TIMER, this.onTimer);
            this._timerShowSpellTooltip.start();
            super.main(oParam);
        }

        protected function onTimer(e:TimerEvent):void
        {
            var cacheCode:String;
            var spellModif:CharacterSpellModification;
            var setting:String;
            var ref:Object;
            var weapon:Object;
            var modifValue:int;
            if (this._timerShowSpellTooltip)
            {
                this._timerShowSpellTooltip.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerShowSpellTooltip.stop();
                this._timerShowSpellTooltip = null;
            };
            var criticalMiss:int = this._spellWrapper.playerCriticalFailureRate;
            if (this._spellWrapper.isSpellWeapon)
            {
                weapon = this.playerApi.getWeapon();
                if (weapon)
                {
                    cacheCode = ((((((((((((((("SpellBanner-" + this._spellWrapper.id) + "#") + this.tooltipApi.getSpellTooltipCache()) + ",") + this._shortcutKey) + ",") + this._spellWrapper.playerCriticalRate) + ",") + criticalMiss) + ",") + weapon.objectUID) + ",") + weapon.setCount) + ",") + this._spellWrapper.versionNum);
                }
                else
                {
                    cacheCode = ((((((((((("SpellBanner-" + this._spellWrapper.id) + "#-") + this._shortcutKey) + ",") + this._shortcutKey) + ",") + this._spellWrapper.playerCriticalRate) + ",") + criticalMiss) + ",") + this._spellWrapper.versionNum);
                };
            }
            else
            {
                cacheCode = ((((((((((((((("SpellBanner-" + this._spellWrapper.id) + ",") + this._spellWrapper.spellLevel) + "#") + this.tooltipApi.getSpellTooltipCache()) + ",") + this._spellWrapper.playerCriticalRate) + ",") + this._spellWrapper.maximalRangeWithBoosts) + ",") + this._shortcutKey) + ",") + criticalMiss) + ",") + this._spellWrapper.versionNum);
            };
            var spellModifs:Object = this.playerApi.getSpellModifications(this._spellWrapper.id);
            spellModifs.sort(function (spellModifA:CharacterSpellModification, spellModifB:CharacterSpellModification):int
            {
                if (spellModifA.modificationType < spellModifB.modificationType)
                {
                    return (-1);
                };
                if (spellModifA.modificationType > spellModifB.modificationType)
                {
                    return (1);
                };
                return (0);
            });
            for each (spellModif in spellModifs)
            {
                modifValue = ((((spellModif.value.alignGiftBonus + spellModif.value.base) + spellModif.value.additionnal) + spellModif.value.contextModif) + spellModif.value.objectsAndMountBonus);
                cacheCode = (cacheCode + ("," + modifValue));
            };
            if (sysApi.getOption("useAdvancedSpellTooltips", "dofus"))
            {
                cacheCode = (cacheCode + ",useAdvancedSpellTooltips");
            };
            var spellTS:SpellTooltipSettings = (sysApi.getData("spellTooltipSettings", DataStoreEnum.BIND_ACCOUNT) as SpellTooltipSettings);
            if (!spellTS)
            {
                spellTS = this.tooltipApi.createSpellSettings();
                sysApi.setData("spellTooltipSettings", spellTS, DataStoreEnum.BIND_ACCOUNT);
            };
            var settings:Object = {};
            for each (setting in sysApi.getObjectVariables(spellTS))
            {
                if (setting == "header")
                {
                    settings["name"] = spellTS[setting];
                }
                else
                {
                    settings[setting] = spellTS[setting];
                };
            };
            settings.smallSpell = true;
            settings.contextual = true;
            settings.noBg = false;
            settings.shortcutKey = this._shortcutKey;
            settings.CC_EC = sysApi.getOption("useAdvancedSpellTooltips", "dofus");
            ref = uiApi.getUi(UIEnum.BANNER).getElement(((sysApi.isFightContext()) ? "tooltipFightPlacer" : "tooltipRoleplayPlacer"));
            uiApi.showTooltip(this._spellWrapper, ref, false, "spellBanner", 8, 2, 3, null, null, settings, cacheCode);
            uiApi.hideTooltip(uiApi.me().name);
        }

        public function unload():void
        {
            if (this._timerShowSpellTooltip)
            {
                this._timerShowSpellTooltip.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerShowSpellTooltip.stop();
                this._timerShowSpellTooltip = null;
            };
        }


    }
}

