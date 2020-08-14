package Ankama_Tooltips.blocks
{
    import com.ankama.dofus.enums.ActionIds;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blockParams.EffectsTooltipBlockParameters;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.datacenter.monsters.MonsterGrade;
    import com.ankamagames.dofus.datacenter.monsters.MonsterBonusCharacteristics;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMount;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
    import com.ankamagames.dofus.datacenter.mounts.MountBehavior;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMinMax;

    public class HtmlEffectsTooltipBlock 
    {

        public const INDEX_DAMAGES:uint = 0;
        public const INDEX_EFFECTS:uint = 1;
        public const INDEX_STATUS:uint = 2;

        private var _effect:Object;
        private var _content:String;
        private var _block:Object;
        private var _setInfo:String;
        private var _splitDamageAndEffects:Boolean;
        private var _itemTheoreticalEffects:Array;
        private var _showDamages:Boolean;
        private var _showTheoreticalEffects:Boolean;
        private var _addTheoricalEffects:Boolean;
        private var _isCriticalEffects:Boolean;
        private var _showLabel:Boolean;
        private var _showDuration:Boolean;
        private var _length:int;
        private var _exoticEffects:Array;
        private var _missingEffects:Array;
        private var _exoticDamage:Array;
        private var _missingDamage:Array;
        private var _customli:String = "customlirightmargin";

        public function HtmlEffectsTooltipBlock(params:EffectsTooltipBlockParameters)
        {
            var e:*;
            super();
            this._effect = params.effects;
            this._showDamages = params.showDamages;
            this._showTheoreticalEffects = params.showTheoreticalEffects;
            this._addTheoricalEffects = params.addTheoreticalEffects;
            this._isCriticalEffects = params.isCriticalEffects;
            this._length = params.length;
            this._showLabel = params.showLabel;
            this._showDuration = params.showDuration;
            this._splitDamageAndEffects = params.splitDamageAndEffects;
            this._customli = params.customli;
            if (params.itemTheoreticalEffects)
            {
                this._itemTheoreticalEffects = [];
                for each (e in params.itemTheoreticalEffects)
                {
                    if (!this._itemTheoreticalEffects[e.effectId])
                    {
                        this._itemTheoreticalEffects[e.effectId] = [];
                    };
                    if (e.effectId != ActionIds.ACTION_CHARACTER_LEARN_EMOTICON)
                    {
                        this._itemTheoreticalEffects[e.effectId].push(e);
                    };
                };
            };
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            var chunkList:Array = new Array(Api.tooltip.createChunkData("separator", (params.chunkType + "/base/separator.txt")), Api.tooltip.createChunkData("subTitle", (params.chunkType + "/base/subTitle.txt")), Api.tooltip.createChunkData("effect", (params.chunkType + "/effect/effect.txt")), Api.tooltip.createChunkData("subEffect", (params.chunkType + "/effect/subEffect.txt")));
            if (params.setInfo)
            {
                this._setInfo = params.setInfo;
                chunkList.unshift(Api.tooltip.createChunkData("namelessContent", (params.chunkType + "/text/namelessContent.txt")));
            };
            this._block.initChunk(chunkList);
        }

        public function onAllChunkLoaded():void
        {
            var ei:*;
            var effectsPart:_EffectPart;
            var currentCategory:int;
            var exotic:Boolean;
            var effectList:Array;
            var i:int;
            var effects:Array;
            this._content = "";
            this._exoticEffects = new Array();
            this._missingEffects = new Array();
            this._exoticDamage = new Array();
            this._missingDamage = new Array();
            var category:Array = new Array();
            var effectsByEffectId:Array = new Array();
            for each (ei in this._effect)
            {
                if (((ei.category == -1) || (!(ei.visibleInTooltip))))
                {
                }
                else
                {
                    if (ei.effectId == ActionIds.ACTION_ITEM_CHANGE_DURABILITY)
                    {
                    }
                    else
                    {
                        currentCategory = this.INDEX_EFFECTS;
                        if (ei.category == DataEnum.ACTION_TYPE_DAMAGES)
                        {
                            currentCategory = this.INDEX_DAMAGES;
                        }
                        else
                        {
                            if (ei.category == DataEnum.ACTION_TYPE_STATUS)
                            {
                                currentCategory = this.INDEX_STATUS;
                            };
                        };
                        if (!category[currentCategory])
                        {
                            category[currentCategory] = new Array();
                        };
                        effectsByEffectId[ei.effectId] = ei;
                        if (this._itemTheoreticalEffects)
                        {
                            exotic = (this._itemTheoreticalEffects[ei.effectId] == null);
                            if (((exotic) && (ei.showInSet)))
                            {
                                if (ei.category == DataEnum.ACTION_TYPE_DAMAGES)
                                {
                                    this._exoticDamage.push(ei);
                                }
                                else
                                {
                                    this._exoticEffects.push(ei);
                                };
                                continue;
                            };
                        };
                        category[currentCategory].push(ei);
                    };
                };
            };
            if (((this._itemTheoreticalEffects) && (this._addTheoricalEffects)))
            {
                for each (effectList in this._itemTheoreticalEffects)
                {
                    i = 0;
                    while (i < effectList.length)
                    {
                        ei = effectList[i];
                        if (((!(effectsByEffectId[ei.effectId])) && (ei.showInSet)))
                        {
                            if (ei.category == DataEnum.ACTION_TYPE_DAMAGES)
                            {
                                this._missingDamage.push(ei);
                            }
                            else
                            {
                                this._missingEffects.push(ei);
                            };
                        };
                        i++;
                    };
                };
            };
            if (!category.length)
            {
                return;
            };
            var sortedCategory:Array = new Array();
            if (category[this.INDEX_STATUS])
            {
                sortedCategory.push(new _EffectPart(Api.ui.getText("ui.chat.status.title"), DataEnum.ACTION_TYPE_STATUS, category[this.INDEX_STATUS]));
            };
            if (this._splitDamageAndEffects)
            {
                if ((((category[this.INDEX_DAMAGES]) && (this._exoticDamage)) && (this._exoticDamage.length)))
                {
                    category[this.INDEX_DAMAGES] = this._exoticDamage.concat(category[this.INDEX_DAMAGES]);
                };
                if ((((category[this.INDEX_DAMAGES]) && (this._missingDamage)) && (this._missingDamage.length)))
                {
                    category[this.INDEX_DAMAGES] = category[this.INDEX_DAMAGES].concat(this._missingDamage);
                };
                if (((category[this.INDEX_DAMAGES]) && (this._showDamages)))
                {
                    sortedCategory.push(new _EffectPart(((this._isCriticalEffects) ? Api.ui.getText("ui.common.criticalDamages") : Api.ui.getText("ui.stats.damagesBonus")), DataEnum.ACTION_TYPE_DAMAGES, category[this.INDEX_DAMAGES]));
                };
                if ((((category[this.INDEX_EFFECTS]) && (this._exoticEffects)) && (this._exoticEffects.length)))
                {
                    category[this.INDEX_EFFECTS] = this._exoticEffects.concat(category[this.INDEX_EFFECTS]);
                };
                if ((((category[this.INDEX_EFFECTS]) && (this._missingEffects)) && (this._missingEffects.length)))
                {
                    category[this.INDEX_EFFECTS] = category[this.INDEX_EFFECTS].concat(this._missingEffects);
                };
                if (category[this.INDEX_EFFECTS])
                {
                    sortedCategory.push(new _EffectPart(Api.ui.processText(((this._isCriticalEffects) ? Api.ui.getText("ui.common.criticalEffects") : Api.ui.getText("ui.common.effects")), "", (category[this.INDEX_EFFECTS].length == 1), (category[this.INDEX_EFFECTS].length == 0)), DataEnum.ACTION_TYPE_CARACTERISTICS, category[this.INDEX_EFFECTS]));
                };
            }
            else
            {
                effects = [];
                if (category[this.INDEX_DAMAGES])
                {
                    effects = category[this.INDEX_DAMAGES];
                };
                if (category[this.INDEX_EFFECTS])
                {
                    effects = effects.concat(category[this.INDEX_EFFECTS]);
                };
                sortedCategory.push(new _EffectPart(Api.ui.processText(((this._isCriticalEffects) ? Api.ui.getText("ui.common.criticalEffects") : Api.ui.getText("ui.common.effects")), "", (effects.length == 1), (effects.length == 0)), DataEnum.ACTION_TYPE_CARACTERISTICS, effects));
            };
            if (this._setInfo)
            {
                this._content = (this._content + this._block.getChunk("namelessContent").processContent({
                    "content":this._setInfo,
                    "css":"[local.css]tooltip_monster.css"
                }));
            };
            var lastDuration:uint;
            var starting:Boolean = true;
            for each (effectsPart in sortedCategory)
            {
                if (((this._showLabel) && (effectsPart.title)))
                {
                    if (!starting)
                    {
                        this._content = (this._content + this._block.getChunk("separator").processContent({}));
                    };
                    this._content = (this._content + this._block.getChunk("subTitle").processContent({"text":effectsPart.title}));
                };
                for each (ei in effectsPart.effects)
                {
                    if (ei)
                    {
                        this._content = (this._content + this.processEffect(effectsPart, ei, "effect"));
                        lastDuration = ei.duration;
                    };
                };
                starting = false;
            };
            this._exoticEffects = null;
            this._missingEffects = null;
            this._exoticDamage = null;
            this._missingDamage;
            this._itemTheoreticalEffects = null;
        }

        private function processEffect(effectsPart:_EffectPart, ei:Object, chunk:String, chunkArgs:Object=null, showSubEffect:Boolean=true):String
        {
            var spell:SpellWrapper;
            var theoreticalEffect:*;
            var theoreticalDesc:String;
            var myPattern:RegExp;
            var result:Object;
            var monster:Monster;
            var gradeId:int;
            var grade:MonsterGrade;
            var bonusCharacteristics:MonsterBonusCharacteristics;
            var level:int;
            var playedCharacterInfo:Object;
            var playerCharacteristics:CharacterCharacteristicsInformations;
            var lifePoints:int;
            var neutralResistance:Number;
            var earthResistance:Number;
            var fireResistance:Number;
            var waterResistance:Number;
            var airResistance:Number;
            var bonusDodge:int;
            var subSpell:Object;
            var bombData:Object;
            var subEffect:Object;
            var mountEffect:EffectInstanceMount;
            var nameText:String;
            var levelText:String;
            var sexText:String;
            var isRideableText:String;
            var fecondationStateText:String;
            var reproductionText:String;
            var capacitiesCount:int;
            var capacitiesText:String;
            var ownerText:String;
            var now:Date;
            var expirationDateText:String;
            var subEffectMount:EffectInstanceInteger;
            var capacity:MountBehavior;
            var i:int;
            if (!ei)
            {
                return ("");
            };
            var content:String = "";
            var description:String = "";
            if (ei.effectId == ActionIds.ACTION_CAST_STARTING_SPELL)
            {
                spell = Api.data.getSpellWrapper(ei.diceNum, ei.diceSide);
                description = (description + spell.spell.description);
            }
            else
            {
                if (this._showTheoreticalEffects)
                {
                    description = (description + ((ei.showInSet) ? ei.theoreticalDescriptionForTooltip : ei.theoreticalDescription));
                }
                else
                {
                    description = (description + ((ei.showInSet) ? ei.descriptionForTooltip : ei.description));
                };
            };
            if (((!(description)) || (description == "null")))
            {
                return ("");
            };
            var cssClass:String = "bonus";
            var baseDescription:String = ei.description;
            if (effectsPart.type == DataEnum.ACTION_TYPE_CARACTERISTICS)
            {
                if (((ei.bonusType == -1) || ((baseDescription) && (baseDescription.charAt(0) == "-"))))
                {
                    if (description.indexOf("<span class='#valueCssClass'>-") == 0)
                    {
                        description = description.replace("<span class='#valueCssClass'>-", "<span class='#valueCssClass'>- ");
                    };
                    cssClass = "malus";
                };
            };
            if ((((this._exoticEffects) && (!(this._exoticEffects.indexOf(ei) == -1))) || ((this._exoticDamage) && (!(this._exoticDamage.indexOf(ei) == -1)))))
            {
                cssClass = "exotic";
            }
            else
            {
                if ((((this._missingEffects) && (!(this._missingEffects.indexOf(ei) == -1))) || ((this._missingDamage) && (!(this._missingDamage.indexOf(ei) == -1)))))
                {
                    cssClass = "theoretical";
                };
            };
            var valueCssClass:* = (cssClass + "value");
            var duration:String;
            if (this._showDuration)
            {
                if (ei.durationString)
                {
                    duration = ((" (" + ei.durationString) + ")");
                };
            };
            if (ei.trigger)
            {
                description = Api.ui.getText("ui.spell.trigger", description);
            };
            if (duration)
            {
                description = (description + duration);
            };
            if (((((((this._addTheoricalEffects) && (ei.showInSet)) && ((!(this._missingEffects)) || (this._missingEffects.indexOf(ei) == -1))) && (this._itemTheoreticalEffects)) && (this._itemTheoreticalEffects[ei.effectId])) && (this._itemTheoreticalEffects[ei.effectId].length)))
            {
                theoreticalEffect = this._itemTheoreticalEffects[ei.effectId][0];
                if (((theoreticalEffect) && ((theoreticalEffect is EffectInstanceMinMax) || (theoreticalEffect is EffectInstanceDice))))
                {
                    if (((!(effectsPart.type == DataEnum.ACTION_TYPE_CARACTERISTICS)) || (!(theoreticalEffect.description == ei.description))))
                    {
                        theoreticalDesc = theoreticalEffect.theoreticalShortDescriptionForTooltip;
                        if (theoreticalDesc)
                        {
                            description = (description + (("  <span class='theoretical'>&#91; " + theoreticalDesc) + " &#93;</span>"));
                        };
                    };
                };
            };
            if ((((ei.targetMask) && (ei.targetMask.length)) && ((((((!(ei.targetMask.indexOf("i") == -1)) || (!(ei.targetMask.indexOf("s") == -1))) || (!(ei.targetMask.indexOf("I") == -1))) || (!(ei.targetMask.indexOf("S") == -1))) || (!(ei.targetMask.indexOf("j") == -1))) || (!(ei.targetMask.indexOf("J") == -1)))))
            {
                myPattern = new RegExp(/^[iIsSjJfFeE0-9,]+$/);
                result = myPattern.exec(ei.targetMask);
                if (result)
                {
                    description = (description + ((" (" + Api.ui.getText("ui.common.summon")) + ")"));
                };
            };
            if (!chunkArgs)
            {
                chunkArgs = new Object();
            };
            chunkArgs.text = description;
            chunkArgs.cssClass = cssClass;
            chunkArgs.li = "";
            chunkArgs.customli = this._customli;
            if (chunk == "subEffect")
            {
                content = (content + this.processSubEffectChunk(chunkArgs, {"valueCssClass":valueCssClass}));
            }
            else
            {
                content = (content + this._block.getChunk(chunk).processContent(chunkArgs, {"valueCssClass":valueCssClass}));
            };
            if (showSubEffect)
            {
                if (((((ei.effectId == ActionIds.ACTION_SUMMON_CREATURE) || (ei.effectId == ActionIds.ACTION_FIGHT_KILL_AND_SUMMON)) || (ei.effectId == ActionIds.ACTION_FIGHT_KILL_AND_SUMMON_SLAVE)) || (ei.effectId == ActionIds.ACTION_SUMMON_SLAVE)))
                {
                    monster = Api.data.getMonsterFromId(int(ei.parameter0));
                    if (monster)
                    {
                        gradeId = int(ei.parameter1);
                        if (((gradeId < 1) || (gradeId > monster.grades.length)))
                        {
                            gradeId = monster.grades.length;
                        };
                        grade = monster.grades[(gradeId - 1)];
                        bonusCharacteristics = grade.bonusCharacteristics;
                        level = 1;
                        playedCharacterInfo = Api.player.getPlayedCharacterInfo();
                        playerCharacteristics = Api.player.characteristics();
                        if (playedCharacterInfo)
                        {
                            level = playedCharacterInfo.limitedLevel;
                        };
                        lifePoints = int(Math.floor((((grade.lifePoints + ((grade.lifePoints * level) / 100)) + grade.vitality) + (Api.player.getBaseLifePoints() * (bonusCharacteristics.lifePoints / 100)))));
                        neutralResistance = Math.floor((grade.neutralResistance + ((Api.player.getTotalValueFromCharacteristic(playerCharacteristics.neutralElementResistPercent) - playerCharacteristics.neutralElementResistPercent.contextModif) * (bonusCharacteristics.neutralResistance / 100))));
                        earthResistance = Math.floor((grade.earthResistance + ((Api.player.getTotalValueFromCharacteristic(playerCharacteristics.earthElementResistPercent) - playerCharacteristics.earthElementResistPercent.contextModif) * (bonusCharacteristics.earthResistance / 100))));
                        fireResistance = Math.floor((grade.fireResistance + ((Api.player.getTotalValueFromCharacteristic(playerCharacteristics.fireElementResistPercent) - playerCharacteristics.fireElementResistPercent.contextModif) * (bonusCharacteristics.fireResistance / 100))));
                        waterResistance = Math.floor((grade.waterResistance + ((Api.player.getTotalValueFromCharacteristic(playerCharacteristics.waterElementResistPercent) - playerCharacteristics.waterElementResistPercent.contextModif) * (bonusCharacteristics.waterResistance / 100))));
                        airResistance = Math.floor((grade.airResistance + ((Api.player.getTotalValueFromCharacteristic(playerCharacteristics.airElementResistPercent) - playerCharacteristics.airElementResistPercent.contextModif) * (bonusCharacteristics.airResistance / 100))));
                        content = (content + this._block.getChunk("subEffect").processContent({
                            "text":((((Api.ui.getText("ui.stats.HP") + Api.ui.getText("ui.common.colon")) + "<span class='#valueCssClass'>") + lifePoints) + "</span>"),
                            "rightText":((((Api.ui.getText("ui.stats.neutralReductionPercent") + Api.ui.getText("ui.common.colon")) + "<span class='#valueCssClass'>") + neutralResistance) + "</span>")
                        }, {"valueCssClass":"value"}));
                        content = (content + this._block.getChunk("subEffect").processContent({
                            "text":((((Api.ui.getText("ui.stats.shortAP") + Api.ui.getText("ui.common.colon")) + "<span class='#valueCssClass'>") + grade.actionPoints) + "</span>"),
                            "rightText":((((Api.ui.getText("ui.stats.earthReductionPercent") + Api.ui.getText("ui.common.colon")) + "<span class='#valueCssClass'>") + earthResistance) + "</span>")
                        }, {"valueCssClass":"value"}));
                        content = (content + this._block.getChunk("subEffect").processContent({
                            "text":((((Api.ui.getText("ui.stats.shortMP") + Api.ui.getText("ui.common.colon")) + "<span class='#valueCssClass'>") + grade.movementPoints) + "</span>"),
                            "rightText":((((Api.ui.getText("ui.stats.fireReductionPercent") + Api.ui.getText("ui.common.colon")) + "<span class='#valueCssClass'>") + fireResistance) + "</span>")
                        }, {"valueCssClass":"value"}));
                        bonusDodge = int(Math.floor(((grade.wisdom + ((grade.wisdom * level) / 100)) / 10)));
                        content = (content + this._block.getChunk("subEffect").processContent({
                            "text":((((Api.ui.getText("ui.stats.dodgeAP") + Api.ui.getText("ui.common.colon")) + "<span class='#valueCssClass'>") + (grade.paDodge + bonusDodge)) + "</span>"),
                            "rightText":((((Api.ui.getText("ui.stats.waterReductionPercent") + Api.ui.getText("ui.common.colon")) + "<span class='#valueCssClass'>") + waterResistance) + "</span>")
                        }, {"valueCssClass":"value"}));
                        content = (content + this._block.getChunk("subEffect").processContent({
                            "text":((((Api.ui.getText("ui.stats.dodgeMP") + Api.ui.getText("ui.common.colon")) + "<span class='#valueCssClass'>") + (grade.pmDodge + bonusDodge)) + "</span>"),
                            "rightText":((((Api.ui.getText("ui.stats.airReductionPercent") + Api.ui.getText("ui.common.colon")) + "<span class='#valueCssClass'>") + airResistance) + "</span>")
                        }, {"valueCssClass":"value"}));
                    };
                };
                if ((((((ei.effectId == ActionIds.ACTION_FIGHT_ADD_TRAP_CASTING_SPELL) || (ei.effectId == ActionIds.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL)) || (ei.effectId == ActionIds.ACTION_SUMMON_BOMB)) || (ei.effectId == ActionIds.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL_ENDTURN)) || (ei.effectId == ActionIds.ACTION_FIGHT_ADD_GLYPH_AURA)))
                {
                    if (ei.effectId != ActionIds.ACTION_SUMMON_BOMB)
                    {
                        subSpell = Api.data.getSpellWrapper(int(ei.parameter0), int(ei.parameter1));
                    }
                    else
                    {
                        bombData = Api.data.getBomb(int(ei.parameter0));
                        subSpell = Api.data.getSpellWrapper(bombData.explodSpellId, int(ei.parameter1));
                    };
                    if (subSpell)
                    {
                        for each (subEffect in subSpell.effects)
                        {
                            if (subEffect.visibleInTooltip)
                            {
                                content = (content + this.processEffect(effectsPart, subEffect, "subEffect", {"rightText":""}, false));
                            };
                        };
                    };
                };
                if (ei.effectId == ActionIds.ACTION_RIDE_DETAILS)
                {
                    mountEffect = (ei as EffectInstanceMount);
                    if (mountEffect.name == "")
                    {
                        nameText = Api.ui.getText("ui.common.noName");
                    }
                    else
                    {
                        nameText = ((((Api.ui.getText("ui.common.name") + Api.ui.getText("ui.common.colon")) + "<span class='#valueCssClass'>") + mountEffect.name) + "</span>");
                    };
                    levelText = ((((Api.ui.getText("ui.common.level") + Api.ui.getText("ui.common.colon")) + "<span class='#valueCssClass'>") + mountEffect.level) + "</span>");
                    sexText = ((mountEffect.sex) ? Api.ui.getText("ui.common.animalFemale") : Api.ui.getText("ui.common.animalMale"));
                    sexText = (("<span class='#valueCssClass'>" + sexText) + "</span>");
                    isRideableText = ((Api.ui.getText("ui.common.mountable") + Api.ui.getText("ui.common.colon")) + ((mountEffect.isRideable) ? ((("<span class='#valueCssClass'>" + Api.ui.getText("ui.common.yes")) + "</span>")) : (Api.ui.getText("ui.common.no"))));
                    fecondationStateText = "<span class='#valueCssClass'>";
                    if (mountEffect.isFeconded)
                    {
                        fecondationStateText = (fecondationStateText + Api.ui.getText("ui.mount.filterFecondee"));
                    }
                    else
                    {
                        if (mountEffect.isFecondationReady)
                        {
                            fecondationStateText = (fecondationStateText + Api.ui.getText("ui.mount.filterFecondable"));
                        }
                        else
                        {
                            fecondationStateText = (fecondationStateText + Api.ui.getText("ui.mount.filterNoFecondable"));
                        };
                    };
                    fecondationStateText = (fecondationStateText + "</span>");
                    if (mountEffect.reproductionCount == -1)
                    {
                        reproductionText = Api.ui.getText("ui.mount.castrated");
                    }
                    else
                    {
                        if (mountEffect.reproductionCount >= mountEffect.reproductionCountMax)
                        {
                            reproductionText = Api.ui.getText("ui.mount.sterilized");
                        }
                        else
                        {
                            reproductionText = ((((((Api.ui.getText("ui.common.reproductions") + Api.ui.getText("ui.common.colon")) + "<span class='#valueCssClass'>") + mountEffect.reproductionCount) + " / ") + mountEffect.reproductionCountMax) + "</span>");
                        };
                    };
                    capacitiesCount = mountEffect.capacities.length;
                    capacitiesText = "";
                    if (capacitiesCount > 0)
                    {
                        capacity = Api.data.getMountBehaviorById(mountEffect.capacities[0]);
                        capacitiesText = (capacitiesText + capacity.name);
                        if (capacitiesCount > 1)
                        {
                            i = 1;
                            while (i < capacitiesCount)
                            {
                                capacity = Api.data.getMountBehaviorById(mountEffect.capacities[i]);
                                capacitiesText = (capacitiesText + (", " + capacity.name));
                                i++;
                            };
                        };
                        capacitiesText = (("<span class='#valueCssClass'>" + capacitiesText) + "</span>");
                    };
                    ownerText = ((Api.ui.getText("ui.common.belongsTo") + Api.ui.getText("ui.common.colon")) + mountEffect.owner);
                    now = new Date();
                    expirationDateText = Api.ui.getText("ui.mount.expiration", Api.time.getShortDuration((mountEffect.expirationDate - now.time), false));
                    content = (content + this._block.getChunk("subEffect").processContent({
                        "text":nameText,
                        "rightText":levelText
                    }, {"valueCssClass":"value"}));
                    content = (content + this._block.getChunk("subEffect").processContent({
                        "text":sexText,
                        "rightText":isRideableText
                    }, {"valueCssClass":"value"}));
                    content = (content + this._block.getChunk("subEffect").processContent({
                        "text":fecondationStateText,
                        "rightText":reproductionText
                    }, {"valueCssClass":"value"}));
                    content = (content + this._block.getChunk("subEffect").processContent({
                        "text":capacitiesText,
                        "rightText":""
                    }, {"valueCssClass":"value"}));
                    content = (content + this._block.getChunk("subEffect").processContent({
                        "text":ownerText,
                        "rightText":""
                    }));
                    content = (content + this._block.getChunk("subEffect").processContent({
                        "text":expirationDateText,
                        "rightText":""
                    }));
                    for each (subEffectMount in mountEffect.effects)
                    {
                        content = (content + this.processEffect(effectsPart, subEffectMount, "subEffect", {"rightText":""}, false));
                    };
                };
            };
            return (content);
        }

        private function getMaxWordwrapIndex(text:String, maxLength:int):int
        {
            var tmpIndex:int;
            var i:int;
            var index:int = Math.min(maxLength, text.length);
            if (index == maxLength)
            {
                tmpIndex = (index - 1);
                if (text.charAt(tmpIndex) != " ")
                {
                    i = (tmpIndex - 1);
                    while (i >= 0)
                    {
                        if (text.charAt(i) == " ")
                        {
                            index = (i + 1);
                            break;
                        };
                        i--;
                    };
                };
            };
            return (index);
        }

        private function processSubEffectChunk(chunkArgs:Object, secondaryParams:Object=null, forcedMaxLength:uint=0):String
        {
            var maxLength:uint;
            var openingValueSpanTag:String;
            var closingSpanTag:String;
            var cssClass:String;
            var valueText:String;
            var openingBonusValueTag:String;
            var startIndex:int;
            var endIndex:int;
            var bonusValueText:String;
            var remainingText:String;
            var leftPart:String;
            var rightPart:String;
            var middlePart:String;
            var textPart:String;
            var index:int;
            if (forcedMaxLength != 0)
            {
                maxLength = forcedMaxLength;
            }
            else
            {
                if (Api.system.getActiveFontType() == "default")
                {
                    maxLength = 47;
                }
                else
                {
                    maxLength = 45;
                };
            };
            var processedContent:String = "";
            var text:String = chunkArgs.text;
            if (text.indexOf("#valueCssClass") != -1)
            {
                openingValueSpanTag = "<span class='#valueCssClass'>";
                closingSpanTag = "</span>";
                cssClass = chunkArgs.cssClass;
                valueText = text.substring(0, text.lastIndexOf(closingSpanTag));
                while (valueText.indexOf(openingValueSpanTag) != -1)
                {
                    valueText = valueText.replace(openingValueSpanTag, "");
                };
                while (valueText.indexOf(closingSpanTag) != -1)
                {
                    valueText = valueText.replace(closingSpanTag, "");
                };
                chunkArgs.text = valueText;
                chunkArgs.cssClass = secondaryParams["valueCssClass"];
                processedContent = (processedContent + this.processSubEffectChunk(chunkArgs, null, ((Api.system.getActiveFontType() == "smallScreen") ? 40 : 0)));
                openingBonusValueTag = (("<p class='subeffectleftcolumn'><span class='" + chunkArgs.cssClass) + "'>");
                startIndex = (processedContent.lastIndexOf(openingBonusValueTag) + openingBonusValueTag.length);
                endIndex = processedContent.indexOf(closingSpanTag, startIndex);
                bonusValueText = processedContent.substring(startIndex, endIndex);
                startIndex = (text.lastIndexOf(closingSpanTag) + closingSpanTag.length);
                remainingText = text.substring(startIndex);
                leftPart = processedContent.substring(0, (endIndex + closingSpanTag.length));
                rightPart = processedContent.substring((endIndex + closingSpanTag.length));
                endIndex = this.getMaxWordwrapIndex(remainingText, (maxLength - bonusValueText.length));
                middlePart = remainingText.substring(0, endIndex);
                processedContent = ((((((leftPart + "<span class='") + cssClass) + "'>") + middlePart) + "</span>") + rightPart);
                chunkArgs.text = remainingText.substring(endIndex);
                if (chunkArgs.text.length)
                {
                    chunkArgs.cssClass = cssClass;
                    processedContent = (processedContent + this.processSubEffectChunk(chunkArgs));
                };
                return (processedContent);
            };
            if (text.length > maxLength)
            {
                while (text.length)
                {
                    textPart = "";
                    index = this.getMaxWordwrapIndex(text, maxLength);
                    textPart = text.substring(0, index);
                    chunkArgs.text = textPart;
                    processedContent = (processedContent + this._block.getChunk("subEffect").processContent(chunkArgs, secondaryParams));
                    text = text.substring(index);
                };
            }
            else
            {
                processedContent = this._block.getChunk("subEffect").processContent(chunkArgs, secondaryParams);
            };
            return (processedContent);
        }

        public function getContent():String
        {
            return (this._content);
        }

        public function get block():Object
        {
            return (this._block);
        }


    }
} Ankama_Tooltips.blocks

class _EffectPart 
{

    public var title:String;
    public var type:uint;
    public var effects:Array;

    public function _EffectPart(title:String, _arg_2:uint, effects:Array):void
    {
        this.title = title;
        this.type = _arg_2;
        this.effects = effects;
    }

}


