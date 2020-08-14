package Ankama_ContextMenu.makers
{
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import Ankama_ContextMenu.Api;
    import d2actions.NpcGenericActionRequest;
    import d2hooks.MouseShiftClick;
    import flash.utils.Dictionary;
    import Ankama_ContextMenu.ContextMenu;
    import d2hooks.*;
    import d2actions.*;

    public class NpcMenuMaker implements IMenuMaker 
    {

        public static var disabled:Boolean = false;


        private function onNPCMenuClick(pNPCId:int, pActionId:int):void
        {
            Api.system.sendAction(new NpcGenericActionRequest(pNPCId, pActionId));
        }

        private function insertLink(pNpcName:String):void
        {
            Api.system.dispatchHook(MouseShiftClick, {
                "data":"Map",
                "params":{
                    "x":Api.player.currentMap().outdoorX,
                    "y":Api.player.currentMap().outdoorY,
                    "worldMapId":Api.player.currentSubArea().worldmap.id,
                    "elementName":(pNpcName + " ")
                }
            });
        }

        public function createMenu(data:*, param:Object):Array
        {
            var realActions:Dictionary;
            var actionId:uint;
            var action:*;
            var actionData:Object;
            var menu:Array = new Array();
            var dead:* = (!(Api.player.isAlive()));
            var npcId:int = data.npcId;
            var npc:Object = Api.data.getNpc(npcId);
            var npcActions:Object = npc.actions;
            if (param.rightClick)
            {
                menu.push(ContextMenu.static_createContextMenuTitleObject(npc.name));
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.chat.insertCoordinates"), this.insertLink, [npc.name], disabled));
                return (menu);
            };
            if (npcActions.length > 0)
            {
                menu.push(ContextMenu.static_createContextMenuTitleObject(npc.name));
                realActions = new Dictionary();
                for each (actionId in npcActions)
                {
                    actionData = Api.data.getNpcAction(actionId);
                    if (((actionData) && ((!(actionData.realId == actionId)) || (!(realActions[actionData.realId])))))
                    {
                        realActions[actionData.realId] = actionData.name;
                    };
                };
                for (action in realActions)
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(realActions[action], this.onNPCMenuClick, [param.entity.id, action], ((disabled) || (dead))));
                };
            };
            return (menu);
        }


    }
} Ankama_ContextMenu.makers

