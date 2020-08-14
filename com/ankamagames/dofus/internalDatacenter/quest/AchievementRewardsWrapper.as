package com.ankamagames.dofus.internalDatacenter.quest
{
    import com.ankamagames.dofus.datacenter.quest.AchievementReward;
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class AchievementRewardsWrapper extends AchievementReward implements IDataCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AchievementRewardsWrapper));

        public var rewardsList:Vector.<AchievementReward> = new Vector.<AchievementReward>();
        public var rewardTruncated:Boolean = false;


        public static function create(rewards:Vector.<AchievementReward>, characterRewardsTruncated:Boolean=false):AchievementRewardsWrapper
        {
            var i:int;
            var mergedRewards:AchievementRewardsWrapper = new (AchievementRewardsWrapper)();
            mergedRewards.rewardsList = rewards;
            mergedRewards.rewardTruncated = characterRewardsTruncated;
            if (((!(rewards == null)) && (rewards.length > 0)))
            {
                mergedRewards.achievementId = rewards[0].achievementId;
            };
            mergedRewards.itemsReward = new Vector.<uint>();
            mergedRewards.itemsQuantityReward = new Vector.<uint>();
            mergedRewards.emotesReward = new Vector.<uint>();
            mergedRewards.spellsReward = new Vector.<uint>();
            mergedRewards.titlesReward = new Vector.<uint>();
            mergedRewards.ornamentsReward = new Vector.<uint>();
            var rewardsCount:int = rewards.length;
            i = 0;
            while (i < rewardsCount)
            {
                if (rewards[i].kamasRatio)
                {
                    mergedRewards.kamasRatio = rewards[i].kamasRatio;
                    mergedRewards.kamasScaleWithPlayerLevel = rewards[i].kamasScaleWithPlayerLevel;
                };
                if (rewards[i].experienceRatio)
                {
                    mergedRewards.experienceRatio = rewards[i].experienceRatio;
                };
                mergedRewards.itemsReward = mergedRewards.itemsReward.concat(rewards[i].itemsReward);
                mergedRewards.itemsQuantityReward = mergedRewards.itemsQuantityReward.concat(rewards[i].itemsQuantityReward);
                mergedRewards.emotesReward = mergedRewards.emotesReward.concat(rewards[i].emotesReward);
                mergedRewards.spellsReward = mergedRewards.spellsReward.concat(rewards[i].spellsReward);
                mergedRewards.titlesReward = mergedRewards.titlesReward.concat(rewards[i].titlesReward);
                mergedRewards.ornamentsReward = mergedRewards.ornamentsReward.concat(rewards[i].ornamentsReward);
                i++;
            };
            return (mergedRewards);
        }


        public function update(rewards:Vector.<AchievementReward>, characterRewardsTruncated:Boolean=false):void
        {
            var i:int;
            this.rewardsList = rewards;
            this.rewardTruncated = characterRewardsTruncated;
            if (((!(rewards == null)) && (rewards.length > 0)))
            {
                this.achievementId = rewards[0].achievementId;
            };
            this.itemsReward = new Vector.<uint>();
            this.itemsQuantityReward = new Vector.<uint>();
            this.emotesReward = new Vector.<uint>();
            this.spellsReward = new Vector.<uint>();
            this.titlesReward = new Vector.<uint>();
            this.ornamentsReward = new Vector.<uint>();
            var rewardsCount:int = rewards.length;
            i = 0;
            while (i < rewardsCount)
            {
                if (rewards[i].kamasRatio)
                {
                    this.kamasRatio = rewards[i].kamasRatio;
                    this.kamasScaleWithPlayerLevel = rewards[i].kamasScaleWithPlayerLevel;
                };
                if (rewards[i].experienceRatio)
                {
                    this.experienceRatio = rewards[i].experienceRatio;
                };
                this.itemsReward = this.itemsReward.concat(rewards[i].itemsReward);
                this.itemsQuantityReward = this.itemsQuantityReward.concat(rewards[i].itemsQuantityReward);
                this.emotesReward = this.emotesReward.concat(rewards[i].emotesReward);
                this.spellsReward = this.spellsReward.concat(rewards[i].spellsReward);
                this.titlesReward = this.titlesReward.concat(rewards[i].titlesReward);
                this.ornamentsReward = this.ornamentsReward.concat(rewards[i].ornamentsReward);
                i++;
            };
        }


    }
} com.ankamagames.dofus.internalDatacenter.quest

