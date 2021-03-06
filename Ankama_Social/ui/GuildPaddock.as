package Ankama_Social.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.MapApi;
    import com.ankamagames.dofus.uiApi.MountApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import d2hooks.GuildInformationsFarms;
    import d2hooks.CurrentMap;
    import d2actions.GuildGetInformations;
    import com.ankamagames.dofus.network.enums.GuildInformationsTypeEnum;
    import com.ankamagames.berilia.enums.StatesEnum;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import d2actions.GuildFarmTeleportRequest;
    import d2hooks.*;
    import d2actions.*;

    public class GuildPaddock 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="MapApi")]
        public var mapApi:MapApi;
        [Api(name="MountApi")]
        public var mountApi:MountApi;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        private var _selectedPaddock:Object;
        public var grid_paddock:Grid;
        public var grid_mount:Grid;
        public var lbl_subarea:Label;
        public var btn_join:ButtonContainer;


        public function main(... params):void
        {
            this.btn_join.soundId = SoundEnum.SPEC_BUTTON;
            this.sysApi.addHook(GuildInformationsFarms, this.onGuildInformationsFarms);
            this.sysApi.addHook(CurrentMap, this.onCurrentMap);
            this.uiApi.addComponentHook(this.btn_join, "onRelease");
            this.uiApi.addComponentHook(this.grid_mount, "onSelectItem");
            this.uiApi.addComponentHook(this.grid_mount, "onItemRollOver");
            this.uiApi.addComponentHook(this.grid_mount, "onItemRollOut");
            this.uiApi.addComponentHook(this.grid_paddock, "onSelectItem");
            this.sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_PADDOCKS));
            this.lbl_subarea.text = "";
            this.btn_join.disabled = true;
        }

        public function unload():void
        {
        }

        public function updatePaddockLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (data)
            {
                if (data.paddock.abandonned)
                {
                    componentsRef.tx_abandonned.visible = true;
                    this.uiApi.addComponentHook(componentsRef.tx_abandonned, "onRollOver");
                    this.uiApi.addComponentHook(componentsRef.tx_abandonned, "onRollOut");
                }
                else
                {
                    componentsRef.tx_abandonned.visible = false;
                };
                componentsRef.lbl_name.text = data.text;
                componentsRef.lbl_items.text = ((data.paddock.maxItems + " ") + this.uiApi.getText("ui.common.maxWord"));
                componentsRef.lbl_mounts.text = ((data.paddock.mountsInformations.length + "/") + data.paddock.maxOutdoorMount);
                componentsRef.btn_paddock.visible = true;
                componentsRef.btn_paddock.selected = selected;
                componentsRef.btn_paddock.state = ((selected) ? StatesEnum.STATE_SELECTED : StatesEnum.STATE_NORMAL);
            }
            else
            {
                componentsRef.tx_abandonned.visible = false;
                componentsRef.lbl_name.text = "";
                componentsRef.btn_paddock.visible = false;
                componentsRef.btn_paddock.selected = false;
            };
        }

        public function updateMountLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (data)
            {
                componentsRef.lbl_mountType.text = this.mountApi.getMount(data.modelId).name;
                componentsRef.lbl_owner.text = data.ownerName;
            }
            else
            {
                componentsRef.lbl_mountType.text = "";
                componentsRef.lbl_owner.text = "";
            };
        }

        private function onGuildInformationsFarms():void
        {
            var paddock:PaddockContentInformations;
            var x:int;
            var y:int;
            var subArea:SubArea;
            var provider:Array = new Array();
            var farmsInformations:Object = this.socialApi.getGuildPaddocks();
            var nb:int = farmsInformations.length;
            var i:int;
            while (i < nb)
            {
                paddock = farmsInformations[i];
                if (paddock.worldX)
                {
                    x = paddock.worldX;
                }
                else
                {
                    x = this.mapApi.getMapCoords(paddock.mapId).x;
                };
                if (paddock.worldY)
                {
                    y = paddock.worldY;
                }
                else
                {
                    y = this.mapApi.getMapCoords(paddock.mapId).y;
                };
                subArea = this.dataApi.getSubArea(paddock.subAreaId);
                provider.push({
                    "paddock":paddock,
                    "text":(((((((subArea.area.name + " (") + subArea.name) + ") (") + x) + ", ") + y) + ")"),
                    "areaId":subArea.areaId,
                    "subAreaName":subArea.name,
                    "mapId":paddock.mapId
                });
                i++;
            };
            provider.sortOn(["areaId", "subAreaName", "mapId"], [Array.NUMERIC, Array.CASEINSENSITIVE, Array.NUMERIC]);
            this.grid_paddock.dataProvider = provider;
            if (farmsInformations.length == 0)
            {
                this.grid_mount.dataProvider = new Array();
            };
        }

        private function onPaddockSelected(paddock:Object):void
        {
            var mount:Object;
            this._selectedPaddock = paddock;
            this.btn_join.disabled = false;
            var mountList:Array = new Array();
            for each (mount in paddock.mountsInformations)
            {
                mountList.push(mount);
            };
            this.grid_mount.dataProvider = mountList;
            this.lbl_subarea.text = ((this.uiApi.getText("ui.common.mountPark") + "\n") + this.dataApi.getSubArea(paddock.subAreaId).name);
        }

        private function onCurrentMap(mapId:Number):void
        {
            this.uiApi.unloadUi("socialBase");
        }

        public function showTabHints():void
        {
            this.hintsApi.showSubHints();
        }

        public function onRelease(target:Object):void
        {
            if (target == this.btn_join)
            {
                if (this._selectedPaddock != null)
                {
                    this.sysApi.sendAction(new GuildFarmTeleportRequest(this._selectedPaddock.paddockId));
                    this.uiApi.unloadUi("socialBase");
                };
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (target == this.grid_paddock)
            {
                this.onPaddockSelected(this.grid_paddock.dataProvider[target.selectedIndex].paddock);
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            if (target.name.indexOf("tx_abandonned") != -1)
            {
                text = this.uiApi.getText("ui.social.paddockWithNoOwner");
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var name:String;
            if (((item) && (item.data)))
            {
                if (item.data.name)
                {
                    name = item.data.name;
                }
                else
                {
                    name = this.uiApi.getText("ui.common.noName");
                };
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(name), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }


    }
}

