package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.types.data.UiModule;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.datacenter.world.Hint;
    import com.ankamagames.dofus.datacenter.items.Item;
    import com.ankamagames.dofus.datacenter.world.Dungeon;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.datacenter.notifications.Notification;
    import com.ankamagames.dofus.datacenter.servers.Server;
    import com.ankamagames.dofus.datacenter.servers.ServerPopulation;
    import com.ankamagames.dofus.datacenter.breeds.Breed;
    import com.ankamagames.dofus.datacenter.breeds.BreedRole;
    import com.ankamagames.dofus.datacenter.breeds.Head;
    import com.ankamagames.dofus.datacenter.characteristics.Characteristic;
    import com.ankamagames.dofus.datacenter.characteristics.CharacteristicCategory;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.datacenter.spells.SpellConversion;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.datacenter.spells.SpellVariant;
    import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
    import com.ankamagames.dofus.internalDatacenter.userInterface.ButtonWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
    import com.ankamagames.dofus.datacenter.jobs.Job;
    import com.ankamagames.dofus.internalDatacenter.jobs.JobWrapper;
    import com.ankamagames.dofus.internalDatacenter.appearance.TitleWrapper;
    import com.ankamagames.dofus.internalDatacenter.appearance.OrnamentWrapper;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.dofus.datacenter.spells.SpellType;
    import com.ankamagames.dofus.datacenter.spells.SpellState;
    import com.ankamagames.dofus.datacenter.communication.ChatChannel;
    import com.ankamagames.dofus.datacenter.world.Area;
    import com.ankamagames.dofus.datacenter.world.SuperArea;
    import com.ankamagames.jerakine.types.positions.WorldPoint;
    import com.ankamagames.dofus.datacenter.items.IncarnationLevel;
    import com.ankamagames.dofus.datacenter.items.Incarnation;
    import com.ankamagames.dofus.types.data.GenericSlotData;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.dofus.datacenter.items.ItemType;
    import com.ankamagames.dofus.datacenter.items.ItemSet;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
    import com.ankamagames.dofus.datacenter.effects.Effect;
    import com.ankamagames.dofus.datacenter.arena.ArenaLeague;
    import com.ankamagames.dofus.datacenter.arena.ArenaLeagueSeason;
    import com.ankamagames.dofus.datacenter.arena.ArenaLeagueReward;
    import com.ankamagames.dofus.datacenter.monsters.MonsterMiniBoss;
    import com.ankamagames.dofus.datacenter.monsters.MonsterRace;
    import com.ankamagames.dofus.datacenter.monsters.MonsterSuperRace;
    import com.ankamagames.dofus.datacenter.monsters.Companion;
    import com.ankamagames.dofus.datacenter.monsters.CompanionCharacteristic;
    import com.ankamagames.dofus.datacenter.monsters.CompanionSpell;
    import com.ankamagames.dofus.datacenter.npcs.Npc;
    import com.ankamagames.dofus.datacenter.npcs.NpcAction;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentSide;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentBalance;
    import com.ankamagames.dofus.datacenter.guild.RankName;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.datacenter.jobs.Skill;
    import com.ankamagames.dofus.datacenter.communication.InfoMessage;
    import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
    import com.ankamagames.dofus.datacenter.communication.Smiley;
    import com.ankamagames.dofus.datacenter.communication.SmileyCategory;
    import com.ankamagames.dofus.datacenter.communication.SmileyPack;
    import com.ankamagames.dofus.datacenter.communication.Emoticon;
    import com.ankamagames.dofus.datacenter.challenges.Challenge;
    import com.ankamagames.dofus.internalDatacenter.fight.ChallengeWrapper;
    import com.ankamagames.dofus.datacenter.dare.DareCriteria;
    import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
    import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
    import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
    import com.ankamagames.dofus.datacenter.guild.EmblemBackground;
    import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
    import com.ankamagames.dofus.datacenter.guild.EmblemSymbolCategory;
    import com.ankamagames.dofus.datacenter.quest.Quest;
    import com.ankamagames.dofus.datacenter.quest.QuestCategory;
    import com.ankamagames.dofus.datacenter.quest.QuestObjective;
    import com.ankamagames.dofus.datacenter.quest.QuestStep;
    import com.ankamagames.dofus.datacenter.quest.Achievement;
    import com.ankamagames.dofus.datacenter.quest.AchievementCategory;
    import com.ankamagames.dofus.datacenter.quest.AchievementReward;
    import com.ankamagames.dofus.datacenter.temporis.AchievementProgressStep;
    import com.ankamagames.dofus.network.types.game.achievement.AchievementAchievedRewardable;
    import com.ankamagames.dofus.datacenter.servers.ServerTemporisSeason;
    import com.ankamagames.dofus.datacenter.temporis.AchievementProgress;
    import com.ankamagames.dofus.datacenter.quest.AchievementObjective;
    import com.ankamagames.dofus.datacenter.houses.House;
    import com.ankamagames.dofus.internalDatacenter.items.LivingObjectSkinWrapper;
    import com.ankamagames.dofus.datacenter.abuse.AbuseReasons;
    import com.ankamagames.dofus.datacenter.items.PresetIcon;
    import com.ankamagames.dofus.datacenter.idols.IdolsPresetIcon;
    import com.ankamagames.dofus.datacenter.world.MapPosition;
    import com.ankamagames.dofus.datacenter.world.WorldMap;
    import com.ankamagames.dofus.datacenter.world.Waypoint;
    import com.ankamagames.dofus.datacenter.world.HintCategory;
    import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
    import com.ankamagames.dofus.datacenter.spells.SpellPair;
    import com.ankamagames.dofus.datacenter.spells.SpellBomb;
    import com.ankamagames.dofus.datacenter.misc.Pack;
    import com.ankamagames.dofus.datacenter.quest.treasureHunt.LegendaryTreasureHunt;
    import com.ankamagames.dofus.datacenter.appearance.Title;
    import com.ankamagames.dofus.datacenter.appearance.TitleCategory;
    import com.ankamagames.dofus.datacenter.appearance.Ornament;
    import com.ankamagames.dofus.datacenter.feature.OptionalFeature;
    import com.ankamagames.dofus.datacenter.items.EvolutiveItemType;
    import com.ankamagames.dofus.datacenter.effects.EvolutiveEffect;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
    import com.ankamagames.dofus.logic.game.common.managers.AlmanaxManager;
    import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxEvent;
    import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxZodiac;
    import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxMonth;
    import com.ankamagames.dofus.datacenter.almanax.AlmanaxCalendar;
    import com.ankamagames.dofus.datacenter.externalnotifications.ExternalNotification;
    import com.ankamagames.dofus.misc.utils.GameDataQuery;
    import com.ankamagames.dofus.internalDatacenter.taxi.TeleportDestinationWrapper;
    import com.ankamagames.dofus.datacenter.items.VeteranReward;
    import com.ankamagames.dofus.datacenter.misc.BreachPrize;
    import com.ankamagames.dofus.datacenter.idols.Idol;
    import com.ankamagames.dofus.datacenter.houses.HavenbagFurniture;
    import com.ankamagames.dofus.internalDatacenter.house.HavenbagFurnitureWrapper;
    import com.ankamagames.dofus.datacenter.houses.HavenbagTheme;
    import com.ankamagames.dofus.datacenter.interactives.Interactive;
    import com.ankamagames.dofus.datacenter.bonus.Bonus;
    import com.ankamagames.dofus.datacenter.mounts.MountBehavior;
    import com.ankamagames.dofus.datacenter.mounts.MountFamily;
    import com.ankamagames.dofus.datacenter.mounts.Mount;
    import com.ankamagames.dofus.datacenter.servers.ServerGameType;
    import com.ankamagames.dofus.datacenter.servers.ServerCommunity;
    import com.ankamagames.dofus.datacenter.servers.ServerLang;
    import com.ankamagames.dofus.datacenter.spells.FinishMove;
    import flash.net.registerClassAlias;
    import flash.utils.ByteArray;
    import com.ankamagames.dofus.datacenter.misc.BreachBoss;
    import com.ankamagames.dofus.datacenter.breach.BreachWorldMapCoordinate;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.logic.game.common.types.DofusShopArticle;
    import com.ankamagames.dofus.datacenter.breach.BreachDungeonModificator;
    import com.ankamagames.dofus.datacenter.breach.BreachWorldMapSector;
    import com.ankamagames.dofus.datacenter.breach.BreachInfinityLevel;
    import com.ankamagames.dofus.datacenter.items.RandomDropGroup;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.dofus.logic.game.common.misc.IInventoryView;
    import __AS3__.vec.*;

    [InstanciedApi]
    public class DataApi implements IApi 
    {

        protected static var _log:Logger = Log.getLogger(getQualifiedClassName(DataApi));
        public static var isStaticCartographyInit:Boolean = false;
        public static var dungeonsBySubArea:Dictionary = new Dictionary(true);
        public static var hintsBySubArea:Dictionary = new Dictionary(true);
        public static var allSubAreas:Dictionary = new Dictionary(true);
        public static var allHints:Dictionary = new Dictionary(true);
        public static var allItems:Dictionary = new Dictionary(true);
        public static var allMonsters:Dictionary = new Dictionary(true);
        public static var allDungeons:Dictionary = new Dictionary(true);

        private var _module:UiModule;


        public function initStaticCartographyData():void
        {
            var element:*;
            var itemIds:Vector.<uint>;
            var subArea:*;
            var monster:*;
            var harvestableId:*;
            var drop:*;
            var dungeon:*;
            var hint:*;
            if (DataApi.isStaticCartographyInit)
            {
                return;
            };
            for each (element in SubArea.getAllSubArea())
            {
                DataApi.allSubAreas[element.id] = element;
            };
            for each (element in Monster.getMonsters())
            {
                DataApi.allMonsters[element.id] = element;
            };
            for each (element in Hint.getHints())
            {
                DataApi.allHints[element.id] = element;
            };
            itemIds = new Vector.<uint>();
            for each (subArea in DataApi.allSubAreas)
            {
                for each (harvestableId in subArea.harvestables)
                {
                    if (itemIds.indexOf(harvestableId) == -1)
                    {
                        itemIds.push(harvestableId);
                    };
                };
            };
            for each (monster in DataApi.allMonsters)
            {
                for each (drop in monster.drops)
                {
                    if (itemIds.indexOf(drop.objectId) == -1)
                    {
                        itemIds.push(drop.objectId);
                    };
                };
            };
            for each (element in Item.getItemsByIds(itemIds))
            {
                DataApi.allItems[element.id] = element;
            };
            for each (element in Dungeon.getAllDungeons())
            {
                DataApi.allDungeons[element.id] = element;
            };
            for each (subArea in DataApi.allSubAreas)
            {
                for each (dungeon in DataApi.allDungeons)
                {
                    if (dungeon.undiatricalName.indexOf(subArea.undiatricalName) != -1)
                    {
                        DataApi.dungeonsBySubArea[subArea.id] = [subArea, dungeon];
                        break;
                    };
                };
                for each (hint in DataApi.allHints)
                {
                    if (hint.undiatricalName.indexOf(subArea.undiatricalName) != -1)
                    {
                        DataApi.hintsBySubArea[subArea.id] = [subArea, hint];
                        break;
                    };
                };
            };
            DataApi.isStaticCartographyInit = true;
        }

        private function get entitiesFrame():RoleplayEntitiesFrame
        {
            return (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        public function destroy():void
        {
            this._module = null;
        }

        public function getNotifications():Array
        {
            return (Notification.getNotifications());
        }

        public function getServer(id:int):Server
        {
            return (Server.getServerById(id));
        }

        public function getServerPopulation(id:int):ServerPopulation
        {
            return (ServerPopulation.getServerPopulationById(id));
        }

        public function getBreed(id:int):Breed
        {
            return (Breed.getBreedById(id));
        }

        public function getBreeds():Array
        {
            return (Breed.getBreeds());
        }

        public function getBreedRole(id:int):BreedRole
        {
            return (BreedRole.getBreedRoleById(id));
        }

        public function getBreedRoles():Array
        {
            return (BreedRole.getBreedRoles());
        }

        public function getHead(id:int):Head
        {
            return (Head.getHeadById(id));
        }

        public function getHeads():Array
        {
            return (Head.getHeads());
        }

        public function getCharacteristic(id:int):Characteristic
        {
            return (Characteristic.getCharacteristicById(id));
        }

        public function getCharacteristics():Array
        {
            return (Characteristic.getCharacteristics());
        }

        public function getCharacteristicCategory(id:int):CharacteristicCategory
        {
            return (CharacteristicCategory.getCharacteristicCategoryById(id));
        }

        public function getCharacteristicCategories():Array
        {
            return (CharacteristicCategory.getCharacteristicCategories());
        }

        public function getSpell(id:int):Spell
        {
            return (Spell.getSpellById(id));
        }

        public function getSpellConversion(id:int):SpellConversion
        {
            return (SpellConversion.getSpellConversionById(id));
        }

        public function getSpells():Array
        {
            return (Spell.getSpells());
        }

        public function getSpellWrapper(id:uint, level:uint=1, useCache:Boolean=false, playerId:Number=0, variantActivated:Boolean=false):SpellWrapper
        {
            var sw:SpellWrapper = SpellWrapper.create(id, level, useCache, playerId, variantActivated);
            return (sw);
        }

        public function getSpellVariant(id:int):SpellVariant
        {
            return (SpellVariant.getSpellVariantById(id));
        }

        public function getSpellVariants():Array
        {
            return (SpellVariant.getSpellVariants());
        }

        public function getEmoteWrapper(id:uint, position:uint=0):EmoteWrapper
        {
            return (EmoteWrapper.create(id, position));
        }

        public function getButtonWrapper(buttonId:uint, position:int, uriName:String, callback:Function, name:String, shortcutName:String="", description:String=""):ButtonWrapper
        {
            return (ButtonWrapper.create(buttonId, position, uriName, callback, name, shortcutName, description));
        }

        public function getShortcutWrapper(slot:uint, id:int, shortcutType:uint=0, gid:int=0):ShortcutWrapper
        {
            return (ShortcutWrapper.create(slot, id, shortcutType, gid));
        }

        public function getJobs():Array
        {
            return (Job.getJobs());
        }

        public function getJobWrapper(id:uint):JobWrapper
        {
            return (JobWrapper.create(id));
        }

        public function getTitleWrapper(id:uint):TitleWrapper
        {
            return (TitleWrapper.create(id));
        }

        public function getOrnamentWrapper(id:uint):OrnamentWrapper
        {
            return (OrnamentWrapper.create(id));
        }

        public function getSpellLevel(id:int):SpellLevel
        {
            return (SpellLevel.getLevelById(id));
        }

        public function getSpellLevelBySpell(spell:Spell, level:int):SpellLevel
        {
            return (spell.getSpellLevel(level));
        }

        public function getSpellType(id:int):SpellType
        {
            return (SpellType.getSpellTypeById(id));
        }

        public function getSpellState(id:int):SpellState
        {
            return (SpellState.getSpellStateById(id));
        }

        public function getChatChannel(id:int):ChatChannel
        {
            return (ChatChannel.getChannelById(id));
        }

        public function getAllChatChannels():Array
        {
            return (ChatChannel.getChannels());
        }

        public function getSubArea(id:int):SubArea
        {
            return (SubArea.getSubAreaById(id));
        }

        public function getSubAreaFromMap(mapId:Number):SubArea
        {
            return (SubArea.getSubAreaByMapId(mapId));
        }

        public function getAllSubAreas():Array
        {
            return (SubArea.getAllSubArea());
        }

        public function getArea(id:int):Area
        {
            return (Area.getAreaById(id));
        }

        public function getSuperArea(id:int):SuperArea
        {
            return (SuperArea.getSuperAreaById(id));
        }

        public function getAllArea(withHouses:Boolean=false, withPaddocks:Boolean=false):Array
        {
            var area:Area;
            var results:Array = new Array();
            for each (area in Area.getAllArea())
            {
                if (((((withHouses) && (area.containHouses)) || ((withPaddocks) && (area.containPaddocks))) || ((!(withHouses)) && (!(withPaddocks)))))
                {
                    results.push(area);
                };
            };
            return (results);
        }

        public function getWorldPoint(id:int):WorldPoint
        {
            return (WorldPoint.fromMapId(id));
        }

        public function getItem(id:int, returnDefaultItemIfNull:Boolean=true):Item
        {
            return (Item.getItemById(id, returnDefaultItemIfNull));
        }

        public function getItems():Array
        {
            return (Item.getItems());
        }

        public function getItemsByIds(ids:Vector.<uint>):Vector.<Item>
        {
            return (Item.getItemsByIds(ids));
        }

        public function getIncarnationLevel(incarnationId:int, level:int):IncarnationLevel
        {
            return (IncarnationLevel.getIncarnationLevelByIdAndLevel(incarnationId, level));
        }

        public function getIncarnation(incarnationId:int):Incarnation
        {
            return (Incarnation.getIncarnationById(incarnationId));
        }

        [NoBoxing]
        public function getNewGenericSlotData():GenericSlotData
        {
            return (new GenericSlotData());
        }

        public function getItemIconUri(iconId:uint):Uri
        {
            return (new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat(iconId).concat(".png")));
        }

        public function getItemName(id:int):String
        {
            var i:Item = Item.getItemById(id);
            if (i)
            {
                return (i.name);
            };
            return (null);
        }

        public function getItemType(id:int):ItemType
        {
            var it:ItemType = ItemType.getItemTypeById(id);
            return (it);
        }

        public function getItemTypes():Array
        {
            return (ItemType.getItemTypes());
        }

        public function getItemSet(id:int):ItemSet
        {
            return (ItemSet.getItemSetById(id));
        }

        public function getSetEffects(GIDList:Array, aSetBonus:Array=null):Array
        {
            var item:*;
            var GID:*;
            var GIDe:*;
            var line:*;
            var lineNA:*;
            var iGID:*;
            var effect:EffectInstance;
            var effectEquip:*;
            var setBonusLineTemp:*;
            var setBonusLine:*;
            var effectsDice:Dictionary = new Dictionary();
            var effects:Array = new Array();
            var effectsNonAddable:Array = new Array();
            var GIDEquippedList:Array = new Array();
            for each (item in PlayedCharacterManager.getInstance().inventory)
            {
                if (item.position <= CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD)
                {
                    for (iGID in GIDList)
                    {
                        if (item.objectGID == GIDList[iGID])
                        {
                            GIDEquippedList.push(item);
                            GIDList[iGID] = -1;
                        };
                    };
                };
            };
            for each (GID in GIDList)
            {
                if (GID != -1)
                {
                    for each (effect in Item.getItemById(GID).possibleEffects)
                    {
                        if (Effect.getEffectById(effect.effectId).useDice)
                        {
                            if (effectsDice[effect.effectId])
                            {
                                effectsDice[effect.effectId].add(effect);
                            }
                            else
                            {
                                effectsDice[effect.effectId] = effect.clone();
                            };
                        }
                        else
                        {
                            effectsNonAddable.push(effect.clone());
                        };
                    };
                };
            };
            for each (GIDe in GIDEquippedList)
            {
                for each (effectEquip in GIDe.effects)
                {
                    if (Effect.getEffectById(effectEquip.effectId).useDice)
                    {
                        if (effectsDice[effectEquip.effectId])
                        {
                            effectsDice[effectEquip.effectId].add(effectEquip);
                        }
                        else
                        {
                            effectsDice[effectEquip.effectId] = effectEquip.clone();
                        };
                    }
                    else
                    {
                        effectsNonAddable.push(effectEquip.clone());
                    };
                };
            };
            if (((aSetBonus) && (aSetBonus.length)))
            {
                for each (setBonusLineTemp in aSetBonus)
                {
                    setBonusLine = this.deepClone(setBonusLineTemp);
                    if ((setBonusLine is String))
                    {
                        _log.debug((("Bonus en texte, on ne peut pas l'ajouter '" + setBonusLine) + "'"));
                    }
                    else
                    {
                        if (((Effect.getEffectById(setBonusLine.effectId)) && (Effect.getEffectById(setBonusLine.effectId).useDice)))
                        {
                            if (effectsDice[setBonusLine.effectId])
                            {
                                effectsDice[setBonusLine.effectId].add(setBonusLine);
                            }
                            else
                            {
                                effectsDice[setBonusLine.effectId] = setBonusLine.clone();
                            };
                        }
                        else
                        {
                            effectsNonAddable.push(this.deepClone(setBonusLine));
                        };
                    };
                };
            };
            for each (line in effectsDice)
            {
                if (line.showInSet > 0)
                {
                    effects.push(line);
                };
            };
            for each (lineNA in effectsNonAddable)
            {
                if (lineNA.showInSet > 0)
                {
                    effects.push(lineNA);
                };
            };
            return (effects);
        }

        public function getArenaLeagueById(leagueId:uint):ArenaLeague
        {
            return (ArenaLeague.getArenaLeagueById(leagueId));
        }

        public function getArenaLeagueSeasonById(seasonId:uint):ArenaLeagueSeason
        {
            return (ArenaLeagueSeason.getArenaLeagueSeasonById(seasonId));
        }

        public function getArenaLeagueRewardsForCurrentRankAndSeason(league:int, season:int, endSeason:Boolean):ArenaLeagueReward
        {
            var reward:ArenaLeagueReward;
            var rewards:Array = ArenaLeagueReward.getArenaLeagueRewards();
            for each (reward in rewards)
            {
                if ((((reward.leagueId == league) && (reward.seasonId == season)) && (reward.endSeasonRewards == endSeason)))
                {
                    return (reward);
                };
            };
            return (null);
        }

        public function getMonsterFromId(monsterId:uint):Monster
        {
            return (Monster.getMonsterById(monsterId));
        }

        public function getMonsters():Array
        {
            return (Monster.getMonsters());
        }

        public function getMonsterMiniBossFromId(monsterId:uint):MonsterMiniBoss
        {
            return (MonsterMiniBoss.getMonsterById(monsterId));
        }

        public function getMonsterRaceFromId(raceId:uint):MonsterRace
        {
            return (MonsterRace.getMonsterRaceById(raceId));
        }

        public function getMonsterRaces():Array
        {
            return (MonsterRace.getMonsterRaces());
        }

        public function getMonsterSuperRaceFromId(raceId:uint):MonsterSuperRace
        {
            return (MonsterSuperRace.getMonsterSuperRaceById(raceId));
        }

        public function getMonsterSuperRaces():Array
        {
            return (MonsterSuperRace.getMonsterSuperRaces());
        }

        public function getCompanion(companionId:uint):Companion
        {
            return (Companion.getCompanionById(companionId));
        }

        public function getAllCompanions():Array
        {
            return (Companion.getCompanions());
        }

        public function getCompanionCharacteristic(companionCharacteristicId:uint):CompanionCharacteristic
        {
            return (CompanionCharacteristic.getCompanionCharacteristicById(companionCharacteristicId));
        }

        public function getCompanionSpell(companionSpellId:uint):CompanionSpell
        {
            return (CompanionSpell.getCompanionSpellById(companionSpellId));
        }

        public function getNpc(npcId:uint):Npc
        {
            return (Npc.getNpcById(npcId));
        }

        public function getNpcAction(actionId:uint):NpcAction
        {
            return (NpcAction.getNpcActionById(actionId));
        }

        public function getAlignmentSide(sideId:uint):AlignmentSide
        {
            return (AlignmentSide.getAlignmentSideById(sideId));
        }

        public function getAlignmentBalance(percent:uint):AlignmentBalance
        {
            var balance:uint;
            if (percent == 0)
            {
                balance = 1;
            }
            else
            {
                if (percent == 10)
                {
                    balance = 2;
                }
                else
                {
                    if (percent == 20)
                    {
                        balance = 3;
                    }
                    else
                    {
                        if (percent == 30)
                        {
                            balance = 4;
                        }
                        else
                        {
                            if (percent == 40)
                            {
                                balance = 5;
                            }
                            else
                            {
                                if (percent == 50)
                                {
                                    balance = 6;
                                }
                                else
                                {
                                    if (percent == 60)
                                    {
                                        balance = 7;
                                    }
                                    else
                                    {
                                        if (percent == 70)
                                        {
                                            balance = 8;
                                        }
                                        else
                                        {
                                            if (percent == 80)
                                            {
                                                balance = 9;
                                            }
                                            else
                                            {
                                                if (percent == 90)
                                                {
                                                    balance = 10;
                                                }
                                                else
                                                {
                                                    balance = uint(Math.ceil((percent / 10)));
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            return (AlignmentBalance.getAlignmentBalanceById(balance));
        }

        public function getRankName(rankId:uint):RankName
        {
            return (RankName.getRankNameById(rankId));
        }

        public function getAllRankNames():Array
        {
            return (RankName.getRankNames());
        }

        public function getItemWrapper(itemGID:uint, itemPosition:int=0, itemUID:uint=0, itemQuantity:uint=0, itemEffects:*=null):ItemWrapper
        {
            if (itemEffects == null)
            {
                itemEffects = new Vector.<ObjectEffect>();
            };
            return (ItemWrapper.create(itemPosition, itemUID, itemGID, itemQuantity, itemEffects, false));
        }

        public function getItemFromUId(objectUID:uint):ItemWrapper
        {
            return (ItemWrapper.getItemFromUId(objectUID));
        }

        public function getSkill(skillId:uint):Skill
        {
            return (Skill.getSkillById(skillId));
        }

        public function getSkills():Array
        {
            return (Skill.getSkills());
        }

        public function getHouseSkills():Array
        {
            var skill:Skill;
            var houseSkills:Array = new Array();
            for each (skill in Skill.getSkills())
            {
                if (skill.availableInHouse)
                {
                    houseSkills.push(skill);
                };
            };
            return (houseSkills);
        }

        public function getInfoMessage(infoMsgId:uint):InfoMessage
        {
            return (InfoMessage.getInfoMessageById(infoMsgId));
        }

        public function getAllInfoMessages():Array
        {
            return (InfoMessage.getInfoMessages());
        }

        public function getSmileyWrappers():Array
        {
            var chatFrame:ChatFrame = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame);
            if ((((chatFrame) && (chatFrame.smilies)) && (chatFrame.smilies.length > 0)))
            {
                return (chatFrame.smilies);
            };
            return (new Array());
        }

        public function getSmiley(id:uint):Smiley
        {
            return (Smiley.getSmileyById(id));
        }

        public function getAllSmiley():Array
        {
            return (Smiley.getSmileys());
        }

        public function getSmileyCategory(id:uint):SmileyCategory
        {
            return (SmileyCategory.getSmileyCategoryById(id));
        }

        public function getAllSmileyCategory():Array
        {
            return (SmileyCategory.getSmileyCategories());
        }

        public function getSmileyPack(id:uint):SmileyPack
        {
            return (SmileyPack.getSmileyPackById(id));
        }

        public function getAllSmileyPack():Array
        {
            return (SmileyPack.getSmileyPacks());
        }

        public function getEmoticon(id:uint):Emoticon
        {
            return (Emoticon.getEmoticonById(id));
        }

        public function getChallenge(id:uint):Challenge
        {
            return (Challenge.getChallengeById(id));
        }

        public function getChallengeWrapper(id:uint):ChallengeWrapper
        {
            var c:ChallengeWrapper = ChallengeWrapper.create();
            c.id = id;
            return (c);
        }

        public function getChallenges():Array
        {
            return (Challenge.getChallenges());
        }

        public function getDareCriteria(id:uint):DareCriteria
        {
            return (DareCriteria.getDareCriteriaById(id));
        }

        public function getAllDareCriteria():Array
        {
            return (DareCriteria.getDareCriterias());
        }

        public function getTaxCollectorName(id:uint):TaxCollectorName
        {
            return (TaxCollectorName.getTaxCollectorNameById(id));
        }

        public function getTaxCollectorFirstname(id:uint):TaxCollectorFirstname
        {
            return (TaxCollectorFirstname.getTaxCollectorFirstnameById(id));
        }

        public function getEmblems():Array
        {
            var upEmblem:EmblemSymbol;
            var backEmblem:EmblemBackground;
            var returnValue:Array;
            var upEmblemTotal:Array = EmblemSymbol.getEmblemSymbols();
            var backEmblemTotal:Array = EmblemBackground.getEmblemBackgrounds();
            var upEmblems:Array = new Array();
            var backEmblems:Array = new Array();
            for each (upEmblem in upEmblemTotal)
            {
                upEmblems.push(EmblemWrapper.create(upEmblem.id, EmblemWrapper.UP));
            };
            upEmblems.sortOn("order", Array.NUMERIC);
            for each (backEmblem in backEmblemTotal)
            {
                backEmblems.push(EmblemWrapper.create(backEmblem.id, EmblemWrapper.BACK));
            };
            backEmblems.sortOn("order", Array.NUMERIC);
            returnValue = new Array(upEmblems, backEmblems);
            return (returnValue);
        }

        public function getEmblemSymbol(symbolId:int):EmblemSymbol
        {
            return (EmblemSymbol.getEmblemSymbolById(symbolId));
        }

        public function getAllEmblemSymbolCategories():Array
        {
            return (EmblemSymbolCategory.getEmblemSymbolCategories());
        }

        public function getQuest(questId:int):Quest
        {
            return (Quest.getQuestById(questId));
        }

        public function getQuestCategory(questCatId:int):QuestCategory
        {
            return (QuestCategory.getQuestCategoryById(questCatId));
        }

        public function getQuestObjective(questObjectiveId:int):QuestObjective
        {
            return (QuestObjective.getQuestObjectiveById(questObjectiveId));
        }

        public function getQuestStep(questStepId:int):QuestStep
        {
            return (QuestStep.getQuestStepById(questStepId));
        }

        public function getAchievement(achievementId:int):Achievement
        {
            return (Achievement.getAchievementById(achievementId));
        }

        public function getAchievements():Array
        {
            return (Achievement.getAchievements());
        }

        public function getAchievementCategory(achievementCatId:int):AchievementCategory
        {
            return (AchievementCategory.getAchievementCategoryById(achievementCatId));
        }

        public function getAchievementCategories():Array
        {
            return (AchievementCategory.getAchievementCategories());
        }

        public function getAchievementReward(rewardId:int):AchievementReward
        {
            return (AchievementReward.getAchievementRewardById(rewardId));
        }

        public function getAchievementRewards():Array
        {
            return (AchievementReward.getAchievementRewards());
        }

        public function areTemporisRewardsAvailable():Boolean
        {
            var achievementProgressStep:AchievementProgressStep;
            var achievementAchievedRewardable:AchievementAchievedRewardable;
            if (!this.isTemporisSpellsUi())
            {
                return (false);
            };
            var currentSeason:ServerTemporisSeason = this.getCurrentSeason();
            var achievementProgress:AchievementProgress = this.getAchievementProgressWithSeasonId(currentSeason.uid);
            if (achievementProgress === null)
            {
                return (false);
            };
            var achievementProgressSteps:Array = this.getAchievementProgressStepsWithProgressId(achievementProgress.id);
            var currentAchievement:Achievement;
            var questApi:QuestApi = QuestApi.getInstance();
            if (questApi === null)
            {
                return (false);
            };
            var rewardableAchievementsObject:Object = questApi.getRewardableAchievements();
            for each (achievementProgressStep in achievementProgressSteps)
            {
                currentAchievement = this.getAchievementById(achievementProgressStep.achievementId);
                if (currentAchievement === null)
                {
                }
                else
                {
                    for each (achievementAchievedRewardable in rewardableAchievementsObject)
                    {
                        if (achievementAchievedRewardable.id === currentAchievement.id)
                        {
                            return (true);
                        };
                    };
                };
            };
            return (false);
        }

        public function getAchievementObjective(objectiveId:int):AchievementObjective
        {
            return (AchievementObjective.getAchievementObjectiveById(objectiveId));
        }

        public function getAchievementObjectives():Array
        {
            return (AchievementObjective.getAchievementObjectives());
        }

        public function getHouse(houseId:int):House
        {
            return (House.getGuildHouseById(houseId));
        }

        public function getLivingObjectSkins(item:ItemWrapper):Array
        {
            var skin:LivingObjectSkinWrapper;
            if (!item.isLivingObject)
            {
                return ([]);
            };
            var array:Array = new Array();
            var i:int = 1;
            while (i <= item.livingObjectLevel)
            {
                skin = LivingObjectSkinWrapper.create(((item.livingObjectId) ? item.livingObjectId : item.id), item.livingObjectMood, i);
                if (skin.iconUri)
                {
                    array.push(skin);
                };
                i++;
            };
            return (array);
        }

        public function getAbuseReasonName(abuseReasonId:uint):AbuseReasons
        {
            return (AbuseReasons.getReasonNameById(abuseReasonId));
        }

        public function getAllAbuseReasons():Array
        {
            return (AbuseReasons.getReasonNames());
        }

        public function getPresetIcons():Array
        {
            return (PresetIcon.getPresetIcons());
        }

        public function getPresetIcon(iconId:uint):PresetIcon
        {
            return (PresetIcon.getPresetIconById(iconId));
        }

        public function getIdolsPresetIcons():Array
        {
            return (IdolsPresetIcon.getIdolsPresetIcons());
        }

        public function getIdolsPresetIcon(iconId:uint):IdolsPresetIcon
        {
            return (IdolsPresetIcon.getIdolsPresetIconById(iconId));
        }

        public function getDungeons():Array
        {
            return (Dungeon.getAllDungeons());
        }

        public function getDungeon(dungeonId:uint):Dungeon
        {
            return (Dungeon.getDungeonById(dungeonId));
        }

        public function getMapInfo(mapId:Number):MapPosition
        {
            return (MapPosition.getMapPositionById(mapId));
        }

        public function getWorldMap(mapId:Number):WorldMap
        {
            return (WorldMap.getWorldMapById(mapId));
        }

        public function getAllWorldMaps():Array
        {
            return (WorldMap.getAllWorldMaps());
        }

        public function getAllWaypoints():Array
        {
            return (Waypoint.getAllWaypoints());
        }

        public function getHintCategory(hintId:uint):HintCategory
        {
            return (HintCategory.getHintCategoryById(hintId));
        }

        public function getHintCategories():Array
        {
            return (HintCategory.getHintCategories());
        }

        public function getHousesInformations():Dictionary
        {
            if (this.entitiesFrame)
            {
                return (this.entitiesFrame.housesInformations);
            };
            return (null);
        }

        public function getHouseInformations(doorId:uint):HouseWrapper
        {
            if (((this.entitiesFrame) && (this.entitiesFrame.housesInformations)))
            {
                return (this.entitiesFrame.housesInformations[doorId]);
            };
            return (null);
        }

        public function getSpellPair(pairId:uint):SpellPair
        {
            return (SpellPair.getSpellPairById(pairId));
        }

        public function getBomb(bombId:uint):SpellBomb
        {
            return (SpellBomb.getSpellBombById(bombId));
        }

        public function getPack(packId:uint):Pack
        {
            return (Pack.getPackById(packId));
        }

        public function getLegendaryTreasureHunt(huntId:uint):LegendaryTreasureHunt
        {
            return (LegendaryTreasureHunt.getLegendaryTreasureHuntById(huntId));
        }

        public function getLegendaryTreasureHunts():Array
        {
            return (LegendaryTreasureHunt.getLegendaryTreasureHunts());
        }

        public function getTitle(titleId:uint):Title
        {
            return (Title.getTitleById(titleId));
        }

        public function getTitles():Array
        {
            return (Title.getAllTitle());
        }

        public function getTitleCategory(titleCatId:uint):TitleCategory
        {
            return (TitleCategory.getTitleCategoryById(titleCatId));
        }

        public function getTitleCategories():Array
        {
            return (TitleCategory.getTitleCategories());
        }

        public function getOrnament(oId:uint):Ornament
        {
            return (Ornament.getOrnamentById(oId));
        }

        public function getOrnaments():Array
        {
            return (Ornament.getAllOrnaments());
        }

        public function getOptionalFeatureByKeyword(key:String):OptionalFeature
        {
            return (OptionalFeature.getOptionalFeatureByKeyword(key));
        }

        public function getEffect(effectId:uint):Effect
        {
            return (Effect.getEffectById(effectId));
        }

        public function getEvolutiveEffectInstancesByExperienceBoost(item:ItemWrapper, experienceBoost:int):Array
        {
            var evolutiveEffectId:int;
            var effect:EffectInstance;
            if ((((((experienceBoost == 0) || (!(item))) || (!(item.isEvolutive()))) || (!(item.type))) || (!(item.type.evolutiveType))))
            {
                return ([]);
            };
            var newTotalExperience:int = (experienceBoost + item.experiencePoints);
            var evolutiveItemType:EvolutiveItemType = item.type.evolutiveType;
            if (evolutiveItemType.maxLevel == item.evolutiveLevel)
            {
                return ([]);
            };
            var newLevel:int = evolutiveItemType.getLevelFromExperiencePoints(newTotalExperience);
            if (newLevel == item.evolutiveLevel)
            {
                return ([]);
            };
            var evolutiveEffectInstances:Array = [];
            for each (evolutiveEffectId in item.evolutiveEffectIds)
            {
                effect = EvolutiveEffect.getEvolutiveEffectInstanceByLevelRange(evolutiveEffectId, item.evolutiveLevel, newLevel);
                if (((effect is EffectInstanceInteger) && (!((effect as EffectInstanceInteger).value == 0))))
                {
                    evolutiveEffectInstances.push(effect);
                };
            };
            return (evolutiveEffectInstances);
        }

        public function getEvolutiveItemLevelByExperiencePoints(item:ItemWrapper, experiencePoints:int):int
        {
            if (((((experiencePoints == 0) || (!(item))) || (!(item.type))) || (!(item.type.evolutiveType))))
            {
                return (0);
            };
            var evolutiveItemType:EvolutiveItemType = item.type.evolutiveType;
            if (!evolutiveItemType)
            {
                return (0);
            };
            var level:int = evolutiveItemType.getLevelFromExperiencePoints(experiencePoints);
            return (level);
        }

        public function getAlmanaxEvent():AlmanaxEvent
        {
            return (AlmanaxManager.getInstance().event);
        }

        public function getAlmanaxZodiac():AlmanaxZodiac
        {
            return (AlmanaxManager.getInstance().zodiac);
        }

        public function getAlmanaxMonth():AlmanaxMonth
        {
            return (AlmanaxManager.getInstance().month);
        }

        public function getAlmanaxCalendar(calendarId:uint):AlmanaxCalendar
        {
            return (AlmanaxCalendar.getAlmanaxCalendarById(calendarId));
        }

        public function getExternalNotification(pExtNotifId:int):ExternalNotification
        {
            return (ExternalNotification.getExternalNotificationById(pExtNotifId));
        }

        public function getExternalNotifications():Array
        {
            return (ExternalNotification.getExternalNotifications());
        }

        public function queryString(dataClass:Class, field:String, pattern:String):Vector.<uint>
        {
            return (GameDataQuery.queryString(dataClass, field, pattern));
        }

        public function queryEquals(dataClass:Class, field:String, value:*):Vector.<uint>
        {
            return (GameDataQuery.queryEquals(dataClass, field, value));
        }

        public function queryUnion(... ids):Vector.<uint>
        {
            return (GameDataQuery.union.apply(null, ids));
        }

        public function queryIntersection(... ids):Vector.<uint>
        {
            return (GameDataQuery.intersection.apply(null, ids));
        }

        public function queryGreaterThan(dataClass:Class, field:String, value:*):Vector.<uint>
        {
            return (GameDataQuery.queryGreaterThan(dataClass, field, value));
        }

        public function querySmallerThan(dataClass:Class, field:String, value:*):Vector.<uint>
        {
            return (GameDataQuery.querySmallerThan(dataClass, field, value));
        }

        public function queryReturnInstance(dataClass:Class, ids:Vector.<uint>):Vector.<Object>
        {
            return (GameDataQuery.returnInstance(dataClass, ids));
        }

        public function querySort(dataClass:Class, ids:Vector.<uint>, fields:*, ascending:*=true):Vector.<uint>
        {
            return (GameDataQuery.sort(dataClass, ids, fields, ascending));
        }

        public function querySortI18nId(data:*, fields:*, ascending:*=true):*
        {
            return (GameDataQuery.sortI18n(data, fields, ascending));
        }

        public function getAllZaaps():Array
        {
            var waypoint:Waypoint;
            var allZapList:Array = new Array();
            var allWaypoints:Array = Waypoint.getAllWaypoints();
            for each (waypoint in allWaypoints)
            {
                if (waypoint.activated)
                {
                    allZapList.push(new TeleportDestinationWrapper(0, waypoint.mapId, waypoint.subAreaId, 0, SubArea.getSubAreaById(waypoint.subAreaId).level, 0, false, null, false));
                };
            };
            return (allZapList);
        }

        public function getUnknowZaaps(knwonZaapList:Array):Array
        {
            var tpd:TeleportDestinationWrapper;
            var knownTpd:*;
            var allZaaps:Array = this.getAllZaaps();
            var knownCoordinates:Array = new Array();
            var unknowZaaps:Array = new Array();
            for each (knownTpd in knwonZaapList)
            {
                knownCoordinates.push(knownTpd.coord);
            };
            for each (tpd in allZaaps)
            {
                if (knownCoordinates.indexOf(tpd.coord) != -1)
                {
                }
                else
                {
                    unknowZaaps.push(tpd);
                };
            };
            return (unknowZaaps);
        }

        public function getAllVeteranRewards():Array
        {
            return (VeteranReward.getAllVeteranRewards());
        }

        public function getBreachPrizeById(id:int):BreachPrize
        {
            return (BreachPrize.getBreachPrizeById(id));
        }

        public function getIdol(pIdolId:uint):Idol
        {
            return (Idol.getIdolById(pIdolId));
        }

        public function getIdolByItemId(pItemId:int):Idol
        {
            return (Idol.getIdolByItemId(pItemId));
        }

        public function getAllIdols():Array
        {
            return (Idol.getIdols());
        }

        public function getHintById(pHintId:int):Hint
        {
            return (Hint.getHintById(pHintId));
        }

        public function getHints():Array
        {
            return (Hint.getHints());
        }

        public function getHavenbagFurnitures():Array
        {
            return (HavenbagFurniture.getAllFurnitures());
        }

        public function getHavenbagFurnitureWrapper(furnitureTypeId:int):HavenbagFurnitureWrapper
        {
            return (HavenbagFurnitureWrapper.create(furnitureTypeId));
        }

        public function getHavenbagTheme(themeId:int):HavenbagTheme
        {
            return (HavenbagTheme.getTheme(themeId));
        }

        public function getInteractive(interactiveId:int):Interactive
        {
            return (Interactive.getInteractiveById(interactiveId));
        }

        public function getNullEffectInstance(e:*):*
        {
            var nullEffect:* = this.deepClone(e);
            nullEffect.setParameter(0, 0);
            nullEffect.setParameter(1, 0);
            nullEffect.setParameter(2, 0);
            return (nullEffect);
        }

        public function setEffectInstanceParameters(e:*, paramIndex:uint, value:*):void
        {
            e.setParameter(paramIndex, value);
        }

        public function getBonusById(pBonusId:int):Bonus
        {
            return (Bonus.getBonusById(pBonusId));
        }

        public function getMountBehaviorById(id:int):MountBehavior
        {
            return (MountBehavior.getMountBehaviorById(id));
        }

        public function getMountFamilyNameById(mountFamilyId:int):String
        {
            return (MountFamily.getMountFamilyById(mountFamilyId).name);
        }

        public function getMountById(mountId:int):Mount
        {
            return (Mount.getMountById(mountId));
        }

        public function getServerGameTypes():Array
        {
            return (ServerGameType.getServerGameTypes());
        }

        public function getServerGameType(id:int):ServerGameType
        {
            return (ServerGameType.getServerGameTypeById(id));
        }

        public function getServerCommunities():Array
        {
            return (ServerCommunity.getServerCommunities());
        }

        public function getServerCommunity(id:int):ServerCommunity
        {
            return (ServerCommunity.getServerCommunityById(id));
        }

        public function getServerLang(langId:int):ServerLang
        {
            return (ServerLang.getServerLangById(langId));
        }

        public function getFinishMoves():Array
        {
            return (FinishMove.getFinishMoves());
        }

        private function deepClone(source:*):*
        {
            var className:String = getQualifiedClassName(source);
            var classToClone:Class = source.constructor;
            registerClassAlias(className, classToClone);
            var b:ByteArray = new ByteArray();
            b.writeObject(source);
            b.position = 0;
            return (b.readObject() as classToClone);
        }

        public function getBreachBossById(id:int):BreachBoss
        {
            return (BreachBoss.getBreachBossById(id));
        }

        public function getBreachBossByMonsterId(id:int):BreachBoss
        {
            var boss:BreachBoss;
            var temp:Array = BreachBoss.getBreachBosses();
            for each (boss in temp)
            {
                if (boss.monsterId == id)
                {
                    return (boss);
                };
            };
            return (null);
        }

        public function getBreachBossByRewardId(id:int):BreachBoss
        {
            var boss:BreachBoss;
            var temp:Array = BreachBoss.getBreachBosses();
            for each (boss in temp)
            {
                if (boss.rewardId == id)
                {
                    return (boss);
                };
            };
            return (null);
        }

        public function getCurrentSeason():ServerTemporisSeason
        {
            return (ServerTemporisSeason.getCurrentSeason());
        }

        public function getBreachWorldMapCoordinate(stage:uint):BreachWorldMapCoordinate
        {
            return (BreachWorldMapCoordinate.getBreachWorldMapCoordinatesByMapStage(stage));
        }

        public function getBreachMinStageWorldMapCoordinate():BreachWorldMapCoordinate
        {
            var coordinate:BreachWorldMapCoordinate;
            var allCoordinate:Array = BreachWorldMapCoordinate.getAllBreachWorldMapCoordinates();
            var minCoordinate:BreachWorldMapCoordinate = (allCoordinate[0] as BreachWorldMapCoordinate);
            for each (coordinate in allCoordinate)
            {
                if (coordinate.mapStage < minCoordinate.mapStage)
                {
                    minCoordinate = coordinate;
                };
            };
            return (minCoordinate);
        }

        public function getBreachMaxStageWorldMapCoordinate():BreachWorldMapCoordinate
        {
            var coordinate:BreachWorldMapCoordinate;
            var allCoordinate:Array = BreachWorldMapCoordinate.getAllBreachWorldMapCoordinates();
            var maxCoordinate:BreachWorldMapCoordinate = (allCoordinate[(allCoordinate.length - 1)] as BreachWorldMapCoordinate);
            for each (coordinate in allCoordinate)
            {
                if (coordinate.mapStage > maxCoordinate.mapStage)
                {
                    maxCoordinate = coordinate;
                };
            };
            return (maxCoordinate);
        }

        public function getEmoteAnimName(emoteId:int, look:TiphonEntityLook):String
        {
            return (Emoticon.getEmoticonById(emoteId).getAnimName(look));
        }

        public function createDofusShopArticle(data:Object):DofusShopArticle
        {
            return (new DofusShopArticle(data));
        }

        public function getAllBreachWorldMapCoordinate():Array
        {
            return (BreachWorldMapCoordinate.getAllBreachWorldMapCoordinates());
        }

        public function updateItemWrapperEffects(itemWrapper:ItemWrapper, effects:Vector.<ObjectEffect>):void
        {
            itemWrapper.updateEffects(effects);
        }

        public function getBreachDungeonModificator(modificatorId:uint):BreachDungeonModificator
        {
            return (BreachDungeonModificator.getBreachDungeonModificatorByModificatorId(modificatorId));
        }

        public function getBreachWorldMapSector(id:uint):BreachWorldMapSector
        {
            return (BreachWorldMapSector.getBreachWorldMapSectorById(id));
        }

        public function getBreachWorldMapSectorByFloor(floor:uint):BreachWorldMapSector
        {
            var sector:BreachWorldMapSector;
            for each (sector in BreachWorldMapSector.getAllBreachWorldMapSectors())
            {
                if (((floor >= sector.minStage) && (floor <= ((sector.maxStage > 0) ? sector.maxStage : sector.minStage))))
                {
                    return (sector);
                };
            };
            return (null);
        }

        public function getAllBreachWorldMapSector():Array
        {
            return (BreachWorldMapSector.getAllBreachWorldMapSectors());
        }

        public function getBreachInfinityLevel(id:uint):BreachInfinityLevel
        {
            return (BreachInfinityLevel.getBreachInfinityLevelById(id));
        }

        public function getBreachInfinityLevelByLevel(level:uint):BreachInfinityLevel
        {
            var infinityLevel:BreachInfinityLevel;
            for each (infinityLevel in BreachInfinityLevel.getAllBreachInfinityLevel())
            {
                if (infinityLevel.level == level)
                {
                    return (infinityLevel);
                };
            };
            return (null);
        }

        public function getAllBreachInfinityLevel():Array
        {
            return (BreachInfinityLevel.getAllBreachInfinityLevel());
        }

        public function getRandomDropGroup(id:uint):RandomDropGroup
        {
            return (RandomDropGroup.getRandomDropGroupById(id));
        }

        public function getAllRandomDropGroup():Array
        {
            return (RandomDropGroup.getAllRandomDropGroup());
        }

        public function isTemporisSpellsUi():Boolean
        {
            return (ServerTemporisSeason.isTemporisSpellsUi);
        }

        public function getInventoryViewContent(viewName:String):Vector.<ItemWrapper>
        {
            var view:IInventoryView = InventoryManager.getInstance().inventory.getView(viewName);
            if (view === null)
            {
                return (null);
            };
            return (view.content);
        }

        public function getAchievementProgressWithSeasonId(seasonId:int):AchievementProgress
        {
            return (AchievementProgress.getAchievementProgressBySeasonId(seasonId));
        }

        public function getAchievementProgressStepsWithProgressId(progressId:int):Array
        {
            return (AchievementProgressStep.getAchievementProgressStepsByProgressId(progressId));
        }

        public function getAchievementById(achievementId:int):Achievement
        {
            return (Achievement.getAchievementById(achievementId));
        }


    }
}

