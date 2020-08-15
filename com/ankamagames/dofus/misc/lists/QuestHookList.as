package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.berilia.types.data.Hook;

    public class QuestHookList 
    {

        public static const QuestListUpdated:Hook = new Hook("QuestListUpdated");
        public static const QuestInfosUpdated:Hook = new Hook("QuestInfosUpdated");
        public static const QuestStarted:Hook = new Hook("QuestStarted");
        public static const QuestValidated:Hook = new Hook("QuestValidated");
        public static const QuestObjectiveValidated:Hook = new Hook("QuestObjectiveValidated");
        public static const QuestStepValidated:Hook = new Hook("QuestStepValidated");
        public static const QuestStepStarted:Hook = new Hook("QuestStepStarted");
        public static const AchievementList:Hook = new Hook("AchievementList");
        public static const AchievementDetailedList:Hook = new Hook("AchievementDetailedList");
        public static const AchievementDetails:Hook = new Hook("AchievementDetails");
        public static const AchievementFinished:Hook = new Hook("AchievementFinished");
        public static const AchievementRewardSuccess:Hook = new Hook("AchievementRewardSuccess");
        public static const AchievementRewardError:Hook = new Hook("AchievementRewardError");
        public static const RewardableAchievementsVisible:Hook = new Hook("RewardableAchievementsVisible");
        public static const TitlesListUpdated:Hook = new Hook("TitlesListUpdated");
        public static const OrnamentsListUpdated:Hook = new Hook("OrnamentsListUpdated");
        public static const TitleUpdated:Hook = new Hook("TitleUpdated");
        public static const OrnamentUpdated:Hook = new Hook("OrnamentUpdated");
        public static const TreasureHuntLegendaryUiUpdate:Hook = new Hook("TreasureHuntLegendaryUiUpdate");
        public static const TreasureHuntUpdate:Hook = new Hook("TreasureHuntUpdate");
        public static const TreasureHuntFinished:Hook = new Hook("TreasureHuntFinished");
        public static const TreasureHuntAvailableRetryCountUpdate:Hook = new Hook("TreasureHuntAvailableRetryCountUpdate");
        public static const AreaFightModificatorUpdate:Hook = new Hook("AreaFightModificatorUpdate");
        public static const QuestFollowed:Hook = new Hook("QuestFollowed");


    }
}

