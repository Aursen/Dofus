package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.berilia.types.data.Hook;

    public class RoleplayHookList 
    {

        public static const PlayerFightRequestSent:Hook = new Hook("PlayerFightRequestSent");
        public static const PlayerFightFriendlyRequested:Hook = new Hook("PlayerFightFriendlyRequested");
        public static const FightRequestCanceled:Hook = new Hook("FightRequestCanceled");
        public static const PlayerFightFriendlyAnswer:Hook = new Hook("PlayerFightFriendlyAnswer");
        public static const PlayerFightFriendlyAnswered:Hook = new Hook("PlayerFightFriendlyAnswered");
        public static const EmoteListUpdated:Hook = new Hook("EmoteListUpdated");
        public static const EmoteEnabledListUpdated:Hook = new Hook("EmoteEnabledListUpdated");
        public static const DocumentReadingBegin:Hook = new Hook("DocumentReadingBegin");
        public static const TeleportDestinationList:Hook = new Hook("TeleportDestinationList");
        public static const EstateToSellList:Hook = new Hook("EstateToSellList");
        public static const DungeonPartyFinderAvailableDungeons:Hook = new Hook("DungeonPartyFinderAvailableDungeons");
        public static const DungeonPartyFinderRoomContent:Hook = new Hook("DungeonPartyFinderRoomContent");
        public static const DungeonPartyFinderRegister:Hook = new Hook("DungeonPartyFinderRegister");
        public static const ArenaRegistrationStatusUpdate:Hook = new Hook("ArenaRegistrationStatusUpdate");
        public static const ArenaFightProposition:Hook = new Hook("ArenaFightProposition");
        public static const ArenaFighterStatusUpdate:Hook = new Hook("ArenaFighterStatusUpdate");
        public static const ArenaUpdateRank:Hook = new Hook("ArenaUpdateRank");
        public static const ArenaLeagueRewards:Hook = new Hook("ArenaLeagueRewards");
        public static const NpcDialogCreation:Hook = new Hook("NpcDialogCreation");
        public static const PonyDialogCreation:Hook = new Hook("PonyDialogCreation");
        public static const PrismDialogCreation:Hook = new Hook("PrismDialogCreation");
        public static const PortalDialogCreation:Hook = new Hook("PortalDialogCreation");
        public static const NpcDialogCreationFailure:Hook = new Hook("NpcDialogCreationFailure");
        public static const NpcDialogQuestion:Hook = new Hook("NpcDialogQuestion");
        public static const PortalDialogQuestion:Hook = new Hook("PortalDialogQuestion");
        public static const GiftsWaitingAllocation:Hook = new Hook("GiftsWaitingAllocation");
        public static const MerchantListUpdated:Hook = new Hook("MerchantListUpdated");


    }
}

