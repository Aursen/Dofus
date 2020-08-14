package com.ankamagames.dofus.internalDatacenter.spells
{
    import flash.utils.Proxy;
    import com.ankamagames.jerakine.interfaces.ISlotData;
    import com.ankamagames.berilia.interfaces.IClonable;
    import com.ankamagames.jerakine.utils.display.spellZone.ICellZoneProvider;
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.managers.SlotDataHolderManager;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.berilia.managers.SecureCenter;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
    import com.ankamagames.jerakine.utils.display.spellZone.IZoneShape;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.berilia.components.Slot;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
    import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
    import __AS3__.vec.*;
    import flash.utils.flash_proxy; 

    use namespace flash.utils.flash_proxy;

    public dynamic class SpellWrapper extends Proxy implements ISlotData, IClonable, ICellZoneProvider, IDataCenter 
    {

        private static var _cache:Array = new Array();
        private static var _playersCache:Dictionary = new Dictionary();
        private static var _cac:SpellWrapper;
        private static var _errorIconUri:Uri;
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellWrapper));
        public static const BASE_DAMAGE_EFFECT_IDS:Array = new Array(100, 96, 97, 98, 99, 92, 93, 94, 95, 1012, 1013, 1014, 1015, 1016);

        private var _uri:Uri;
        private var _slotDataHolderManager:SlotDataHolderManager;
        private var _canTargetCasterOutOfZone:Object;
        private var _variantActivated:Boolean;
        private var _spellLevel:SpellLevel;
        private var _spell:Spell;
        public var id:uint = 0;
        public var spellLevel:int = 1;
        public var effects:Vector.<EffectInstance>;
        public var criticalEffect:Vector.<EffectInstance>;
        public var gfxId:int;
        public var playerId:Number;
        public var versionNum:int;
        public var additionalEffectsZones:Vector.<EffectZone>;
        private var _actualCooldown:uint = 0;


        public static function create(spellID:uint, spellLevel:int=0, useCache:Boolean=true, playerId:Number=0, variantActivated:Boolean=false):SpellWrapper
        {
            var spell:SpellWrapper;
            if (spellID == 0)
            {
                useCache = false;
            };
            if (useCache)
            {
                if (((_cache[spellID]) && (!(playerId))))
                {
                    spell = _cache[spellID];
                }
                else
                {
                    if (((_playersCache[playerId]) && (_playersCache[playerId][spellID])))
                    {
                        spell = _playersCache[playerId][spellID];
                    };
                };
            };
            if (((spellID == 0) && (!(_cac == null))))
            {
                spell = _cac;
            };
            if (!spell)
            {
                spell = new (SpellWrapper)();
                spell.id = spellID;
                if (useCache)
                {
                    if (playerId)
                    {
                        if (!_playersCache[playerId])
                        {
                            _playersCache[playerId] = new Array();
                        };
                        if (!_playersCache[playerId][spellID])
                        {
                            _playersCache[playerId][spellID] = spell;
                        };
                    }
                    else
                    {
                        _cache[spellID] = spell;
                    };
                };
                spell._slotDataHolderManager = new SlotDataHolderManager(spell);
            };
            if (((!(spellID == 0)) || (!(_cac))))
            {
                if (spellID == 0)
                {
                    _cac = spell;
                };
                spell.id = spellID;
                spell.gfxId = spellID;
                spell.variantActivated = variantActivated;
            };
            spell.playerId = playerId;
            var spellData:Spell = Spell.getSpellById(spellID);
            if (!spellData)
            {
                return (null);
            };
            if (spellLevel == 0)
            {
                spell.updateSpellLevelAccordingToPlayerLevel();
            }
            else
            {
                spell.spellLevel = spellLevel;
                spell._spellLevel = spellData.getSpellLevel(spell.spellLevel);
            };
            spell.updateEffectsWithSpellModificators();
            return (spell);
        }

        public static function getSpellWrapperById(spellId:uint, playerID:Number, forceCreate:Boolean=false):SpellWrapper
        {
            if (forceCreate)
            {
                return (create(spellId));
            };
            if (playerID != 0)
            {
                if (!_playersCache[playerID])
                {
                    return (null);
                };
                if (((!(_playersCache[playerID][spellId])) && (_cache[spellId])))
                {
                    _playersCache[playerID][spellId] = _cache[spellId].clone();
                };
                if (spellId == 0)
                {
                    return (_cac);
                };
                if (_playersCache[playerID][spellId])
                {
                    return (_playersCache[playerID][spellId]);
                };
            }
            else
            {
                return (_cache[spellId]);
            };
            return (null);
        }

        public static function refreshAllPlayerSpellHolder(playerId:Number):void
        {
            var wrapper:SpellWrapper;
            for each (wrapper in _playersCache[playerId])
            {
                wrapper._slotDataHolderManager.refreshAll();
            };
            if (_cac)
            {
                _cac._slotDataHolderManager.refreshAll();
            };
        }

        public static function resetAllCoolDown(playerId:Number, accessKey:Object):void
        {
            var wrapper:SpellWrapper;
            SecureCenter.checkAccessKey(accessKey);
            for each (wrapper in _playersCache[playerId])
            {
                wrapper.actualCooldown = 0;
            };
        }

        public static function removeAllSpellWrapperBut(playerId:Number, accessKey:Object):void
        {
            var id:String;
            var num:int;
            var i:int;
            SecureCenter.checkAccessKey(accessKey);
            var temp:Array = new Array();
            for (id in _playersCache)
            {
                if (Number(id) != playerId)
                {
                    temp.push(id);
                };
            };
            num = temp.length;
            i = -1;
            while (++i < num)
            {
                delete _playersCache[temp[i]];
            };
        }

        public static function removeAllSpellWrapper():void
        {
            _playersCache = new Dictionary();
            _cache = new Array();
        }


        public function set actualCooldown(u:uint):void
        {
            this._actualCooldown = u;
            this._slotDataHolderManager.refreshAll();
        }

        public function get actualCooldown():uint
        {
            return ((PlayedCharacterManager.getInstance().isFighting) ? this._actualCooldown : 0);
        }

        public function get spellLevelInfos():SpellLevel
        {
            return (this._spellLevel);
        }

        public function updateSpellLevelAndEffectsAccordingToPlayerLevel():void
        {
            this.updateSpellLevelAccordingToPlayerLevel();
            this.updateEffectsWithSpellModificators();
        }

        public function get variantActivated():Boolean
        {
            return (this._variantActivated);
        }

        public function set variantActivated(value:Boolean):void
        {
            this._variantActivated = value;
        }

        public function get minimalRange():uint
        {
            return (this["minRange"]);
        }

        public function get maximalRange():uint
        {
            return (this.spellLevelInfos.range);
        }

        public function get castZoneInLine():Boolean
        {
            return (this["castInLine"]);
        }

        public function get castZoneInDiagonal():Boolean
        {
            return (this["castInDiagonal"]);
        }

        public function get spellZoneEffects():Vector.<IZoneShape>
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
                if (this.id == 0)
                {
                    for each (iw in build.equipment)
                    {
                        if ((iw is WeaponWrapper))
                        {
                            break;
                        };
                    };
                    if (((!(iw is WeaponWrapper)) && (this.spellLevelInfos)))
                    {
                        return (this.spellLevelInfos.spellZoneEffects);
                    };
                };
            };
            if (((!(this.id == 0)) || (!(PlayedCharacterManager.getInstance().currentWeapon))))
            {
                if (this.spellLevelInfos)
                {
                    return (this.spellLevelInfos.spellZoneEffects);
                };
            };
            return (null);
        }

        public function get hideEffects():Boolean
        {
            if (((this.id == 0) && (!(PlayedCharacterManager.getInstance().currentWeapon == null))))
            {
                return ((PlayedCharacterManager.getInstance().currentWeapon as ItemWrapper).hideEffects);
            };
            if (this.spellLevelInfos)
            {
                return (this.spellLevelInfos.hideEffects);
            };
            return (false);
        }

        public function get backGroundIconUri():Uri
        {
            if (((this.id == 0) && (!(PlayedCharacterManager.getInstance().currentWeapon == null))))
            {
                return (new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/spells/all.swf|noIcon")));
            };
            return (null);
        }

        public function get iconUri():Uri
        {
            return (this.fullSizeIconUri);
        }

        public function get fullSizeIconUri():Uri
        {
            var build:BuildWrapper;
            var iw:ItemWrapper;
            if (((!(this._uri)) || (this.id == 0)))
            {
                if (InventoryManager.getInstance().currentBuildId != -1)
                {
                    for each (build in InventoryManager.getInstance().builds)
                    {
                        if (build.id == InventoryManager.getInstance().currentBuildId)
                        {
                            break;
                        };
                    };
                    if (this.id == 0)
                    {
                        for each (iw in build.equipment)
                        {
                            if ((iw is WeaponWrapper))
                            {
                                break;
                            };
                        };
                        if ((iw is WeaponWrapper))
                        {
                            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|weapon_").concat(iw.typeId));
                        }
                        else
                        {
                            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|sort_0"));
                        };
                    }
                    else
                    {
                        this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|sort_").concat(((this.spell) ? this.spell.iconId : 0)));
                    };
                }
                else
                {
                    if (((this.id == 0) && (!(PlayedCharacterManager.getInstance().currentWeapon == null))))
                    {
                        this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|weapon_").concat(PlayedCharacterManager.getInstance().currentWeapon.typeId));
                    }
                    else
                    {
                        this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|sort_").concat(((this.spell) ? this.spell.iconId : 0)));
                    };
                };
                this._uri.tag = Slot.NEED_CACHE_AS_BITMAP;
            };
            return (this._uri);
        }

        public function get errorIconUri():Uri
        {
            if (!_errorIconUri)
            {
                _errorIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|noIcon"));
            };
            return (_errorIconUri);
        }

        public function get info1():String
        {
            if (((this.actualCooldown == 0) || (!(PlayedCharacterManager.getInstance().isFighting))))
            {
                return (null);
            };
            if (this.actualCooldown == 63)
            {
                return ("-");
            };
            return (this.actualCooldown.toString());
        }

        public function get startTime():int
        {
            return (0);
        }

        public function get endTime():int
        {
            return (0);
        }

        public function set endTime(t:int):void
        {
        }

        public function get timer():int
        {
            return (0);
        }

        public function get active():Boolean
        {
            if (!PlayedCharacterManager.getInstance().isFighting)
            {
                return (true);
            };
            var canCast:Boolean = CurrentPlayedFighterManager.getInstance().canCastThisSpell(this.spellId, this.spellLevel);
            return (canCast);
        }

        public function get spell():Spell
        {
            if (!this._spell)
            {
                this._spell = Spell.getSpellById(this.id);
            };
            return (this._spell);
        }

        public function get spellId():uint
        {
            if (this.spell)
            {
                return (this.spell.id);
            };
            return (0);
        }

        public function get playerCriticalRate():int
        {
            var currentCriticalHitProbability:Number;
            var weaponCriticalHit:uint;
            var characteristics:CharacterCharacteristicsInformations;
            var criticalHit:CharacterBaseCharacteristic;
            var totalCriticalHit:int;
            var critikRate:int;
            if (((this["isSpellWeapon"]) && (!(this["isDefaultSpellWeapon"]))))
            {
                weaponCriticalHit = this.getWeaponProperty("criticalHitProbability");
                currentCriticalHitProbability = ((weaponCriticalHit > 0) ? (55 - weaponCriticalHit) : 0);
            }
            else
            {
                currentCriticalHitProbability = this.getCriticalHitProbability();
            };
            if (((!(isNaN(currentCriticalHitProbability))) && (PlayedCharacterApi.getInstance().knowSpell(this.spellId) >= 0)))
            {
                if ((((!(Kernel.getWorker().contains(FightContextFrame))) || (!(CurrentPlayedFighterManager.getInstance()))) || (PlayedCharacterManager.getInstance().id == CurrentPlayedFighterManager.getInstance().currentFighterId)))
                {
                    characteristics = PlayedCharacterManager.getInstance().characteristics;
                    if (characteristics)
                    {
                        criticalHit = characteristics.criticalHit;
                        totalCriticalHit = (((criticalHit.alignGiftBonus + criticalHit.base) + criticalHit.contextModif) + criticalHit.objectsAndMountBonus);
                        critikRate = (currentCriticalHitProbability - totalCriticalHit);
                        if (critikRate > 55)
                        {
                            critikRate = 55;
                        };
                        return (critikRate);
                    };
                }
                else
                {
                    return (currentCriticalHitProbability);
                };
            };
            return (0);
        }

        public function get maximalRangeWithBoosts():int
        {
            var boostableRange:Boolean;
            var spellModification:CharacterSpellModification;
            var bonus:int;
            var characteristics:CharacterCharacteristicsInformations = PlayedCharacterManager.getInstance().characteristics;
            if (characteristics)
            {
                boostableRange = this.spellLevelInfos.rangeCanBeBoosted;
                if (!boostableRange)
                {
                    for each (spellModification in characteristics.spellModifications)
                    {
                        if (((spellModification.spellId == this.id) && (spellModification.modificationType == CharacterSpellModificationTypeEnum.RANGEABLE)))
                        {
                            boostableRange = true;
                            break;
                        };
                    };
                };
                if (boostableRange)
                {
                    bonus = (((characteristics.range.base + characteristics.range.alignGiftBonus) + characteristics.range.contextModif) + characteristics.range.objectsAndMountBonus);
                    if ((this.maximalRange + bonus) < this.minimalRange)
                    {
                        return (this.minimalRange);
                    };
                    return (this.maximalRange + bonus);
                };
            };
            return (this.maximalRange);
        }

        public function get canTargetCasterOutOfZone():Boolean
        {
            var effect:EffectInstance;
            if (this._canTargetCasterOutOfZone == null)
            {
                for each (effect in this.effects)
                {
                    if (((!(effect.targetMask.indexOf("C") == -1)) && (effect.triggers == "I")))
                    {
                        this._canTargetCasterOutOfZone = true;
                        break;
                    };
                };
                if (!this._canTargetCasterOutOfZone)
                {
                    for each (effect in this.criticalEffect)
                    {
                        if (((!(effect.targetMask.indexOf("C") == -1)) && (effect.triggers == "I")))
                        {
                            this._canTargetCasterOutOfZone = true;
                            break;
                        };
                    };
                };
                if (!this._canTargetCasterOutOfZone)
                {
                    this._canTargetCasterOutOfZone = false;
                };
            };
            return (this._canTargetCasterOutOfZone);
        }

        override flash_proxy function hasProperty(name:*):Boolean
        {
            return (isAttribute(name));
        }

        override flash_proxy function getProperty(name:*):*
        {
            var playedFighter:CurrentPlayedFighterManager;
            var spellModif:CharacterSpellModification;
            var build:BuildWrapper;
            var iw:ItemWrapper;
            var spellLevelRangeCanBeBoosted:Boolean;
            var spellModifRangeValue:int;
            if (isAttribute(name))
            {
                return (this[name]);
            };
            if (InventoryManager.getInstance().currentBuildId != -1)
            {
                for each (build in InventoryManager.getInstance().builds)
                {
                    if (build.id == InventoryManager.getInstance().currentBuildId)
                    {
                        break;
                    };
                };
                if (this.id == 0)
                {
                    for each (iw in build.equipment)
                    {
                        if ((iw is WeaponWrapper))
                        {
                            break;
                        };
                    };
                    if ((iw is WeaponWrapper))
                    {
                        return (this.getWeaponProperty(name, iw));
                    };
                };
            }
            else
            {
                if (((this.id == 0) && (!(PlayedCharacterManager.getInstance().currentWeapon == null))))
                {
                    return (this.getWeaponProperty(name));
                };
            };
            playedFighter = CurrentPlayedFighterManager.getInstance();
            switch (name.toString())
            {
                case "id":
                case "nameId":
                case "descriptionId":
                case "typeId":
                case "scriptParams":
                case "scriptParamsCritical":
                case "scriptId":
                case "scriptIdCritical":
                case "iconId":
                case "spellLevels":
                case "useParamCache":
                case "name":
                case "description":
                case "variants":
                case "default_zone":
                    return (this.spell[name]);
                case "spellBreed":
                case "needFreeCell":
                case "needTakenCell":
                case "minPlayerLevel":
                case "maxStack":
                case "globalCooldown":
                    return (this.spellLevelInfos[name.toString()]);
                case "criticalHitProbability":
                    return (this.getCriticalHitProbability());
                case "maxCastPerTurn":
                    spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.MAX_CAST_PER_TURN);
                    if (spellModif)
                    {
                        return ((this.spellLevelInfos["maxCastPerTurn"] + spellModif.value.contextModif) + spellModif.value.objectsAndMountBonus);
                    };
                    return (this.spellLevelInfos["maxCastPerTurn"]);
                case "range":
                    spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.RANGE_MAX);
                    if (spellModif)
                    {
                        return ((this.spellLevelInfos["range"] + spellModif.value.contextModif) + spellModif.value.objectsAndMountBonus);
                    };
                    return (this.spellLevelInfos["range"]);
                case "minRange":
                    spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.RANGE_MIN);
                    if (spellModif)
                    {
                        return ((this.spellLevelInfos["minRange"] + spellModif.value.contextModif) + spellModif.value.objectsAndMountBonus);
                    };
                    return (this.spellLevelInfos["minRange"]);
                case "maxCastPerTarget":
                    spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET);
                    if (spellModif)
                    {
                        return ((this.spellLevelInfos["maxCastPerTarget"] + spellModif.value.contextModif) + spellModif.value.objectsAndMountBonus);
                    };
                    return (this.spellLevelInfos["maxCastPerTarget"]);
                case "castInLine":
                    spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.CAST_LINE);
                    if (spellModif)
                    {
                        return ((this.spellLevelInfos["castInLine"]) && (((((spellModif.value.contextModif + spellModif.value.objectsAndMountBonus) + spellModif.value.base) + spellModif.value.additionnal) + spellModif.value.alignGiftBonus) == 0));
                    };
                    return (this.spellLevelInfos["castInLine"]);
                case "castInDiagonal":
                    return (this.spellLevelInfos["castInDiagonal"]);
                case "castTestLos":
                    spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.LOS);
                    if (spellModif)
                    {
                        return ((this.spellLevelInfos["castTestLos"]) && (((((spellModif.value.contextModif + spellModif.value.objectsAndMountBonus) + spellModif.value.base) + spellModif.value.additionnal) + spellModif.value.alignGiftBonus) == 0));
                    };
                    return (this.spellLevelInfos["castTestLos"]);
                case "rangeCanBeBoosted":
                    spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.RANGEABLE);
                    spellLevelRangeCanBeBoosted = this.spellLevelInfos["rangeCanBeBoosted"];
                    if (spellModif)
                    {
                        spellModifRangeValue = ((((spellModif.value.contextModif + spellModif.value.objectsAndMountBonus) + spellModif.value.base) + spellModif.value.additionnal) + spellModif.value.alignGiftBonus);
                        return ((spellLevelRangeCanBeBoosted) || (spellModifRangeValue > 0));
                    };
                    return (spellLevelRangeCanBeBoosted);
                case "apCost":
                    spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.AP_COST);
                    if (spellModif)
                    {
                        return (this.spellLevelInfos["apCost"] - ((((spellModif.value.contextModif + spellModif.value.objectsAndMountBonus) + spellModif.value.base) + spellModif.value.additionnal) + spellModif.value.alignGiftBonus));
                    };
                    return (this.spellLevelInfos["apCost"]);
                case "minCastInterval":
                    spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.CAST_INTERVAL);
                    if (spellModif)
                    {
                        return (this.spellLevelInfos["minCastInterval"] - ((((spellModif.value.contextModif + spellModif.value.objectsAndMountBonus) + spellModif.value.base) + spellModif.value.additionnal) + spellModif.value.alignGiftBonus));
                    };
                    return (this.spellLevelInfos["minCastInterval"]);
                case "isSpellWeapon":
                    return (this.id == 0);
                case "isDefaultSpellWeapon":
                    return ((this.id == 0) && (!(PlayedCharacterManager.getInstance().currentWeapon)));
                case "statesRequired":
                    return (this.spellLevelInfos.statesRequired);
                case "statesForbidden":
                    return (this.spellLevelInfos.statesForbidden);
            };
        }

        override flash_proxy function callProperty(name:*, ... rest):*
        {
            return (null);
        }

        private function getWeaponProperty(name:*, item:ItemWrapper=null):*
        {
            var modificator:int;
            var weapon:ItemWrapper = ((item) ? item : (PlayedCharacterManager.getInstance().currentWeapon as ItemWrapper));
            if (!weapon)
            {
                return (null);
            };
            switch (name.toString())
            {
                case "id":
                    return (0);
                case "nameId":
                case "descriptionId":
                case "iconId":
                case "name":
                case "description":
                case "criticalHitProbability":
                case "castInLine":
                case "castInDiagonal":
                case "castTestLos":
                case "apCost":
                case "minRange":
                case "range":
                    return (weapon[name]);
                case "isDefaultSpellWeapon":
                case "useParamCache":
                case "needTakenCell":
                case "rangeCanBeBoosted":
                    return (false);
                case "isSpellWeapon":
                case "needFreeCell":
                    return (true);
                case "minCastInterval":
                case "minPlayerLevel":
                case "maxStack":
                case "maxCastPerTurn":
                case "maxCastPerTarget":
                    return (0);
                case "typeId":
                    return (DataEnum.SPELL_TYPE_SPECIALS);
                case "scriptParams":
                case "scriptParamsCritical":
                case "spellLevels":
                    return (null);
                case "scriptId":
                case "scriptIdCritical":
                case "spellBreed":
                    return (0);
                case "variants":
                    return ([]);
            };
        }

        private function getCriticalHitProbability():Number
        {
            var modifValue:int;
            var criticalHit:Number = ((this.spellLevelInfos["criticalHitProbability"] > 0) ? (55 - this.spellLevelInfos["criticalHitProbability"]) : NaN);
            if (isNaN(criticalHit))
            {
                return (NaN);
            };
            var spellModif:CharacterSpellModification = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.CRITICAL_HIT_BONUS);
            if (spellModif)
            {
                modifValue = ((((spellModif.value.contextModif + spellModif.value.objectsAndMountBonus) + spellModif.value.alignGiftBonus) + spellModif.value.base) + spellModif.value.additionnal);
                return ((criticalHit > 0) ? ((criticalHit - modifValue)) : 0);
            };
            return (criticalHit);
        }

        public function clone():*
        {
            var returnSpellWrapper:SpellWrapper;
            var useCache:Boolean;
            returnSpellWrapper = SpellWrapper.create(this.id, this.spellLevel, useCache, this.playerId, this.variantActivated);
            return (returnSpellWrapper);
        }

        public function addHolder(h:ISlotDataHolder):void
        {
            this._slotDataHolderManager.addHolder(h);
        }

        public function setLinkedSlotData(slotData:ISlotData):void
        {
            this._slotDataHolderManager.setLinkedSlotData(slotData);
        }

        public function removeHolder(h:ISlotDataHolder):void
        {
            this._slotDataHolderManager.removeHolder(h);
        }

        public function toString():String
        {
            return (("[SpellWrapper #" + this.id) + "]");
        }

        private function updateSpellLevelAccordingToPlayerLevel():void
        {
            var i:int;
            var currentCharacterLevel:int = PlayedCharacterManager.getInstance().limitedLevel;
            if (!this.spell)
            {
                return;
            };
            var spellLevels:Array = this._spell.spellLevelsInfo;
            var spellLevelsCount:int = spellLevels.length;
            var index:int;
            i = (spellLevelsCount - 1);
            while (i >= 0)
            {
                if (currentCharacterLevel >= spellLevels[i].minPlayerLevel)
                {
                    index = i;
                    break;
                };
                i--;
            };
            this._spellLevel = spellLevels[index];
            this.spellLevel = (index + 1);
        }

        private function updateEffectsWithSpellModificators():void
        {
            var effectInstance:EffectInstance;
            var damageBaseSpellModif:CharacterSpellModification;
            var damageSpellModif:CharacterSpellModification;
            var healSpellModif:CharacterSpellModification;
            var modif:int;
            var len:uint;
            this.effects = new Vector.<EffectInstance>();
            this.criticalEffect = new Vector.<EffectInstance>();
            for each (effectInstance in this._spellLevel.effects)
            {
                effectInstance = effectInstance.clone();
                if (((effectInstance.category == DataEnum.ACTION_TYPE_DAMAGES) && (!(BASE_DAMAGE_EFFECT_IDS.indexOf(effectInstance.effectId) == -1))))
                {
                    damageBaseSpellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.BASE_DAMAGE);
                    if (((damageBaseSpellModif) && (effectInstance is EffectInstanceDice)))
                    {
                        modif = (((damageBaseSpellModif.value.alignGiftBonus + damageBaseSpellModif.value.base) + damageBaseSpellModif.value.contextModif) + damageBaseSpellModif.value.objectsAndMountBonus);
                        (effectInstance as EffectInstanceDice).diceNum = ((effectInstance as EffectInstanceDice).diceNum + modif);
                        if ((effectInstance as EffectInstanceDice).diceSide > 0)
                        {
                            (effectInstance as EffectInstanceDice).diceSide = ((effectInstance as EffectInstanceDice).diceSide + modif);
                        };
                    };
                    damageSpellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.DAMAGE);
                    healSpellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.HEAL_BONUS);
                    if (damageSpellModif)
                    {
                        effectInstance.modificator = (((damageSpellModif.value.alignGiftBonus + damageSpellModif.value.base) + damageSpellModif.value.contextModif) + damageSpellModif.value.objectsAndMountBonus);
                    }
                    else
                    {
                        if (healSpellModif)
                        {
                            effectInstance.modificator = (((healSpellModif.value.alignGiftBonus + healSpellModif.value.base) + healSpellModif.value.contextModif) + healSpellModif.value.objectsAndMountBonus);
                        };
                    };
                };
                this.effects.push(effectInstance);
            };
            for each (effectInstance in this._spellLevel.criticalEffect)
            {
                effectInstance = effectInstance.clone();
                if (((effectInstance.category == DataEnum.ACTION_TYPE_DAMAGES) && (!(BASE_DAMAGE_EFFECT_IDS.indexOf(effectInstance.effectId) == -1))))
                {
                    damageBaseSpellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.BASE_DAMAGE);
                    if (((damageBaseSpellModif) && (effectInstance is EffectInstanceDice)))
                    {
                        modif = (((damageBaseSpellModif.value.alignGiftBonus + damageBaseSpellModif.value.base) + damageBaseSpellModif.value.contextModif) + damageBaseSpellModif.value.objectsAndMountBonus);
                        (effectInstance as EffectInstanceDice).diceNum = ((effectInstance as EffectInstanceDice).diceNum + modif);
                        if ((effectInstance as EffectInstanceDice).diceSide > 0)
                        {
                            (effectInstance as EffectInstanceDice).diceSide = ((effectInstance as EffectInstanceDice).diceSide + modif);
                        };
                    };
                    damageSpellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.DAMAGE);
                    healSpellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.HEAL_BONUS);
                    if (damageSpellModif)
                    {
                        effectInstance.modificator = (((damageSpellModif.value.alignGiftBonus + damageSpellModif.value.base) + damageSpellModif.value.contextModif) + damageSpellModif.value.objectsAndMountBonus);
                    }
                    else
                    {
                        if (healSpellModif)
                        {
                            effectInstance.modificator = (((healSpellModif.value.alignGiftBonus + healSpellModif.value.base) + healSpellModif.value.contextModif) + healSpellModif.value.objectsAndMountBonus);
                        };
                    };
                };
                this.criticalEffect.push(effectInstance);
            };
            len = this._spellLevel.additionalEffectsZones.length;
            if (len > 0)
            {
                this.additionalEffectsZones = new Vector.<EffectZone>(0);
            };
            var j:int;
            while (j < len)
            {
                this.additionalEffectsZones.push(new EffectZone(this._spellLevel.additionalEffectsZones[j], this._spellLevel.additionalEffectsZones[(j + 1)]));
                j = (j + 2);
            };
        }


    }
} com.ankamagames.dofus.internalDatacenter.spells

