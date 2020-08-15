package Ankama_House
{
    import flash.display.Sprite;
    import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.MapApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import Ankama_House.ui.HouseManager;
    import Ankama_House.ui.HouseSale;
    import Ankama_House.ui.HouseGuildManager;
    import Ankama_House.ui.HavenbagManager;
    import Ankama_House.ui.HavenbagUi;
    import Ankama_House.ui.HavenbagFurnituresTypes;
    import d2hooks.CurrentMap;
    import d2hooks.HouseEntered;
    import d2hooks.HouseExit;
    import d2hooks.HouseSold;
    import d2hooks.HouseSellingUpdate;
    import d2hooks.PurchasableDialog;
    import d2hooks.HouseBuyResult;
    import d2hooks.OpenHouseGuildManager;
    import d2hooks.LockableShowCode;
    import d2hooks.LockableCodeResult;
    import d2hooks.LockableStateUpdateHouseDoor;
    import d2hooks.HavenbagDisplayUi;
    import d2hooks.HavenBagLotteryGift;
    import d2hooks.UiLoaded;
    import d2actions.LockableChangeCode;
    import d2actions.LockableUseCode;
    import d2actions.LeaveDialog;
    import com.ankamagames.dofus.network.enums.LockableResultEnum;
    import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.havenbag.HavenBagRoomPreviewInformation;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
    import com.ankamagames.berilia.enums.StrataEnum;
    import d2hooks.*;
    import d2actions.*;

    public class House extends Sprite 
    {

        public static var currentHouse:HouseWrapper;

        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="MapApi")]
        public var mapApi:MapApi;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        private var include_HouseManager:HouseManager = null;
        private var include_HouseSale:HouseSale = null;
        private var include_HouseGuildManager:HouseGuildManager = null;
        private var include_HavenbagManager:HavenbagManager = null;
        private var include_HavenbagUi:HavenbagUi = null;
        private var include_HavenbagFurnituresTypes:HavenbagFurnituresTypes = null;
        private var _subAreaAlliance:Boolean;
        private var _price:Number = 0;


        public function main():void
        {
            this._price = 0;
            this.sysApi.addHook(CurrentMap, this.onCurrentMap);
            this.sysApi.addHook(HouseEntered, this.houseEntered);
            this.sysApi.addHook(HouseExit, this.houseExit);
            this.sysApi.addHook(HouseSold, this.onHouseSold);
            this.sysApi.addHook(HouseSellingUpdate, this.onHouseSellingUpdate);
            this.sysApi.addHook(PurchasableDialog, this.purchasableDialog);
            this.sysApi.addHook(HouseBuyResult, this.houseBuyResult);
            this.sysApi.addHook(OpenHouseGuildManager, this.onOpenHouseGuildManager);
            this.sysApi.addHook(LockableShowCode, this.lockableShowCode);
            this.sysApi.addHook(LockableCodeResult, this.lockableCodeResult);
            this.sysApi.addHook(LockableStateUpdateHouseDoor, this.lockableStateUpdateHouseDoor);
            this.sysApi.addHook(HavenbagDisplayUi, this.onHavenbagDisplayUi);
            this.sysApi.addHook(HavenBagLotteryGift, this.onHavenBagLotteryGift);
            this.sysApi.addHook(UiLoaded, this.onUiLoaded);
        }

        private function lockableShowCode(changeOrUse:Boolean, codeSize:uint):void
        {
            this.modCommon.openPasswordMenu(codeSize, changeOrUse, this.selectCode, this.codeCancelChange);
        }

        private function selectCode(changeOrUse:Boolean, code:String):void
        {
            if (changeOrUse)
            {
                this.sysApi.sendAction(new LockableChangeCode(code));
            }
            else
            {
                this.sysApi.sendAction(new LockableUseCode(code));
            };
        }

        private function codeCancelChange():void
        {
            this.sysApi.sendAction(new LeaveDialog());
        }

        private function lockableCodeResult(result:uint):void
        {
            if (result == LockableResultEnum.LOCKABLE_UNLOCKED)
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.common.code"), this.uiApi.getText("ui.house.codeChanged"), [this.uiApi.getText("ui.common.ok")]);
            }
            else
            {
                if (result == LockableResultEnum.LOCKABLE_CODE_ERROR)
                {
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.code"), this.uiApi.getText("ui.error.badCode"), [this.uiApi.getText("ui.common.ok")]);
                }
                else
                {
                    if (result == LockableResultEnum.LOCKABLE_UNLOCK_FORBIDDEN)
                    {
                        this.modCommon.openPopup(this.uiApi.getText("ui.common.code"), this.uiApi.getText("ui.error.forbiddenUnlock"), [this.uiApi.getText("ui.common.ok")]);
                    };
                };
            };
        }

        private function lockableStateUpdateHouseDoor(houseId:int, instanceId:int, locked:Boolean):void
        {
            var uiHouseManager:Object = this.uiApi.getUi("houseManager");
            if (uiHouseManager != null)
            {
                uiHouseManager.uiClass.locked = locked;
                uiHouseManager.uiClass.updateIcon();
            };
        }

        private function purchasableDialog(buyOrSell:Boolean, price:Number, houseWrapper:HouseWrapper, instanceId:int):void
        {
            currentHouse = houseWrapper;
            this._price = price;
            if (buyOrSell)
            {
                this.uiApi.loadUi("houseSale", "houseSale", {
                    "buyMode":true,
                    "price":price,
                    "instanceId":instanceId
                });
            }
            else
            {
                this.uiApi.loadUi("houseSale", "houseSale", {
                    "buyMode":false,
                    "inside":false,
                    "price":price,
                    "instanceId":instanceId
                });
            };
        }

        private function houseBuyResult(houseId:uint, bought:Boolean, realPrice:Number, ownerName:String):void
        {
            if (bought)
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.login.news"), this.uiApi.getText("ui.common.houseBuy", this.uiApi.getText("ui.common.houseOwnerName", ownerName), this.utilApi.kamasToString(realPrice, "")), [this.uiApi.getText("ui.common.ok")]);
            }
            else
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.login.news"), this.uiApi.getText("ui.common.cantBuyHouse", this.utilApi.kamasToString(realPrice, "")), [this.uiApi.getText("ui.common.ok")]);
            };
        }

        private function onHouseSellingUpdate(houseId:uint, instanceId:uint, realPrice:Number, buyerName:String):void
        {
            var textSell:String;
            var uiHouseManager:Object = this.uiApi.getUi("houseManager");
            if (uiHouseManager != null)
            {
                uiHouseManager.uiClass.updatePrice(realPrice);
            };
            if (realPrice == 0)
            {
                textSell = this.uiApi.getText("ui.common.houseNosell", this.uiApi.getText("ui.common.houseOwnerName", buyerName));
            }
            else
            {
                textSell = this.uiApi.getText("ui.common.houseSell", this.uiApi.getText("ui.common.houseOwnerName", buyerName), this.utilApi.kamasToString(realPrice, ""));
            };
            this.modCommon.openPopup(this.uiApi.getText("ui.login.news"), textSell, [this.uiApi.getText("ui.common.ok")]);
        }

        private function onHouseSold(houseId:uint, instanceId:uint, realPrice:Number, buyerName:String, subAreaName:String, worldX:int, worldY:int):void
        {
            var uiHouseManager:Object = this.uiApi.getUi("houseManager");
            if (uiHouseManager != null)
            {
                uiHouseManager.uiClass.updatePrice(realPrice);
            };
            var textSell:String = this.uiApi.getText("ui.common.houseSold", subAreaName, worldX, worldY);
            this.modCommon.openPopup(this.uiApi.getText("ui.login.news"), textSell, [this.uiApi.getText("ui.common.ok")]);
        }

        private function houseEntered(isPlayerHouse:Boolean, worldX:int, worldY:int, houseWrapper:HouseWrapper):void
        {
            currentHouse = houseWrapper;
            if (isPlayerHouse)
            {
                if (!this.uiApi.getUi("houseManager"))
                {
                    this.uiApi.loadUi("houseManager", "houseManager", {
                        "houseWrapper":houseWrapper,
                        "subAreaAlliance":this._subAreaAlliance
                    }, 0);
                };
            }
            else
            {
                if (this.uiApi.getUi("houseManager"))
                {
                    this.uiApi.unloadUi("houseManager");
                };
            };
        }

        private function houseExit():void
        {
            if (this.uiApi.getUi("houseManager"))
            {
                this.uiApi.unloadUi("houseManager");
            };
        }

        private function onCurrentMap(pMapId:Number):void
        {
            var prismInfo:PrismSubAreaWrapper;
            var subArea:SubArea = this.mapApi.getMapPositionById(pMapId).subArea;
            this._subAreaAlliance = false;
            if (subArea)
            {
                prismInfo = this.socialApi.getPrismSubAreaById(subArea.id);
                if (((prismInfo) && (!(prismInfo.mapId == -1))))
                {
                    this._subAreaAlliance = true;
                };
            };
        }

        private function onOpenHouseGuildManager(house:HouseWrapper):void
        {
            if (this.uiApi.getUi("houseGuildManager"))
            {
                this.uiApi.unloadUi("houseGuildManager");
            }
            else
            {
                this.uiApi.loadUi("houseGuildManager", "houseGuildManager", house, 3);
            };
        }

        private function onHavenbagDisplayUi(display:Boolean, havenbagCurrentRoomId:uint, havenBagAvailableRooms:Vector.<HavenBagRoomPreviewInformation>, havenbagCurrentRoomThemeId:int, havenbagAvailableThemes:*, havenbagOwnerInfos:CharacterMinimalInformations):void
        {
            if (display)
            {
                this.uiApi.loadUi("havenbagManager", "havenbagManager", {
                    "currentRoomId":havenbagCurrentRoomId,
                    "availableRooms":havenBagAvailableRooms,
                    "currentRoomThemeId":havenbagCurrentRoomThemeId,
                    "availableThemes":havenbagAvailableThemes,
                    "ownerInfos":havenbagOwnerInfos
                });
            }
            else
            {
                this.uiApi.unloadUi("havenbagUi");
                this.uiApi.unloadUi("havenbagFurnituresTypes");
                this.uiApi.unloadUi("havenbagManager");
            };
        }

        private function onHavenBagLotteryGift(pGiftName:String):void
        {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.information"), this.uiApi.getText("ui.common.giftReceived", pGiftName), [this.uiApi.getText("ui.common.ok")]);
        }

        private function onUiLoaded(pUiName:String):void
        {
            if (pUiName == "havenbagManager")
            {
                this.uiApi.loadUi("havenbagUi", null, null, StrataEnum.STRATA_LOW);
                this.uiApi.loadUi("havenbagFurnituresTypes");
            };
        }


    }
}

