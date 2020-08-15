package Ankama_Tooltips.utils
{
    public class FormulaHandler 
    {

        private static var _self:FormulaHandler;
        private static const XP_GROUP:Array = [1, 1.1, 1.5, 2.3, 3.1, 3.6, 4.2, 4.7];
        private static const MAX_LEVEL_MALUS:Number = 4;

        private var _xpSolo:Number;
        private var _xpGroup:Number;

        public function FormulaHandler():void
        {
            this.clearData();
        }

        public static function getInstance():FormulaHandler
        {
            if (_self == null)
            {
                _self = new (FormulaHandler)();
            };
            return (_self);
        }

        public static function createMonsterData(pLevel:int, pXp:int, pHiddenLevel:uint):MonsterData
        {
            return (new MonsterData(pLevel, pXp, pHiddenLevel));
        }

        public static function createGroupMember(pLevel:int, pIsCompanion:Boolean=false):GroupMemberData
        {
            return (new GroupMemberData(pLevel, pIsCompanion));
        }

        public static function createPlayerData(pLevel:int, pWisdom:int=0, pXpBonus:Number=0, pXpMount:Number=0, pXpGuild:Number=0, pXpAlliancePrismBonus:Number=0):PlayerData
        {
            return (new PlayerData(pLevel, pWisdom, pXpBonus, pXpMount, pXpGuild, pXpAlliancePrismBonus));
        }

        public static function getArenaMalusDrop(pLootShare:int, pMembers:int):int
        {
            var malus:int = int(Math.round((100 - ((pLootShare / pMembers) * 100))));
            return ((malus < 0) ? 0 : malus);
        }


        private function clearData():void
        {
            this._xpSolo = 0;
            this._xpGroup = 0;
        }

        public function initXpFormula(pPlayerData:PlayerData, pMonstersList:Array, pMembersList:Array, pMapRewardRate:int=0, pXpIdolsBonusPercentSolo:int=0, pXpIdolsBonusPercentGroup:int=0):void
        {
            var mob:MonsterData;
            var lvlPlayers:uint;
            var lvlMaxGroup:uint;
            var totalPlayerForBonusGroup:uint;
            var member:GroupMemberData;
            var coeffDiffLvlGroup:Number;
            var ratioXpMontureSolo:Number;
            var ratioXpMontureGroup:Number;
            var ratioXpGuildSolo:Number;
            var ratioXpGuildGroup:Number;
            var xpAlliancePrismBonus:Number;
            this.clearData();
            var xpBase:uint;
            var maxLvlMonster:uint;
            var lvlMonsters:uint;
            var hiddenLvlMonsters:uint;
            for each (mob in pMonstersList)
            {
                xpBase = (xpBase + mob.xp);
                lvlMonsters = (lvlMonsters + mob.level);
                hiddenLvlMonsters = (hiddenLvlMonsters + ((mob.hiddenLevel > 0) ? mob.hiddenLevel : mob.level));
                if (mob.level > maxLvlMonster)
                {
                    maxLvlMonster = mob.level;
                };
            };
            lvlPlayers = 0;
            lvlMaxGroup = 0;
            totalPlayerForBonusGroup = 0;
            for each (member in pMembersList)
            {
                lvlPlayers = (lvlPlayers + member.level);
                if (member.level > lvlMaxGroup)
                {
                    lvlMaxGroup = member.level;
                };
            };
            for each (member in pMembersList)
            {
                if (((!(member.companion)) && (member.level >= (lvlMaxGroup / 3))))
                {
                    totalPlayerForBonusGroup++;
                };
            };
            coeffDiffLvlGroup = 1;
            if ((lvlPlayers - 5) > lvlMonsters)
            {
                coeffDiffLvlGroup = (lvlMonsters / lvlPlayers);
            }
            else
            {
                if ((lvlPlayers + 10) < lvlMonsters)
                {
                    coeffDiffLvlGroup = ((lvlPlayers + 10) / lvlMonsters);
                };
            };
            var coeffDiffLvlSolo:Number = 1;
            if ((pPlayerData.level - 5) > lvlMonsters)
            {
                coeffDiffLvlSolo = (lvlMonsters / pPlayerData.level);
            }
            else
            {
                if ((pPlayerData.level + 10) < lvlMonsters)
                {
                    coeffDiffLvlSolo = ((pPlayerData.level + 10) / lvlMonsters);
                };
            };
            var v:uint = Math.min(pPlayerData.level, this.truncate((2.5 * maxLvlMonster)));
            var xpLimitMaxLvlSolo:Number = ((v / pPlayerData.level) * 100);
            var xpLimitMaxLvlGroup:Number = ((v / lvlPlayers) * 100);
            var xpGroupAlone:uint = this.truncate(((xpBase * XP_GROUP[0]) * coeffDiffLvlSolo));
            if (totalPlayerForBonusGroup == 0)
            {
                totalPlayerForBonusGroup = 1;
            };
            var xpGroup:uint = this.truncate(((xpBase * XP_GROUP[(totalPlayerForBonusGroup - 1)]) * coeffDiffLvlGroup));
            var xpNoSagesseAlone:uint = uint(this.truncate(((xpLimitMaxLvlSolo / 100) * xpGroupAlone)));
            var xpNoSagesseGroup:uint = uint(this.truncate(((xpLimitMaxLvlGroup / 100) * xpGroup)));
            var realMapRewardRate:Number = ((100 + pMapRewardRate) / 100);
            var lvlMalusIdolsSolo:Number = Math.min(MAX_LEVEL_MALUS, ((hiddenLvlMonsters / pMonstersList.length) / pPlayerData.level));
            lvlMalusIdolsSolo = (lvlMalusIdolsSolo * lvlMalusIdolsSolo);
            var lvlMalusIdolsGroup:Number = Math.min(MAX_LEVEL_MALUS, ((hiddenLvlMonsters / pMonstersList.length) / lvlMaxGroup));
            lvlMalusIdolsGroup = (lvlMalusIdolsGroup * lvlMalusIdolsGroup);
            var idolsWisdomBonusSolo:int = int(this.truncate((((100 + (pPlayerData.level * 2.5)) * this.truncate((pXpIdolsBonusPercentSolo * lvlMalusIdolsSolo))) / 100)));
            var idolsWisdomBonusGroup:int = int(this.truncate((((100 + (pPlayerData.level * 2.5)) * this.truncate((pXpIdolsBonusPercentGroup * lvlMalusIdolsGroup))) / 100)));
            var totalWisdomSolo:uint = Math.max((pPlayerData.wisdom + idolsWisdomBonusSolo), 0);
            var totalWisdomGroup:uint = Math.max((pPlayerData.wisdom + idolsWisdomBonusGroup), 0);
            var xpTotalOnePlayer:uint = this.truncate((this.truncate(((xpNoSagesseAlone * (100 + totalWisdomSolo)) / 100)) * realMapRewardRate));
            var xpTotalGroup:uint = this.truncate((this.truncate(((xpNoSagesseGroup * (100 + totalWisdomGroup)) / 100)) * realMapRewardRate));
            var xpBonus:Number = (1 + (pPlayerData.xpBonusPercent / 100));
            var tmpSolo:Number = xpTotalOnePlayer;
            var tmpGroup:Number = xpTotalGroup;
            if (pPlayerData.xpRatioMount > 0)
            {
                ratioXpMontureSolo = ((tmpSolo * pPlayerData.xpRatioMount) / 100);
                ratioXpMontureGroup = ((tmpGroup * pPlayerData.xpRatioMount) / 100);
                tmpSolo = this.truncate((tmpSolo - ratioXpMontureSolo));
                tmpGroup = this.truncate((tmpGroup - ratioXpMontureGroup));
            };
            tmpSolo = (tmpSolo * xpBonus);
            tmpGroup = (tmpGroup * xpBonus);
            if (pPlayerData.xpGuildGivenPercent > 0)
            {
                ratioXpGuildSolo = ((tmpSolo * pPlayerData.xpGuildGivenPercent) / 100);
                ratioXpGuildGroup = ((tmpGroup * pPlayerData.xpGuildGivenPercent) / 100);
                tmpSolo = (tmpSolo - ratioXpGuildSolo);
                tmpGroup = (tmpGroup - ratioXpGuildGroup);
            };
            if (pPlayerData.xpAlliancePrismBonusPercent > 0)
            {
                xpAlliancePrismBonus = (1 + (pPlayerData.xpAlliancePrismBonusPercent / 100));
                tmpSolo = (tmpSolo * xpAlliancePrismBonus);
                tmpGroup = (tmpGroup * xpAlliancePrismBonus);
            };
            xpTotalOnePlayer = this.truncate(tmpSolo);
            xpTotalGroup = this.truncate(tmpGroup);
            this._xpSolo = ((xpBase > 0) ? Math.max(xpTotalOnePlayer, 1) : 0);
            this._xpGroup = ((xpBase > 0) ? Math.max(xpTotalGroup, 1) : 0);
        }

        private function truncate(val:Number):int
        {
            var multiplier:uint = Math.pow(10, 0);
            var truncatedVal:Number = (val * multiplier);
            return (int(truncatedVal) / multiplier);
        }

        public function get xpSolo():Number
        {
            return (this._xpSolo);
        }

        public function get xpGroup():Number
        {
            return (this._xpGroup);
        }


    }
}

