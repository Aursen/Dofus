package Ankama_Fight.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.FightApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.EntityDisplayer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import flash.utils.Dictionary;
    import d2hooks.FighterInfoUpdate;
    import d2hooks.FightEvent;
    import d2hooks.SpectateUpdate;
    import d2hooks.GameFightEnd;
    import d2hooks.SpectatorWantLeave;
    import d2hooks.FontActiveTypeChanged;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
    import d2hooks.*;

    public class FighterInfo 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="FightApi")]
        public var fightApi:FightApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        public var mainCtr:GraphicContainer;
        public var ctr_entity:GraphicContainer;
        public var btn_spectatorPanel:ButtonContainer;
        public var entityDisplayer:EntityDisplayer;
        public var lbl_name:Label;
        public var lbl_lifePoints:Label;
        public var lbl_shieldPoints:Label;
        public var lbl_actionPoints:Label;
        public var lbl_movementPoints:Label;
        public var lbl_action:Label;
        public var lbl_movement:Label;
        public var lbl_tackle:Label;
        public var lbl_criticalDmgReduction:Label;
        public var lbl_pushDmgReduction:Label;
        public var lbl_neutralPercent:Label;
        public var lbl_strengthPercent:Label;
        public var lbl_intelligencePercent:Label;
        public var lbl_chancePercent:Label;
        public var lbl_agilityPercent:Label;
        public var lbl_neutral:Label;
        public var lbl_strength:Label;
        public var lbl_intelligence:Label;
        public var lbl_chance:Label;
        public var lbl_agility:Label;
        public var tx_shieldPoints:Texture;
        public var tx_actionPoints:Texture;
        public var tx_movementPoints:Texture;
        public var tx_action:Texture;
        public var tx_movement:Texture;
        public var tx_tackle:Texture;
        public var tx_criticalDmgReduction:Texture;
        public var tx_pushDmgReduction:Texture;
        public var tx_neutralPercent:Texture;
        public var tx_strengthPercent:Texture;
        public var tx_intelligencePercent:Texture;
        public var tx_chancePercent:Texture;
        public var tx_agilityPercent:Texture;
        public var tx_neutral:Texture;
        public var tx_strength:Texture;
        public var tx_intelligence:Texture;
        public var tx_chance:Texture;
        public var tx_agility:Texture;
        private var _fighterId:Number;
        private var _lastFighterId:Number;
        private var _stats:Dictionary = new Dictionary();
        private var _textureByLabel:Dictionary = new Dictionary();


        public function main(params:Object):void
        {
            this.sysApi.addHook(FighterInfoUpdate, this.onFighterInfoUpdate);
            this.sysApi.addHook(FightEvent, this.onFightEvent);
            this.sysApi.addHook(SpectateUpdate, this.onSpectateUpdate);
            this.sysApi.addHook(GameFightEnd, this.onGameFightEnd);
            this.sysApi.addHook(SpectatorWantLeave, this.onSpectatorWantLeave);
            this.sysApi.addHook(FontActiveTypeChanged, this.onFontActiveTypeChanged);
            this.mainCtr.visible = false;
            this.entityDisplayer.useFade = false;
            this._textureByLabel[this.lbl_shieldPoints] = this.tx_shieldPoints;
            this._textureByLabel[this.lbl_actionPoints] = this.tx_actionPoints;
            this._textureByLabel[this.lbl_movementPoints] = this.tx_movementPoints;
            this._textureByLabel[this.lbl_action] = this.tx_action;
            this._textureByLabel[this.lbl_movement] = this.tx_movement;
            this._textureByLabel[this.lbl_tackle] = this.tx_tackle;
            this._textureByLabel[this.lbl_criticalDmgReduction] = this.tx_criticalDmgReduction;
            this._textureByLabel[this.lbl_pushDmgReduction] = this.tx_pushDmgReduction;
            this._textureByLabel[this.lbl_neutralPercent] = this.tx_neutralPercent;
            this._textureByLabel[this.lbl_strengthPercent] = this.tx_strengthPercent;
            this._textureByLabel[this.lbl_intelligencePercent] = this.tx_intelligencePercent;
            this._textureByLabel[this.lbl_chancePercent] = this.tx_chancePercent;
            this._textureByLabel[this.lbl_agilityPercent] = this.tx_agilityPercent;
            this._textureByLabel[this.lbl_neutral] = this.tx_neutral;
            this._textureByLabel[this.lbl_strength] = this.tx_strength;
            this._textureByLabel[this.lbl_intelligence] = this.tx_intelligence;
            this._textureByLabel[this.lbl_chance] = this.tx_chance;
            this._textureByLabel[this.lbl_agility] = this.tx_agility;
            this.forceLabelUpdate();
        }

        public function unload():void
        {
            var bannerUi:Object = this.uiApi.getUi("bannerMenu").uiClass;
            bannerUi.gd_btnUis.mouseChildren = true;
        }

        private function forceLabelUpdate():void
        {
            var ls:String;
            var letterSpacing:int;
            if ((((this.sysApi.getActiveFontType() == "smallScreen") && (this.lbl_lifePoints.aStyleObj)) && (this.lbl_lifePoints.aStyleObj[this.lbl_lifePoints.cssClass])))
            {
                ls = this.lbl_lifePoints.aStyleObj[this.lbl_lifePoints.cssClass].letterSpacing;
                letterSpacing = parseInt(ls.substring(0, ls.indexOf("px")));
                this.lbl_lifePoints.updateTextFormatProperty("letterSpacing", letterSpacing);
            };
        }

        private function showEntityDisplayer():void
        {
            this.entityDisplayer.look = this.fightApi.getFighterInformations(this._fighterId).look;
            this.entityDisplayer.setAnimationAndDirection("AnimStatique", 1);
            this.entityDisplayer.visible = true;
        }

        public function onRelease(target:Object):void
        {
            if (target == this.btn_spectatorPanel)
            {
                if (!this.uiApi.getUi("spectatorPanel"))
                {
                    this.sysApi.dispatchHook(SpectateUpdate, 0, "", "");
                    this.btn_spectatorPanel.selected = true;
                }
                else
                {
                    this.uiApi.unloadUi("spectatorPanel");
                    this.btn_spectatorPanel.selected = false;
                };
            };
        }

        private function updateStatText(label:Label, text:String, isAPercent:Boolean=false):void
        {
            if (text == "0")
            {
                label.cssClass = "fighterinfodisabled";
                this._textureByLabel[label].disabled = true;
            }
            else
            {
                label.cssClass = "fighterinfo";
                this._textureByLabel[label].disabled = false;
            };
            if (isAPercent)
            {
                text = (text + "%");
            };
            label.text = text;
        }

        public function onFontActiveTypeChanged():void
        {
            this.forceLabelUpdate();
        }

        public function onFighterInfoUpdate(infos:Object=null):void
        {
            var nameText:String;
            var level:int;
            var breedText:String;
            var bannerUi:Object = this.uiApi.getUi("bannerMenu").uiClass;
            if (((infos) && (!(this.fightApi.preFightIsActive()))))
            {
                bannerUi.gd_btnUis.mouseChildren = false;
                if (((this.fightApi.isSpectator()) && (this.sysApi.getOption("spectatorAutoShowCurrentFighterInfo", "dofus"))))
                {
                    this.btn_spectatorPanel.visible = false;
                };
                this.entityDisplayer.disabled = (infos.stats.lifePoints <= 0);
                nameText = (this.fightApi.getFighterName(infos.contextualId) + "  ");
                level = this.fightApi.getFighterLevel(infos.contextualId);
                if (((infos.contextualId > 0) && (level > ProtocolConstantsEnum.MAX_LEVEL)))
                {
                    nameText = (nameText + (this.uiApi.getText("ui.common.short.prestige") + (level - ProtocolConstantsEnum.MAX_LEVEL)));
                }
                else
                {
                    nameText = (nameText + (this.uiApi.getText("ui.common.short.level") + level));
                };
                if (((infos.hasOwnProperty("breed")) && (infos.breed > 0)))
                {
                    breedText = this.dataApi.getBreed(infos.breed).shortName;
                    nameText = (nameText + (" - " + breedText));
                };
                this.lbl_name.text = nameText;
                this._lastFighterId = this._fighterId;
                this._fighterId = infos.contextualId;
                if (((!(this._stats["lifePoints"] == infos.stats.lifePoints)) || (!(this._stats["maxLifePoints"] == infos.stats.maxLifePoints))))
                {
                    this._stats["lifePoints"] = infos.stats.lifePoints;
                    this._stats["maxLifePoints"] = infos.stats.maxLifePoints;
                    this.updateLifePoints();
                };
                if (this._stats["shieldPoints"] != infos.stats.shieldPoints)
                {
                    this._stats["shieldPoints"] = infos.stats.shieldPoints;
                    this.updateShieldPoints();
                };
                if (this._stats["fighterUsedAP"] != infos.stats.actionPoints)
                {
                    this._stats["fighterUsedAP"] = infos.stats.actionPoints;
                    this.updateStatText(this.lbl_actionPoints, this._stats["fighterUsedAP"]);
                };
                if (this._stats["movementPoints"] != infos.stats.movementPoints)
                {
                    this._stats["movementPoints"] = infos.stats.movementPoints;
                    this.updateStatText(this.lbl_movementPoints, this._stats["movementPoints"]);
                };
                if (this._stats["dodgePALostProbability"] != infos.stats.dodgePALostProbability)
                {
                    this._stats["dodgePALostProbability"] = infos.stats.dodgePALostProbability;
                    this.updateStatText(this.lbl_action, infos.stats.dodgePALostProbability);
                };
                if (this._stats["dodgePMLostProbability"] != infos.stats.dodgePMLostProbability)
                {
                    this._stats["dodgePMLostProbability"] = infos.stats.dodgePMLostProbability;
                    this.updateStatText(this.lbl_movement, this._stats["dodgePMLostProbability"]);
                };
                if (this._stats["tackleBlock"] != infos.stats.tackleBlock)
                {
                    this._stats["tackleBlock"] = infos.stats.tackleBlock;
                    this.updateStatText(this.lbl_tackle, ((this._stats["tackleBlock"] > 0) ? this._stats["tackleBlock"].toString() : "0"));
                };
                if (this._stats["criticalDamageReduction"] != infos.stats.criticalDamageFixedResist)
                {
                    this._stats["criticalDamageReduction"] = infos.stats.criticalDamageFixedResist;
                    this.updateStatText(this.lbl_criticalDmgReduction, this._stats["criticalDamageReduction"]);
                };
                if (this._stats["pushDamageReduction"] != infos.stats.pushDamageFixedResist)
                {
                    this._stats["pushDamageReduction"] = infos.stats.pushDamageFixedResist;
                    this.updateStatText(this.lbl_pushDmgReduction, this._stats["pushDamageReduction"]);
                };
                if (((infos is GameFightCharacterInformations) || (infos is GameFightEntityInformation)))
                {
                    this._stats["neutralPercent"] = ((infos.stats.neutralElementResistPercent > 50) ? 50 : infos.stats.neutralElementResistPercent);
                    this._stats["strengthPercent"] = ((infos.stats.earthElementResistPercent > 50) ? 50 : infos.stats.earthElementResistPercent);
                    this._stats["intelligencePercent"] = ((infos.stats.fireElementResistPercent > 50) ? 50 : infos.stats.fireElementResistPercent);
                    this._stats["chancePercent"] = ((infos.stats.waterElementResistPercent > 50) ? 50 : infos.stats.waterElementResistPercent);
                    this._stats["agilityPercent"] = ((infos.stats.airElementResistPercent > 50) ? 50 : infos.stats.airElementResistPercent);
                    this._stats["neutral"] = infos.stats.neutralElementReduction;
                    this._stats["strength"] = infos.stats.earthElementReduction;
                    this._stats["intelligence"] = infos.stats.fireElementReduction;
                    this._stats["chance"] = infos.stats.waterElementReduction;
                    this._stats["agility"] = infos.stats.airElementReduction;
                }
                else
                {
                    this._stats["neutralPercent"] = infos.stats.neutralElementResistPercent;
                    this._stats["strengthPercent"] = infos.stats.earthElementResistPercent;
                    this._stats["intelligencePercent"] = infos.stats.fireElementResistPercent;
                    this._stats["chancePercent"] = infos.stats.waterElementResistPercent;
                    this._stats["agilityPercent"] = infos.stats.airElementResistPercent;
                    this._stats["neutral"] = infos.stats.neutralElementReduction;
                    this._stats["strength"] = infos.stats.earthElementReduction;
                    this._stats["intelligence"] = infos.stats.fireElementReduction;
                    this._stats["chance"] = infos.stats.waterElementReduction;
                    this._stats["agility"] = infos.stats.airElementReduction;
                };
                this.updateResistance();
                this.mainCtr.visible = true;
                if (this.entityDisplayer.look != this.fightApi.getFighterInformations(this._fighterId).look)
                {
                    this.showEntityDisplayer();
                };
            }
            else
            {
                if (this.entityDisplayer.entity)
                {
                    this.entityDisplayer.entity.stopAnimation();
                };
                bannerUi.gd_btnUis.mouseChildren = true;
                this.mainCtr.visible = false;
            };
        }

        private function updateLifePoints():void
        {
            this.lbl_lifePoints.text = ((this._stats["lifePoints"] + " / ") + this._stats["maxLifePoints"]);
        }

        private function updateShieldPoints():void
        {
            this.updateStatText(this.lbl_shieldPoints, this._stats["shieldPoints"]);
        }

        private function updateResistance():void
        {
            this.updateStatText(this.lbl_neutralPercent, this._stats["neutralPercent"], true);
            this.updateStatText(this.lbl_strengthPercent, this._stats["strengthPercent"], true);
            this.updateStatText(this.lbl_intelligencePercent, this._stats["intelligencePercent"], true);
            this.updateStatText(this.lbl_chancePercent, this._stats["chancePercent"], true);
            this.updateStatText(this.lbl_agilityPercent, this._stats["agilityPercent"], true);
            this.updateStatText(this.lbl_neutral, this._stats["neutral"]);
            this.updateStatText(this.lbl_strength, this._stats["strength"]);
            this.updateStatText(this.lbl_intelligence, this._stats["intelligence"]);
            this.updateStatText(this.lbl_chance, this._stats["chance"]);
            this.updateStatText(this.lbl_agility, this._stats["agility"]);
        }

        private function onFightEvent(eventName:String, params:Object, targetList:Object=null):void
        {
            var targetId:Number;
            var infos:FighterInformations;
            if (!this._fighterId)
            {
                return;
            };
            if (targetList == null)
            {
                targetList = new Array();
                if (params.length)
                {
                    targetList[0] = params[0];
                };
            };
            var num:int = targetList.length;
            var i:int;
            while (i < num)
            {
                targetId = targetList[i];
                if (this._fighterId == targetId)
                {
                    switch (eventName)
                    {
                        case "fighterUsedMP":
                        case "fighterLostMP":
                            this._stats["movementPoints"] = (this._stats["movementPoints"] - params[1]);
                            this.updateStatText(this.lbl_movementPoints, this._stats["movementPoints"]);
                            break;
                        case "fighterGainedMP":
                            this._stats["movementPoints"] = (this._stats["movementPoints"] + params[1]);
                            this.updateStatText(this.lbl_movementPoints, this._stats["movementPoints"]);
                            break;
                        case "fighterUsedAP":
                        case "fighterLostAP":
                            this._stats["fighterUsedAP"] = (this._stats["fighterUsedAP"] - params[1]);
                            this.updateStatText(this.lbl_actionPoints, this._stats["fighterUsedAP"]);
                            break;
                        case "fighterGainedAP":
                            this._stats["fighterUsedAP"] = (this._stats["fighterUsedAP"] + params[1]);
                            this.updateStatText(this.lbl_actionPoints, this._stats["fighterUsedAP"]);
                            break;
                        case "fighterLifeGain":
                            this._stats["lifePoints"] = (this._stats["lifePoints"] + params[1]);
                            this.updateLifePoints();
                            break;
                        case "fighterLifeLoss":
                            this._stats["lifePoints"] = (this._stats["lifePoints"] - params[1]);
                            this.updateLifePoints();
                            break;
                        case "fighterShieldLoss":
                            this._stats["shieldPoints"] = (this._stats["shieldPoints"] - params[1]);
                            this.updateShieldPoints();
                            break;
                        case "fighterShieldGain":
                            this._stats["shieldPoints"] = (this._stats["shieldPoints"] + params[1]);
                            this.updateShieldPoints();
                            break;
                        case "fighterGotDispelled":
                        case "fighterTemporaryBoosted":
                            infos = this.fightApi.getFighterInformations(targetId);
                            this._stats["shieldPoints"] = infos.shieldPoints;
                            this._stats["lifePoints"] = infos.lifePoints;
                            this.updateLifePoints();
                            this.updateShieldPoints();
                            if (this._stats["movementPoints"] != infos.movementPoints)
                            {
                                this._stats["movementPoints"] = infos.movementPoints;
                                this.updateStatText(this.lbl_movementPoints, this._stats["movementPoints"]);
                            };
                            if (this._stats["fighterUsedAP"] != infos.actionPoints)
                            {
                                this._stats["fighterUsedAP"] = infos.actionPoints;
                                this.updateStatText(this.lbl_actionPoints, this._stats["fighterUsedAP"]);
                            };
                            this._stats["neutral"] = infos.neutralFixedResist;
                            this._stats["strength"] = infos.earthFixedResist;
                            this._stats["intelligence"] = infos.fireFixedResist;
                            this._stats["chance"] = infos.waterFixedResist;
                            this._stats["agility"] = infos.airFixedResist;
                            this._stats["neutralPercent"] = ((infos.neutralResist > 50) ? 50 : infos.neutralResist);
                            this._stats["strengthPercent"] = ((infos.earthResist > 50) ? 50 : infos.earthResist);
                            this._stats["intelligencePercent"] = ((infos.fireResist > 50) ? 50 : infos.fireResist);
                            this._stats["chancePercent"] = ((infos.waterResist > 50) ? 50 : infos.waterResist);
                            this._stats["agilityPercent"] = ((infos.airResist > 50) ? 50 : infos.airResist);
                            this.updateResistance();
                            break;
                        case "fighterGotTackled":
                            this._stats["fighterUsedAP"] = (this._stats["fighterUsedAP"] - params[1]);
                            this._stats["movementPoints"] = (this._stats["movementPoints"] - params[2]);
                            this.updateStatText(this.lbl_actionPoints, this._stats["fighterUsedAP"]);
                            this.updateStatText(this.lbl_movementPoints, this._stats["movementPoints"]);
                            break;
                        case "fighterDeath":
                        case "fighterLeave":
                            this._stats["lifePoints"] = 0;
                            this.updateLifePoints();
                            break;
                    };
                    return;
                };
                i++;
            };
        }

        private function onSpectateUpdate(fightStartTime:Number, attackersName:String="", defendersName:String=""):void
        {
            this.btn_spectatorPanel.selected = true;
        }

        private function onGameFightEnd(params:Object):void
        {
            this.btn_spectatorPanel.visible = false;
        }

        private function onSpectatorWantLeave():void
        {
            this.btn_spectatorPanel.visible = false;
        }


    }
}

