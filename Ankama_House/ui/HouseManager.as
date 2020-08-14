package Ankama_House.ui
{
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Texture;
    import d2enums.ComponentHookList;
    import d2actions.HouseLockFromInside;
    import d2actions.*;

    public class HouseManager 
    {

        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        private var _house:HouseWrapper;
        private var _price:Number;
        private var _ownerName:String;
        private var _playerHasGuild:Boolean;
        private var _houseWithNoOwner:Boolean;
        private var _locked:Boolean;
        public var mainCtr:GraphicContainer;
        public var btnHouse:ButtonContainer;
        public var txHouse:Texture;
        public var txHouseSell:Texture;
        public var txHouseLock:Texture;


        public function main(param:Object):void
        {
            this.uiApi.addComponentHook(this.mainCtr, ComponentHookList.ON_RELEASE);
            this._house = param.houseWrapper;
            this._ownerName = this._house.houseInstances[0].ownerName;
            this._price = this._house.houseInstances[0].price;
            this._locked = this._house.houseInstances[0].isLocked;
            this.txHouse.mouseEnabled = false;
            this.txHouse.mouseChildren = false;
            this.txHouseSell.mouseEnabled = false;
            this.txHouseSell.mouseChildren = false;
            this.txHouseLock.mouseEnabled = false;
            this.txHouseLock.mouseChildren = false;
            this._houseWithNoOwner = ((this._ownerName == "") || (this._ownerName == "?"));
            this.updateIcon();
            this._playerHasGuild = this.socialApi.hasGuild();
            if (param.subAreaAlliance)
            {
                this.mainCtr.y = (this.mainCtr.y + 50);
            };
        }

        public function unload():void
        {
            this.modCommon.closeAllMenu();
        }

        public function get locked():Boolean
        {
            return (this._locked);
        }

        public function set locked(l:Boolean):void
        {
            this._locked = l;
        }

        public function updatePrice(price:Number):void
        {
            this._price = price;
            this._house.houseInstances[0].price = price;
            this.updateIcon();
        }

        public function updateIcon():void
        {
            if (this._price == 0)
            {
                if (this._locked)
                {
                    this.txHouseLock.visible = true;
                    this.txHouse.x = 10;
                }
                else
                {
                    this.txHouse.x = 25;
                    this.txHouseLock.visible = false;
                };
                this.txHouseSell.visible = false;
            }
            else
            {
                this.txHouse.x = 10;
                this.txHouseSell.visible = true;
                this.txHouseLock.visible = false;
            };
        }

        private function displayHousePrice():void
        {
            this.uiApi.loadUi("houseSale", "houseSale", {
                "buyMode":false,
                "inside":true,
                "price":this._price,
                "instanceId":this._house.houseInstances[0].id
            }, 3);
        }

        private function displayUiHouseGuildManager():void
        {
            this.uiApi.loadUi("houseGuildManager", "houseGuildManager", this._house, 3);
        }

        private function displayPasswordMenu():void
        {
            this.modCommon.openPasswordMenu(8, true, this.codeUpdate);
        }

        private function codeUpdate(change:Boolean, code:String):void
        {
            this.sysApi.sendAction(new HouseLockFromInside(code));
        }

        public function onRelease(target:Object):void
        {
            var list:Array;
            var sellDisabled:Boolean;
            if (((!(this.uiApi.getUi("houseGuildManager"))) && (!(this.uiApi.getUi("houseSale")))))
            {
                list = new Array();
                sellDisabled = false;
                if (this._houseWithNoOwner)
                {
                    list.push(this.modCommon.createContextMenuTitleObject(this.uiApi.getText("ui.common.houseWithNoOwner")));
                }
                else
                {
                    list.push(this.modCommon.createContextMenuTitleObject(this.uiApi.getText("ui.common.houseOwnerName", this._ownerName)));
                };
                if (this._price == 0)
                {
                    list.push(this.modCommon.createContextMenuItemObject(this.uiApi.getText("ui.common.sell"), this.displayHousePrice, null, sellDisabled, null));
                }
                else
                {
                    list.push(this.modCommon.createContextMenuItemObject(this.uiApi.getText("ui.common.changeHousePrice"), this.displayHousePrice, null, sellDisabled));
                };
                if (this._locked)
                {
                    list.push(this.modCommon.createContextMenuItemObject(this.uiApi.getText("ui.common.unlock"), this.displayPasswordMenu, null, false, null));
                }
                else
                {
                    list.push(this.modCommon.createContextMenuItemObject(this.uiApi.getText("ui.common.lock"), this.displayPasswordMenu, null, false, null));
                };
                if (((this._playerHasGuild) || (this._house.houseInstances[0].guildIdentity)))
                {
                    list.push(this.modCommon.createContextMenuItemObject(this.uiApi.getText("ui.common.guildHouseConfiguration"), this.displayUiHouseGuildManager, null, false, null));
                };
                this.modCommon.createContextMenu(list);
            };
        }


    }
} Ankama_House.ui

