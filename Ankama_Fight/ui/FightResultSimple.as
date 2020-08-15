package Ankama_Fight.ui
{
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.AveragePricesApi;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import flash.utils.setTimeout;
    import Ankama_Fight.Fight;
    import d2enums.ComponentHookList;
    import Ankama_Fight.Api;
    import d2hooks.FightResultClosed;
    import com.ankamagames.dofus.internalDatacenter.fight.FightResultEntryWrapper;
    import com.ankamagames.dofus.network.enums.FightOutcomeEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
    import d2hooks.ShowObjectLinked;
    import com.ankamagames.dofus.datacenter.idols.Idol;
    import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
    import com.ankamagames.berilia.types.LocationEnum;
    import d2hooks.*;

    public class FightResultSimple 
    {

        private static const RESULT_COMPLETE:uint = 1;
        private static const RESULT_FAILED:uint = 2;

        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="AveragePricesApi")]
        public var averagePricesApi:AveragePricesApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var btn_close:ButtonContainer;
        public var btn_maximize:ButtonContainer;
        public var btn_previous:ButtonContainer;
        public var btn_next:ButtonContainer;
        public var lbl_result:Label;
        public var lbl_xp:Label;
        public var lbl_kama:Label;
        public var tx_kamaIcon:Texture;
        public var gd_objects:Grid;
        public var tx_challenge1:Texture;
        public var tx_challenge2:Texture;
        public var tx_challenge_result1:Texture;
        public var tx_challenge_result2:Texture;
        public var tx_result:TextureBitmap;
        public var tx_windowFrame:TextureBitmap;
        public var tx_previous:TextureBitmap;
        public var tx_next:TextureBitmap;
        public var ctr_main:GraphicContainer;
        public var ctr_resultsLeftAnchor:GraphicContainer;
        public var ctr_kama:GraphicContainer;
        public var ctr_challenges:GraphicContainer;
        private var _challenges:Array;
        private var _currentPageIndex:uint;
        private var _currentMapId:Number;
        private var _breachMode:Boolean = false;
        private var _budget:int;
        private var _isPlayerWin:Boolean = false;


        public function main(params:Object):void
        {
            this._currentMapId = this.playerApi.currentMap().mapId;
            setTimeout(this.uiApi.me().render, 0.3);
            if (this.playerApi.isInTutorialArea())
            {
                this.btn_maximize.mouseEnabled = false;
            };
            if (this.uiApi.getUi("levelUp"))
            {
                this.uiApi.me().visible = false;
            };
            if (params)
            {
                Fight.resultsRecap = params;
            }
            else
            {
                params = Fight.resultsRecap;
            };
            this.uiApi.addComponentHook(this.tx_challenge1, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_challenge1, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_challenge2, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_challenge2, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_challenge_result1, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_challenge_result1, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_challenge_result2, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_challenge_result2, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.gd_objects, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.gd_objects, ComponentHookList.ON_ITEM_RIGHT_CLICK);
            this.uiApi.addComponentHook(this.gd_objects, ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addComponentHook(this.gd_objects, ComponentHookList.ON_ITEM_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_maximize, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_maximize, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.lbl_kama, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_kama, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_kamaIcon, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_kamaIcon, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            if (!params)
            {
                return;
            };
            if (params.budget != null)
            {
                this._breachMode = true;
                this._budget = params.budget;
                this.tx_kamaIcon.width = (this.tx_kamaIcon.height = this.uiApi.me().getConstant("iconSpiral_width_height"));
                this.tx_kamaIcon.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "icon_spiral.png"));
            };
            this._currentPageIndex = 0;
            this.displayResults(params.results, params.playSound);
            params.playSound = false;
            if (params.challenges.length > 0)
            {
                this._challenges = params.challenges;
                this.displayChallenges();
            }
            else
            {
                if (this._isPlayerWin)
                {
                    this.ctr_challenges.visible = false;
                    this.tx_windowFrame.width = 624;
                    this.tx_windowFrame.x = 25;
                };
            };
        }

        public function unload():void
        {
            this.uiApi.hideTooltip();
            Api.sysApi.dispatchHook(FightResultClosed);
        }

        private function displayResults(results:Object, playSound:Boolean):void
        {
            var result:FightResultEntryWrapper;
            var objects:Array;
            var o:Object;
            var i:int;
            while (i < results.length)
            {
                result = results[i];
                if (result.id == this.playerApi.id())
                {
                    if (result.outcome == FightOutcomeEnum.RESULT_VICTORY)
                    {
                        this._isPlayerWin = true;
                        this.lbl_result.text = this.uiApi.getText("ui.fightend.victory");
                        this.tx_result.uri = this.uiApi.createUri(this.uiApi.me().getConstant("result_victory"));
                        if (this._breachMode)
                        {
                            this.tx_windowFrame.width = this.uiApi.me().getConstant("victory_breach_width");
                            this.gd_objects.width = this.uiApi.me().getConstant("victory_breach_object_width");
                        };
                        if (playSound)
                        {
                            this.soundApi.playSound(SoundTypeEnum.FIGHT_WIN);
                        };
                    }
                    else
                    {
                        if (result.outcome == FightOutcomeEnum.RESULT_LOST)
                        {
                            this._isPlayerWin = false;
                            this.ctr_main.x = this.uiApi.me().getConstant("defeat_x");
                            this.tx_windowFrame.width = this.uiApi.me().getConstant("defeat_width");
                            if (!this._breachMode)
                            {
                                this.ctr_kama.visible = false;
                                this.ctr_resultsLeftAnchor.x = this.uiApi.me().getConstant("lbl_xp_defeat_x");
                            };
                            this.gd_objects.visible = false;
                            this.ctr_challenges.visible = false;
                            this.lbl_result.cssClass = this.uiApi.me().getConstant("defeat_css");
                            this.lbl_result.text = this.uiApi.getText("ui.fightend.loss");
                            this.tx_result.uri = this.uiApi.createUri(this.uiApi.me().getConstant("result_defeat"));
                            if (playSound)
                            {
                                this.soundApi.playSound(SoundTypeEnum.FIGHT_LOSE);
                            };
                        };
                    };
                    if (result.showExperienceFightDelta)
                    {
                        this.lbl_xp.text = this.utilApi.kamasToString(result.experienceFightDelta, "");
                    }
                    else
                    {
                        this.lbl_xp.text = "0";
                    };
                    if (this._breachMode)
                    {
                        this.lbl_kama.text = this.utilApi.kamasToString(this._budget, "");
                    }
                    else
                    {
                        if (result.rewards.kamas > 0)
                        {
                            this.lbl_kama.text = this.utilApi.kamasToString(result.rewards.kamas, "");
                        }
                        else
                        {
                            this.lbl_kama.text = "0";
                        };
                    };
                    if (result.rewards.objects.length > 0)
                    {
                        result.rewards.objects.sort(this.compareItemsAveragePrices);
                        objects = new Array();
                        for each (o in result.rewards.objects)
                        {
                            objects.push(o);
                        };
                        this.gd_objects.dataProvider = objects;
                        if (this.gd_objects.pagesCount > 0)
                        {
                            this.btn_next.visible = (this.tx_next.visible = true);
                        };
                    }
                    else
                    {
                        this.gd_objects.dataProvider = new Array();
                    };
                    break;
                };
                i++;
            };
        }

        public function displayChallenges():void
        {
            var ctr_challenges:Array = [{
                "tx_challenge":this.tx_challenge1,
                "tx_challenge_result":this.tx_challenge_result1
            }, {
                "tx_challenge":this.tx_challenge2,
                "tx_challenge_result":this.tx_challenge_result2
            }];
            var i:int;
            while (i < ctr_challenges.length)
            {
                ctr_challenges[i].tx_challenge.visible = false;
                ctr_challenges[i].tx_challenge_result.visible = false;
                i++;
            };
            var maxChallenge:uint = ((this._challenges.length <= 2) ? this._challenges.length : 2);
            i = 0;
            while (i < maxChallenge)
            {
                this.displayChallenge(ctr_challenges[i], this._challenges[i]);
                i++;
            };
        }

        public function displayChallenge(ctr_challenge:Object, challenge:Object):void
        {
            ctr_challenge.tx_challenge.visible = true;
            ctr_challenge.tx_challenge.uri = challenge.iconUri;
            switch (challenge.result)
            {
                case RESULT_COMPLETE:
                    ctr_challenge.tx_challenge_result.visible = true;
                    ctr_challenge.tx_challenge_result.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "hud/filter_iconChallenge_check.png"));
                    break;
                case RESULT_FAILED:
                    ctr_challenge.tx_challenge_result.visible = true;
                    ctr_challenge.tx_challenge_result.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "hud/filter_iconChallenge_cross.png"));
                    break;
            };
        }

        private function compareItemsAveragePrices(pItemA:Object, pItemB:Object):int
        {
            var itemAPrice:Number = (this.averagePricesApi.getItemAveragePrice(pItemA.objectGID) * pItemA.quantity);
            var itemBPrice:Number = (this.averagePricesApi.getItemAveragePrice(pItemB.objectGID) * pItemB.quantity);
            return ((itemAPrice < itemBPrice) ? 1 : ((itemAPrice > itemBPrice) ? -1 : 0));
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_previous:
                    this._currentPageIndex--;
                    this.btn_next.visible = (this.tx_next.visible = true);
                    if (this._currentPageIndex <= 0)
                    {
                        this._currentPageIndex = 0;
                        this.btn_previous.visible = (this.tx_previous.visible = false);
                    };
                    this.gd_objects.moveToPage(this._currentPageIndex);
                    break;
                case this.btn_next:
                    this._currentPageIndex++;
                    this.btn_previous.visible = (this.tx_previous.visible = true);
                    if (this._currentPageIndex >= this.gd_objects.pagesCount)
                    {
                        this._currentPageIndex = this.gd_objects.pagesCount;
                        this.btn_next.visible = (this.tx_next.visible = false);
                    };
                    this.gd_objects.moveToPage(this._currentPageIndex);
                    break;
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_maximize:
                    Api.sysApi.setData("useFightResultSimple", false, DataStoreEnum.BIND_ACCOUNT);
                    this.uiApi.loadUi("fightResult", "fightResult");
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String = "";
            var pos:Object = {
                "point":7,
                "relativePoint":7,
                "offset":0
            };
            switch (target)
            {
                case this.btn_maximize:
                    text = this.uiApi.getText("ui.common.maximize");
                    break;
                case this.lbl_kama:
                case this.tx_kamaIcon:
                    if (this._breachMode)
                    {
                        text = this.uiApi.getText("ui.fightend.teamDreamPoints");
                    };
                    break;
                case this.tx_challenge_result1:
                    this.uiApi.showTooltip(this._challenges[0], target, false, "standard", 2, 8, 0, null, null, null);
                    break;
                case this.tx_challenge_result2:
                    this.uiApi.showTooltip(this._challenges[1], target, false, "standard", 2, 8, 0, null, null, null);
                    break;
            };
            if (text != "")
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, pos.offset, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var item:Object;
            if (target.name.indexOf("gd_objects") != -1)
            {
                if (((!(Api.sysApi.getOption("displayTooltips", "dofus"))) && ((selectMethod == GridItemSelectMethodEnum.CLICK) || (selectMethod == GridItemSelectMethodEnum.MANUAL))))
                {
                    item = target.selectedItem;
                    Api.sysApi.dispatchHook(ShowObjectLinked, item);
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var idol:Idol;
            var itemTooltipSettings:ItemTooltipSettings;
            var tooltipData:*;
            if (item.data)
            {
                if (item.data.typeId == 178)
                {
                    idol = Api.dataApi.getIdolByItemId(item.data.objectGID);
                    this.uiApi.showTooltip(idol.spellPair, item.container, false, "standard", LocationEnum.POINT_BOTTOM, LocationEnum.POINT_BOTTOM, 0, null, null, {
                        "smallSpell":true,
                        "header":false,
                        "footer":false,
                        "effects":false,
                        "currentCC_EC":false,
                        "baseCC_EC":false,
                        "spellTab":false
                    });
                }
                else
                {
                    itemTooltipSettings = (Api.sysApi.getData("itemTooltipSettings", DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings);
                    if (!itemTooltipSettings)
                    {
                        itemTooltipSettings = this.tooltipApi.createItemSettings();
                        Api.sysApi.setData("itemTooltipSettings", itemTooltipSettings, DataStoreEnum.BIND_ACCOUNT);
                    };
                    tooltipData = item.data;
                    if ((((((!(itemTooltipSettings.header)) && (!(itemTooltipSettings.conditions))) && (!(itemTooltipSettings.effects))) && (!(itemTooltipSettings.description))) && (!(itemTooltipSettings.averagePrice))))
                    {
                        tooltipData = item.data.name;
                    };
                    this.uiApi.showTooltip(item.data, item.container, false, "standard", 7, 7, 0, "itemName", null, {
                        "header":itemTooltipSettings.header,
                        "conditions":itemTooltipSettings.conditions,
                        "description":itemTooltipSettings.description,
                        "averagePrice":itemTooltipSettings.averagePrice,
                        "showEffects":itemTooltipSettings.effects
                    }, "ItemInfo");
                };
            };
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            if (item.data == null)
            {
                return;
            };
            var data:Object = item.data;
            var contextMenu:Object = this.menuApi.create(data);
            var itemTooltipSettings:ItemTooltipSettings = (Api.sysApi.getData("itemTooltipSettings", DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings);
            if (!itemTooltipSettings)
            {
                itemTooltipSettings = this.tooltipApi.createItemSettings();
                Api.sysApi.setData("itemTooltipSettings", itemTooltipSettings, DataStoreEnum.BIND_ACCOUNT);
            };
            this.modContextMenu.createContextMenu(contextMenu);
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemDetails(item:Object, target:Object):void
        {
            this.uiApi.showTooltip(item, target, false, "Hyperlink", 0, 2, 3, null, null, null, null, true);
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                case "closeUi":
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }

        private function onCurrentMap(mapId:Number):void
        {
            if (this.playerApi.isInTutorialArea())
            {
                return;
            };
            if (((this.uiApi.me().visible) && (!(mapId == this._currentMapId))))
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }


    }
}

