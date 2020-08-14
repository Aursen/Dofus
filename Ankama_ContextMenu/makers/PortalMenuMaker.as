package Ankama_ContextMenu.makers
{
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import Ankama_ContextMenu.Api;
    import d2actions.NpcGenericActionRequest;
    import d2actions.PortalUseRequest;
    import d2hooks.MouseShiftClick;
    import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.PortalInformation;
    import com.ankamagames.dofus.datacenter.world.Area;
    import Ankama_ContextMenu.ContextMenu;
    import d2hooks.*;
    import d2actions.*;

    public class PortalMenuMaker implements IMenuMaker 
    {

        public static var disabled:Boolean = false;

        public var _portalId:int;
        public var _areaName:String;


        private function onPortalTalk(entityId:Number):void
        {
            Api.system.sendAction(new NpcGenericActionRequest(entityId, 3));
        }

        private function onPortalUse():void
        {
            Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"), Api.ui.getText("ui.dimension.confirmTeleport", this._areaName), [Api.ui.getText("ui.common.yes"), Api.ui.getText("ui.common.no")], [this.onValid], this.onValid);
        }

        protected function onValid():void
        {
            Api.system.sendAction(new PortalUseRequest(this._portalId));
        }

        private function insertLink(pPortalName:String):void
        {
            Api.system.dispatchHook(MouseShiftClick, {
                "data":"Map",
                "params":{
                    "x":Api.player.currentMap().outdoorX,
                    "y":Api.player.currentMap().outdoorY,
                    "worldMapId":Api.player.currentSubArea().worldmap.id,
                    "elementName":(pPortalName + " ")
                }
            });
        }

        public function createMenu(data:*, param:Object):Array
        {
            var name:String;
            var menu:Array = new Array();
            var dead:* = (!(Api.player.isAlive()));
            var portalInfos:PortalInformation = data.portal;
            this._portalId = portalInfos.portalId;
            var area:Area = Api.data.getArea(portalInfos.areaId);
            if (area)
            {
                this._areaName = area.name;
            }
            else
            {
                this._areaName = "???";
            };
            name = Api.ui.getText("ui.dimension.portal", this._areaName);
            menu.push(ContextMenu.static_createContextMenuTitleObject(name));
            if (!param.rightClick)
            {
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.talk"), this.onPortalTalk, [param.entity.id]));
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.use"), this.onPortalUse, null, ((disabled) || (dead))));
            }
            else
            {
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.chat.insertCoordinates"), this.insertLink, [name], disabled));
            };
            return (menu);
        }


    }
} Ankama_ContextMenu.makers

