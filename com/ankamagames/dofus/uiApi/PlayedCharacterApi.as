package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
    import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
    import com.ankamagames.dofus.datacenter.temporis.ForgettableSpell;
    import com.ankamagames.dofus.network.types.game.data.items.ForgettableSpellItem;
    import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
    import com.ankamagames.dofus.datacenter.temporis.CustomModeBreedSpell;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.datacenter.breeds.Breed;
    import com.ankamagames.dofus.datacenter.appearance.Title;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
    import com.ankamagames.dofus.logic.game.common.frames.TinselFrame;
    import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionTitle;
    import com.ankamagames.dofus.datacenter.appearance.Ornament;
    import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.logic.game.roleplay.types.CharacterTooltipInformation;
    import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
    import com.ankamagames.dofus.network.types.game.character.restriction.ActorRestrictionsInformations;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
    import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
    import com.ankamagames.dofus.network.enums.AlignmentSideEnum;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
    import com.ankamagames.dofus.logic.game.common.frames.HouseFrame;
    import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
    import com.ankamagames.dofus.types.data.PlayerSetInfo;
    import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.IdolsPresetWrapper;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.logic.game.roleplay.frames.HavenbagFrame;
    import com.ankamagames.dofus.logic.game.common.managers.DebtManager;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
    import __AS3__.vec.*;

    public class PlayedCharacterApi implements IApi 
    {

        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayedCharacterApi));
        private static var _instance:PlayedCharacterApi;
        private static const LIFE_POINTS_GAINED_BY_LEVEL:int = 5;
        private static const BASE_LIFE_POINTS:int = 50;

        public function PlayedCharacterApi()
        {
            MEMORY_LOG[this] = 1;
            _instance = this;
        }

        public static function getInstance():PlayedCharacterApi
        {
            return (_instance);
        }


        public function characteristics():CharacterCharacteristicsInformations
        {
            return (PlayedCharacterManager.getInstance().characteristics);
        }

        public function getPlayedCharacterInfo():Object
        {
            var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
            if (!i)
            {
                return (null);
            };
            var o:Object = new Object();
            o.id = i.id;
            o.breed = i.breed;
            o.level = i.level;
            o.limitedLevel = PlayedCharacterManager.getInstance().limitedLevel;
            o.sex = i.sex;
            o.name = i.name;
            if (PlayedCharacterManager.getInstance().realEntityLook)
            {
                o.entityLook = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().realEntityLook);
            }
            else
            {
                o.entityLook = EntityLookAdapter.fromNetwork(i.entityLook);
            };
            o.realEntityLook = (o.entityLook as TiphonEntityLook).clone();
            if (((this.isCreature()) && (PlayedCharacterManager.getInstance().realEntityLook)))
            {
                o.entityLook = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().realEntityLook);
            };
            var ridderLook:TiphonEntityLook = TiphonEntityLook(o.entityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
            if (ridderLook)
            {
                if (ridderLook.getBone() == 2)
                {
                    ridderLook.setBone(1);
                };
                o.entityLook = ridderLook;
            };
            return (o);
        }

        public function getCurrentEntityLook():TiphonEntityLook
        {
            var look:TiphonEntityLook;
            var entity:AnimatedCharacter = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter);
            if (entity)
            {
                look = entity.look.clone();
            }
            else
            {
                look = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook);
            };
            return (look);
        }

        public function getInventory():Vector.<ItemWrapper>
        {
            return (InventoryManager.getInstance().realInventory);
        }

        public function getEquipment():Array
        {
            var item:*;
            var equipment:Array = new Array();
            for each (item in PlayedCharacterManager.getInstance().inventory)
            {
                if (item.position <= CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD)
                {
                    equipment.push(item);
                };
            };
            return (equipment);
        }

        public function getSpellInventory():Array
        {
            return (PlayedCharacterManager.getInstance().spellsInventory);
        }

        public function getSpells(returnBreedSpells:Boolean):Array
        {
            var spim:SpellInventoryManagementFrame = (Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame);
            if (returnBreedSpells)
            {
                return (spim.getBreedSpellsInVariantsArray());
            };
            return (spim.getCommonSpellsInVariantsArray());
        }

        public function getPlayerForgettableSpells():Dictionary
        {
            return (PlayedCharacterManager.getInstance().playerTemporisSpellDictionary);
        }

        public function getPlayerMaxTemporisSpellsNumber():int
        {
            return (PlayedCharacterManager.getInstance().playerMaxTemporisSpellsNumber);
        }

        public function getForgettableSpells():Array
        {
            return (ForgettableSpell.getForgettableSpells());
        }

        public function getForgettableSpellById(id:int):ForgettableSpell
        {
            return (ForgettableSpell.getForgettableSpellById(id));
        }

        public function isForgettableSpellAvailable(id:int):Boolean
        {
            var forgettableSpellItems:Dictionary = PlayedCharacterManager.getInstance().playerTemporisSpellDictionary;
            if (forgettableSpellItems === null)
            {
                return (false);
            };
            var forgettableSpellItem:ForgettableSpellItem = forgettableSpellItems[id];
            if (forgettableSpellItem === null)
            {
                return (false);
            };
            return (forgettableSpellItem.available);
        }

        public function isForgettableSpell(spellId:int):Boolean
        {
            return (SpellManager.isForgettableSpell(spellId));
        }

        public function getCustomModeBreedSpells():Array
        {
            return (CustomModeBreedSpell.getCustomModeBreedSpells());
        }

        public function getCustomModeBreedSpellById(id:int):CustomModeBreedSpell
        {
            return (CustomModeBreedSpell.getCustomModeBreedSpellById(id));
        }

        public function getCustomModeSpellIds():Array
        {
            return (CustomModeBreedSpell.getAllCustomModeBreedSpellIds());
        }

        public function getCustomModeBreedSpellList(breedId:int):Array
        {
            return (CustomModeBreedSpell.getCustomModeBreedSpellList(breedId));
        }

        public function getBreedSpellActivatedIds():Array
        {
            var spellWrapper:SpellWrapper;
            var spellsInventory:Array = PlayedCharacterManager.getInstance().spellsInventory;
            var activatedSpellIds:Array = new Array();
            var playerBreedId:int = PlayedCharacterManager.getInstance().infos.breed;
            var breedData:Breed = Breed.getBreedById(playerBreedId);
            var breedSpellsId:Array = breedData.allSpellsId;
            for each (spellWrapper in spellsInventory)
            {
                if (spellWrapper === null)
                {
                }
                else
                {
                    if (((spellWrapper.variantActivated) && (!(breedSpellsId.indexOf(spellWrapper.id) == -1))))
                    {
                        activatedSpellIds.push(spellWrapper.id);
                    };
                };
            };
            return (activatedSpellIds);
        }

        public function getJobs():Array
        {
            return (PlayedCharacterManager.getInstance().jobs);
        }

        public function getMount():Object
        {
            return (PlayedCharacterManager.getInstance().mount);
        }

        public function getTitle():Title
        {
            var title:Title;
            var playerInfo:GameRolePlayCharacterInformations;
            var option:*;
            var title2:Title;
            var titleId:int = (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).currentTitle;
            if (titleId)
            {
                title = Title.getTitleById(titleId);
                return (title);
            };
            playerInfo = this.getEntityInfos();
            if (((playerInfo) && (playerInfo.humanoidInfo)))
            {
                for each (option in playerInfo.humanoidInfo.options)
                {
                    if ((option is HumanOptionTitle))
                    {
                        titleId = option.titleId;
                    };
                };
                title2 = Title.getTitleById(titleId);
                return (title2);
            };
            return (null);
        }

        public function getOrnament():Ornament
        {
            var ornament:Ornament;
            var ornamentId:int = (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).currentOrnament;
            if (ornamentId)
            {
                ornament = Ornament.getOrnamentById(ornamentId);
                return (ornament);
            };
            return (null);
        }

        public function getKnownTitles():Vector.<uint>
        {
            return ((Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).knownTitles);
        }

        public function getKnownOrnaments():Vector.<uint>
        {
            return ((Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).knownOrnaments);
        }

        public function titlesOrnamentsAskedBefore():Boolean
        {
            return ((Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).titlesOrnamentsAskedBefore);
        }

        public function getEntityInfos():GameRolePlayCharacterInformations
        {
            var entitiesFrame:AbstractEntitiesFrame;
            if (this.isInFight())
            {
                entitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as AbstractEntitiesFrame);
            }
            else
            {
                entitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as AbstractEntitiesFrame);
            };
            if (!entitiesFrame)
            {
                return (null);
            };
            var playerInfo:GameRolePlayCharacterInformations = (entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayCharacterInformations);
            return (playerInfo);
        }

        public function getEntityTooltipInfos():CharacterTooltipInformation
        {
            var playerInfo:GameRolePlayCharacterInformations = this.getEntityInfos();
            if (!playerInfo)
            {
                return (null);
            };
            var tooltipInfos:CharacterTooltipInformation = new CharacterTooltipInformation(playerInfo, 0);
            return (tooltipInfos);
        }

        public function getKamasMaxLimit():Number
        {
            var playedCharacterFrame:PlayedCharacterUpdatesFrame = (Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame) as PlayedCharacterUpdatesFrame);
            if (playedCharacterFrame)
            {
                return (playedCharacterFrame.kamasLimit);
            };
            return (0);
        }

        public function inventoryWeight():uint
        {
            return (PlayedCharacterManager.getInstance().inventoryWeight);
        }

        public function shopWeight():uint
        {
            return (PlayedCharacterManager.getInstance().shopWeight);
        }

        public function inventoryWeightMax():uint
        {
            return (PlayedCharacterManager.getInstance().inventoryWeightMax);
        }

        public function isIncarnation():Boolean
        {
            return (PlayedCharacterManager.getInstance().isIncarnation);
        }

        public function isMutated():Boolean
        {
            return (PlayedCharacterManager.getInstance().isMutated);
        }

        public function isInHouse():Boolean
        {
            return (PlayedCharacterManager.getInstance().isInHouse);
        }

        public function isIndoor():Boolean
        {
            return (PlayedCharacterManager.getInstance().isIndoor);
        }

        public function isInExchange():Boolean
        {
            return (PlayedCharacterManager.getInstance().isInExchange);
        }

        public function isInFight():Boolean
        {
            return (!(Kernel.getWorker().getFrame(FightContextFrame) == null));
        }

        public function isInPreFight():Boolean
        {
            return ((Kernel.getWorker().contains(FightPreparationFrame)) || (Kernel.getWorker().isBeingAdded(FightPreparationFrame)));
        }

        public function isSpectator():Boolean
        {
            return (PlayedCharacterManager.getInstance().isSpectator);
        }

        public function isInParty():Boolean
        {
            return (PlayedCharacterManager.getInstance().isInParty);
        }

        public function isPartyLeader():Boolean
        {
            return (PlayedCharacterManager.getInstance().isPartyLeader);
        }

        public function isRidding():Boolean
        {
            return (PlayedCharacterManager.getInstance().isRidding);
        }

        public function isPetsMounting():Boolean
        {
            return (PlayedCharacterManager.getInstance().isPetsMounting);
        }

        public function hasCompanion():Boolean
        {
            return (PlayedCharacterManager.getInstance().hasCompanion);
        }

        public function id():Number
        {
            return (PlayedCharacterManager.getInstance().id);
        }

        public function restrictions():ActorRestrictionsInformations
        {
            return (PlayedCharacterManager.getInstance().restrictions);
        }

        public function isMutant():Boolean
        {
            var rcf:RoleplayContextFrame = (Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame);
            var infos:GameRolePlayActorInformations = (rcf.entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayActorInformations);
            return (infos is GameRolePlayMutantInformations);
        }

        public function publicMode():Boolean
        {
            return (PlayedCharacterManager.getInstance().publicMode);
        }

        public function artworkId():int
        {
            return (PlayedCharacterManager.getInstance().artworkId);
        }

        public function isCreature():Boolean
        {
            return (EntitiesLooksManager.getInstance().isCreature(this.id()));
        }

        public function getBone():uint
        {
            var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
            return (EntityLookAdapter.fromNetwork(i.entityLook).getBone());
        }

        public function getSkin():uint
        {
            var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
            if ((((EntityLookAdapter.fromNetwork(i.entityLook)) && (EntityLookAdapter.fromNetwork(i.entityLook).getSkins())) && (EntityLookAdapter.fromNetwork(i.entityLook).getSkins().length > 0)))
            {
                return (EntityLookAdapter.fromNetwork(i.entityLook).getSkins()[0]);
            };
            return (0);
        }

        public function getColors():Object
        {
            var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
            return (EntityLookAdapter.fromNetwork(i.entityLook).getColors());
        }

        public function getSubentityColors():Object
        {
            var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
            var subTel:TiphonEntityLook = EntityLookAdapter.fromNetwork(i.entityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
            if (((!(subTel)) && (PlayedCharacterManager.getInstance().realEntityLook)))
            {
                subTel = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().realEntityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
            };
            return ((subTel) ? subTel.getColors() : null);
        }

        public function getAlignmentSide():int
        {
            if (PlayedCharacterManager.getInstance().characteristics)
            {
                return (PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentSide);
            };
            return (AlignmentSideEnum.ALIGNMENT_NEUTRAL);
        }

        public function getAlignmentValue():uint
        {
            return (PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentValue);
        }

        public function getAlignmentAggressableStatus():uint
        {
            return (PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable);
        }

        public function getAlignmentGrade():uint
        {
            return (PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentGrade);
        }

        public function getMaxSummonedCreature():uint
        {
            return (CurrentPlayedFighterManager.getInstance().getMaxSummonedCreature());
        }

        public function getCurrentSummonedCreature():uint
        {
            return (CurrentPlayedFighterManager.getInstance().getCurrentSummonedCreature());
        }

        public function canSummon():Boolean
        {
            return (CurrentPlayedFighterManager.getInstance().canSummon());
        }

        public function getSpell(spellId:uint):SpellWrapper
        {
            return (CurrentPlayedFighterManager.getInstance().getSpellById(spellId));
        }

        public function canCastThisSpell(spellId:uint, lvl:uint):Boolean
        {
            return (CurrentPlayedFighterManager.getInstance().canCastThisSpell(spellId, lvl));
        }

        public function canCastThisSpellWithResult(spellId:uint, lvl:uint, target:Number=0):String
        {
            var resultA:Array = ["."];
            CurrentPlayedFighterManager.getInstance().canCastThisSpell(spellId, lvl, target, resultA);
            return (resultA[0]);
        }

        public function canCastThisSpellOnTarget(spellId:uint, lvl:uint, pTargetId:Number):Boolean
        {
            return (CurrentPlayedFighterManager.getInstance().canCastThisSpell(spellId, lvl, pTargetId));
        }

        public function getSpellModification(spellId:uint, carac:int):int
        {
            var modif:CharacterSpellModification = CurrentPlayedFighterManager.getInstance().getSpellModifications(spellId, carac);
            if (((modif) && (modif.value)))
            {
                return ((((modif.value.alignGiftBonus + modif.value.base) + modif.value.additionnal) + modif.value.contextModif) + modif.value.objectsAndMountBonus);
            };
            return (0);
        }

        public function getSpellModifications(spellId:uint):Vector.<CharacterSpellModification>
        {
            var spellModif:CharacterSpellModification;
            var spellModifs:Vector.<CharacterSpellModification> = new Vector.<CharacterSpellModification>(0);
            for each (spellModif in CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().spellModifications)
            {
                if (spellModif.spellId == spellId)
                {
                    spellModifs.push(spellModif);
                };
            };
            return (spellModifs);
        }

        public function isInHisHouse():Boolean
        {
            return (PlayedCharacterManager.getInstance().isInHisHouse);
        }

        public function getPlayerHouses():Vector.<HouseWrapper>
        {
            return ((Kernel.getWorker().getFrame(HouseFrame) as HouseFrame).accountHouses);
        }

        public function currentMap():WorldPointWrapper
        {
            return (PlayedCharacterManager.getInstance().currentMap);
        }

        public function previousMap():WorldPointWrapper
        {
            return (PlayedCharacterManager.getInstance().previousMap);
        }

        public function previousWorldMapId():int
        {
            return (PlayedCharacterManager.getInstance().previousWorldMapId);
        }

        public function previousSubArea():SubArea
        {
            return (PlayedCharacterManager.getInstance().previousSubArea);
        }

        public function currentSubArea():SubArea
        {
            return (PlayedCharacterManager.getInstance().currentSubArea);
        }

        public function isInTutorialArea():Boolean
        {
            var subarea:SubArea = PlayedCharacterManager.getInstance().currentSubArea;
            return ((subarea) && (subarea.id == DataEnum.SUBAREA_TUTORIAL));
        }

        public function state():uint
        {
            return (PlayedCharacterManager.getInstance().state);
        }

        public function isAlive():Boolean
        {
            return (PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING);
        }

        public function getFollowingPlayerIds():Vector.<Number>
        {
            return (PlayedCharacterManager.getInstance().followingPlayerIds);
        }

        public function getPlayerSet(objectGID:uint):PlayerSetInfo
        {
            return (PlayedCharacterUpdatesFrame(Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame)).getPlayerSet(objectGID));
        }

        public function getWeapon():WeaponWrapper
        {
            var build:BuildWrapper;
            var iw:ItemWrapper;
            if (InventoryManager.getInstance().currentBuildId != -1)
            {
                for each (build in InventoryManager.getInstance().builds)
                {
                    if (build.id == InventoryManager.getInstance().currentBuildId)
                    {
                        break;
                    };
                };
                for each (iw in build.equipment)
                {
                    if ((iw is WeaponWrapper))
                    {
                        break;
                    };
                };
                if ((iw as WeaponWrapper))
                {
                    return (iw as WeaponWrapper);
                };
                return (null);
            };
            return (PlayedCharacterManager.getInstance().currentWeapon);
        }

        public function getExperienceBonusPercent():int
        {
            return (PlayedCharacterManager.getInstance().experiencePercent);
        }

        public function getAchievementPoints():int
        {
            return (PlayedCharacterManager.getInstance().achievementPoints);
        }

        public function getWaitingGifts():Array
        {
            return (PlayedCharacterManager.getInstance().waitingGifts);
        }

        public function getSoloIdols():Vector.<uint>
        {
            return (PlayedCharacterManager.getInstance().soloIdols);
        }

        public function getPartyIdols():Vector.<uint>
        {
            return (PlayedCharacterManager.getInstance().partyIdols);
        }

        public function setPartyIdols(pIdols:Vector.<uint>):void
        {
            PlayedCharacterManager.getInstance().partyIdols = pIdols;
        }

        public function getIdolsPresets():Vector.<IdolsPresetWrapper>
        {
            return (PlayedCharacterManager.getInstance().idolsPresets);
        }

        public function knowSpell(pSpellId:uint):int
        {
            var obtentionSpellLevel:uint;
            var playerSpellLevel:uint;
            var sp:SpellWrapper;
            var disable:Boolean;
            var spellWrapper:SpellWrapper;
            var spellLevelZero:SpellLevel;
            var spell:Spell = Spell.getSpellById(pSpellId);
            var spellLevel:SpellLevel = SpellLevel.getLevelById(pSpellId);
            if (pSpellId == 0)
            {
                obtentionSpellLevel = 0;
            }
            else
            {
                spellLevelZero = spell.getSpellLevel(1);
                obtentionSpellLevel = spellLevelZero.minPlayerLevel;
            };
            var spellInv:Array = this.getSpellInventory();
            for each (sp in spellInv)
            {
                if (sp.spellId == pSpellId)
                {
                    playerSpellLevel = sp.spellLevel;
                };
            };
            disable = true;
            for each (spellWrapper in spellInv)
            {
                if (spellWrapper.spellId == pSpellId)
                {
                    disable = false;
                };
            };
            if (disable)
            {
                return (-1);
            };
            return (playerSpellLevel);
        }

        public function isInHisHavenbag():Boolean
        {
            return (PlayedCharacterManager.getInstance().isInHisHavenbag);
        }

        public function isInHavenbag():Boolean
        {
            return (PlayedCharacterManager.getInstance().isInHavenbag);
        }

        public function havenbagSharePermissions():uint
        {
            var hbFrame:HavenbagFrame = (Kernel.getWorker().getFrame(HavenbagFrame) as HavenbagFrame);
            return (hbFrame.sharePermissions);
        }

        public function isInBreach():Boolean
        {
            return (PlayedCharacterManager.getInstance().isInBreach);
        }

        public function isInBreachSubArea():Boolean
        {
            return ((PlayedCharacterManager.getInstance().currentSubArea.id == 904) || (PlayedCharacterManager.getInstance().currentSubArea.id == 938));
        }

        public function isInAnomaly():Boolean
        {
            return (PlayedCharacterManager.getInstance().isInAnomaly);
        }

        public function hasDebt():Boolean
        {
            return (DebtManager.getInstance().hasDebt());
        }

        public function getKamaDebt():uint
        {
            return (DebtManager.getInstance().getTotalKamaDebt());
        }

        public function getTotalValueFromCharacteristic(characteristic:CharacterBaseCharacteristic):Number
        {
            return ((((characteristic.base + characteristic.additionnal) + characteristic.objectsAndMountBonus) + characteristic.alignGiftBonus) + characteristic.contextModif);
        }

        public function getBaseLifePoints():Number
        {
            var level:int = 1;
            var playedCharacterInfo:Object = this.getPlayedCharacterInfo();
            if (playedCharacterInfo)
            {
                level = playedCharacterInfo.limitedLevel;
            };
            return (BASE_LIFE_POINTS + (LIFE_POINTS_GAINED_BY_LEVEL * level));
        }


    }
} com.ankamagames.dofus.uiApi

