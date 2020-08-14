package Ankama_Mount
{
    import flash.display.Sprite;
    import Ankama_Mount.ui.MountInfo;
    import Ankama_Mount.ui.MountAncestors;
    import Ankama_Mount.ui.MountPaddock;
    import Ankama_Mount.ui.PaddockSellBuy;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import d2hooks.OpenMount;
    import d2hooks.ExchangeStartOkMount;
    import d2hooks.CertificateMountData;
    import d2hooks.PaddockedMountData;
    import d2hooks.PaddockBuyResult;
    import d2hooks.ViewMountAncestors;
    import d2hooks.CurrentMap;
    import d2hooks.GameFightStarting;
    import d2hooks.PaddockSellBuyDialog;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMount;
    import d2actions.MountInfoRequest;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import d2hooks.*;

    public class Mount extends Sprite 
    {

        private var include_mountInfo:MountInfo;
        private var include_mountAncestors:MountAncestors;
        private var include_mountPaddock:MountPaddock;
        private var include_paddockSellBuy:PaddockSellBuy;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        private var _mountIdWaitingForAncestors:Number = 0;


        public function main():void
        {
            this.sysApi.addHook(OpenMount, this.onOpenMount);
            this.sysApi.addHook(ExchangeStartOkMount, this.onExchangeStartOkMount);
            this.sysApi.addHook(CertificateMountData, this.onCertificateMountData);
            this.sysApi.addHook(PaddockedMountData, this.onCertificateMountData);
            this.sysApi.addHook(PaddockBuyResult, this.paddockBuyResult);
            this.sysApi.addHook(ViewMountAncestors, this.onViewMountAncestors);
            this.sysApi.addHook(CurrentMap, this.onCurrentMap);
            this.sysApi.addHook(GameFightStarting, this.onGameFightStarting);
            this.sysApi.addHook(PaddockSellBuyDialog, this.onPaddockSellBuyDialog);
        }

        private function onExchangeStartOkMount(stabledList:Object, paddockedList:Object):void
        {
            this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
            var paddockUi:Object = this.uiApi.getUi("mountPaddock");
            if (paddockUi)
            {
                paddockUi.uiClass.showUi(stabledList, paddockedList);
            }
            else
            {
                this.uiApi.loadUi("mountPaddock", "mountPaddock", {
                    "stabledList":stabledList,
                    "paddockedList":paddockedList
                }, StrataEnum.STRATA_TOP);
            };
        }

        private function onCurrentMap(mapId:Number):void
        {
            this.uiApi.unloadUi("mountPaddock");
        }

        private function onGameFightStarting(fightType:uint):void
        {
            this.uiApi.unloadUi("mountPaddock");
        }

        private function onOpenMount():void
        {
            var mountPaddock:Object;
            var mountInfo:Object = this.uiApi.getUi(UIEnum.MOUNT_INFO);
            if (mountInfo)
            {
                mountPaddock = this.uiApi.getUi("mountPaddock");
                if (((!(mountPaddock)) || (mountPaddock.uiClass.visible == false)))
                {
                    if (mountInfo.visible == false)
                    {
                        mountInfo.visible = true;
                    }
                    else
                    {
                        this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
                    };
                    this.uiApi.unloadUi(UIEnum.MOUNT_ANCESTORS);
                }
                else
                {
                    if (mountInfo.visible == false)
                    {
                        mountPaddock.uiClass.showCurrentMountInfo();
                        mountInfo.visible = true;
                    };
                };
            }
            else
            {
                if (this.uiApi.getUi(UIEnum.MOUNT_INFO))
                {
                    this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
                };
                if (this.playerApi.getMount())
                {
                    this.uiApi.loadUi(UIEnum.MOUNT_INFO, UIEnum.MOUNT_INFO, {
                        "paddockMode":false,
                        "posX":890,
                        "posY":150,
                        "mountData":this.playerApi.getMount()
                    });
                };
            };
        }

        private function onPaddockSellBuyDialog(sellMode:Boolean, ownerId:Number, price:Number, ... args):void
        {
            this.uiApi.loadUi("paddockSellBuy", "paddockSellBuy", {
                "sellMode":sellMode,
                "id":ownerId,
                "price":price
            });
        }

        private function paddockBuyResult(paddockId:Number, bought:Boolean, realPrice:Number):void
        {
            if (bought)
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.login.news"), this.uiApi.getText("ui.common.houseBuy", this.uiApi.getText("ui.common.mountPark"), this.utilApi.kamasToString(realPrice, "")), [this.uiApi.getText("ui.common.ok")]);
            }
            else
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.login.news"), this.uiApi.getText("ui.common.cantBuyPaddock", this.utilApi.kamasToString(realPrice, "")), [this.uiApi.getText("ui.common.ok")]);
            };
        }

        private function onCertificateMountData(mount:Object):void
        {
            if (this._mountIdWaitingForAncestors > 0)
            {
                if (!this.uiApi.getUi(UIEnum.MOUNT_ANCESTORS))
                {
                    this.uiApi.loadUi(UIEnum.MOUNT_ANCESTORS, UIEnum.MOUNT_ANCESTORS, {"mount":mount}, StrataEnum.STRATA_TOP);
                };
                this._mountIdWaitingForAncestors = 0;
                return;
            };
            var mountPaddockUi:Object = this.uiApi.getUi("mountPaddock");
            if (((!(mountPaddockUi)) || (!(mountPaddockUi.uiClass.visible))))
            {
                if (this.uiApi.getUi(UIEnum.MOUNT_INFO))
                {
                    this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
                };
                this.uiApi.loadUi(UIEnum.MOUNT_INFO, UIEnum.MOUNT_INFO, {
                    "centeredMode":true,
                    "posX":550,
                    "posY":150,
                    "mountData":mount
                });
            }
            else
            {
                mountPaddockUi.uiClass.showMountInfo(mount, 1);
            };
        }

        private function onViewMountAncestors(item:ItemWrapper):void
        {
            var effect:EffectInstance;
            if ((((!(item)) || (!(item.effects))) || (item.effects.length == 0)))
            {
                return;
            };
            for each (effect in item.effects)
            {
                if ((effect is EffectInstanceMount))
                {
                    this._mountIdWaitingForAncestors = (effect as EffectInstanceMount).id;
                };
            };
            this.sysApi.sendAction(new MountInfoRequest(item));
        }

        private function onPaddockedMountData(mount:Object):void
        {
            if (this.uiApi.getUi(UIEnum.MOUNT_INFO))
            {
                this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
            };
            this.uiApi.loadUi(UIEnum.MOUNT_INFO, UIEnum.MOUNT_INFO, {
                "centeredMode":true,
                "posX":452,
                "posY":152,
                "mountData":mount
            });
        }


    }
} Ankama_Mount

