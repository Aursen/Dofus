package Ankama_ContextMenu.makers
{
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import Ankama_ContextMenu.Api;
    import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
    import d2actions.ObjectSetPosition;
    import d2actions.GameFightPlacementSwapPositionsRequest;
    import d2actions.GameContextKick;
    import d2actions.PartyKickRequest;
    import d2actions.PartyCancelInvitation;
    import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
    import com.ankamagames.dofus.internalDatacenter.people.PartyCompanionWrapper;
    import Ankama_ContextMenu.ContextMenu;
    import d2actions.*;

    public class CompanionMenuMaker implements IMenuMaker 
    {

        public static var disabled:Boolean = false;


        private function onDismiss():void
        {
            var companionUID:int;
            var item:Object;
            var equipment:Object = Api.storage.getViewContent("equipment");
            for each (item in equipment)
            {
                if (((item) && (item.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY)))
                {
                    companionUID = item.objectUID;
                    break;
                };
            };
            if (companionUID != 0)
            {
                Api.system.sendAction(new ObjectSetPosition(companionUID, 63, 1));
            };
        }

        private function onSwitchPlaces(cellId:int, companionId:Number):void
        {
            Api.system.sendAction(new GameFightPlacementSwapPositionsRequest(cellId, companionId));
        }

        protected function onKick(targetId:Number):void
        {
            Api.system.sendAction(new GameContextKick(targetId));
        }

        protected function kickPlayer(partyId:int, playerId:Number):void
        {
            Api.system.sendAction(new PartyKickRequest(partyId, playerId));
        }

        protected function cancelPartyInvitation(partyId:int, guestId:Number):void
        {
            Api.system.sendAction(new PartyCancelInvitation(partyId, guestId));
        }

        public function createMenu(data:*, param:Object):Array
        {
            var cData:Object;
            var playerId:Number;
            var playerName:String;
            var companionId:Number;
            var companionName:String;
            var partyId:int;
            var playerIsGuest:Boolean;
            var partyMember:PartyMemberWrapper;
            if ((data is GameFightEntityInformation))
            {
                cData = (data as GameFightEntityInformation);
                if (((Api.player.isInFight()) && (!(Api.player.isInPreFight()))))
                {
                    return ([]);
                };
                playerId = cData.masterId;
                companionId = cData.contextualId;
                companionName = Api.data.getCompanion(cData.entityModelId).name;
                if (playerId != Api.player.id())
                {
                    playerName = Api.fight.getFighterName(playerId);
                    companionName = Api.ui.getText("ui.common.belonging", companionName, playerName);
                }
                else
                {
                    playerName = Api.player.getPlayedCharacterInfo().name;
                };
            }
            else
            {
                cData = (data as PartyCompanionWrapper);
                playerId = cData.id;
                playerName = cData.masterName;
                companionId = cData.id;
                companionName = cData.name;
            };
            var menu:Array = [];
            var companionTeam:String = Api.fight.getFighterInformations(playerId).team;
            var ownTeam:String = Api.fight.getFighterInformations(Api.player.id()).team;
            menu.push(ContextMenu.static_createContextMenuTitleObject(companionName));
            if (playerId == Api.player.id())
            {
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.companion.dismiss"), this.onDismiss, [], disabled));
            }
            else
            {
                if (((Api.player.isInPreFight()) && (Api.fight.isFightLeader())))
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.fight.kickSomeone", playerName), this.onKick, [playerId], disabled));
                };
                if (Api.player.isInParty())
                {
                    partyId = Api.party.getPartyId();
                    if (((partyId > 0) && (Api.party.getPartyLeaderId(partyId) == Api.player.id())))
                    {
                        playerIsGuest = false;
                        for each (partyMember in Api.party.getPartyMembers(0))
                        {
                            if (partyMember.id == playerId)
                            {
                                playerIsGuest = (!(partyMember.isMember));
                                break;
                            };
                        };
                        if (playerIsGuest)
                        {
                            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.cancelInvitationForSomeone", playerName), this.cancelPartyInvitation, [partyId, playerId]));
                        }
                        else
                        {
                            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.kickSomeone", playerName), this.kickPlayer, [partyId, playerId]));
                        };
                    };
                };
            };
            if (((((Api.player.isInPreFight()) && (companionTeam == ownTeam)) && (cData.hasOwnProperty("disposition"))) && (cData.disposition)))
            {
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.companion.switchPlaces"), this.onSwitchPlaces, [cData.disposition.cellId, companionId], disabled));
            };
            if (menu.length == 1)
            {
                menu = null;
            };
            return (menu);
        }


    }
}

