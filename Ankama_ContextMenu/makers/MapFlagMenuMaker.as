package Ankama_ContextMenu.makers
{
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import Ankama_ContextMenu.Api;
    import d2actions.FriendSpouseFollow;
    import com.ankamagames.dofus.network.enums.CompassTypeEnum;
    import d2actions.PartyStopFollowingMember;
    import d2hooks.RemoveMapFlag;
    import com.ankamagames.dofus.datacenter.quest.Quest;
    import d2hooks.OpenBook;
    import Ankama_ContextMenu.ContextMenu;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import d2hooks.*;
    import d2actions.*;

    public class MapFlagMenuMaker implements IMenuMaker 
    {

        private var disabled:Boolean = false;
        private var _worldMapId:int;


        private function askRemoveFlag(flagId:String):void
        {
            var flagType:int;
            if (flagId.indexOf("flag_srv") == 0)
            {
                flagType = int(flagId.substring(8, 9));
                switch (flagType)
                {
                    case CompassTypeEnum.COMPASS_TYPE_SPOUSE:
                        Api.system.sendAction(new FriendSpouseFollow(false));
                        break;
                    case CompassTypeEnum.COMPASS_TYPE_PARTY:
                        Api.system.sendAction(new PartyStopFollowingMember(Api.party.getPartyId(), int(flagId.substring(10))));
                        break;
                    default:
                        Api.system.dispatchHook(RemoveMapFlag, flagId, this._worldMapId);
                };
            }
            else
            {
                Api.system.dispatchHook(RemoveMapFlag, flagId, this._worldMapId);
            };
        }

        private function askOpenQuest(flagId:String):void
        {
            var data:Object;
            var questId:int = int(flagId.split("_")[2]);
            var quest:Quest = Api.data.getQuest(questId);
            if (quest)
            {
                data = new Object();
                data.quest = quest;
                data.forceOpen = true;
                Api.system.dispatchHook(OpenBook, "questTab", data);
            };
        }

        private function mountRunToThisPosition(pMapX:int, pMapY:int):void
        {
            Api.map.autoTravel(pMapX, pMapY);
        }

        public function createMenu(data:*, param:Object):Array
        {
            var coords:Array;
            var flagX:int;
            var flagY:int;
            var mountInfo:Object;
            var hasAutopilot:Boolean;
            var capacityCount:int;
            var i:int;
            var menu:Array = new Array();
            if (((data) && (data.id.indexOf("flag_") == 0)))
            {
                this._worldMapId = param[0];
                if (data.canBeManuallyRemoved)
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.map.removeFlag"), this.askRemoveFlag, [data.id], this.disabled));
                };
                if (data.id.indexOf(("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST)) == 0)
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.shortcuts.openBookQuest"), this.askOpenQuest, [data.id], this.disabled));
                };
                coords = data.key.split("_");
                flagX = int(coords[0]);
                flagY = int(coords[1]);
                mountInfo = Api.player.getMount();
                if (((Api.player.isRidding()) && (mountInfo)))
                {
                    if (Api.system.getPlayerManager().hasFreeAutopilot)
                    {
                        hasAutopilot = true;
                    }
                    else
                    {
                        capacityCount = mountInfo.ability.length;
                        i = 0;
                        if (capacityCount)
                        {
                            i = 0;
                            while (i < capacityCount)
                            {
                                if (mountInfo.ability[i].id == DataEnum.MOUNT_CAPACITY_AUTOPILOT)
                                {
                                    hasAutopilot = true;
                                    break;
                                };
                                i++;
                            };
                        };
                    };
                    if (hasAutopilot)
                    {
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mountTrip.travel"), this.mountRunToThisPosition, [flagX, flagY]));
                    };
                };
            };
            return (menu);
        }


    }
} Ankama_ContextMenu.makers

