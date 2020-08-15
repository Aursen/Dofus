package Ankama_Tooltips.ui
{
    import flash.geom.ColorTransform;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.PartyApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.RoleplayApi;
    import com.ankamagames.dofus.uiApi.BreachApi;
    import com.ankamagames.dofus.uiApi.LuaApi;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
    import com.ankamagames.dofus.network.types.game.guild.GuildMember;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import Ankama_Tooltips.utils.FormulaHandler;
    import com.ankamagames.dofus.datacenter.idols.Idol;
    import __AS3__.vec.*;

    public class BreachMonstersGroupTooltipUi 
    {

        private static const WAVE_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1, 1, 1, 1, 202, 173, -13);
        private static const WAVE_SIZE:uint = 4;

        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="PartyApi")]
        public var partyApi:PartyApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Api(name="RoleplayApi")]
        public var roleplayApi:RoleplayApi;
        [Api(name="BreachApi")]
        public var breachApi:BreachApi;
        [Api(name="LuaApi")]
        public var luaApi:LuaApi;
        private var _monsters:Vector.<MonsterInGroupLightInformations>;
        private var _mainMonstersCount:uint;
        private var _formulaGroupMembers:Array;
        private var _playerData:*;
        private var _isInParty:Boolean;
        private var _score:int;
        private var _relativeScore:int;
        private var _expMultiplier:Number;
        public var mainCtr:GraphicContainer;
        public var ctr_wave:GraphicContainer;
        public var ctr_xp:GraphicContainer;
        public var ctr_back:GraphicContainer;
        public var ctr_main:GraphicContainer;
        public var ctr_header:GraphicContainer;
        public var ctr_separatorXp:GraphicContainer;
        public var lbl_level:Label;
        public var lbl_monsterList:Label;
        public var lbl_nbWaves:Label;
        public var lbl_monsterXp:Label;
        public var tx_wave:Texture;


        public function main(oParams:*=null):void
        {
            var monster:Monster;
            var id:uint;
            var waveXpSolo:Number;
            var waveXpGroup:Number;
            var waveData:MonstersGroupData;
            var wavesCount:uint;
            var currentWaveCount:uint;
            var currentWaveMonstersIds:Vector.<MonsterInGroupLightInformations>;
            this._monsters = oParams.data.monsterGroup;
            this._score = oParams.data.score;
            this._relativeScore = oParams.data.relativeScore;
            if (this._monsters.length <= 5)
            {
                this._mainMonstersCount = this._monsters.length;
            }
            else
            {
                if ((this._monsters.length % WAVE_SIZE) != 0)
                {
                    this._mainMonstersCount = 5;
                }
                else
                {
                    this._mainMonstersCount = 4;
                };
            };
            var mainMonsters:Vector.<MonsterInGroupLightInformations> = this._monsters.concat().splice(0, this._mainMonstersCount);
            var waveMonsters:Vector.<MonsterInGroupLightInformations> = this._monsters.concat().splice(this._mainMonstersCount, (this._monsters.length - this._mainMonstersCount));
            this.ctr_back.width = 1;
            this.ctr_wave.height = 1;
            this.lbl_monsterList.width = 1;
            this.lbl_monsterXp.width = 1;
            this.ctr_header.width = 1;
            this.ctr_separatorXp.width = 1;
            this._expMultiplier = this.luaApi.getFightExpMultiplier(this.breachApi.getFloor(), this._score, this._relativeScore);
            this.setPlayerData();
            var groupData:MonstersGroupData = this.getBreachMonstersGroupData(mainMonsters, this._playerData, this._formulaGroupMembers);
            this.lbl_level.text = ((this.uiApi.getText("ui.common.level") + " ") + groupData.level);
            var xpText:String = "";
            var textList:String = "";
            var grp:Vector.<uint> = this.sortMonsters();
            for each (id in grp)
            {
                monster = this.dataApi.getMonsterFromId(id);
                textList = (textList + (((("\n" + monster.name) + " (") + this.breachApi.getFloor()) + ")"));
            };
            if (textList)
            {
                textList = textList.substr(1);
            };
            this._isInParty = (this._formulaGroupMembers.length > 0);
            if (this._monsters.length > this._mainMonstersCount)
            {
                this.tx_wave.colorTransform = WAVE_COLOR_TRANSFORM;
                this.ctr_wave.visible = true;
                this.lbl_nbWaves.text = ("x " + (Math.floor((waveMonsters.length / WAVE_SIZE)) + 1));
                this.lbl_nbWaves.fullWidthAndHeight();
                this.ctr_wave.height = this.lbl_nbWaves.height;
                waveXpSolo = groupData.xpSolo;
                waveXpGroup = groupData.xpGroup;
                wavesCount = uint((waveMonsters.length / WAVE_SIZE));
                currentWaveCount = 0;
                while (currentWaveCount < wavesCount)
                {
                    currentWaveMonstersIds = waveMonsters.splice(0, WAVE_SIZE);
                    waveData = this.getBreachMonstersGroupData(currentWaveMonstersIds, this._playerData, this._formulaGroupMembers);
                    waveXpSolo = (waveXpSolo + waveData.xpSolo);
                    waveXpGroup = (waveXpGroup + waveData.xpGroup);
                    currentWaveCount++;
                };
                xpText = (xpText + this.uiApi.getText("ui.tooltip.monsterXpAlone", this.utilApi.formateIntToString(int((waveXpSolo * this._expMultiplier)))));
                if (this._isInParty)
                {
                    xpText = (xpText + ("\n" + this.uiApi.getText("ui.tooltip.monsterXpParty", this.utilApi.formateIntToString(int((waveXpGroup * this._expMultiplier))))));
                };
            }
            else
            {
                this.hideBloc(this.ctr_wave);
                xpText = (xpText + this.uiApi.getText("ui.tooltip.monsterXpAlone", this.utilApi.formateIntToString(int((groupData.xpSolo * this._expMultiplier)))));
                if (this._isInParty)
                {
                    xpText = (xpText + ("\n" + this.uiApi.getText("ui.tooltip.monsterXpParty", this.utilApi.formateIntToString(int((groupData.xpGroup * this._expMultiplier))))));
                };
            };
            this.lbl_monsterXp.text = xpText;
            this.lbl_monsterList.text = textList;
            this.resizeLabels();
            this.tooltipApi.place(oParams.position, oParams.showDirectionalArrow, oParams.point, oParams.relativePoint, oParams.offset, true);
        }

        private function setPlayerData():void
        {
            var member:PartyMemberWrapper;
            var i:uint;
            var wisdom:int;
            var pg:GuildMember;
            var nbCompanions:int;
            var partyMembers:Object = this.breachApi.getBreachGroupPlayers();
            var currentPlayerLevel:uint = Math.min(this.playerApi.getPlayedCharacterInfo().level, ProtocolConstantsEnum.MAX_LEVEL);
            var currentPlayerCharac:Object = this.playerApi.characteristics();
            this._formulaGroupMembers = new Array();
            if (((partyMembers.length == 0) && (this.playerApi.hasCompanion())))
            {
                this._formulaGroupMembers.push(FormulaHandler.createGroupMember(currentPlayerLevel));
                this._formulaGroupMembers.push(FormulaHandler.createGroupMember(currentPlayerLevel, true));
            }
            else
            {
                for each (member in partyMembers)
                {
                    this._formulaGroupMembers.push(FormulaHandler.createGroupMember(Math.min(200, member.level)));
                    nbCompanions = member.companions.length;
                    i = 0;
                    while (i < nbCompanions)
                    {
                        this._formulaGroupMembers.push(FormulaHandler.createGroupMember(Math.min(200, member.level), true));
                        i++;
                    };
                };
            };
            wisdom = ((((currentPlayerCharac.wisdom.base + currentPlayerCharac.wisdom.additionnal) + currentPlayerCharac.wisdom.objectsAndMountBonus) + currentPlayerCharac.wisdom.alignGiftBonus) + currentPlayerCharac.wisdom.contextModif);
            pg = this.getPlayerGuild(this.playerApi.getPlayedCharacterInfo().id);
            this._playerData = FormulaHandler.createPlayerData(currentPlayerLevel, wisdom, this.playerApi.getExperienceBonusPercent(), (((!(this.playerApi.getMount() == null)) && (this.playerApi.isRidding())) ? this.playerApi.getMount().xpRatio : 0), ((pg != null) ? pg.experienceGivenPercent : 0));
        }

        private function getBreachMonstersGroupData(monsters:Vector.<MonsterInGroupLightInformations>, pPlayerData:*, pGroupMembersData:Array):MonstersGroupData
        {
            var monsterInfo:MonsterInGroupLightInformations;
            var monster:Monster;
            var formulaMobs:Array;
            var m:Object;
            var numFirstMonsters:uint;
            var idolsExpBonusTotalPercentSolo:uint;
            var idolsExpBonusTotalPercentGroup:uint;
            var groupData:MonstersGroupData;
            var level:uint;
            var grp:Array = [];
            var totalLevel:uint;
            for each (monsterInfo in monsters)
            {
                level = this.breachApi.getFloor();
                monster = this.dataApi.getMonsterFromId(monsterInfo.genericId);
                totalLevel = (totalLevel + level);
                grp.push({
                    "monsterId":monsterInfo.genericId,
                    "level":monsterInfo.level,
                    "hiddenLevel":this.luaApi.getMonsterHiddenLevel(monsterInfo.level, monster),
                    "xp":this.luaApi.getCurrentMonsterXp(this.breachApi.getFloor(), monster.isBoss)
                });
            };
            formulaMobs = new Array();
            for each (m in grp)
            {
                formulaMobs.push(FormulaHandler.createMonsterData(m.level, ((m.xp * this.roleplayApi.getMonsterXpBoostMultiplier(m.monsterId)) * this.roleplayApi.getAlmanaxMonsterXpBonusMultiplier(m.monsterId)), m.hiddenLevel));
            };
            numFirstMonsters = formulaMobs.length;
            idolsExpBonusTotalPercentSolo = this.getIdolsExpBonusPercent(this.playerApi.getSoloIdols(), numFirstMonsters, grp, 0);
            idolsExpBonusTotalPercentGroup = this.getIdolsExpBonusPercent((((!(this.playerApi.isInParty())) && (pGroupMembersData.length)) ? this.playerApi.getSoloIdols() : this.playerApi.getPartyIdols()), numFirstMonsters, grp, pGroupMembersData.length);
            FormulaHandler.getInstance().initXpFormula(pPlayerData, formulaMobs, pGroupMembersData, 0, idolsExpBonusTotalPercentSolo, idolsExpBonusTotalPercentGroup);
            groupData = new MonstersGroupData(totalLevel, grp, FormulaHandler.getInstance().xpSolo, FormulaHandler.getInstance().xpGroup);
            return (groupData);
        }

        private function sortMonsters():Vector.<uint>
        {
            var uId:Vector.<uint>;
            var sortFunc:Function = function (a:MonsterInGroupLightInformations, b:MonsterInGroupLightInformations):Number
            {
                var mA:Monster = dataApi.getMonsterFromId(a.genericId);
                var mB:Monster = dataApi.getMonsterFromId(b.genericId);
                if (mA.isBoss != mB.isBoss)
                {
                    return ((mA.isBoss) ? -1 : 1);
                };
                if (mA.isMiniBoss != mB.isMiniBoss)
                {
                    return ((mA.isBoss) ? -1 : 1);
                };
                return (0);
            };
            uId = new Vector.<uint>();
            var removeFunc:Function = function (a:MonsterInGroupLightInformations, index:int, vector:Vector.<MonsterInGroupLightInformations>):void
            {
                if (((uId.indexOf(a.genericId) == -1) || (_monsters.length <= _mainMonstersCount)))
                {
                    uId.push(a.genericId);
                };
            };
            this._monsters.sort(sortFunc).forEach(removeFunc);
            return (uId);
        }

        private function getIdolsExpBonusPercent(pIdolsList:Object, pNumFirstMonsters:uint, pMonsters:Array, pNbAllies:uint):uint
        {
            var i:int;
            var coeff:Number;
            var idol:Idol;
            var incompatibleIdol:Boolean;
            var monster:Monster;
            var m:Object;
            var numIdols:uint = pIdolsList.length;
            var idolsExpBonusTotalPercent:uint;
            var enabledIdols:Vector.<uint> = new Vector.<uint>(0);
            i = 0;
            while (i < numIdols)
            {
                idol = this.dataApi.getIdol(pIdolsList[i]);
                incompatibleIdol = false;
                for each (m in pMonsters)
                {
                    monster = this.dataApi.getMonsterFromId(m.monsterId);
                    if (monster.incompatibleIdols.indexOf(idol.id) != -1)
                    {
                        incompatibleIdol = true;
                        break;
                    };
                };
                if (((incompatibleIdol) || ((idol.groupOnly) && ((pNbAllies < 4) || (pNumFirstMonsters < 4)))))
                {
                }
                else
                {
                    enabledIdols.push(pIdolsList[i]);
                };
                i++;
            };
            numIdols = enabledIdols.length;
            i = 0;
            while (i < numIdols)
            {
                idol = this.dataApi.getIdol(enabledIdols[i]);
                coeff = this.getIdolCoeff(idol, enabledIdols);
                idolsExpBonusTotalPercent = (idolsExpBonusTotalPercent + (idol.experienceBonus * coeff));
                i++;
            };
            return (idolsExpBonusTotalPercent);
        }

        private function getIdolCoeff(pIdol:Idol, pIdolsList:Object):Number
        {
            var i:int;
            var j:int;
            var coeff:Number = 1;
            var synergiesIds:Object = pIdol.synergyIdolsIds;
            var synergiesCoeffs:Object = pIdol.synergyIdolsCoeff;
            var numSynergies:uint = synergiesIds.length;
            var numActiveIdols:uint = pIdolsList.length;
            i = 0;
            while (i < numActiveIdols)
            {
                j = 0;
                while (j < numSynergies)
                {
                    if (synergiesIds[j] == pIdolsList[i])
                    {
                        coeff = (coeff * synergiesCoeffs[j]);
                    };
                    j++;
                };
                i++;
            };
            return (coeff);
        }

        private function getPlayerGuild(idPlayer:Number):GuildMember
        {
            var mem:GuildMember;
            for each (mem in this.socialApi.getGuildMembers())
            {
                if (mem.id == idPlayer)
                {
                    return (mem);
                };
            };
            return (null);
        }

        private function hideBloc(ctr:GraphicContainer):void
        {
            ctr.height = 0;
            ctr.visible = false;
        }

        private function getMaxWidth():int
        {
            var maxValue:int;
            if (((this.lbl_level.width > this.lbl_monsterList.width) && (this.lbl_level.width > this.lbl_monsterXp.width)))
            {
                maxValue = this.lbl_level.width;
            }
            else
            {
                if ((((this.lbl_monsterXp.visible) && (this.lbl_monsterXp.width > this.lbl_monsterList.width)) && (this.lbl_monsterXp.width > this.lbl_level.width)))
                {
                    maxValue = this.lbl_monsterXp.width;
                }
                else
                {
                    maxValue = this.lbl_monsterList.width;
                };
            };
            return (maxValue);
        }

        private function resizeLabels():void
        {
            this.lbl_monsterList.fullWidthAndHeight();
            this.lbl_monsterXp.fullWidthAndHeight();
            this.lbl_level.fullWidthAndHeight();
            var maxWidth:int = this.getMaxWidth();
            this.lbl_monsterList.width = maxWidth;
            this.lbl_monsterXp.width = maxWidth;
            this.lbl_level.width = maxWidth;
            this.ctr_xp.width = maxWidth;
            this.ctr_header.width = maxWidth;
            this.ctr_main.width = maxWidth;
            this.ctr_separatorXp.width = maxWidth;
            if (this.ctr_wave.visible)
            {
                this.tx_wave.x = ((maxWidth / 2) - ((this.tx_wave.width + this.lbl_nbWaves.width) / 2));
                this.lbl_nbWaves.x = (this.tx_wave.x + this.tx_wave.width);
                this.ctr_wave.y = (this.ctr_header.y + this.ctr_header.contentHeight);
                this.ctr_xp.y = (this.ctr_wave.y + this.ctr_wave.contentHeight);
            }
            else
            {
                this.ctr_xp.y = (this.ctr_header.y + this.ctr_header.contentHeight);
            };
            this.ctr_separatorXp.y = (this.ctr_xp.y + this.ctr_xp.contentHeight);
            this.lbl_monsterList.y = (this.ctr_separatorXp.y + this.ctr_separatorXp.height);
            this.ctr_back.width = (maxWidth + 8);
            var firstInit:* = (this.ctr_back.height == 0);
            var backHeight:Number = this.ctr_main.height;
            var th:int = (this.ctr_separatorXp.y + this.lbl_monsterList.height);
            if (backHeight < th)
            {
                backHeight = th;
            };
            if (firstInit)
            {
                if (this._isInParty)
                {
                    backHeight = (backHeight + 21);
                };
            };
            this.ctr_back.height = (backHeight + 8);
        }


    }
}

class MonstersGroupData 
{

    /*private*/ var _level:int;
    /*private*/ var _group:Array;
    /*private*/ var _xpSolo:Number;
    /*private*/ var _xpGroup:Number;

    public function MonstersGroupData(pLevel:int, pGroup:Array, pXpSolo:Number, pXpGroup:Number)
    {
        this._level = pLevel;
        this._group = pGroup;
        this._xpSolo = pXpSolo;
        this._xpGroup = pXpGroup;
    }

    public function get level():int
    {
        return (this._level);
    }

    public function get group():Array
    {
        return (this._group);
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


