package Ankama_ContextMenu.makers
{
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import Ankama_ContextMenu.Api;
    import d2hooks.OpenEncyclopedia;
    import d2hooks.MouseShiftClick;
    import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupInformations;
    import Ankama_ContextMenu.ContextMenu;
    import d2hooks.*;

    public class MonsterGroupMenuMaker implements IMenuMaker 
    {

        public static var disabled:Boolean = false;


        private function askBestiary(monsterIds:Array):void
        {
            var data:Object = {};
            data.monsterId = 0;
            data.monsterSearch = null;
            data.monsterIdsList = monsterIds;
            data.forceOpen = true;
            Api.system.dispatchHook(OpenEncyclopedia, "bestiaryTab", data);
        }

        private function insertLink(pInfos:*):void
        {
            Api.system.dispatchHook(MouseShiftClick, {
                "data":"MonsterGroup",
                "params":{
                    "x":Api.player.currentMap().outdoorX,
                    "y":Api.player.currentMap().outdoorY,
                    "worldMapId":Api.player.currentSubArea().worldmap.id,
                    "monsterName":Api.data.getMonsterFromId(pInfos.staticInfos.mainCreatureLightInfos.genericId).name,
                    "infos":Api.roleplay.getMonsterGroupString(pInfos)
                }
            });
        }

        public function createMenu(data:*, param:Object):Array
        {
            var creature:MonsterInGroupInformations;
            var menu:Array = [];
            var monsterIds:Array = [];
            monsterIds.push(data.staticInfos.mainCreatureLightInfos.genericId);
            for each (creature in data.staticInfos.underlings)
            {
                if (monsterIds.indexOf(creature.genericId) == -1)
                {
                    monsterIds.push(creature.genericId);
                };
            };
            if (monsterIds.length > 0)
            {
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.bestiary"), this.askBestiary, [monsterIds], disabled));
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.chat.insertCoordinates"), this.insertLink, [data], disabled));
            };
            return (menu);
        }


    }
}

