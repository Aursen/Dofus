package Ankama_ContextMenu.makers
{
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import Ankama_ContextMenu.Api;
    import d2actions.SpellVariantActivationRequest;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import Ankama_ContextMenu.ContextMenu;
    import d2hooks.InsertHyperlink;
    import com.ankamagames.dofus.modules.utils.SpellTooltipSettings;
    import flash.geom.Rectangle;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import d2actions.*;

    public class SpellMenuMaker implements IMenuMaker 
    {

        public static var disabled:Boolean = false;

        private var _shortcutColor:String;

        public function SpellMenuMaker()
        {
            this._shortcutColor = (Api.system.getConfigEntry("colors.shortcut") as String).replace("0x", "#");
        }

        private function switchToVariantId(spellId:int):void
        {
            Api.system.sendAction(new SpellVariantActivationRequest(spellId));
        }

        public function createMenu(data:*, param:Object):Array
        {
            var spellToSwitchTo:Spell;
            var variantSpells:Array;
            var spellLevelToSwitchTo:SpellLevel;
            Api.ui.hideTooltip();
            var menu:Array = [];
            menu.push(ContextMenu.static_createContextMenuItemObject((((((((Api.ui.getText("ui.tooltip.displayChatSpell") + " <font color='") + this._shortcutColor) + "'>(") + Api.ui.getText("ui.keyboard.shift")) + " + ") + Api.ui.getText("ui.mouse.click")) + ")</font>"), this.displayChatSpell, [data]), ContextMenu.static_createContextMenuItemObject((((Api.ui.getText("ui.tooltip.pin") + " <font color='") + this._shortcutColor) + "'>(Alt)</font>"), this.pinTooltip, [data, (!(!(((param) && (param.length)) && (param[0].hasOwnProperty("advanced")))))]));
            if (((Api.player.isInFight()) && (!(Api.player.isInPreFight()))))
            {
                return (menu);
            };
            var spell:Spell = data.spell;
            if ((((((param) && (param.length)) && (param[0].hasOwnProperty("replaceByOtherSpell"))) && (spell.spellVariant)) && (spell.spellVariant.spells.length > 1)))
            {
                variantSpells = spell.spellVariant.spells;
                if (variantSpells[0].id != spell.id)
                {
                    spellToSwitchTo = variantSpells[0];
                }
                else
                {
                    spellToSwitchTo = variantSpells[1];
                };
                spellLevelToSwitchTo = Api.data.getSpellLevel(spellToSwitchTo.spellLevels[0]);
                disabled = ((!(spellLevelToSwitchTo)) || (spellLevelToSwitchTo.minPlayerLevel > Api.player.getPlayedCharacterInfo().level));
                menu.push(ContextMenu.static_createContextMenuSeparatorObject(), ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.spell.replaceBy", spellToSwitchTo.name), this.switchToVariantId, [spellToSwitchTo.id], disabled));
            };
            return (menu);
        }

        private function displayChatSpell(data:Object):void
        {
            Api.system.dispatchHook(InsertHyperlink, data);
        }

        private function pinTooltip(data:*, advanced:Boolean):void
        {
            var setting:String;
            var settings:* = {};
            var spellTooltipSettings:SpellTooltipSettings = this.getSpellTooltipSettings();
            var objVariables:* = Api.system.getObjectVariables(spellTooltipSettings);
            for each (setting in objVariables)
            {
                settings[setting] = spellTooltipSettings[setting];
            };
            settings.pinnable = true;
            settings.footerText = "";
            if (advanced)
            {
                settings.advanced = true;
            };
            Api.ui.showTooltip(data, new Rectangle(20, 20, 0, 0), false, "standard", 0, 0, 0, null, null, settings, null, true, 4, 1, "gameUiCore");
        }

        private function getSpellTooltipSettings():SpellTooltipSettings
        {
            var spellTS:SpellTooltipSettings = (Api.system.getData("spellTooltipSettings", DataStoreEnum.BIND_ACCOUNT) as SpellTooltipSettings);
            if (spellTS == null)
            {
                spellTS = Api.tooltip.createSpellSettings();
                this.setSpellTooltipSettings(spellTS);
            };
            return (spellTS);
        }

        private function setSpellTooltipSettings(val:SpellTooltipSettings):Boolean
        {
            return (Api.system.setData("spellTooltipSettings", val, DataStoreEnum.BIND_ACCOUNT));
        }


    }
} Ankama_ContextMenu.makers

