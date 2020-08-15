package Ankama_GameUiCore.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.QuestApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.AveragePricesApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.dofus.datacenter.quest.AchievementCategory;
    import com.ankamagames.dofus.network.types.game.guild.GuildMember;
    import d2hooks.GuildInformationsMemberUpdate;
    import d2hooks.GameFightEnd;
    import d2hooks.GameFightLeave;
    import d2hooks.GameFightJoin;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.internalDatacenter.appearance.TitleWrapper;
    import com.ankamagames.dofus.internalDatacenter.appearance.OrnamentWrapper;
    import com.ankamagames.dofus.network.types.game.achievement.AchievementAchievedRewardable;
    import com.ankamagames.dofus.datacenter.quest.Achievement;
    import com.ankamagames.dofus.internalDatacenter.quest.AchievementRewardsWrapper;
    import com.ankamagames.dofus.network.types.game.dare.DareReward;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.network.enums.DareRewardTypeEnum;
    import d2hooks.RewardsOpenClose;
    import d2actions.AchievementRewardRequest;
    import d2actions.DareRewardRequest;
    import d2actions.OpenBook;
    import d2hooks.OpenDareSearch;
    import com.ankamagames.berilia.types.LocationEnum;
    import d2hooks.*;
    import d2actions.*;

    public class RewardsUi 
    {

        private static const TEMPORIS_4_CATEGORY:uint = 107;

        private const TYPE_ACHIEVEMENT_REWARD:int = 0;
        private const TYPE_GIFT:int = 1;
        private const TYPE_DARE_REWARD:int = 2;

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="QuestApi")]
        public var questApi:QuestApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="AveragePricesApi")]
        public var averagePricesApi:AveragePricesApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        private var _componentDict:Dictionary = new Dictionary(true);
        private var _achievementCategories:Array = new Array();
        private var _myGuildXp:int;
        public var ctr_mainWindow:GraphicContainer;
        public var ctr_rewards:GraphicContainer;
        public var ctr_grid:GraphicContainer;
        public var gd_rewards:Grid;
        public var ctr_bottom:GraphicContainer;
        public var btn_acceptAll:ButtonContainer;
        public var btn_close:ButtonContainer;
        public var btn_help:ButtonContainer;
        public var btn_rewards:ButtonContainer;


        public function main(param:Object=null):void
        {
            var cat:AchievementCategory;
            var meMember:GuildMember;
            var myId:Number;
            var mem:GuildMember;
            this.sysApi.addHook(GuildInformationsMemberUpdate, this.onGuildInformationsMemberUpdate);
            this.sysApi.addHook(GameFightEnd, this.onGameFightEnd);
            this.sysApi.addHook(GameFightLeave, this.onGameFightLeave);
            this.sysApi.addHook(GameFightJoin, this.onGameFightJoin);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addComponentHook(this.btn_rewards, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_rewards, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_acceptAll, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_acceptAll, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_help, ComponentHookList.ON_RELEASE);
            if (this.socialApi.hasGuild())
            {
                myId = this.playerApi.id();
                for each (mem in this.socialApi.getGuildMembers())
                {
                    if (mem.id == myId)
                    {
                        meMember = mem;
                        break;
                    };
                };
                this._myGuildXp = meMember.experienceGivenPercent;
            };
            for each (cat in this.dataApi.getAchievementCategories())
            {
                this._achievementCategories[cat.id] = cat;
            };
            this.ctr_mainWindow.visible = false;
            this.ctr_rewards.visible = (!(this.playerApi.isInFight()));
            this.updateList(true);
        }

        public function unload():void
        {
            this.uiApi.hideTooltip();
        }

        public function updateAchievementLine(data:*, compRef:*, selected:Boolean):void
        {
            var rewardsSlotContent:Array;
            var i:int;
            var rewardId:uint;
            var item:ItemWrapper;
            var emote:EmoteWrapper;
            var spell:SpellWrapper;
            var title:TitleWrapper;
            var ornament:OrnamentWrapper;
            if (data)
            {
                compRef.lbl_title.text = data.title;
                if (this.sysApi.getPlayerManager().hasRights)
                {
                    compRef.lbl_title.text = (compRef.lbl_title.text + ((" (" + data.id) + ")"));
                };
                compRef.lbl_category.text = data.subtitle;
                if (data.type != this.TYPE_GIFT)
                {
                    compRef.lbl_title.handCursor = true;
                }
                else
                {
                    compRef.lbl_title.handCursor = false;
                };
                if (data.kamas > 0)
                {
                    compRef.lbl_rewardsKama.text = this.utilApi.formateIntToString(data.kamas);
                }
                else
                {
                    compRef.lbl_rewardsKama.text = "0";
                };
                if (data.xp > 0)
                {
                    compRef.lbl_rewardsXp.text = this.utilApi.formateIntToString(data.xp);
                }
                else
                {
                    compRef.lbl_rewardsXp.text = "0";
                };
                rewardsSlotContent = new Array();
                if (data.rewardData)
                {
                    i = 0;
                    while (i < data.rewardData.itemsReward.length)
                    {
                        if ((data.rewardData.itemsReward[i] is int))
                        {
                            item = this.dataApi.getItemWrapper(data.rewardData.itemsReward[i], 0, 0, data.rewardData.itemsQuantityReward[i]);
                            rewardsSlotContent.push(item);
                        }
                        else
                        {
                            rewardsSlotContent.push((data.rewardData.itemsReward[i] as ItemWrapper));
                        };
                        i++;
                    };
                    for each (rewardId in data.rewardData.emotesReward)
                    {
                        emote = this.dataApi.getEmoteWrapper(rewardId);
                        rewardsSlotContent.push(emote);
                    };
                    for each (rewardId in data.rewardData.spellsReward)
                    {
                        spell = this.dataApi.getSpellWrapper(rewardId);
                        rewardsSlotContent.push(spell);
                    };
                    for each (rewardId in data.rewardData.titlesReward)
                    {
                        title = this.dataApi.getTitleWrapper(rewardId);
                        rewardsSlotContent.push(title);
                    };
                    for each (rewardId in data.rewardData.ornamentsReward)
                    {
                        ornament = this.dataApi.getOrnamentWrapper(rewardId);
                        rewardsSlotContent.push(ornament);
                    };
                };
                compRef.gd_rewards.dataProvider = rewardsSlotContent;
                if (!this._componentDict[compRef.gd_rewards.name])
                {
                    this.uiApi.addComponentHook(compRef.gd_rewards, ComponentHookList.ON_ITEM_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.gd_rewards, ComponentHookList.ON_ITEM_ROLL_OUT);
                };
                this._componentDict[compRef.gd_rewards.name] = data;
                if (!this._componentDict[compRef.btn_acceptOne.name])
                {
                    this.uiApi.addComponentHook(compRef.btn_acceptOne, ComponentHookList.ON_RELEASE);
                    this.uiApi.addComponentHook(compRef.btn_acceptOne, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.btn_acceptOne, ComponentHookList.ON_ROLL_OUT);
                };
                this._componentDict[compRef.btn_acceptOne.name] = data;
                if (data.type != this.TYPE_GIFT)
                {
                    if (!this._componentDict[compRef.lbl_title.name])
                    {
                        this.uiApi.addComponentHook(compRef.lbl_title, ComponentHookList.ON_RELEASE);
                    };
                    this._componentDict[compRef.lbl_title.name] = [data.type, data.id];
                };
                compRef.ctr_achievement.visible = true;
            }
            else
            {
                compRef.ctr_achievement.visible = false;
            };
        }

        public function updateList(firstOpening:Boolean=false):void
        {
            var reward:Object;
            var rewardable:AchievementAchievedRewardable;
            var ach:Achievement;
            var cat:AchievementCategory;
            var rewards:AchievementRewardsWrapper;
            var subtitle:String;
            var dr:DareReward;
            var monster:Monster;
            var monsterName:String;
            var nbLineToRemove:int;
            var lineHeight:int;
            var oldLength:int = this.gd_rewards.dataProvider.length;
            var dp:Array = new Array();
            var apiRewardablesList:Object = this.questApi.getRewardableAchievements();
            if (apiRewardablesList.length > 0)
            {
                for each (rewardable in apiRewardablesList)
                {
                    ach = this.dataApi.getAchievement(rewardable.id);
                    if (!ach)
                    {
                    }
                    else
                    {
                        cat = ach.category;
                        if (((cat === null) || (cat.id === TEMPORIS_4_CATEGORY)))
                        {
                        }
                        else
                        {
                            if (cat.parentId != 0)
                            {
                                cat = this._achievementCategories[cat.parentId];
                            };
                            reward = {
                                "title":ach.name,
                                "subtitle":cat.name,
                                "rewardData":null,
                                "kamas":0,
                                "xp":0,
                                "id":rewardable.id,
                                "type":this.TYPE_ACHIEVEMENT_REWARD
                            };
                            rewards = this.questApi.getAchievementReward(ach, rewardable.finishedlevel);
                            reward.rewardData = rewards;
                            reward.kamas = this.questApi.getAchievementKamasReward(ach, rewardable.finishedlevel);
                            reward.xp = this.questApi.getAchievementExperienceReward(ach, rewardable.finishedlevel);
                            dp.push(reward);
                        };
                    };
                };
            };
            var dareRewardsList:Object = this.socialApi.getDareRewards();
            if (dareRewardsList.length > 0)
            {
                subtitle = "";
                for each (dr in dareRewardsList)
                {
                    switch (dr.type)
                    {
                        case DareRewardTypeEnum.DARE_REWARD_TYPE_JACKPOT:
                            subtitle = this.uiApi.getText("ui.dare.jackpot");
                            break;
                        case DareRewardTypeEnum.DARE_REWARD_TYPE_PARTICIPATION_REFILL:
                        case DareRewardTypeEnum.DARE_REWARD_TYPE_OWNER_JACKPOT_REFILL:
                            subtitle = this.uiApi.getText("ui.dare.refund");
                            break;
                        case DareRewardTypeEnum.DARE_REWARD_TYPE_OWNER_PARTICIPATION:
                            subtitle = this.uiApi.getText("ui.dare.reward.participation");
                            break;
                    };
                    monster = this.dataApi.getMonsterFromId(dr.monsterId);
                    monsterName = "";
                    if (monster)
                    {
                        monsterName = monster.name;
                    };
                    reward = {
                        "title":((this.uiApi.getText("ui.dare.dareShort") + this.uiApi.getText("ui.common.colon")) + monsterName),
                        "subtitle":subtitle,
                        "rewardData":null,
                        "kamas":dr.kamas,
                        "xp":0,
                        "id":dr.dareId,
                        "type":this.TYPE_DARE_REWARD,
                        "rewardType":dr.type
                    };
                    dp.push(reward);
                };
            };
            if (dp.length == 0)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                return;
            };
            if (((dp.length <= 4) && ((!(this.ctr_mainWindow.visible)) || (firstOpening))))
            {
                nbLineToRemove = (4 - dp.length);
                lineHeight = int(this.uiApi.me().getConstant("height_line"));
                this.ctr_mainWindow.height = (int(this.uiApi.me().getConstant("height_tx_generalBg")) - (nbLineToRemove * lineHeight));
                this.ctr_grid.height = (int(this.uiApi.me().getConstant("height_tx_gridBg")) - (nbLineToRemove * lineHeight));
                this.gd_rewards.height = (int(this.uiApi.me().getConstant("height_grid")) - (nbLineToRemove * lineHeight));
            }
            else
            {
                if (((dp.length > 4) && (!(this.ctr_mainWindow.visible))))
                {
                    this.ctr_mainWindow.height = int(this.uiApi.me().getConstant("height_tx_generalBg"));
                    this.ctr_grid.height = int(this.uiApi.me().getConstant("height_tx_gridBg"));
                    this.gd_rewards.height = int(this.uiApi.me().getConstant("height_grid"));
                };
            };
            this.gd_rewards.dataProvider = dp;
            if (firstOpening)
            {
                this.uiApi.me().render();
            };
        }

        private function getMountPercentXp():int
        {
            var xpRatio:int;
            if ((((!(this.playerApi.getMount() == null)) && (this.playerApi.isRidding())) && (this.playerApi.getMount().xpRatio > 0)))
            {
                xpRatio = this.playerApi.getMount().xpRatio;
            };
            return (xpRatio);
        }

        public function onAchievementRewardSuccess():void
        {
            this.updateList();
        }

        private function onDareRewardSuccess():void
        {
            this.updateList();
        }

        public function onGuildInformationsMemberUpdate(member:Object):void
        {
            if (member.id == this.playerApi.id())
            {
                this._myGuildXp = member.experienceGivenPercent;
            };
        }

        public function onRewardableAchievementsVisible():void
        {
            if (this.ctr_mainWindow.visible)
            {
                this.updateList();
            };
        }

        public function onDareRewardVisible():void
        {
            if (this.ctr_mainWindow.visible)
            {
                this.updateList();
            };
        }

        public function onGameFightEnd(... rest):void
        {
            this.ctr_rewards.visible = this.updateVisibility();
        }

        public function onGameFightLeave(charId:Number):void
        {
            this.ctr_rewards.visible = this.updateVisibility();
        }

        public function onGameFightJoin(... rest):void
        {
            this.ctr_rewards.visible = false;
            this.ctr_mainWindow.visible = false;
        }

        private function updateVisibility():Boolean
        {
            var rewards:* = this.questApi.getRewardableAchievements();
            var dareReward:* = this.socialApi.getDareRewards();
            return (((rewards) && (rewards.length > 0)) || ((dareReward) && (dareReward.length > 0)));
        }

        public function onRelease(target:Object):void
        {
            var data:Object;
            var achievementDescr:Object;
            switch (target)
            {
                case this.btn_close:
                    this.ctr_rewards.visible = true;
                    this.ctr_mainWindow.visible = false;
                    this.sysApi.dispatchHook(RewardsOpenClose);
                    break;
                case this.btn_acceptAll:
                    if (this.dataApi.isTemporisSpellsUi())
                    {
                        for each (achievementDescr in this.gd_rewards.dataProvider)
                        {
                            this.sysApi.sendAction(new AchievementRewardRequest(achievementDescr.id));
                        };
                    }
                    else
                    {
                        this.sysApi.sendAction(new AchievementRewardRequest(-1));
                    };
                    this.sysApi.sendAction(new DareRewardRequest(-1, 0));
                    break;
                case this.btn_help:
                    this.hintsApi.showSubHints();
                    break;
                case this.btn_rewards:
                    this.updateList((!(this.ctr_mainWindow.visible)));
                    this.ctr_mainWindow.visible = (!(this.ctr_mainWindow.visible));
                    this.sysApi.dispatchHook(RewardsOpenClose);
                    break;
                default:
                    if (target.name.indexOf("btn_acceptOne") != -1)
                    {
                        data = this._componentDict[target.name];
                        if (data.type == this.TYPE_ACHIEVEMENT_REWARD)
                        {
                            this.sysApi.sendAction(new AchievementRewardRequest(data.id));
                        }
                        else
                        {
                            if (data.type == this.TYPE_DARE_REWARD)
                            {
                                this.sysApi.sendAction(new DareRewardRequest(data.id, data.rewardType));
                            };
                        };
                    }
                    else
                    {
                        if (target.name.indexOf("lbl_title") != -1)
                        {
                            data = this._componentDict[target.name];
                            if (data[0] == this.TYPE_ACHIEVEMENT_REWARD)
                            {
                                data = new Object();
                                data.achievementId = this._componentDict[target.name][1];
                                data.forceOpen = true;
                                this.sysApi.sendAction(new OpenBook("achievementTab", data));
                            }
                            else
                            {
                                if (data[0] == this.TYPE_DARE_REWARD)
                                {
                                    this.sysApi.dispatchHook(OpenDareSearch, ("" + data[1]), "searchFilterId");
                                };
                            };
                        };
                    };
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            if (target.name.indexOf("btn_acceptOne") != -1)
            {
                text = this.uiApi.getText("ui.achievement.rewardsGet");
            };
            var myMountXp:int = this.getMountPercentXp();
            if ((((target == this.btn_acceptAll) && (myMountXp)) || (this._myGuildXp)))
            {
                text = this.uiApi.getText("ui.popup.warning");
            };
            if (myMountXp)
            {
                text = (text + ("\n" + this.uiApi.getText("ui.achievement.mountXpPercent", myMountXp)));
            };
            if (this._myGuildXp)
            {
                text = (text + ("\n" + this.uiApi.getText("ui.achievement.guildXpPercent", this._myGuildXp)));
            };
            if (target == this.btn_rewards)
            {
                text = this.uiApi.getText("ui.achievement.rewardsWaiting");
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (((item.data) && (!(target.name.indexOf("gd_rewards") == -1))))
            {
                data = item.data;
                if (((data == null) || (!(data is ItemWrapper))))
                {
                    return;
                };
                contextMenu = this.menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var text:String;
            var pos:Object;
            if (((item.data) && (!(target.name.indexOf("gd_rewards") == -1))))
            {
                pos = {
                    "point":LocationEnum.POINT_BOTTOM,
                    "relativePoint":LocationEnum.POINT_TOP
                };
                if ((item.data is ItemWrapper))
                {
                    text = item.data.name;
                    text = (text + this.averagePricesApi.getItemAveragePriceString(item.data, true));
                }
                else
                {
                    if ((item.data is EmoteWrapper))
                    {
                        text = this.uiApi.getText("ui.common.emote", item.data.emote.name);
                    }
                    else
                    {
                        if ((item.data is SpellWrapper))
                        {
                            text = this.uiApi.getText("ui.common.spell", item.data.spell.name);
                        }
                        else
                        {
                            if ((item.data is TitleWrapper))
                            {
                                text = this.uiApi.getText("ui.common.title", item.data.title.name);
                            }
                            else
                            {
                                if ((item.data is OrnamentWrapper))
                                {
                                    text = this.uiApi.getText("ui.common.ornament", item.data.name);
                                };
                            };
                        };
                    };
                };
                if (text)
                {
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
                };
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "closeUi":
                    if (!this.ctr_mainWindow.visible)
                    {
                        return (false);
                    };
                    this.ctr_mainWindow.visible = false;
                    return (true);
            };
            return (false);
        }


    }
}

