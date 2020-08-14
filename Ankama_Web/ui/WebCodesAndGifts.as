package Ankama_Web.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.NotificationApi;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.TextureBitmap;
    import d2enums.ComponentHookList;
    import d2hooks.UiUnloaded;
    import d2hooks.CodesAndGiftErrorCode;
    import d2hooks.CodesAndGiftCodeSuccess;
    import d2hooks.CodesAndGiftUpdatePurchaseList;
    import d2hooks.GiftAssigned;
    import d2hooks.CodesAndGiftGiftAssigned;
    import d2hooks.GiftsWaitingAllocation;
    import d2hooks.CodesAndGiftConsumeSimpleKardSuccess;
    import d2hooks.CodesAndGiftNoMoreMysteryBox;
    import d2hooks.DofusShopMoney;
    import d2hooks.KeyUp;
    import d2hooks.CodesAndGiftNotificationValue;
    import flash.geom.ColorTransform;
    import d2actions.OpenCodesAndGiftRequest;
    import com.ankamagames.dofus.datacenter.items.VeteranReward;
    import d2actions.GiftAssignRequest;
    import d2hooks.CodesAndGiftGetArticlesStats;
    import d2actions.GiftAssignAllRequest;
    import d2actions.ConsumeSimpleKard;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
    import com.ankamagames.berilia.types.LocationEnum;
    import d2actions.OpenWebService;
    import com.ankamagames.dofus.types.enums.DofusShopEnum;
    import com.ankamagames.berilia.enums.StatesEnum;
    import d2actions.ConsumeCode;
    import com.ankamagames.dofus.types.enums.NotificationTypeEnum;

    public class WebCodesAndGifts 
    {

        private static const KEY_GREATER_THAN:int = 226;
        private static const SECONDS_PER_DAY:uint = 86400;
        private static const CODE_POPUP:String = "codeResultPopup";
        private static const MYSTERYBOX_POPUP:String = "mysteryBoxPopup";

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="NotificationApi")]
        public var notificationApi:NotificationApi;
        private var _allVeteranRewards:Array;
        private var _subscriptionDurationElapsed:Number;
        private var _nextRewardIndex:uint = 0;
        private var _actualVtRewardWrapper:ItemWrapper;
        private var _actualIndex:uint = 0;
        private var _giftsList:Array = [];
        private var _purchaseList:Array = [];
        private var _componentList:Dictionary = new Dictionary(true);
        private var _blockRefresh:Boolean = false;
        private var _ascendingSort:Boolean = true;
        private var _sortCriteria:String = "name";
        private var _mbProbaArrays:Dictionary = new Dictionary(true);
        private var _tooltipCount:uint = 0;
        private var _tooltipTarget:Object;
        private var _actualItemData:Object;
        public var inp_code:Input;
        public var lbl_errorCode:Label;
        public var lbl_codeSuccess:Label;
        public var hint_code:Texture;
        public var btn_validCode:ButtonContainer;
        public var gd_giftList:Grid;
        public var tx_giftVisu:Texture;
        public var tx_sortNameUp:Texture;
        public var tx_sortNameDown:Texture;
        public var btn_getAll:ButtonContainer;
        public var btn_tabName:ButtonContainer;
        public var lbl_nextReward:Label;
        public var lbl_nextRewardTime:Label;
        public var lbl_subscribed:Label;
        public var lbl_subscriptionLink:Label;
        public var lbl_currentOgrines:Label;
        public var tx_nextRwd:Texture;
        public var hint_reward:Texture;
        public var tx_subscriptionExpire:Texture;
        public var iconTexturebtn_buyOgrins:TextureBitmap;
        public var btn_previousVeteranReward:ButtonContainer;
        public var btn_nextVeteranReward:ButtonContainer;
        public var btn_buyOgrins:ButtonContainer;
        public var btn_gotToSubscriptions:ButtonContainer;


        public function main(oParam:Object=null):void
        {
            this.sysApi.startStats("openBox");
            this.sysApi.startStats("getArticles");
            this.btn_validCode.softDisabled = true;
            this.btn_validCode.handCursor = false;
            this.uiApi.addComponentHook(this.btn_previousVeteranReward, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_nextVeteranReward, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_gotToSubscriptions, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.hint_reward, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.hint_reward, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.hint_code, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.hint_code, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.inp_code, ComponentHookList.ON_CHANGE);
            this.uiApi.addComponentHook(this.tx_nextRwd, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_nextRwd, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_getAll, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_getAll, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            this.sysApi.addHook(UiUnloaded, this.onUiUnloaded);
            this.sysApi.addHook(CodesAndGiftErrorCode, this.onCodeError);
            this.sysApi.addHook(CodesAndGiftCodeSuccess, this.onCodeSuccess);
            this.sysApi.addHook(CodesAndGiftUpdatePurchaseList, this.onPurchaseGiftListUpdate);
            this.sysApi.addHook(GiftAssigned, this.updateWaitingGiftList);
            this.sysApi.addHook(CodesAndGiftGiftAssigned, this.onGiftAssigned);
            this.sysApi.addHook(GiftsWaitingAllocation, this.updateWaitingGiftList);
            this.sysApi.addHook(CodesAndGiftConsumeSimpleKardSuccess, this.onSimpleKardConsumed);
            this.sysApi.addHook(CodesAndGiftNoMoreMysteryBox, this.onNoMoreMysteryBox);
            this.sysApi.addHook(DofusShopMoney, this.onDofusShopMoney);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.sysApi.setData("giftNotification", false);
            this.sysApi.dispatchHook(CodesAndGiftNotificationValue, false);
            this.btn_buyOgrins.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -112, -15, 253);
            this.iconTexturebtn_buyOgrins.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 112, 15, -253);
            this._allVeteranRewards = this.dataApi.getAllVeteranRewards();
            this._allVeteranRewards.sortOn("requiredSubDays", Array.NUMERIC);
            this.sysApi.sendAction(new OpenCodesAndGiftRequest());
            this.displaySubscriptionMessage();
            this.resizeLabels();
            this.refreshCodesAndGiftsUi();
        }

        private function resizeLabels():void
        {
            this.lbl_subscribed.fullWidthAndHeight(0, 7);
            this.lbl_subscriptionLink.fullWidthAndHeight();
        }

        private function displaySubscriptionMessage():void
        {
            var playerManager:* = this.sysApi.getPlayerManager();
            if (playerManager.subscriptionEndDate > 0)
            {
                this.lbl_subscribed.text = this.uiApi.getText("ui.bak.subscribed", this.timeApi.getDate(playerManager.subscriptionEndDate));
                if (playerManager.subscriptionEndDate > 172800000)
                {
                    this.tx_subscriptionExpire.width = 0;
                    this.lbl_subscriptionLink.visible = false;
                }
                else
                {
                    this.tx_subscriptionExpire.width = 25;
                    this.lbl_subscriptionLink.visible = true;
                };
            }
            else
            {
                this.lbl_subscribed.text = this.uiApi.getText("ui.bak.notSubscribed");
                this.tx_subscriptionExpire.width = 0;
                this.lbl_subscriptionLink.visible = true;
            };
        }

        public function updateGiftItem(data:*, componentsRef:*, selected:Boolean):void
        {
            if (!data)
            {
                componentsRef.ctr_gd_Gift.visible = false;
            }
            else
            {
                if (!this._componentList[componentsRef.btn_getGift.name])
                {
                    this.uiApi.addComponentHook(componentsRef.btn_getGift, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(componentsRef.btn_getGift, ComponentHookList.ON_ROLL_OUT);
                };
                if (!this._componentList[componentsRef.btn_gridItem.name])
                {
                    this.uiApi.addComponentHook(componentsRef.btn_gridItem, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(componentsRef.btn_gridItem, ComponentHookList.ON_ROLL_OUT);
                };
                if (!this._componentList[componentsRef.tx_giftBg.name])
                {
                    this.uiApi.addComponentHook(componentsRef.tx_giftBg, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(componentsRef.tx_giftBg, ComponentHookList.ON_ROLL_OUT);
                };
                this._componentList[componentsRef.tx_giftBg.name] = data;
                this._componentList[componentsRef.btn_getGift.name] = data;
                this._componentList[componentsRef.btn_gridItem.name] = data;
                componentsRef.tx_giftIcon.uri = data.iconUri;
                componentsRef.lbl_name.text = data.name;
                componentsRef.lbl_quantity.text = ((data.type == "MysteryBox") ? data.ids.length : "1");
                componentsRef.btn_lbl_btn_getGift.text = ((data.type == "Gift") ? this.uiApi.getText("ui.achievement.rewardsGet") : (((data.type == "Purchase") ? this.uiApi.getText("ui.common.use") : (this.uiApi.getText("ui.common.open")))));
                componentsRef.ctr_gd_Gift.visible = true;
            };
        }

        public function showTabHints():void
        {
            this.hintsApi.showSubHints();
        }

        private function refreshCodesAndGiftsUi():void
        {
            this._subscriptionDurationElapsed = this.sysApi.getPlayerManager().subscriptionDurationElapsed;
            var i:uint;
            while (i < this._allVeteranRewards.length)
            {
                if ((this._allVeteranRewards[i].requiredSubDays * SECONDS_PER_DAY) > this._subscriptionDurationElapsed)
                {
                    this._nextRewardIndex = i;
                    break;
                };
                i++;
            };
            this._actualIndex = this._nextRewardIndex;
            this.updateWaitingGiftList(null);
            this.updateGrid();
            if (i == this._allVeteranRewards.length)
            {
                this._actualIndex = (i - 1);
            };
            this.displayVeteranRewardItem(this._actualIndex);
        }

        private function displayVeteranRewardItem(vtRewardIndex:uint):void
        {
            var days:int;
            var daysStr:String;
            var vtReward:VeteranReward = this._allVeteranRewards[vtRewardIndex];
            var remainingTime:int = ((vtReward.requiredSubDays * SECONDS_PER_DAY) - this._subscriptionDurationElapsed);
            if (vtReward.itemGID)
            {
                this._actualVtRewardWrapper = this.dataApi.getItemWrapper(vtReward.itemGID);
                this.tx_nextRwd.uri = this._actualVtRewardWrapper.fullSizeIconUri;
                this.lbl_nextReward.text = this._actualVtRewardWrapper.name;
                if (remainingTime > 0)
                {
                    days = int(Math.ceil((remainingTime / SECONDS_PER_DAY)));
                    daysStr = ((days + " ") + this.uiApi.processText(this.uiApi.getText("ui.time.days"), "m", (days == 1), (days == 0)));
                    this.lbl_nextRewardTime.text = this.uiApi.getText("ui.codesAndGift.veteran.remainingTimeNextReward", daysStr);
                }
                else
                {
                    this.lbl_nextRewardTime.text = this.uiApi.getText("ui.codesAndGift.veteran.allreadyRewarded");
                };
                this.lbl_nextRewardTime.fullWidthAndHeight();
                this.uiApi.me().render();
            };
            this.btn_previousVeteranReward.softDisabled = (vtRewardIndex == 0);
            this.btn_nextVeteranReward.softDisabled = (vtRewardIndex == (this._allVeteranRewards.length - 1));
            this.btn_previousVeteranReward.handCursor = (!(this.btn_previousVeteranReward.softDisabled));
            this.btn_nextVeteranReward.handCursor = (!(this.btn_nextVeteranReward.softDisabled));
        }

        private function updateValidateButton():void
        {
            this.btn_validCode.softDisabled = (this.inp_code.text.length < 1);
            this.btn_validCode.handCursor = (!(this.btn_validCode.softDisabled));
        }

        private function acceptGift(gift:Object):void
        {
            this.sysApi.sendAction(new GiftAssignRequest(gift.uid, this.playerApi.id()));
        }

        private function acceptAll():void
        {
            this.sysApi.dispatchHook(CodesAndGiftGetArticlesStats, null);
            this.sysApi.sendAction(new GiftAssignAllRequest(this.playerApi.id()));
        }

        private function updateGrid():void
        {
            this.btn_getAll.softDisabled = (this._giftsList.length == 0);
            this.btn_getAll.handCursor = (!(this.btn_getAll.softDisabled));
            this.gd_giftList.dataProvider = this._giftsList;
            this.gd_giftList.dataProvider = this.gd_giftList.dataProvider.concat(this._purchaseList);
        }

        private function consume(data:Object):void
        {
            if (data.type == "Purchase")
            {
                this.sysApi.sendAction(new ConsumeSimpleKard(data.item.id));
            }
            else
            {
                this._blockRefresh = true;
                this.uiApi.loadUi("mysteryBoxPopup", null, {"data":data}, StrataEnum.STRATA_TOP, null, true);
            };
        }

        private function displayItemTooltip(target:Object, itemWrapper:Object, multipleItems:Boolean=false):void
        {
            var setting:String;
            var settings:Object = new Object();
            var itemTooltipSettings:ItemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings);
            if (itemTooltipSettings == null)
            {
                itemTooltipSettings = this.tooltipApi.createItemSettings();
                this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, DataStoreEnum.BIND_ACCOUNT);
            };
            var objVariables:* = this.sysApi.getObjectVariables(itemTooltipSettings);
            for each (setting in objVariables)
            {
                settings[setting] = itemTooltipSettings[setting];
            };
            if (!itemWrapper.objectUID)
            {
                settings.showEffects = true;
            };
            settings.rightText = ((multipleItems) ? this.uiApi.getText("ui.tooltip.swapItem") : "");
            itemTooltipSettings.showEffects = false;
            this.uiApi.showTooltip(itemWrapper, target, false, "standard", LocationEnum.POINT_TOPRIGHT, LocationEnum.POINT_TOPLEFT, 3, null, null, settings);
        }

        private function displayPackTooltip(target:Object):void
        {
            this.displayItemTooltip(target, this._actualItemData[this._tooltipCount], true);
        }

        private function sortItemList(arrayToSort:Array, sortField:String):Array
        {
            this._sortCriteria = sortField;
            var dataProvider:Array = arrayToSort;
            switch (sortField)
            {
                case "name":
                    this.displaySortArrows(true);
                    if (this._ascendingSort)
                    {
                        dataProvider.sort(this.sortByName);
                    }
                    else
                    {
                        dataProvider.sort(this.sortByName, Array.DESCENDING);
                    };
                    break;
            };
            return (dataProvider);
        }

        private function sortByName(firstItem:Object, secondItem:Object):int
        {
            var firstValue:String = this.utilApi.noAccent(firstItem.name);
            var secondValue:String = this.utilApi.noAccent(secondItem.name);
            if (firstValue > secondValue)
            {
                return (1);
            };
            if (firstValue < secondValue)
            {
                return (-1);
            };
            return (0);
        }

        private function displaySortArrows(name:Boolean):void
        {
            this.tx_sortNameUp.visible = ((name) && (!(this._ascendingSort)));
            this.tx_sortNameDown.visible = ((name) && (this._ascendingSort));
        }

        private function createProbaObjectArrayFromKard(kards:Array):Array
        {
            var kard:Object;
            var internalFunc:Function;
            var res:Array = [];
            for each (kard in kards)
            {
                res.push({
                    "name":kard.kard.name,
                    "proba":kard.probability,
                    "rarity":kard.rarity,
                    "showProba":true
                });
            };
            internalFunc = function (kard1:Object, kard2:Object):int
            {
                if (kard1.proba > kard2.proba)
                {
                    return (1);
                };
                if (kard1.proba < kard2.proba)
                {
                    return (-1);
                };
                return (0);
            };
            res.sort(internalFunc);
            return (res);
        }

        public function onRelease(target:Object):void
        {
            var data:Object;
            switch (target)
            {
                case this.btn_gotToSubscriptions:
                    this.sysApi.sendAction(new OpenWebService("webShop", {"categoryId":DofusShopEnum.SUBSCRIPTION_CATEGORY_ID}));
                    break;
                case this.btn_buyOgrins:
                    this.sysApi.sendAction(new OpenWebService("webShop", {"categoryId":DofusShopEnum.OGRINES_CATEGORY_ID}));
                    break;
                case this.btn_previousVeteranReward:
                    this._actualIndex--;
                    this.displayVeteranRewardItem(this._actualIndex);
                    break;
                case this.btn_nextVeteranReward:
                    this._actualIndex++;
                    this.displayVeteranRewardItem(this._actualIndex);
                    break;
                case this.btn_validCode:
                    this.validCode();
                    break;
                case this.btn_getAll:
                    this.acceptAll();
                    break;
                case this.btn_tabName:
                    this._ascendingSort = ((this._sortCriteria == "name") ? (!(this._ascendingSort)) : true);
                    this.gd_giftList.dataProvider = this.sortItemList(this.gd_giftList.dataProvider, "name");
                    break;
                default:
                    if (target.name.indexOf("btn_getGift") != -1)
                    {
                        data = this._componentList[target.name];
                        if (data.type == "Gift")
                        {
                            this.acceptGift(data.item);
                        }
                        else
                        {
                            this.consume(data);
                        };
                    };
                    if (target.name.indexOf("btn_gridItem") != -1)
                    {
                        target.selected = false;
                        target.state = StatesEnum.STATE_OVER;
                    };
            };
        }

        public function onRollOver(target:Object):void
        {
            var data:*;
            var probaObject:Object;
            var purchaseObject:Object;
            var tooltipText:String = "";
            switch (target)
            {
                case this.hint_reward:
                    tooltipText = this.uiApi.getText("ui.codesAndGift.veteran.infosTooltip");
                    break;
                case this.hint_code:
                    tooltipText = this.uiApi.getText("ui.codesAndGift.codes.infosTooltip");
                    break;
                case this.tx_nextRwd:
                    this.displayItemTooltip(this.tx_nextRwd, this._actualVtRewardWrapper);
                    return;
                case this.btn_getAll:
                    if (this.btn_getAll.softDisabled)
                    {
                        tooltipText = this.uiApi.getText("ui.codesAndGift.gifts.getAllTooltip");
                    };
                    break;
                default:
                    if (target.name.indexOf("btn_gridItem") != -1)
                    {
                        data = this._componentList[target.name];
                        this.tx_giftVisu.uri = (((data.type == "Purchase") || (data.type == "MysteryBox")) ? (data.iconUri) : (data.item.items[0].fullSizeIconUri));
                    }
                    else
                    {
                        if (target.name.indexOf("tx_giftBg") != -1)
                        {
                            data = this._componentList[target.name];
                            if (data.type == "MysteryBox")
                            {
                                if (!this._mbProbaArrays[data.mbType.id])
                                {
                                    this._mbProbaArrays[data.mbType.id] = this.createProbaObjectArrayFromKard(data.mbType.kards);
                                };
                                probaObject = {
                                    "name":data.name,
                                    "icon":data.iconUri.uri,
                                    "probas":this._mbProbaArrays[data.mbType.id]
                                };
                                this.uiApi.showTooltip(probaObject, target, false, "mysteryBox", 0, 2, 3, "mysteryBox", null, {
                                    "showProba":true,
                                    "sortInBlocks":true,
                                    "description":((data.description) ? data.description : "")
                                });
                            }
                            else
                            {
                                if (data.type == "Gift")
                                {
                                    this._actualItemData = data.item.items;
                                    this._tooltipTarget = target;
                                    this.displayPackTooltip(target);
                                }
                                else
                                {
                                    if (data.type == "Purchase")
                                    {
                                        purchaseObject = {
                                            "name":data.name,
                                            "icon":data.iconUri.uri
                                        };
                                        this.uiApi.showTooltip(purchaseObject, target, false, "mysteryBox", 0, 2, 3, "mysteryBox", null, {"description":((data.description) ? data.description : "")});
                                    };
                                };
                            };
                            this.tx_giftVisu.uri = (((data.type == "Purchase") || (data.type == "MysteryBox")) ? (data.iconUri) : (data.item.items[0].fullSizeIconUri));
                        };
                    };
            };
            if (tooltipText != "")
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target);
            };
        }

        private function onShortcut(shortcut:String):Boolean
        {
            if (((shortcut == "validUi") && (!(this.inp_code.text == ""))))
            {
                this.validCode();
                return (true);
            };
            return (false);
        }

        public function onChange(target:Object):void
        {
            if (target == this.inp_code)
            {
                this.updateValidateButton();
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
            this.uiApi.hideTooltip("mysteryBox");
        }

        private function validCode():void
        {
            this.sysApi.sendAction(new ConsumeCode(this.inp_code.text));
        }

        private function onCodeError(errorEvent:Object):void
        {
            var errorCode:String;
            var dateArray:Array;
            var dateTime:Number;
            var timeStr:String;
            var reason:String = "";
            if (((errorEvent is Array) && (errorEvent.length > 0)))
            {
                errorCode = errorEvent[0].message;
                reason = errorEvent[0].reason;
            }
            else
            {
                errorCode = errorEvent.message;
            };
            this.lbl_errorCode.visible = true;
            this.lbl_codeSuccess.visible = false;
            if (((!(errorCode.indexOf("since") == -1)) || (!(errorCode.indexOf("until") == -1))))
            {
                dateArray = errorCode.substring(errorCode.indexOf('message":')).split(" ")[3].split("-");
                dateArray = dateArray.map(function (item:*, index:int, arr:Array):int
                {
                    return (parseInt(item));
                });
                dateTime = new Date(dateArray[0], (dateArray[1] - 1), dateArray[2]).getTime();
                timeStr = this.timeApi.getDate(dateTime);
                this.lbl_errorCode.text = this.uiApi.getText(((errorCode.indexOf("since") != -1) ? "ui.codesAndGift.codes.invalidCodeSince" : "ui.codesAndGift.codes.inactiveCodeUntil"), timeStr);
            }
            else
            {
                if (errorCode.indexOf("Invalid code") != -1)
                {
                    this.lbl_errorCode.text = this.uiApi.getText("ui.codesAndGift.codes.invalidCode");
                }
                else
                {
                    if (errorCode.indexOf("Canceled code") != -1)
                    {
                        this.lbl_errorCode.text = this.uiApi.getText("ui.codesAndGift.codes.canceledCode");
                    }
                    else
                    {
                        if (errorCode.indexOf("Allready") != -1)
                        {
                            this.lbl_errorCode.text = this.uiApi.getText("ui.codesAndGift.codes.codeAllreadyUsed");
                        }
                        else
                        {
                            if (reason.indexOf("community") != -1)
                            {
                                this.lbl_errorCode.text = this.uiApi.getText("ui.codesAndGift.codes.codeWrongCommu");
                            }
                            else
                            {
                                if (reason.indexOf("kard_not_use") != -1)
                                {
                                    this.lbl_errorCode.text = this.uiApi.getText("ui.codesAndGift.codes.codeAccountTooOld");
                                }
                                else
                                {
                                    if (reason.indexOf("kards_give_to_a_friend") != -1)
                                    {
                                        this.lbl_errorCode.text = this.uiApi.getText("ui.codesAndGift.codes.codeMaxAccountUse");
                                    }
                                    else
                                    {
                                        this.lbl_errorCode.text = this.uiApi.getText("ui.codesAndGift.codes.codeUnknownError");
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        private function onCodeSuccess(result:Object):void
        {
            this.lbl_errorCode.visible = false;
            this.inp_code.text = "";
            this.uiApi.loadUi("codeResultPopup", null, {"object":result}, StrataEnum.STRATA_TOP, null, true);
        }

        private function onPurchaseGiftListUpdate(result:Array):void
        {
            var elem:*;
            var mb:*;
            if (this._blockRefresh)
            {
                return;
            };
            var dataRes:Array = [];
            var mbDic:Dictionary = new Dictionary();
            var mbIdsDic:Dictionary = new Dictionary();
            for each (elem in result)
            {
                if (elem.kard.type != "MULTIPLE")
                {
                    dataRes.push({
                        "item":elem,
                        "type":"Purchase",
                        "name":elem.kard.name,
                        "iconUri":this.uiApi.createUri(elem.kard.image)
                    });
                }
                else
                {
                    if (!mbDic[elem.kard.id])
                    {
                        mbDic[elem.kard.id] = elem.kard;
                        mbIdsDic[elem.kard.id] = [];
                    };
                    mbIdsDic[elem.kard.id].push(elem.id);
                };
            };
            for each (mb in mbDic)
            {
                dataRes.push({
                    "item":mb,
                    "type":"MysteryBox",
                    "name":mb.name,
                    "iconUri":this.uiApi.createUri(mb.image),
                    "ids":mbIdsDic[mb.id],
                    "mbType":mb,
                    "description":mb.description
                });
            };
            this._purchaseList = dataRes;
            this.updateGrid();
        }

        private function onGiftAssigned(items:Array):void
        {
            var item:Object;
            for each (item in items)
            {
                this.sysApi.dispatchHook(CodesAndGiftGetArticlesStats, item.objectGID);
            };
        }

        private function updateWaitingGiftList(newGifts:*):void
        {
            this.sysApi.setData("giftNotification", false);
            this.sysApi.dispatchHook(CodesAndGiftNotificationValue, false);
            if (this._blockRefresh)
            {
                return;
            };
            var list:Array = this.playerApi.getWaitingGifts();
            var internalFunction:Function = function (item:*, index:int, array:Array):Object
            {
                return ({
                    "item":item,
                    "type":"Gift",
                    "name":item.title,
                    "iconUri":item.items[0].iconUri
                });
            };
            this._giftsList = list.map(internalFunction);
            this.updateGrid();
        }

        private function onSimpleKardConsumed(kardId:int):void
        {
            var data:*;
            var i:int;
            while (i < this._purchaseList.length)
            {
                data = this._purchaseList[i];
                if (data.type != "Purchase")
                {
                }
                else
                {
                    if (kardId == data.item.id)
                    {
                        this.notificationApi.showNotification(this.uiApi.getText("ui.codesAndGift.tooltipKard.title"), this.uiApi.getText("ui.codesAndGift.tooltipKard.content", data.name), NotificationTypeEnum.SERVER_INFORMATION);
                        this._purchaseList.removeAt(i);
                        this.updateGrid();
                    };
                };
                i++;
            };
        }

        private function onNoMoreMysteryBox(mbId:uint):void
        {
            var data:*;
            var i:int;
            while (i < this._purchaseList.length)
            {
                data = this._purchaseList[i];
                if (data.type != "MysteryBox")
                {
                }
                else
                {
                    if (mbId == data.item.id)
                    {
                        this._purchaseList.removeAt(i);
                        this.updateGrid();
                    };
                };
                i++;
            };
        }

        private function onUiUnloaded(uiName:String):void
        {
            if (((uiName == CODE_POPUP) || (uiName == MYSTERYBOX_POPUP)))
            {
                this._blockRefresh = false;
                this.requestUpdate();
            };
        }

        private function requestUpdate():void
        {
            this.sysApi.sendAction(new OpenCodesAndGiftRequest());
            this.updateWaitingGiftList(null);
            this.updateGrid();
        }

        private function onDofusShopMoney(ogrins:int):void
        {
            this.lbl_currentOgrines.text = this.utilApi.kamasToString(ogrins, "");
        }

        private function onKeyUp(target:Object, keyCode:uint):void
        {
            if (((this._actualItemData) && (this._tooltipTarget)))
            {
                if (keyCode == KEY_GREATER_THAN)
                {
                    if (this._tooltipCount == (this._actualItemData.length - 1))
                    {
                        this._tooltipCount = 0;
                    }
                    else
                    {
                        this._tooltipCount++;
                    };
                    this.displayPackTooltip(this._tooltipTarget);
                };
            };
        }


    }
} Ankama_Web.ui

