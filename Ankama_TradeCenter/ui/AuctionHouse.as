package Ankama_TradeCenter.ui
{
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import d2hooks.UiLoaded;
    import d2hooks.UiUnloaded;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import Ankama_TradeCenter.TradeCenter;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import d2actions.CloseInventory;
    import d2actions.OpenInventory;
    import d2actions.LeaveShopStock;
    import d2actions.BidSwitchToBuyerMode;
    import d2actions.BidSwitchToSellerMode;
    import d2hooks.*;
    import d2actions.*;

    public class AuctionHouse extends Stock 
    {

        public var _sellerDescriptor:Object;
        private var _currentTabUi:String = "";
        public var uiCtr:GraphicContainer;
        public var btn_purchase:ButtonContainer;
        public var btn_sale:ButtonContainer;
        public var lbl_btn_purchase:Label;
        public var lbl_btn_sale:Label;
        public var tx_icon_auctionHouse:Texture;


        override public function main(params:Object=null):void
        {
            this._sellerDescriptor = params.sellerBuyerDescriptor;
            uiApi.me().restoreSnapshotAfterLoading = false;
            sysApi.addHook(UiLoaded, this.onUiLoaded);
            sysApi.addHook(UiUnloaded, this.onUiUnloaded);
            uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.lbl_btn_purchase.text = uiApi.getText("ui.common.purchase");
            this.lbl_btn_sale.text = uiApi.getText("ui.common.sale");
            if (params.sellerBuyerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_COLLAR) != -1)
            {
                this.tx_icon_auctionHouse.uri = uiApi.createUri((uiApi.me().getConstant("texture") + "windowIcon/icon__0039_Equipements_HDV.png"));
            }
            else
            {
                if (params.sellerBuyerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_DRINK) != -1)
                {
                    this.tx_icon_auctionHouse.uri = uiApi.createUri((uiApi.me().getConstant("texture") + "windowIcon/icon__0038_Objets_util_HDV.png"));
                }
                else
                {
                    if (params.sellerBuyerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_WING) != -1)
                    {
                        this.tx_icon_auctionHouse.uri = uiApi.createUri((uiApi.me().getConstant("texture") + "windowIcon/icon__0037_Ressources_HDV.png"));
                    }
                    else
                    {
                        if (params.sellerBuyerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE) != -1)
                        {
                            this.tx_icon_auctionHouse.uri = uiApi.createUri((uiApi.me().getConstant("texture") + "windowIcon/icon__0041_runes_HDV.png"));
                        }
                        else
                        {
                            if (params.sellerBuyerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_EMPTY_SOULSTONE) != -1)
                            {
                                this.tx_icon_auctionHouse.uri = uiApi.createUri((uiApi.me().getConstant("texture") + "windowIcon/icon__0042_pierre_ame_HDV.png"));
                            }
                            else
                            {
                                if (params.sellerBuyerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_DRAGOTURKEY_CERTIFICATE) != -1)
                                {
                                    this.tx_icon_auctionHouse.uri = uiApi.createUri((uiApi.me().getConstant("texture") + "windowIcon/icon__0040_creatures_HDV.png"));
                                };
                            };
                        };
                    };
                };
            };
            if (this._currentTabUi == "")
            {
                if (TradeCenter.BID_HOUSE_BUY_MODE)
                {
                    this.openTab(UIEnum.AUCTIONHOUSE_BUY, params);
                }
                else
                {
                    this.openTab(UIEnum.AUCTIONHOUSE_SELL, params);
                };
            };
        }

        public function onUiLoaded(uiName:String):void
        {
            if (uiName == UIEnum.STORAGE_UI)
            {
                uiApi.me().setOnTop();
                uiApi.me().setOnTopBeforeMe.push(uiApi.getUi(UIEnum.STORAGE_UI));
            };
        }

        public function onUiUnloaded(pUiName:String):void
        {
            if (pUiName == UIEnum.STORAGE_UI)
            {
                uiApi.me().setOnTopBeforeMe = [];
            };
        }

        override public function unload():void
        {
            TradeCenter.SEARCH_MODE = false;
            sysApi.setData("BetaModeAuctionHouseAlreadyDisplayed", true, DataStoreEnum.BIND_ACCOUNT);
            sysApi.sendAction(new CloseInventory());
            if (this._currentTabUi != "")
            {
                this.closeTab(this._currentTabUi);
            };
            uiApi.hideTooltip();
        }

        public function openTab(tab:String, params:Object=null):void
        {
            if (this._currentTabUi == tab)
            {
                return;
            };
            if (this._currentTabUi != "")
            {
                uiApi.unloadUi(this._currentTabUi);
            };
            if (tab == "")
            {
                this._currentTabUi = UIEnum.AUCTIONHOUSE_BUY;
            }
            else
            {
                this._currentTabUi = tab;
            };
            if (this._currentTabUi == UIEnum.AUCTIONHOUSE_BUY)
            {
                uiApi.loadUiInside(this._currentTabUi, this.uiCtr, UIEnum.AUCTIONHOUSE_BUY, params);
            }
            else
            {
                if (this._currentTabUi == UIEnum.AUCTIONHOUSE_SELL)
                {
                    uiApi.loadUiInside(this._currentTabUi, this.uiCtr, UIEnum.AUCTIONHOUSE_SELL, params);
                };
            };
            if (!uiApi.getUi(UIEnum.STORAGE_UI))
            {
                sysApi.sendAction(new OpenInventory("bidHouse"));
            }
            else
            {
                uiApi.getUi(UIEnum.STORAGE_UI).uiClass.associateUi();
            };
            uiApi.setRadioGroupSelectedItem("tabHGroup", this.getButtonByTab(this._currentTabUi), uiApi.me());
            this.getButtonByTab(this._currentTabUi).selected = true;
        }

        private function closeTab(tab:String):void
        {
            uiApi.unloadUi(tab);
        }

        private function getButtonByTab(tab:String):ButtonContainer
        {
            var returnButton:ButtonContainer;
            switch (tab)
            {
                case UIEnum.AUCTIONHOUSE_BUY:
                    returnButton = this.btn_purchase;
                    break;
                case UIEnum.AUCTIONHOUSE_SELL:
                    returnButton = this.btn_sale;
                    break;
            };
            return (returnButton);
        }

        public function isSwitching():Boolean
        {
            return (TradeCenter.SWITCH_MODE);
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case btn_close:
                    sysApi.sendAction(new LeaveShopStock());
                    uiApi.unloadUi(uiApi.me().name);
                    break;
                case this.btn_purchase:
                    if (!TradeCenter.BID_HOUSE_BUY_MODE)
                    {
                        TradeCenter.SWITCH_MODE = true;
                        TradeCenter.BID_HOUSE_BUY_MODE = true;
                        sysApi.sendAction(new BidSwitchToBuyerMode());
                    };
                    break;
                case this.btn_sale:
                    if (TradeCenter.BID_HOUSE_BUY_MODE)
                    {
                        TradeCenter.SWITCH_MODE = true;
                        TradeCenter.BID_HOUSE_BUY_MODE = false;
                        sysApi.sendAction(new BidSwitchToSellerMode());
                    };
                    break;
            };
        }

        override protected function onShortcut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                sysApi.sendAction(new LeaveShopStock());
                uiApi.unloadUi(uiApi.me().name);
                return (true);
            };
            return (false);
        }


    }
}

