package com.ankamagames.dofus.datacenter.quest
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.types.IdAccessors;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.internalDatacenter.quest.AchievementRewardsWrapper;
    import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.datacenter.items.criterion.LevelItemCriterion;
    import com.ankamagames.dofus.datacenter.items.criterion.PrestigeLevelItemCriterion;
    import com.ankamagames.dofus.misc.utils.GameDataQuery;
    import com.ankamagames.dofus.datacenter.items.criterion.IItemCriterion;
    import com.ankamagames.dofus.datacenter.items.criterion.AchievementAccountItemCriterion;
    import __AS3__.vec.*;

    public class Achievement implements IDataCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Achievement));
        public static const MODULE:String = "Achievements";
        public static var idAccessors:IdAccessors = new IdAccessors(getAchievementById, getAchievements);

        public var id:uint;
        public var nameId:uint;
        public var categoryId:uint;
        public var descriptionId:uint;
        public var iconId:uint;
        public var points:uint;
        public var level:uint;
        public var order:uint;
        public var accountLinked:Boolean;
        public var objectiveIds:Vector.<int>;
        public var rewardIds:Vector.<int>;
        private var _name:String;
        private var _desc:String;
        private var _category:AchievementCategory;
        private var _currentLevelRewards:AchievementRewardsWrapper;
        private var _currentLevelRewardsAll:AchievementRewardsWrapper;
        private var _currentRewardsCriteriaRespected:Vector.<GroupItemCriterion>;
        private var _currentRewardsCriteriaNotRespected:Vector.<GroupItemCriterion>;


        public static function getAchievementById(id:int):Achievement
        {
            return (GameData.getObject(MODULE, id) as Achievement);
        }

        public static function getAchievements():Array
        {
            return (GameData.getObjects(MODULE));
        }


        public function get name():String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            };
            return (this._name);
        }

        public function get description():String
        {
            if (!this._desc)
            {
                this._desc = I18n.getText(this.descriptionId);
            };
            return (this._desc);
        }

        public function get category():AchievementCategory
        {
            if (!this._category)
            {
                this._category = AchievementCategory.getAchievementCategoryById(this.categoryId);
            };
            return (this._category);
        }

        public function get canBeStarted():Boolean
        {
            var ach:Achievement;
            var objId:int;
            var achObj:AchievementObjective;
            var achObjValue:Array;
            var qu:Quest;
            var quObj:QuestObjective;
            var questsIds:Vector.<uint>;
            for each (objId in this.objectiveIds)
            {
                achObj = AchievementObjective.getAchievementObjectiveById(objId);
                if (achObj)
                {
                    achObjValue = achObj.criterion.substr(3).split(",");
                    if (achObj.criterion.indexOf("PL") == 0)
                    {
                        return (new LevelItemCriterion(achObj.criterion).isRespected);
                    };
                    if (achObj.criterion.indexOf("Pl") == 0)
                    {
                        return (new PrestigeLevelItemCriterion(achObj.criterion).isRespected);
                    };
                    if (achObj.criterion.indexOf("OA") == 0)
                    {
                        ach = getAchievementById(parseInt(achObjValue[0]));
                        if (!ach.canBeStarted)
                        {
                            return (false);
                        };
                    }
                    else
                    {
                        if (achObj.criterion.indexOf("Q") == 0)
                        {
                            if (achObj.criterion.charAt(1) == "o")
                            {
                                quObj = QuestObjective.getQuestObjectiveById(parseInt(achObjValue[0]));
                                questsIds = GameDataQuery.queryEquals(Quest, "stepIds", quObj.stepId);
                                if (questsIds.length > 0)
                                {
                                    qu = Quest.getQuestById(questsIds[0]);
                                };
                            }
                            else
                            {
                                qu = Quest.getQuestById(parseInt(achObjValue[0]));
                            };
                            if (((!(qu)) || (!(qu.canBeStarted))))
                            {
                                return (false);
                            };
                        };
                    };
                };
            };
            return (true);
        }

        public function getKamasReward(pPlayerLevel:int):Number
        {
            this.initCurrentLevelRewards(pPlayerLevel);
            return ((this._currentLevelRewards == null) ? 0 : this._currentLevelRewards.getKamasReward(pPlayerLevel));
        }

        public function getExperienceReward(pPlayerLevel:int, pXpBonus:int):Number
        {
            this.initCurrentLevelRewards(pPlayerLevel);
            return ((this._currentLevelRewards == null) ? 0 : this._currentLevelRewards.getExperienceReward(pPlayerLevel, pXpBonus));
        }

        public function getAchievementRewardByLevel(playerLevel:int, showAllReward:Boolean=false):AchievementRewardsWrapper
        {
            this.initCurrentLevelRewards(playerLevel);
            if (showAllReward)
            {
                return (this._currentLevelRewardsAll);
            };
            return (this._currentLevelRewards);
        }

        private function initCurrentLevelRewards(level:int):void
        {
            var criterion:GroupItemCriterion;
            var rewardId:uint;
            var characterRewardsTruncated:Boolean;
            var rewards:AchievementReward;
            var criterionToCheckForOb:IItemCriterion;
            var indexOperatorToRemove:int;
            var index:int;
            var criteriaListWithoutOb:Vector.<IItemCriterion>;
            var conditionsWithoutOb:GroupItemCriterion;
            var operators:Vector.<String>;
            if (this._currentRewardsCriteriaRespected == null)
            {
                this._currentRewardsCriteriaRespected = new Vector.<GroupItemCriterion>();
            };
            if (this._currentRewardsCriteriaNotRespected == null)
            {
                this._currentRewardsCriteriaNotRespected = new Vector.<GroupItemCriterion>();
            };
            var changeInCriteriaRespect:Boolean;
            for each (criterion in this._currentRewardsCriteriaRespected)
            {
                if (!criterion.isRespected)
                {
                    changeInCriteriaRespect = true;
                    break;
                };
            };
            if (!changeInCriteriaRespect)
            {
                for each (criterion in this._currentRewardsCriteriaNotRespected)
                {
                    if (criterion.isRespected)
                    {
                        changeInCriteriaRespect = true;
                        break;
                    };
                };
            };
            if (((!(changeInCriteriaRespect)) && (!(this._currentLevelRewards == null))))
            {
                return;
            };
            var currentRewards:Vector.<AchievementReward> = new Vector.<AchievementReward>();
            var currentRewardsAll:Vector.<AchievementReward> = new Vector.<AchievementReward>();
            this._currentRewardsCriteriaRespected = new Vector.<GroupItemCriterion>();
            this._currentRewardsCriteriaNotRespected = new Vector.<GroupItemCriterion>();
            for each (rewardId in this.rewardIds)
            {
                rewards = AchievementReward.getAchievementRewardById(rewardId);
                if (rewards.conditions == null)
                {
                    currentRewards.push(rewards);
                    currentRewardsAll.push(rewards);
                }
                else
                {
                    if (rewards.conditions.isRespected)
                    {
                        currentRewards.push(rewards);
                    };
                    indexOperatorToRemove = -1;
                    index = 0;
                    criteriaListWithoutOb = new Vector.<IItemCriterion>();
                    for each (criterionToCheckForOb in rewards.conditions.criteria)
                    {
                        if ((criterionToCheckForOb is AchievementAccountItemCriterion))
                        {
                            indexOperatorToRemove = (index - 1);
                        }
                        else
                        {
                            criteriaListWithoutOb.push(criterionToCheckForOb);
                        };
                        index++;
                    };
                    if (criteriaListWithoutOb.length > 0)
                    {
                        operators = rewards.conditions.operators;
                        if (indexOperatorToRemove > -1)
                        {
                            operators.splice(indexOperatorToRemove, 1);
                        };
                        conditionsWithoutOb = GroupItemCriterion.create(criteriaListWithoutOb, operators);
                    };
                    if (((!(conditionsWithoutOb)) || (conditionsWithoutOb.isRespected)))
                    {
                        currentRewardsAll.push(rewards);
                    };
                };
                if (rewards.conditions)
                {
                    if (rewards.conditions.isRespected)
                    {
                        this._currentRewardsCriteriaRespected.push(rewards.conditions);
                    }
                    else
                    {
                        this._currentRewardsCriteriaNotRespected.push(rewards.conditions);
                    };
                };
            };
            characterRewardsTruncated = false;
            if (((currentRewardsAll) && ((!(currentRewards)) || (currentRewards.length < currentRewardsAll.length))))
            {
                characterRewardsTruncated = true;
            };
            if (!this._currentLevelRewards)
            {
                this._currentLevelRewards = AchievementRewardsWrapper.create(currentRewards, characterRewardsTruncated);
            }
            else
            {
                this._currentLevelRewards.update(currentRewards, characterRewardsTruncated);
            };
            if (!this._currentLevelRewardsAll)
            {
                this._currentLevelRewardsAll = AchievementRewardsWrapper.create(currentRewardsAll);
            }
            else
            {
                this._currentLevelRewardsAll.update(currentRewardsAll);
            };
        }


    }
}

