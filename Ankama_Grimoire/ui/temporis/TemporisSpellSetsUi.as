package Ankama_Grimoire.ui.temporis
{
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.InventoryApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import d2hooks.PresetsUpdate;
    import d2hooks.PresetUsed;
    import d2hooks.PresetSelected;
    import d2hooks.PresetError;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import d2enums.ComponentHookList;
    import d2actions.PresetUseRequest;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.presets.SpellForPreset;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;

    public class TemporisSpellSetsUi 
    {

        public static const TOOLTIP_UI_NAME:String = "TemporisSpellSetsUiTooltip";
        public static const STANDARD_TOOLTIP_UI_NAME:String = "standard";

        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="InventoryApi")]
        public var inventoryApi:InventoryApi;
        [Module(name="Ankama_Common")]
        public var ankamaCommon:Object;
        [Api(name="PlayedCharacterApi")]
        public var playedCharacterApi:PlayedCharacterApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="SystemApi")]
        public var systemApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        private var _componentsDictionary:Dictionary = new Dictionary(true);
        private var _currentSpellSetBuild:BuildWrapper = null;
        public var btn_close:ButtonContainer;
        public var ctr_noSpellSetYet:GraphicContainer;
        public var gd_spellSets:Grid;


        public function main(paramsObject:Object=null):void
        {
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortcut);
            this.systemApi.addHook(PresetsUpdate, this.onPresetsUpdate);
            this.systemApi.addHook(PresetUsed, this.onPresetUsed);
            this.systemApi.addHook(PresetSelected, this.onPresetSelected);
            this.systemApi.addHook(PresetError, this.onPresetError);
            this.loadSpellSets();
        }

        public function unload():void
        {
            this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
            this.uiApi.hideTooltip(STANDARD_TOOLTIP_UI_NAME);
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
        }

        public function updateTemporisSpellSetLine(spellSetDescr:Object, components:*, isSelected:Boolean):void
        {
            this.uiApi.removeComponentHook(components.btn_equipSpellSet, ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.btn_editSpellSet, ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.btn_shareTemporisSpells, ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.btn_editSpellSet, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_editSpellSet, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_shareTemporisSpells, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_shareTemporisSpells, ComponentHookList.ON_ROLL_OUT);
            components.gd_temporisSpells.renderer.allowDrop = false;
            if (spellSetDescr === null)
            {
                components.slot_spellSetIcon.data = null;
                components.lbl_spellSetName.text = null;
                components.gd_temporisSpells.dataProvider = [];
                components.lineBlock.visible = false;
                return;
            };
            this.uiApi.addComponentHook(components.btn_editSpellSet, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_editSpellSet, ComponentHookList.ON_ROLL_OUT);
            if (((!(this._currentSpellSetBuild === null)) && (spellSetDescr.spellSetId === this._currentSpellSetBuild.id)))
            {
                components.btn_equipSpellSet.disabled = true;
            }
            else
            {
                components.btn_equipSpellSet.disabled = false;
                this.uiApi.addComponentHook(components.btn_equipSpellSet, ComponentHookList.ON_RELEASE);
                this._componentsDictionary[components.btn_equipSpellSet.name] = spellSetDescr;
            };
            this.uiApi.addComponentHook(components.btn_editSpellSet, ComponentHookList.ON_RELEASE);
            this._componentsDictionary[components.btn_editSpellSet.name] = spellSetDescr;
            if (((!(spellSetDescr.temporisSpells === null)) && (spellSetDescr.temporisSpells.length > 0)))
            {
                this.uiApi.addComponentHook(components.btn_shareTemporisSpells, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.btn_shareTemporisSpells, ComponentHookList.ON_ROLL_OUT);
                this.uiApi.addComponentHook(components.btn_shareTemporisSpells, ComponentHookList.ON_RELEASE);
                components.btn_shareTemporisSpells.disabled = false;
                this._componentsDictionary[components.btn_shareTemporisSpells.name] = spellSetDescr;
            }
            else
            {
                components.btn_shareTemporisSpells.disabled = true;
            };
            components.lineBlock.visible = true;
            components.slot_spellSetIcon.data = spellSetDescr.spellSetData;
            components.lbl_spellSetName.text = spellSetDescr.spellSetName;
            components.gd_temporisSpells.dataProvider = spellSetDescr.temporisSpells;
        }

        private function equipSpellSet(spellSetDescr:Object):void
        {
            this._currentSpellSetBuild = spellSetDescr.spellSetData;
            this.systemApi.sendAction(new PresetUseRequest(spellSetDescr.spellSetId));
        }

        private function editSpellSet(spellSetDescr:Object):void
        {
            if (!this.uiApi.getUi(UIEnum.TEMPORIS_SPELL_SET_POP_UP))
            {
                this.uiApi.loadUi(UIEnum.TEMPORIS_SPELL_SET_POP_UP, UIEnum.TEMPORIS_SPELL_SET_POP_UP, [TemporisSpellSetPopUp.ACTION_EDIT_SPELL_SET, spellSetDescr]);
            };
        }

        private function shareTemporisSpells(temporisSpells:Array):void
        {
            var temporisSpellIds:Array = [];
            var currentSpellWrapper:SpellWrapper;
            for each (currentSpellWrapper in temporisSpells)
            {
                if (currentSpellWrapper !== null)
                {
                    temporisSpellIds.push(currentSpellWrapper.spellId);
                };
            };
            temporisSpellIds = temporisSpellIds.sort(Array.NUMERIC);
            this.systemApi.goToUrl((this.uiApi.getText("ui.link.shareTemporisSpells") + temporisSpellIds.toString()));
        }

        private function loadSpellSets():void
        {
            var item:Object;
            var index:uint;
            var builds:Array = this.inventoryApi.getBuilds(2);
            var spellSets:Array = [];
            var currentBuildWrapper:BuildWrapper;
            var temporisSpells:Array;
            var currentSpellWrapper:SpellWrapper;
            var currentSpellsForPreset:Vector.<SpellForPreset>;
            var currentSpellId:uint;
            for each (item in builds)
            {
                if ((item is BuildWrapper))
                {
                    currentBuildWrapper = (item as BuildWrapper);
                    temporisSpells = [];
                    if (currentBuildWrapper.forgettableSpellsPreset !== null)
                    {
                        currentSpellsForPreset = currentBuildWrapper.forgettableSpellsPreset.forgettableSpells;
                    }
                    else
                    {
                        currentSpellsForPreset = null;
                    };
                    if (currentSpellsForPreset !== null)
                    {
                        index = 0;
                        while (index < currentSpellsForPreset.length)
                        {
                            currentSpellId = currentSpellsForPreset[index].spellId;
                            if (this.playedCharacterApi.isForgettableSpell(currentSpellId))
                            {
                                currentSpellWrapper = this.dataApi.getSpellWrapper(currentSpellId);
                                if (currentSpellWrapper !== null)
                                {
                                    temporisSpells.push(currentSpellWrapper);
                                };
                            };
                            index++;
                        };
                    };
                    spellSets.push({
                        "spellSetName":currentBuildWrapper.buildName,
                        "spellSetId":currentBuildWrapper.id,
                        "spellSetIcon":currentBuildWrapper.iconUri,
                        "spellSetIconId":currentBuildWrapper.gfxId,
                        "temporisSpells":temporisSpells,
                        "spellSetData":currentBuildWrapper
                    });
                };
            };
            this.ctr_noSpellSetYet.visible = (spellSets.length <= 0);
            this.gd_spellSets.dataProvider = spellSets;
        }

        private function closeMe():void
        {
            if (this.uiApi !== null)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }

        private function showSpellTooltip(data:Object, target:Object):void
        {
            if ((((data === null) || (target === null)) || (data === null)))
            {
                return;
            };
            this.uiApi.showTooltip(data, target, false, STANDARD_TOOLTIP_UI_NAME, LocationEnum.POINT_TOPLEFT, LocationEnum.POINT_TOPRIGHT, 3, null, null, {
                "alwaysAdvanced":true,
                "footer":false
            }, null, false);
        }

        public function onRollOver(target:Object):void
        {
            this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
            this.uiApi.hideTooltip(STANDARD_TOOLTIP_UI_NAME);
            var tooltipText:String;
            if (target.name.indexOf("btn_editSpellSet") !== -1)
            {
                tooltipText = this.uiApi.getText("ui.temporis.editOrDeleteSpellSet");
            }
            else
            {
                if (target.name.indexOf("btn_shareTemporisSpells") !== -1)
                {
                    tooltipText = this.uiApi.getText("ui.temporis.shareSpellSet");
                };
            };
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target, false, TOOLTIP_UI_NAME, LocationEnum.POINT_TOP, LocationEnum.POINT_BOTTOM, 0, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
            this.uiApi.hideTooltip(STANDARD_TOOLTIP_UI_NAME);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.closeMe();
                    break;
                default:
                    if ((target.name in this._componentsDictionary))
                    {
                        if (target.name.indexOf("btn_equipSpellSet") !== -1)
                        {
                            this.equipSpellSet(this._componentsDictionary[target.name]);
                        }
                        else
                        {
                            if (target.name.indexOf("btn_editSpellSet") !== -1)
                            {
                                this.editSpellSet(this._componentsDictionary[target.name]);
                            }
                            else
                            {
                                if (target.name.indexOf("btn_shareTemporisSpells") !== -1)
                                {
                                    this.shareTemporisSpells(this._componentsDictionary[target.name].temporisSpells);
                                };
                            };
                        };
                    };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (((!(target.name.indexOf("gd_temporisSpells") === -1)) && (!(item.data === null))))
            {
                this.showSpellTooltip(item.data, item.container);
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip(STANDARD_TOOLTIP_UI_NAME);
        }

        public function onShortcut(shortcutLabel:String):Boolean
        {
            var me:UiRootContainer;
            if (shortcutLabel === ShortcutHookListEnum.CLOSE_UI)
            {
                me = this.uiApi.me();
                if (me === null)
                {
                    return (false);
                };
                this.uiApi.unloadUi(me.name);
                return (true);
            };
            return (false);
        }

        public function onPresetsUpdate(buildId:int=-1):void
        {
            this.loadSpellSets();
        }

        public function onPresetSelected(buildId:int):void
        {
            this.loadSpellSets();
        }

        public function onPresetUsed(buildId:int):void
        {
            this.loadSpellSets();
        }

        public function onPresetError(reasonText:String):void
        {
            this.loadSpellSets();
        }


    }
} Ankama_Grimoire.ui.temporis

