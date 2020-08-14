package Ankama_House.ui
{
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.ConfigApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.havenbag.HavenBagRoomPreviewInformation;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
    import flash.geom.Point;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.dofus.datacenter.houses.HavenbagTheme;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import d2hooks.HavenbagExitEditMode;
    import d2hooks.HavenbagAvailableRoomsUpdate;
    import d2hooks.HavenbagAvailableThemesUpdate;
    import d2hooks.HavenBagPermissionsUpdate;
    import d2hooks.DropStart;
    import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
    import d2actions.HavenbagFurnitureSelected;
    import d2actions.HavenbagEditMode;
    import d2actions.HavenbagRoomSelected;
    import com.ankamagames.dofus.network.enums.HavenBagShareBitEnum;
    import d2actions.HavenbagPermissionsUpdateRequest;
    import d2actions.HavenbagThemeSelected;
    import d2actions.HavenbagExit;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import d2actions.HavenbagSave;
    import com.ankamagames.berilia.types.LocationEnum;
    import d2actions.HavenbagClear;
    import d2actions.HavenbagReset;
    import d2actions.*;

    public class HavenbagManager 
    {

        private static const BANNER_HEIGHT:uint = 141;

        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="ConfigApi")]
        public var configApi:ConfigApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        private var _inMyOwnHavenbag:Boolean;
        private var _furnitures:Object;
        private var _furnituresLayer0:Array;
        private var _furnituresLayer1:Array;
        private var _furnituresLayer2:Array;
        private var _availableRooms:Vector.<HavenBagRoomPreviewInformation>;
        private var _currentRoomIndex:uint;
        private var _currentRoomThemeId:int;
        private var _availableThemes:Array;
        private var _ownerInfos:CharacterMinimalInformations;
        private var _ctrEditCurrentPosition:Point;
        private var _ctrEditLastPosition:Point;
        private var _themeFiltersForFurnitures:Dictionary;
        private var _groupByTheme:Boolean;
        private var _currentFurnitureType:int;
        private var _havenbagSharedWithGuild:Boolean;
        private var _havenbagSharedWithFriends:Boolean;
        private var _allThemesSelected:Boolean = true;
        public var tx_help:Texture;
        public var tx_title_bar_ctr_edit:TextureBitmap;
        public var ctr_edit:GraphicContainer;
        public var lbl_title:Label;
        public var btn_close:ButtonContainer;
        public var btn_searchFilter:ButtonContainer;
        public var btn_editClear:ButtonContainer;
        public var btn_editReset:ButtonContainer;
        public var btn_save:ButtonContainer;
        public var gd_furnitures:Grid;


        public function main(param:Object):void
        {
            var theme:HavenbagTheme;
            var availableThemeId:int;
            this.ctr_edit.visible = false;
            this.uiApi.addComponentHook(this.gd_furnitures, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.gd_furnitures, ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addComponentHook(this.gd_furnitures, ComponentHookList.ON_ITEM_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_editClear, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_editClear, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_editReset, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_editReset, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_save, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_save, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_help, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_help, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortcut);
            this.sysApi.addHook(HavenbagExitEditMode, this.onHavenbagExitEditMode);
            this.sysApi.addHook(HavenbagAvailableRoomsUpdate, this.onHavenbagAvailableRoomsUpdate);
            this.sysApi.addHook(HavenbagAvailableThemesUpdate, this.onHavenbagAvailableThemesUpdate);
            this.sysApi.addHook(HavenBagPermissionsUpdate, this.onHavenBagPermissionsUpdate);
            this.sysApi.addHook(DropStart, this.onDropStart);
            var position:Point = this.configApi.getConfigProperty("dofus", "havenbagEditPosition");
            if (!position)
            {
                position = new Point(this.ctr_edit.x, this.ctr_edit.y);
            }
            else
            {
                if (position)
                {
                    this.ctr_edit.x = position.x;
                    this.ctr_edit.y = position.y;
                };
            };
            this.tx_title_bar_ctr_edit.mouseEnabled = true;
            this.tx_title_bar_ctr_edit.buttonMode = (this.tx_title_bar_ctr_edit.useHandCursor = true);
            this._ctrEditCurrentPosition = position.clone();
            this._ctrEditLastPosition = this._ctrEditCurrentPosition.clone();
            this._currentRoomIndex = param.currentRoomId;
            this._availableRooms = param.availableRooms;
            this._currentRoomThemeId = param.currentRoomThemeId;
            this._ownerInfos = param.ownerInfos;
            this._inMyOwnHavenbag = (this._ownerInfos.id == this.playerApi.id());
            this._themeFiltersForFurnitures = new Dictionary();
            this._availableThemes = new Array();
            for each (availableThemeId in param.availableThemes)
            {
                theme = this.dataApi.getHavenbagTheme(availableThemeId);
                if (!theme)
                {
                }
                else
                {
                    this._availableThemes.push({
                        "id":availableThemeId,
                        "name":theme.name
                    });
                    this._themeFiltersForFurnitures[availableThemeId] = true;
                };
            };
            this._availableThemes.sortOn("name", Array.CASEINSENSITIVE);
            this._furnitures = this.dataApi.getHavenbagFurnitures();
            (this.gd_furnitures.renderer as SlotGridRenderer).dropValidatorFunction = this.dropValidatorFalse;
            this.updateFurnituresLists();
            this.onHavenBagPermissionsUpdate();
        }

        public function dropValidatorFalse(target:Object, data:Object, source:Object):Boolean
        {
            return (false);
        }

        public function unload():void
        {
        }

        private function onDropStart(src:Object):void
        {
            if (src.getUi() == this.uiApi.me())
            {
                this.gd_furnitures.selectedIndex = -1;
                this.gd_furnitures.selectedIndex = this.gd_furnitures.getItemIndex(src);
                this.sysApi.sendAction(new HavenbagFurnitureSelected(src.data.typeId));
            };
        }

        public function selectFurnitureType(pTypeId:int):void
        {
            this.gd_furnitures.dataProvider = this[("_furnituresLayer" + pTypeId)];
            this.gd_furnitures.selectedIndex = -1;
            switch (pTypeId)
            {
                case 0:
                    this.lbl_title.text = this.uiApi.getText("ui.havenbag.layer.floors");
                    break;
                case 1:
                    this.lbl_title.text = this.uiApi.getText("ui.havenbag.layer.supports");
                    break;
                case 2:
                    this.lbl_title.text = this.uiApi.getText("ui.havenbag.layer.objects");
                    break;
            };
            this._currentFurnitureType = pTypeId;
        }

        private function updateFurnituresLists():void
        {
            this._furnituresLayer0 = new Array();
            this._furnituresLayer1 = new Array();
            this._furnituresLayer2 = new Array();
            var i:int;
            while (i < this._furnitures.length)
            {
                if (!this._themeFiltersForFurnitures[this._furnitures[i].themeId])
                {
                }
                else
                {
                    if (this._furnitures[i].layerId == 0)
                    {
                        this._furnituresLayer0.push(this.dataApi.getHavenbagFurnitureWrapper(this._furnitures[i].typeId));
                    }
                    else
                    {
                        if (this._furnitures[i].layerId == 1)
                        {
                            this._furnituresLayer1.push(this.dataApi.getHavenbagFurnitureWrapper(this._furnitures[i].typeId));
                        }
                        else
                        {
                            if (this._furnitures[i].layerId == 2)
                            {
                                this._furnituresLayer2.push(this.dataApi.getHavenbagFurnitureWrapper(this._furnitures[i].typeId));
                            };
                        };
                    };
                };
                i++;
            };
            if (this._groupByTheme)
            {
                this._furnituresLayer0.sortOn(["themeId", "order"], [Array.NUMERIC, Array.NUMERIC]);
                this._furnituresLayer1.sortOn(["themeId", "order"], [Array.NUMERIC, Array.NUMERIC]);
                this._furnituresLayer2.sortOn(["themeId", "order"], [Array.NUMERIC, Array.NUMERIC]);
            }
            else
            {
                this._furnituresLayer0.sortOn("order", Array.NUMERIC);
                this._furnituresLayer1.sortOn("order", Array.NUMERIC);
                this._furnituresLayer2.sortOn("order", Array.NUMERIC);
            };
            this.gd_furnitures.dataProvider = this[("_furnituresLayer" + this._currentFurnitureType)];
            this.gd_furnitures.selectedIndex = -1;
        }

        private function toggleEditionWindow(open:Boolean):void
        {
            var helpTooltipDisplayedTimeNumber:int;
            var txt:Object;
            if (open)
            {
                this.uiApi.getUi("havenbagFurnituresTypes").getElement("mainCtr").visible = true;
                this.ctr_edit.visible = true;
                helpTooltipDisplayedTimeNumber = this.sysApi.getData("havenbagHelpTooltip");
                if (((!(helpTooltipDisplayedTimeNumber)) || (helpTooltipDisplayedTimeNumber < 3)))
                {
                    txt = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.havenbag.help"));
                    this.uiApi.showTooltip(txt, this.tx_help, true, "standard", 7, 1, 3, null, null, null, "TextInfo");
                    this.sysApi.setData("havenbagHelpTooltip", ((helpTooltipDisplayedTimeNumber) ? (helpTooltipDisplayedTimeNumber + 1) : 1));
                };
            }
            else
            {
                this.uiApi.getUi("havenbagFurnituresTypes").getElement("mainCtr").visible = false;
                this.ctr_edit.visible = false;
            };
            this.sysApi.sendAction(new HavenbagEditMode(open));
        }

        private function changeRoom(roomIndex:int):void
        {
            if (roomIndex != this._currentRoomIndex)
            {
                this.sysApi.sendAction(new HavenbagRoomSelected(roomIndex));
            };
        }

        private function changeTheme(themeId:uint):void
        {
            if (themeId != this._currentRoomThemeId)
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.havenbag.themeChange.popup"), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [function ():void
                {
                    onPopupChangeTheme(themeId);
                }, this.onPopupClose], function ():void
                {
                    onPopupChangeTheme(themeId);
                }, this.onPopupClose);
            };
        }

        private function changeShare(shareTarget:uint):void
        {
            var permissionValue:uint = HavenBagShareBitEnum.HAVEN_BAG_NONE;
            if (shareTarget == HavenBagShareBitEnum.HAVEN_BAG_FRIENDS)
            {
                this._havenbagSharedWithFriends = (!(this._havenbagSharedWithFriends));
            }
            else
            {
                if (shareTarget == HavenBagShareBitEnum.HAVEN_BAG_GUILD)
                {
                    this._havenbagSharedWithGuild = (!(this._havenbagSharedWithGuild));
                };
            };
            if (this._havenbagSharedWithFriends)
            {
                permissionValue = (permissionValue + HavenBagShareBitEnum.HAVEN_BAG_FRIENDS);
            };
            if (this._havenbagSharedWithGuild)
            {
                permissionValue = (permissionValue + HavenBagShareBitEnum.HAVEN_BAG_GUILD);
            };
            this.sysApi.sendAction(new HavenbagPermissionsUpdateRequest(permissionValue));
        }

        private function onPopupChangeTheme(themeId:uint):void
        {
            this.sysApi.sendAction(new HavenbagThemeSelected(themeId));
        }

        private function quit():void
        {
            this.sysApi.sendAction(new HavenbagExit());
        }

        private function selectAllThemes(selected:Boolean):void
        {
            var themeId:String;
            this.modContextMenu.closeAllMenu();
            this._allThemesSelected = selected;
            for (themeId in this._themeFiltersForFurnitures)
            {
                this._themeFiltersForFurnitures[themeId] = this._allThemesSelected;
            };
            this.updateFurnituresLists();
            this.createSearchFilterMenu();
        }

        private function filterFurnituresByThemes(themeId:int):void
        {
            this._themeFiltersForFurnitures[themeId] = (!(this._themeFiltersForFurnitures[themeId]));
            this.updateFurnituresLists();
        }

        private function groupFurnituresByTheme():void
        {
            this._groupByTheme = (!(this._groupByTheme));
            this.updateFurnituresLists();
        }

        private function createSearchFilterMenu():void
        {
            var availableTheme:Object;
            var point:Point;
            var contextMenu:Array = new Array();
            contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.havenbag.group")));
            contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.havenbag.groupByTheme"), this.groupFurnituresByTheme, null, false, null, this._groupByTheme, true));
            contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.havenbag.filterByThemes")));
            contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.selectAll"), this.selectAllThemes, [true], false, null, false, false));
            contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.unselectAll"), this.selectAllThemes, [false], false, null, false, false));
            contextMenu.push(this.modContextMenu.createContextMenuSeparatorObject());
            for each (availableTheme in this._availableThemes)
            {
                contextMenu.push(this.modContextMenu.createContextMenuItemObject(availableTheme.name, this.filterFurnituresByThemes, [availableTheme.id], false, null, this._themeFiltersForFurnitures[availableTheme.id], false));
            };
            point = this.btn_searchFilter.localToGlobal(new Point());
            this.modContextMenu.createContextMenu(contextMenu, {
                "x":(point.x + (this.btn_searchFilter.x + this.btn_searchFilter.width)),
                "y":point.y
            });
        }

        public function onShortcut(s:String):Boolean
        {
            if (((s == ShortcutHookListEnum.CLOSE_UI) && (this.ctr_edit.visible)))
            {
                this.toggleEditionWindow(false);
                return (true);
            };
            return (false);
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var item:Object = this.gd_furnitures.selectedItem;
            if (!item)
            {
                return;
            };
            switch (selectMethod)
            {
                case SelectMethodEnum.CLICK:
                    this.sysApi.sendAction(new HavenbagFurnitureSelected(item.typeId));
                    break;
            };
        }

        private function getThemeName(themeId:int):String
        {
            var index:int;
            while (index < this._availableThemes.length)
            {
                if (this._availableThemes[index].id == themeId)
                {
                    return (this._availableThemes[index].name);
                };
                index++;
            };
            return ("");
        }

        public function onRelease(target:Object):void
        {
            var availableTheme:Object;
            var menu:Array;
            var themesMenu:Array;
            var roomsMenu:Array;
            var shareMenu:Array;
            var selected:Boolean;
            var previewInfo:HavenBagRoomPreviewInformation;
            var roomName:String;
            var themeName:String;
            var i:int;
            this.modCommon.closeAllMenu();
            var list:Array = new Array();
            switch (target)
            {
                case "btn_havenbag":
                    if (this.playerApi.isInExchange())
                    {
                        return;
                    };
                    menu = new Array();
                    themesMenu = new Array();
                    roomsMenu = new Array();
                    shareMenu = new Array();
                    if (this._inMyOwnHavenbag)
                    {
                        for each (availableTheme in this._availableThemes)
                        {
                            selected = false;
                            if (availableTheme.id == this._currentRoomThemeId)
                            {
                                selected = true;
                            };
                            themeName = availableTheme.name;
                            if (this.sysApi.getPlayerManager().hasRights)
                            {
                                themeName = (themeName + ((" (id " + availableTheme.id) + ")"));
                            };
                            themesMenu.push(this.modContextMenu.createContextMenuItemObject(themeName, this.changeTheme, [availableTheme.id], false, null, selected));
                        };
                        shareMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.guildMembers"), this.changeShare, [HavenBagShareBitEnum.HAVEN_BAG_GUILD], false, null, this._havenbagSharedWithGuild, false));
                        shareMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.friends"), this.changeShare, [HavenBagShareBitEnum.HAVEN_BAG_FRIENDS], false, null, this._havenbagSharedWithFriends, false));
                    };
                    previewInfo = null;
                    roomName = "";
                    i = 0;
                    while (i < this._availableRooms.length)
                    {
                        previewInfo = this._availableRooms[i];
                        selected = false;
                        if (i == this._currentRoomIndex)
                        {
                            selected = true;
                        };
                        roomName = ((this.uiApi.getText("ui.havenbag.room") + " ") + (i + 1));
                        if (previewInfo != null)
                        {
                            roomName = (roomName + (" - " + this.getThemeName(previewInfo.themeId)));
                        };
                        roomsMenu.push(this.modContextMenu.createContextMenuItemObject(roomName, this.changeRoom, [i], false, null, selected));
                        i++;
                    };
                    if (this._inMyOwnHavenbag)
                    {
                        menu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.havenbag.myHavenbag")));
                    }
                    else
                    {
                        menu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.havenbag.havenbagOf", this._ownerInfos.name)));
                    };
                    if (this._inMyOwnHavenbag)
                    {
                        menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.havenbag.editMode"), this.toggleEditionWindow, [true], false));
                        menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.havenbag.themeChoice"), null, null, (themesMenu.length <= 1), themesMenu));
                        menu.push(this.modContextMenu.createContextMenuSeparatorObject());
                    };
                    menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.havenbag.goToAnotherRoom"), null, null, false, roomsMenu));
                    if (this._inMyOwnHavenbag)
                    {
                        menu.push(this.modContextMenu.createContextMenuSeparatorObject());
                        menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.havenbag.accessibleFor"), null, null, false, shareMenu));
                    };
                    this.modContextMenu.createContextMenu(menu);
                    if (this.ctr_edit.visible)
                    {
                        this.toggleEditionWindow(false);
                    };
                    break;
                case this.btn_searchFilter:
                    this.createSearchFilterMenu();
                    break;
                case this.btn_editClear:
                    this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.havenbag.clear.popup"), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onPopupClear, this.onPopupClose], this.onPopupClear, this.onPopupClose);
                    break;
                case this.btn_editReset:
                    this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.havenbag.reset.popup"), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onPopupReset, this.onPopupClose], this.onPopupReset, this.onPopupClose);
                    break;
                case this.btn_save:
                    this.sysApi.sendAction(new HavenbagSave());
                    break;
                case this.btn_close:
                    this.toggleEditionWindow(false);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var point:uint = 7;
            var relPoint:uint = 1;
            switch (target)
            {
                case this.btn_editClear:
                    tooltipText = this.uiApi.getText("ui.havenbag.clear.info");
                    break;
                case this.btn_editReset:
                    tooltipText = this.uiApi.getText("ui.havenbag.reset.info");
                    break;
                case this.btn_save:
                    tooltipText = this.uiApi.getText("ui.havenbag.save.info");
                    break;
                case this.btn_searchFilter:
                    tooltipText = this.uiApi.getText("ui.havenbag.filter.info");
                    break;
                case this.tx_help:
                    tooltipText = this.uiApi.getText("ui.havenbag.help");
                    break;
            };
            if (tooltipText)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (((item.data) && (this.sysApi.getPlayerManager().hasRights)))
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo((((((((((((((((((("--- DEBUG ---" + "\ntypeId: ") + item.data.typeId) + "\nthemeId: ") + item.data.themeId) + "\nelementId: ") + item.data.elementId) + "\ngfxId: ") + item.data.element.gfxId) + "\nisStackable: ") + item.data.isStackable) + "\nblocksMovement: ") + item.data.blocksMovement) + "\ncolor: ") + ((item.data.color == int.MAX_VALUE) ? "null" : item.data.color)) + "\nsize: ") + item.data.cellsWidth) + "x") + item.data.cellsHeight)), item.container, false, "standard", LocationEnum.POINT_BOTTOMRIGHT, LocationEnum.POINT_TOPLEFT, 0, null, null, null, "DebugInfo");
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        private function onHavenbagAvailableRoomsUpdate(availableRooms:Vector.<HavenBagRoomPreviewInformation>):void
        {
            this._availableRooms = availableRooms;
        }

        private function onHavenbagAvailableThemesUpdate(availableThemeIds:*):void
        {
            var theme:HavenbagTheme;
            var availableThemeId:int;
            this._themeFiltersForFurnitures = new Dictionary();
            this._availableThemes = new Array();
            for each (availableThemeId in availableThemeIds)
            {
                theme = this.dataApi.getHavenbagTheme(availableThemeId);
                if (!theme)
                {
                }
                else
                {
                    this._themeFiltersForFurnitures[availableThemeId] = true;
                    this._availableThemes.push({
                        "id":availableThemeId,
                        "name":theme.name
                    });
                };
            };
            this._availableThemes.sortOn("name", Array.CASEINSENSITIVE);
            this._furnitures = this.dataApi.getHavenbagFurnitures();
            this.updateFurnituresLists();
        }

        public function onHavenbagExitEditMode():void
        {
            this.uiApi.getUi("havenbagFurnituresTypes").getElement("mainCtr").visible = false;
            this.ctr_edit.visible = false;
        }

        public function onHavenBagPermissionsUpdate():void
        {
            var permissions:uint = this.playerApi.havenbagSharePermissions();
            this._havenbagSharedWithFriends = ((permissions & HavenBagShareBitEnum.HAVEN_BAG_FRIENDS) == HavenBagShareBitEnum.HAVEN_BAG_FRIENDS);
            this._havenbagSharedWithGuild = ((permissions & HavenBagShareBitEnum.HAVEN_BAG_GUILD) == HavenBagShareBitEnum.HAVEN_BAG_GUILD);
        }

        public function onPopupClose():void
        {
        }

        public function onPopupClear():void
        {
            this.sysApi.sendAction(new HavenbagClear());
        }

        public function onPopupReset():void
        {
            this.sysApi.sendAction(new HavenbagReset());
        }


    }
} Ankama_House.ui

