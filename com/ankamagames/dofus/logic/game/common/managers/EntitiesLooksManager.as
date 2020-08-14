package com.ankamagames.dofus.logic.game.common.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.datacenter.breeds.Breed;
    import com.ankamagames.dofus.datacenter.appearance.CreatureBoneType;
    import com.ankamagames.dofus.datacenter.items.Incarnation;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
    import com.ankamagames.dofus.datacenter.monsters.Companion;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
    import com.ankamagames.tiphon.types.TiphonUtility;
    import com.ankamagames.dofus.datacenter.appearance.CreatureBoneOverride;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
    import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightTaxCollectorInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMutantInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
    import com.ankama.dofus.enums.ActionIds;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
    import com.ankamagames.dofus.misc.utils.GameDataQuery;
    import com.ankamagames.dofus.datacenter.appearance.Appearance;

    public class EntitiesLooksManager 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(EntitiesLooksManager));
        private static var _self:EntitiesLooksManager;

        private var _entitiesFrame:AbstractEntitiesFrame;


        public static function getInstance():EntitiesLooksManager
        {
            if (!_self)
            {
                _self = new (EntitiesLooksManager)();
            };
            return (_self);
        }


        public function set entitiesFrame(pFrame:AbstractEntitiesFrame):void
        {
            this._entitiesFrame = pFrame;
        }

        public function isCreatureMode():Boolean
        {
            if (!this._entitiesFrame)
            {
                return (false);
            };
            return ((this._entitiesFrame is RoleplayEntitiesFrame) ? ((this._entitiesFrame as RoleplayEntitiesFrame).isCreatureMode) : ((this._entitiesFrame as FightEntitiesFrame).isInCreaturesFightMode()));
        }

        public function isCreature(pEntityId:Number):Boolean
        {
            var look:TiphonEntityLook = this.getTiphonEntityLook(pEntityId);
            if (look)
            {
                if (((this.isCreatureFromLook(look)) || ((this.isCreatureMode()) && (this.getLookFromContext(pEntityId).getBone() == look.getBone()))))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function isCreatureFromLook(pLook:TiphonEntityLook):Boolean
        {
            var breed:Breed;
            var bone:uint = pLook.getBone();
            var breeds:Array = Breed.getBreeds();
            for each (breed in breeds)
            {
                if (breed.creatureBonesId == bone)
                {
                    return (true);
                };
            };
            if (pLook.getBone() == CreatureBoneType.getPlayerIncarnationCreatureBone())
            {
                return (true);
            };
            return (false);
        }

        public function isIncarnation(pEntityId:Number):Boolean
        {
            var look:TiphonEntityLook = this.getRealTiphonEntityLook(pEntityId, true);
            if (((look) && (this.isIncarnationFromLook(look))))
            {
                return (true);
            };
            return (false);
        }

        public function isIncarnationFromLook(pLook:TiphonEntityLook):Boolean
        {
            var incarnation:Incarnation;
            if (pLook.getBone() == CreatureBoneType.getPlayerIncarnationCreatureBone())
            {
                return (true);
            };
            var incarnations:Array = Incarnation.getAllIncarnation();
            var boneId:int = pLook.getBone();
            for each (incarnation in incarnations)
            {
                if (((boneId == incarnation.maleBoneId) || (boneId == incarnation.femaleBoneId)))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function getTiphonEntityLook(pEntityId:Number):TiphonEntityLook
        {
            var _local_2:AnimatedCharacter = (DofusEntities.getEntity(pEntityId) as AnimatedCharacter);
            return ((_local_2) ? _local_2.look.clone() : null);
        }

        public function getRealTiphonEntityLook(pEntityId:Number, pWithoutMount:Boolean=false):TiphonEntityLook
        {
            var entityLook:EntityLook;
            var infos:GameContextActorInformations;
            var riderLook:TiphonEntityLook;
            if (this._entitiesFrame)
            {
                if ((this._entitiesFrame is FightEntitiesFrame))
                {
                    entityLook = (this._entitiesFrame as FightEntitiesFrame).getRealFighterLook(pEntityId);
                }
                else
                {
                    infos = this._entitiesFrame.getEntityInfos(pEntityId);
                    entityLook = ((infos) ? infos.look : null);
                };
            };
            if (((!(entityLook)) && (pEntityId == PlayedCharacterManager.getInstance().id)))
            {
                entityLook = PlayedCharacterManager.getInstance().infos.entityLook;
            };
            var look:TiphonEntityLook = ((entityLook) ? EntityLookAdapter.fromNetwork(entityLook) : null);
            if (((look) && (pWithoutMount)))
            {
                riderLook = look.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
                if (riderLook)
                {
                    look = riderLook;
                };
            };
            return (look);
        }

        public function getCreatureLook(pEntityId:Number):TiphonEntityLook
        {
            var infos:GameContextActorInformations = ((this._entitiesFrame) ? this._entitiesFrame.getEntityInfos(pEntityId) : null);
            return ((infos) ? this.getLookFromContextInfos(infos, true) : null);
        }

        public function getLookFromContext(pEntityId:Number, pForceCreature:Boolean=false):TiphonEntityLook
        {
            var infos:GameContextActorInformations = ((this._entitiesFrame) ? this._entitiesFrame.getEntityInfos(pEntityId) : null);
            return ((infos) ? this.getLookFromContextInfos(infos, pForceCreature) : null);
        }

        public function getLookFromContextInfos(pInfos:GameContextActorInformations, pForceCreature:Boolean=false):TiphonEntityLook
        {
            var creatureBone:int;
            var gfci:GameFightEntityInformation;
            var companion:Companion;
            var gfmi:GameFightMonsterInformations;
            var isPrism:Boolean;
            var m:Monster;
            var fightCreatureBone:int;
            var breedId:int;
            var trueBreed:Breed;
            var fighterLook:TiphonEntityLook;
            var oldBone:int;
            var buffs:Array;
            var buff:BasicBuff;
            var stackBuff:BasicBuff;
            var boneId:int;
            var look:TiphonEntityLook = EntityLookAdapter.fromNetwork(pInfos.look);
            if (((this.isCreatureMode()) || (pForceCreature)))
            {
                if (((pInfos is GameRolePlayHumanoidInformations) || (pInfos is GameFightCharacterInformations)))
                {
                    look = ((look.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0)) ? TiphonUtility.getLookWithoutMount(look) : look);
                };
                creatureBone = CreatureBoneOverride.getCreatureBones(look.getBone());
                if ((((!(pInfos is GameRolePlayGroupMonsterInformations)) && (!(pInfos is GameRolePlayNpcInformations))) && (!(creatureBone == -1))))
                {
                    look.setBone(creatureBone);
                }
                else
                {
                    switch (true)
                    {
                        case (pInfos is GameRolePlayHumanoidInformations):
                        case (pInfos is GameFightCharacterInformations):
                            if (this.isIncarnation(pInfos.contextualId))
                            {
                                look.setBone(CreatureBoneType.getPlayerIncarnationCreatureBone());
                            }
                            else
                            {
                                if ((((pInfos as GameFightCharacterInformations) && ((pInfos as GameFightCharacterInformations).stats)) && ((pInfos as GameFightCharacterInformations).stats.summoned)))
                                {
                                    look.setBone(CreatureBoneType.getMonsterInvocationCreatureBone());
                                }
                                else
                                {
                                    breedId = ((pInfos.hasOwnProperty("breed")) ? pInfos["breed"] : 0);
                                    trueBreed = Breed.getBreedFromSkin(look.firstSkin);
                                    if (((breedId <= 0) && (trueBreed)))
                                    {
                                        breedId = trueBreed.id;
                                    };
                                    if (breedId > 0)
                                    {
                                        look.setBone(Breed.getBreedById(breedId).creatureBonesId);
                                    }
                                    else
                                    {
                                        look.setBone(CreatureBoneType.getPlayerIncarnationCreatureBone());
                                    };
                                };
                            };
                            break;
                        case (pInfos is GameRolePlayPrismInformations):
                            look.setBone(CreatureBoneType.getPrismCreatureBone());
                            break;
                        case (pInfos is GameRolePlayMerchantInformations):
                            look.setBone(CreatureBoneType.getPlayerMerchantCreatureBone());
                            break;
                        case (pInfos is GameRolePlayTaxCollectorInformations):
                        case (pInfos is GameFightTaxCollectorInformations):
                            look.setBone(CreatureBoneType.getTaxCollectorCreatureBone());
                            break;
                        case (pInfos is GameFightEntityInformation):
                            gfci = (pInfos as GameFightEntityInformation);
                            companion = Companion.getCompanionById(gfci.entityModelId);
                            look.setBone(companion.creatureBoneId);
                            break;
                        case (pInfos is GameFightMutantInformations):
                            look.setBone(CreatureBoneType.getMonsterCreatureBone());
                            break;
                        case (pInfos is GameFightMonsterInformations):
                            gfmi = (pInfos as GameFightMonsterInformations);
                            isPrism = (gfmi.creatureGenericId == 3451);
                            m = Monster.getMonsterById(gfmi.creatureGenericId);
                            if (gfmi.stats.summoned)
                            {
                                fightCreatureBone = CreatureBoneType.getMonsterInvocationCreatureBone();
                            }
                            else
                            {
                                if (m.isBoss)
                                {
                                    fightCreatureBone = CreatureBoneType.getBossMonsterCreatureBone();
                                }
                                else
                                {
                                    if (isPrism)
                                    {
                                        fightCreatureBone = CreatureBoneType.getPrismCreatureBone();
                                    }
                                    else
                                    {
                                        fightCreatureBone = CreatureBoneType.getMonsterCreatureBone();
                                    };
                                };
                            };
                            look.setBone(fightCreatureBone);
                            break;
                        case (pInfos is GameRolePlayActorInformations):
                            return (look);
                    };
                };
                look.setScales(0.9, 0.9);
            }
            else
            {
                if ((((pInfos is GameFightCharacterInformations) || (pInfos is GameFightFighterInformations)) && (!((this._entitiesFrame as FightEntitiesFrame).charactersMountsVisible))))
                {
                    fighterLook = look.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
                    if (!fighterLook)
                    {
                        fighterLook = look;
                    };
                    oldBone = fighterLook.getBone();
                    look = TiphonUtility.getLookWithoutMount(look);
                    if (oldBone == 2)
                    {
                        buffs = BuffManager.getInstance().getAllBuff(pInfos.contextualId);
                        if (((buffs) && (buffs.length > 0)))
                        {
                            boneId = -1;
                            for each (buff in buffs)
                            {
                                if (buff.actionId == ActionIds.ACTION_CHARACTER_ADD_APPEARANCE)
                                {
                                    if (((buff.stack) && (buff.stack.length > 0)))
                                    {
                                        for each (stackBuff in buff.stack)
                                        {
                                            boneId = this.getAppearanceBone(stackBuff.dataUid);
                                            if (boneId != -1)
                                            {
                                                break;
                                            };
                                        };
                                    };
                                    if (boneId == -1)
                                    {
                                        boneId = this.getAppearanceBone(buff.dataUid);
                                    };
                                    if (boneId != -1)
                                    {
                                        look.setBone(boneId);
                                        break;
                                    };
                                };
                            };
                        };
                    };
                };
            };
            return (look);
        }

        private function getAppearanceBone(pEffectUid:int):int
        {
            var criticalEffect:Boolean;
            var spellLevel:SpellLevel;
            var effects:Vector.<EffectInstanceDice>;
            var effid:EffectInstanceDice;
            var boneId:int = -1;
            var appearanceId:int = -1;
            var spellLevelsIds:Vector.<uint> = GameDataQuery.queryEquals(SpellLevel, "effects.effectUid", pEffectUid);
            if (spellLevelsIds.length == 0)
            {
                spellLevelsIds = GameDataQuery.queryEquals(SpellLevel, "criticalEffect.effectUid", pEffectUid);
                criticalEffect = true;
            };
            if (spellLevelsIds.length > 0)
            {
                spellLevel = SpellLevel.getLevelById(spellLevelsIds[0]);
                effects = ((criticalEffect) ? spellLevel.criticalEffect : spellLevel.effects);
                for each (effid in effects)
                {
                    if (effid.effectUid == pEffectUid)
                    {
                        appearanceId = (effid.parameter2 as int);
                        break;
                    };
                };
            };
            var appearance:Appearance = Appearance.getAppearanceById(appearanceId);
            if (((appearance) && (appearance.type == 5)))
            {
                return (parseInt(appearance.data));
            };
            return (-1);
        }


    }
} com.ankamagames.dofus.logic.game.common.managers