class MonsterData 
{

    public var xp:int;
    public var level:int;
    public var hiddenLevel:uint;

    public function MonsterData(pLevel:int, pXp:int, pHiddenLevel:uint):void
    {
        this.xp = pXp;
        this.level = pLevel;
        this.hiddenLevel = pHiddenLevel;
    }

}

class GroupMemberData 
{

    public var level:int;
    public var companion:Boolean;

    public function GroupMemberData(pLevel:int, pIsCompanion:Boolean):void
    {
        this.level = pLevel;
        this.companion = pIsCompanion;
    }

}

class PlayerData 
{

    public var level:int;
    public var wisdom:int;
    public var xpBonusPercent:Number;
    public var xpRatioMount:Number;
    public var xpGuildGivenPercent:Number;
    public var xpAlliancePrismBonusPercent:Number;

    public function PlayerData(pLevel:int, pWisdom:int=0, pXpBonus:Number=0, pXpMount:Number=0, pXpGuild:Number=0, pXpAlliancePrismBonus:Number=0):void
    {
        this.level = pLevel;
        this.wisdom = pWisdom;
        this.xpBonusPercent = pXpBonus;
        this.xpRatioMount = pXpMount;
        this.xpGuildGivenPercent = pXpGuild;
        this.xpAlliancePrismBonusPercent = pXpAlliancePrismBonus;
    }

}


