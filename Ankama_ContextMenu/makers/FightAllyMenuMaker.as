package Ankama_ContextMenu.makers
{
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import Ankama_ContextMenu.Api;
    import Ankama_ContextMenu.ContextMenu;
    import d2actions.GameFightPlacementSwapPositionsRequest;

    public class FightAllyMenuMaker implements IMenuMaker 
    {


        public function createMenu(data:*, param:Object):Array
        {
            var allyInfos:GameFightFighterInformations = (data as GameFightFighterInformations);
            var menu:Array = [];
            if ((((Api.player.isInPreFight()) && (allyInfos.hasOwnProperty("disposition"))) && (allyInfos.disposition)))
            {
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.companion.switchPlaces"), this.onSwitchPlaces, [allyInfos.disposition.cellId, allyInfos.contextualId]));
            };
            if (menu.length > 0)
            {
                menu.splice(0, 0, ContextMenu.static_createContextMenuTitleObject(Api.fight.getFighterName(allyInfos.contextualId)));
            };
            return (menu);
        }

        private function onSwitchPlaces(cellId:int, allyId:Number):void
        {
            Api.system.sendAction(new GameFightPlacementSwapPositionsRequest(cellId, allyId));
        }


    }
}

