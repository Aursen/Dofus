package Ankama_ContextMenu.makers
{
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import Ankama_ContextMenu.Api;
    import d2actions.NpcGenericActionRequest;
    import d2actions.ExchangeRequestOnTaxCollector;
    import d2actions.GameRolePlayTaxCollectorFightRequest;
    import d2hooks.MouseShiftClick;
    import Ankama_ContextMenu.ContextMenu;
    import d2hooks.*;
    import d2actions.*;

    public class TaxCollectorMenuMaker implements IMenuMaker 
    {

        public static var disabled:Boolean = false;


        private function onTalkTaxCollectorClick(pTaxCollectorContextualId:int):void
        {
            Api.system.sendAction(new NpcGenericActionRequest(pTaxCollectorContextualId, 3));
        }

        private function onCollectTaxCollectorClick(pTaxCollectorContextualId:int):void
        {
            Api.system.sendAction(new ExchangeRequestOnTaxCollector());
        }

        private function onAttackTaxCollectorClick(pTaxCollectorContextualId:int):void
        {
            Api.system.sendAction(new GameRolePlayTaxCollectorFightRequest());
        }

        private function insertLink(pTaxCollectorText:String):void
        {
            Api.system.dispatchHook(MouseShiftClick, {
                "data":"Map",
                "params":{
                    "x":Api.player.currentMap().outdoorX,
                    "y":Api.player.currentMap().outdoorY,
                    "worldMapId":Api.player.currentSubArea().worldmap.id,
                    "elementName":(pTaxCollectorText + " ")
                }
            });
        }

        public function createMenu(data:*, param:Object):Array
        {
            var playerInfos:Object;
            var lDisabled:Boolean;
            var aDisabled:Boolean;
            var menu:Array = new Array();
            var dead:* = (!(Api.player.isAlive()));
            var taxCollectorName:String = ((Api.data.getTaxCollectorFirstname(data.identification.firstNameId).firstname + " ") + Api.data.getTaxCollectorName(data.identification.lastNameId).name);
            menu.push(ContextMenu.static_createContextMenuTitleObject(taxCollectorName));
            if (param.rightClick)
            {
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.chat.insertCoordinates"), this.insertLink, [Api.ui.getText("ui.guild.taxCollector", data.identification.guildIdentity.guildName)], disabled));
                return (menu);
            };
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.talk"), this.onTalkTaxCollectorClick, [param.entity.id]));
            if (((Api.social.hasGuild()) && (Api.social.getGuild().guildId == data.identification.guildIdentity.guildId)))
            {
                playerInfos = Api.player.getPlayedCharacterInfo();
                lDisabled = (!(Api.social.hasGuildRight(playerInfos.id, "collect")));
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.CollectTaxCollector"), this.onCollectTaxCollectorClick, [param.entity.id], (((disabled) || (lDisabled)) || (dead))));
            }
            else
            {
                aDisabled = false;
                if (data.taxCollectorAttack != 0)
                {
                    aDisabled = true;
                };
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.attack"), this.onAttackTaxCollectorClick, [param.entity.id], (((disabled) || (aDisabled)) || (dead))));
            };
            return (menu);
        }


    }
} Ankama_ContextMenu.makers

