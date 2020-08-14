package Ankama_House.ui
{
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.berilia.components.TextArea;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.dofus.internalDatacenter.house.HouseInstanceWrapper;
    import d2hooks.LeaveDialog;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import Ankama_House.House;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import d2enums.ComponentHookList;
    import d2actions.LeaveDialog;
    import d2actions.HouseSellFromInside;
    import d2actions.HouseSell;
    import d2actions.HouseBuy;
    import d2hooks.*;
    import d2actions.*;

    public class HouseSale 
    {

        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        private var _price:Number = 0;
        private var _inside:Boolean;
        private var _instanceId:int;
        private var _buyMode:Boolean;
        private var _houseWrapper:HouseWrapper;
        private var _houseName:String;
        public var btnClose:ButtonContainer;
        public var lbl_title:Label;
        public var btnValidate:ButtonContainer;
        public var btnCancelTheSale:ButtonContainer;
        public var inputPrice:Input;
        public var lblOwnerName:Label;
        public var lblHouseInfo:TextArea;
        public var tx_houseIcon:Texture;
        public var mask_houseIcon:GraphicContainer;
        public var btn_help:ButtonContainer;


        public function main(param:Object):void
        {
            var houseInstance:HouseInstanceWrapper;
            var instance:HouseInstanceWrapper;
            this.sysApi.addHook(d2hooks.LeaveDialog, this.onLeaveDialog);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortCut);
            this._price = param.price;
            this._inside = param.inside;
            this._buyMode = param.buyMode;
            this._instanceId = param.instanceId;
            this._houseWrapper = House.currentHouse;
            if (this._buyMode)
            {
                this.lbl_title.text = this.uiApi.getText("ui.common.housePurchase");
            }
            else
            {
                this.lbl_title.text = this.uiApi.getText("ui.common.houseSale");
            };
            this.inputPrice.restrict = "0-9";
            this.inputPrice.numberMax = ProtocolConstantsEnum.MAX_KAMA;
            if (this._price == 0)
            {
                this.btnCancelTheSale.disabled = true;
                this.inputPrice.text = this.utilApi.kamasToString(this._houseWrapper.defaultPrice);
            }
            else
            {
                this.inputPrice.text = this.utilApi.kamasToString(this._price, "");
                if (this._buyMode)
                {
                    this.inputPrice.mouseChildren = false;
                    this.btnCancelTheSale.disabled = true;
                    this.btnValidate.disabled = (this._price > this.playerApi.characteristics().kamas);
                }
                else
                {
                    this.btnCancelTheSale.disabled = false;
                    this.inputPrice.focus();
                };
            };
            for each (instance in this._houseWrapper.houseInstances)
            {
                if (instance.id == this._instanceId)
                {
                    houseInstance = instance;
                    break;
                };
            };
            if (houseInstance.ownerName == "?")
            {
                this._houseName = this.uiApi.getText("ui.common.houseWithNoOwner");
            }
            else
            {
                if (houseInstance.ownerName == "")
                {
                    this._houseName = this.uiApi.getText("ui.common.houseForSale");
                }
                else
                {
                    this._houseName = this.uiApi.getText("ui.common.houseOwnerName", houseInstance.ownerName);
                };
            };
            this.lblOwnerName.text = this._houseName;
            var info:String = this._houseWrapper.name;
            if (this._houseWrapper.description)
            {
                info = (info + ("\n\n" + this._houseWrapper.description));
            };
            this.lblHouseInfo.text = info;
            this.lblHouseInfo.wordWrap = true;
            this.tx_houseIcon.uri = this._houseWrapper.iconUri;
            this.tx_houseIcon.mask = this.mask_houseIcon;
            this.uiApi.addComponentHook(this.btnClose, "onRelease");
            this.uiApi.addComponentHook(this.btnValidate, "onRelease");
            this.uiApi.addComponentHook(this.btnCancelTheSale, "onRelease");
            this.uiApi.addComponentHook(this.btn_help, ComponentHookList.ON_RELEASE);
            this.sysApi.disableWorldInteraction();
        }

        public function onRelease(target:Object):void
        {
            var price:Number;
            switch (target)
            {
                case this.btnClose:
                    if (!this._inside)
                    {
                        this.sysApi.sendAction(new d2actions.LeaveDialog());
                    };
                    this.uiApi.unloadUi("houseSale");
                    return;
                case this.btnValidate:
                    price = this.utilApi.stringToKamas(this.inputPrice.text, "");
                    if (this._buyMode)
                    {
                        this._price = price;
                        this.modCommon.openPopup(this.uiApi.getText("ui.common.housePurchase"), this.uiApi.getText("ui.common.doUBuyHouse", this._houseName, this.utilApi.kamasToString(price, "")), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmHouseBuy, null]);
                    }
                    else
                    {
                        if (price == 0)
                        {
                            if (this._inside)
                            {
                                this.sysApi.sendAction(new HouseSellFromInside(this._instanceId, price));
                            }
                            else
                            {
                                this.sysApi.sendAction(new HouseSell(this._instanceId, price));
                            };
                            this.uiApi.unloadUi("houseSale");
                        }
                        else
                        {
                            if (this._inside)
                            {
                                this.sysApi.sendAction(new HouseSellFromInside(this._instanceId, price));
                            }
                            else
                            {
                                this.sysApi.sendAction(new HouseSell(this._instanceId, price));
                            };
                            this.uiApi.unloadUi("houseSale");
                        };
                    };
                    return;
                case this.btnCancelTheSale:
                    if (this._inside)
                    {
                        this.sysApi.sendAction(new HouseSellFromInside(this._instanceId, price, false));
                    }
                    else
                    {
                        this.sysApi.sendAction(new HouseSell(this._instanceId, price, false));
                    };
                    this.uiApi.unloadUi("houseSale");
                    return;
                case this.btn_help:
                    this.hintsApi.showSubHints();
                    break;
            };
        }

        private function onShortCut(s:String):Boolean
        {
            if (s == ShortcutHookListEnum.CLOSE_UI)
            {
                if (!this._inside)
                {
                    this.sysApi.sendAction(new d2actions.LeaveDialog());
                };
                this.uiApi.unloadUi("houseSale");
                return (true);
            };
            return (false);
        }

        private function onConfirmHouseBuy():void
        {
            this.sysApi.sendAction(new HouseBuy(this._price));
            this.uiApi.unloadUi("houseSale");
        }

        public function unload():void
        {
            this.sysApi.enableWorldInteraction();
        }

        private function onLeaveDialog():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }


    }
} Ankama_House.ui

