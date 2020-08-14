package Ankama_Exchange
{
    import flash.display.Sprite;
    import Ankama_Exchange.ui.ExchangeUi;
    import Ankama_Exchange.ui.ExchangeNPCUi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.StorageApi;
    import d2hooks.ExchangeRequestCharacterFromMe;
    import d2hooks.ExchangeRequestCharacterToMe;
    import d2hooks.ExchangeLeave;
    import d2hooks.ExchangeStarted;
    import d2hooks.CloseInventory;
    import d2hooks.ExchangeStartOkNpcTrade;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import d2hooks.UiUnloaded;
    import d2actions.CloseInventory;
    import d2hooks.OpenInventory;
    import d2actions.OpenInventory;
    import d2actions.ExchangeAccept;
    import d2actions.ExchangeRefuse;
    import d2actions.AddIgnored;
    import d2hooks.*;
    import d2actions.*;

    public class Exchange extends Sprite 
    {

        protected var exchangeUi:ExchangeUi = null;
        protected var exchangeNPCUi:ExchangeNPCUi = null;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="StorageApi")]
        public var storageApi:StorageApi;
        private var _playerName:String;
        private var _ignoreName:String;
        private var _popupName:String;
        private var _waitStorageUnloadData:Object;


        public function main():void
        {
            this.sysApi.addHook(ExchangeRequestCharacterFromMe, this.onExchangeRequestCharacterFromMe);
            this.sysApi.addHook(ExchangeRequestCharacterToMe, this.onExchangeRequestCharacterToMe);
            this.sysApi.addHook(ExchangeLeave, this.onExchangeLeave);
            this.sysApi.addHook(ExchangeStarted, this.onExchangeStarted);
            this.sysApi.addHook(d2hooks.CloseInventory, this.onCloseInventory);
            this.sysApi.addHook(ExchangeStartOkNpcTrade, this.onExchangeStartOkNpcTrade);
        }

        private function onCloseInventory(uiName:String="storage"):void
        {
            if (((uiName === UIEnum.STORAGE_UI) && (this.uiApi.getUi(UIEnum.EXCHANGE_UI))))
            {
                this.uiApi.unloadUi(UIEnum.EXCHANGE_UI);
            };
        }

        private function onExchangeStarted(pSourceName:String, pTargetName:String, pSourceLook:Object, pTargetLook:Object, pSourceCurrentPods:int, pTargetCurrentPods:int, pSourceMaxPods:int, pTargetMaxPods:int, otherId:Number):void
        {
            if (this.uiApi.getUi(UIEnum.STORAGE_UI))
            {
                this._waitStorageUnloadData = new Object();
                this._waitStorageUnloadData.pSourceName = pSourceName;
                this._waitStorageUnloadData.pTargetName = pTargetName;
                this._waitStorageUnloadData.pSourceLook = pSourceLook;
                this._waitStorageUnloadData.pTargetLook = pTargetLook;
                this._waitStorageUnloadData.pSourceCurrentPods = pSourceCurrentPods;
                this._waitStorageUnloadData.pTargetCurrentPods = pTargetCurrentPods;
                this._waitStorageUnloadData.pSourceMaxPods = pSourceMaxPods;
                this._waitStorageUnloadData.pTargetMaxPods = pTargetMaxPods;
                this._waitStorageUnloadData.otherId = otherId;
                this.sysApi.addHook(UiUnloaded, this.onUiUnloaded);
                this.uiApi.unloadUi(UIEnum.STORAGE_UI);
            }
            else
            {
                this.loadExchangeUi(pSourceName, pTargetName, pSourceLook, pTargetLook, pSourceCurrentPods, pTargetCurrentPods, pSourceMaxPods, pTargetMaxPods, otherId);
            };
        }

        private function onUiUnloaded(name:String):void
        {
            if (name == UIEnum.STORAGE_UI)
            {
                if (this._waitStorageUnloadData)
                {
                    this.loadExchangeUi(this._waitStorageUnloadData.pSourceName, this._waitStorageUnloadData.pTargetName, this._waitStorageUnloadData.pSourceLook, this._waitStorageUnloadData.pTargetLook, this._waitStorageUnloadData.pSourceCurrentPods, this._waitStorageUnloadData.pTargetCurrentPods, this._waitStorageUnloadData.pSourceMaxPods, this._waitStorageUnloadData.pTargetMaxPods, this._waitStorageUnloadData.otherId);
                    this._waitStorageUnloadData = null;
                    this.sysApi.removeHook(UiUnloaded);
                };
            };
        }

        private function loadExchangeUi(pSourceName:String, pTargetName:String, pSourceLook:Object, pTargetLook:Object, pSourceCurrentPods:int, pTargetCurrentPods:int, pSourceMaxPods:int, pTargetMaxPods:int, otherId:Number):void
        {
            if (this._playerName == pSourceName)
            {
                this.uiApi.unloadUi(this._popupName);
            };
            if (this.uiApi.getUi(UIEnum.STORAGE_UI))
            {
                this.sysApi.log(8, "L'interface de stocage aurait du avoir été préalablement déchargé.");
                return;
            };
            if (this.uiApi.getUi(UIEnum.INVENTORY_UI))
            {
                this.sysApi.sendAction(new d2actions.CloseInventory(UIEnum.INVENTORY_UI));
            };
            this.uiApi.loadUi(UIEnum.EXCHANGE_UI, UIEnum.EXCHANGE_UI, {
                "sourceName":pSourceName,
                "targetName":pTargetName,
                "sourceLook":pSourceLook,
                "targetLook":pTargetLook,
                "sourceCurrentPods":pSourceCurrentPods,
                "targetCurrentPods":pTargetCurrentPods,
                "sourceMaxPods":pSourceMaxPods,
                "targetMaxPods":pTargetMaxPods,
                "otherId":otherId
            });
            this.sysApi.dispatchHook(d2hooks.OpenInventory, "exchange", UIEnum.STORAGE_UI);
        }

        protected function showUi():void
        {
            if (this.uiApi.getUi(UIEnum.INVENTORY_UI))
            {
                this.sysApi.sendAction(new d2actions.CloseInventory(UIEnum.INVENTORY_UI));
            };
            this.uiApi.loadUi(UIEnum.EXCHANGE_UI, UIEnum.EXCHANGE_UI);
        }

        protected function onExchangeRequestCharacterFromMe(myName:String, yourName:String):void
        {
            this._playerName = myName;
            this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.exchange.requestInProgress"), this.uiApi.getText("ui.exchange.requestInProgress"), [this.uiApi.getText("ui.common.cancel")], [this.sendActionExchangeRefuse], null, this.sendActionExchangeRefuse);
        }

        protected function onExchangeRequestCharacterToMe(pTargetName:String, pSourceName:String):void
        {
            this._playerName = pTargetName;
            this._ignoreName = pSourceName;
            this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.exchange.exchangeRequest"), this.uiApi.getText("ui.exchange.resquestMessage", pSourceName), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no"), this.uiApi.getText("ui.common.ignore")], [this.sendActionExchangeAccept, this.sendActionExchangeRefuse, this.sendActionIgnore], this.sendActionExchangeAccept, this.sendActionExchangeRefuse);
        }

        protected function onExchangeLeave(success:Boolean):void
        {
            this.sysApi.enableWorldInteraction();
            if (((!(success)) && (this.uiApi.getUi(this._popupName))))
            {
                this.uiApi.unloadUi(this._popupName);
            };
        }

        private function onExchangeStartOkNpcTrade(pNPCId:uint, pSourceName:String, pTargetName:String, pSourceLook:Object, pTargetLook:Object):void
        {
            if (this.uiApi.getUi(UIEnum.INVENTORY_UI))
            {
                this.sysApi.sendAction(new d2actions.CloseInventory(UIEnum.INVENTORY_UI));
            };
            this.sysApi.disableWorldInteraction();
            this.uiApi.loadUi(UIEnum.EXCHANGE_NPC_UI, UIEnum.EXCHANGE_NPC_UI, {
                "sourceName":pSourceName,
                "targetName":pTargetName,
                "sourceLook":pSourceLook,
                "targetLook":pTargetLook
            });
            this.sysApi.sendAction(new d2actions.OpenInventory("exchangeNpc"));
        }

        private function sendActionExchangeAccept():void
        {
            this.sysApi.sendAction(new ExchangeAccept());
        }

        private function sendActionExchangeRefuse():void
        {
            this.sysApi.sendAction(new ExchangeRefuse());
        }

        private function sendActionIgnore():void
        {
            this.sysApi.sendAction(new ExchangeRefuse());
            this.sysApi.sendAction(new AddIgnored(this._ignoreName));
        }


    }
} Ankama_Exchange

