package Ankama_Roleplay
{
    import flash.display.Sprite;
    import Ankama_Roleplay.ui.NpcDialog;
    import Ankama_Roleplay.ui.SpectatorUi;
    import Ankama_Roleplay.ui.LevelUpUi;
    import Ankama_Roleplay.ui.LevelUpGod;
    import Ankama_Roleplay.ui.KingOfTheHill;
    import Ankama_Roleplay.ui.TreasureHunt;
    import Ankama_Roleplay.ui.LegendaryHunts;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import d2hooks.NpcDialogCreationFailure;
    import d2hooks.NpcDialogCreation;
    import d2hooks.PonyDialogCreation;
    import d2hooks.PrismDialogCreation;
    import d2hooks.PortalDialogCreation;
    import d2hooks.NpcDialogQuestion;
    import d2hooks.MapRunningFightList;
    import d2hooks.GameFightStarting;
    import d2hooks.CurrentMap;
    import d2hooks.MapComplementaryInformationsData;
    import d2hooks.CharacterLevelUp;
    import d2hooks.GameFightJoin;
    import d2hooks.GameFightEnd;
    import d2hooks.SpectatorWantLeave;
    import d2hooks.KohState;
    import d2hooks.PvpAvaStateChange;
    import d2hooks.AllianceMembershipUpdated;
    import d2hooks.TreasureHuntUpdate;
    import d2hooks.TreasureHuntLegendaryUiUpdate;
    import d2actions.LeaveDialogRequest;
    import com.ankamagames.dofus.network.enums.PrismStateEnum;
    import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
    import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import com.ankamagames.dofus.internalDatacenter.connection.BasicCharacterWrapper;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.berilia.enums.StrataEnum;
    import d2hooks.*;
    import d2actions.*;

    public class Roleplay extends Sprite 
    {

        public static var questions:Array;
        private static var _compt:uint = 0;

        protected var npcDialog:NpcDialog;
        protected var spectatorUi:SpectatorUi;
        protected var levelUpUi:LevelUpUi;
        protected var levelUpGod:LevelUpGod;
        protected var kingOfTheHill:KingOfTheHill;
        protected var treasureHunt:TreasureHunt;
        protected var legendaryHunts:LegendaryHunts;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        private var _avaEnable:Boolean;
        private var _probationTime:uint;
        private var _fightContext:Boolean = false;


        public function main():void
        {
            this.sysApi.addHook(NpcDialogCreationFailure, this.onNpcDialogCreationFailure);
            this.sysApi.addHook(NpcDialogCreation, this.onNpcDialogCreation);
            this.sysApi.addHook(PonyDialogCreation, this.onPonyDialogCreation);
            this.sysApi.addHook(PrismDialogCreation, this.onPrismDialogCreation);
            this.sysApi.addHook(PortalDialogCreation, this.onPortalDialogCreation);
            this.sysApi.addHook(NpcDialogQuestion, this.onNpcDialogQuestion);
            this.sysApi.addHook(MapRunningFightList, this.onMapRunningFightList);
            this.sysApi.addHook(GameFightStarting, this.onGameFightStarting);
            this.sysApi.addHook(CurrentMap, this.onMapChange);
            this.sysApi.addHook(MapComplementaryInformationsData, this.onMapLoaded);
            this.sysApi.addHook(CharacterLevelUp, this.onLevelUp);
            this.sysApi.addHook(GameFightJoin, this.onGameFightJoin);
            this.sysApi.addHook(GameFightEnd, this.onGameFightEnd);
            this.sysApi.addHook(SpectatorWantLeave, this.onSpectatorWantLeave);
            this.sysApi.addHook(KohState, this.onKohStateChange);
            this.sysApi.addHook(PvpAvaStateChange, this.onPvpAvaStateChange);
            this.sysApi.addHook(AllianceMembershipUpdated, this.onAllianceMembershipUpdated);
            this.sysApi.addHook(TreasureHuntUpdate, this.onTreasureHunt);
            this.sysApi.addHook(TreasureHuntLegendaryUiUpdate, this.onTreasureHuntLegendaryUiUpdate);
        }

        private function onNpcDialogCreationFailure():void
        {
            this.sysApi.log(16, "Impossible de parler à ce pnj :o");
        }

        private function onNpcDialogCreation(mapId:Number, npcId:int, look:Object):void
        {
            questions = new Array();
            var map:Number = this.playerApi.currentMap().mapId;
            if (mapId == map)
            {
                if (this.uiApi.getUi("npcDialog"))
                {
                    this.uiApi.unloadUi("npcDialog");
                };
                this.uiApi.loadUi("npcDialog", "npcDialog", [npcId, look]);
            }
            else
            {
                this.sysApi.log(16, (((("Required npc (" + npcId) + ") cannot be found on map ") + map) + "."));
                this.sysApi.sendAction(new LeaveDialogRequest());
            };
        }

        private function onPonyDialogCreation(mapId:Number, firstnameId:int, lastNameId:int, look:Object):void
        {
            questions = new Array();
            var map:Number = this.playerApi.currentMap().mapId;
            if (mapId == map)
            {
                this.uiApi.loadUi("npcDialog", "npcDialog", [1, look, firstnameId, lastNameId]);
            }
            else
            {
                this.sysApi.log(16, (("Required tax collector cannot be found on map " + map) + "."));
                this.sysApi.sendAction(new LeaveDialogRequest());
            };
        }

        private function onPrismDialogCreation(mapId:Number, allianceName:String, look:Object):void
        {
            questions = new Array();
            var map:Number = this.playerApi.currentMap().mapId;
            if (mapId == map)
            {
                this.uiApi.loadUi("npcDialog", "npcDialog", [2141, look, allianceName]);
            }
            else
            {
                this.sysApi.log(16, (("Required prism cannot be found on map " + map) + "."));
                this.sysApi.sendAction(new LeaveDialogRequest());
            };
        }

        private function onPortalDialogCreation(mapId:Number, portalNpcId:int, areaName:String, look:Object):void
        {
            questions = new Array();
            var map:Number = this.playerApi.currentMap().mapId;
            if (mapId == map)
            {
                this.uiApi.loadUi("npcDialog", "npcDialog", [portalNpcId, look, areaName]);
            }
            else
            {
                this.sysApi.log(16, (("Required portal cannot be found on map " + map) + "."));
                this.sysApi.sendAction(new LeaveDialogRequest());
            };
        }

        public function onNpcDialogQuestion(messageId:uint=0, dialogParams:Object=null, visibleReplies:Object=null):void
        {
        }

        private function onKohStateChange(prism:PrismSubAreaWrapper):void
        {
            if (!prism)
            {
                this.uiApi.unloadUi("kingOfTheHill");
                return;
            };
            if ((((!(this._avaEnable)) || (!(prism.alliance))) || ((KingOfTheHill.instance) && (!(KingOfTheHill.instance.currentSubArea == prism.subAreaId)))))
            {
                this.uiApi.unloadUi("kingOfTheHill");
            };
            if ((((this._avaEnable) && (prism.state == PrismStateEnum.PRISM_STATE_VULNERABLE)) && (!(this.uiApi.getUi("kingOfTheHill")))))
            {
                this.uiApi.loadUi("kingOfTheHill", "kingOfTheHill", {
                    "prism":prism,
                    "probationTime":this._probationTime
                });
            };
        }

        private function onPvpAvaStateChange(status:uint, probationTime:uint):void
        {
            this._avaEnable = ((((status == AggressableStatusEnum.AvA_DISQUALIFIED) || (status == AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE)) || (status == AggressableStatusEnum.AvA_ENABLED_NON_AGGRESSABLE)) || (status == AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE));
            this._probationTime = probationTime;
            if (!this._avaEnable)
            {
                this.uiApi.unloadUi("kingOfTheHill");
            };
        }

        private function onAllianceMembershipUpdated(hasAlliance:Boolean):void
        {
            if (((!(hasAlliance)) && (this._avaEnable)))
            {
                this.uiApi.unloadUi("kingOfTheHill");
                this._avaEnable = false;
            };
        }

        private function onTreasureHunt(treasureHuntType:uint):void
        {
            if (!this.uiApi.getUi("treasureHunt"))
            {
                this.uiApi.loadUi("treasureHunt", "treasureHunt", treasureHuntType);
            };
        }

        private function onTreasureHuntLegendaryUiUpdate(huntsList:Object):void
        {
            if (!this.uiApi.getUi("legendaryHunts"))
            {
                this.uiApi.loadUi("legendaryHunts", "legendaryHunts", huntsList);
            };
        }

        private function onMapRunningFightList(pFights:Object):void
        {
            if (!this.uiApi.getUi(UIEnum.SPECTATOR_UI))
            {
                this.uiApi.loadUi(UIEnum.SPECTATOR_UI, UIEnum.SPECTATOR_UI, pFights);
            };
        }

        private function onGameFightStarting(pFightType:uint):void
        {
            if (this.uiApi.getUi(UIEnum.SPECTATOR_UI))
            {
                this.uiApi.unloadUi(UIEnum.SPECTATOR_UI);
            };
        }

        private function onMapChange(pMapId:Object):void
        {
            if (this.uiApi.getUi(UIEnum.SPECTATOR_UI))
            {
                this.uiApi.unloadUi(UIEnum.SPECTATOR_UI);
            };
        }

        private function onMapLoaded(wp:WorldPointWrapper, subareaId:uint, foo:Boolean):void
        {
            if (((KingOfTheHill.instance) && (!(this.dataApi.getSubAreaFromMap(this.playerApi.currentMap().mapId).id == KingOfTheHill.instance.currentSubArea))))
            {
                this.uiApi.unloadUi("kingOfTheHill");
            };
        }

        private function onLevelUp(pOldLevel:uint, pNewLevel:uint, pCaracPointEarned:uint, pHealPointEarned:uint, newSpellWrappers:Array):void
        {
            var uiName:String;
            var exactName:String;
            var character:BasicCharacterWrapper;
            var nameText:String;
            var spellObtained:* = (newSpellWrappers.length > 0);
            if ((((spellObtained) && (pNewLevel <= ProtocolConstantsEnum.MAX_LEVEL)) && (!(this.dataApi.isTemporisSpellsUi()))))
            {
                uiName = "levelUpWithSpell";
            }
            else
            {
                if (pNewLevel > ProtocolConstantsEnum.MAX_LEVEL)
                {
                    uiName = "levelUpOmega";
                }
                else
                {
                    uiName = "levelUp";
                };
            };
            var params:Object = new Object();
            params.oldLevel = pOldLevel;
            params.newLevel = pNewLevel;
            params.caracPointEarned = pCaracPointEarned;
            params.healPointEarned = pHealPointEarned;
            params.newSpellWrappers = newSpellWrappers;
            params.spellObtained = (newSpellWrappers.length > 0);
            var currentPlayer:Object = this.playerApi.getPlayedCharacterInfo();
            for each (character in this.sysApi.getPlayerManager().charactersList)
            {
                exactName = character.name.split(" ")[0];
                if (exactName == currentPlayer.name)
                {
                    nameText = ((currentPlayer.name + character.name.split(" ")[1]) + " ");
                    if (pNewLevel > ProtocolConstantsEnum.MAX_LEVEL)
                    {
                        nameText = (nameText + ((this.uiApi.getText("ui.common.short.prestige") + (pNewLevel - ProtocolConstantsEnum.MAX_LEVEL)) + ")"));
                    }
                    else
                    {
                        nameText = (nameText + ((this.uiApi.getText("ui.common.short.level") + pNewLevel) + ")"));
                    };
                    this.sysApi.getPlayerManager().charactersList[this.sysApi.getPlayerManager().charactersList.indexOf(character)].level = pNewLevel;
                };
            };
            this.uiApi.loadUi(uiName, "levelUp", params, StrataEnum.STRATA_MAX, null, true);
        }

        public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:uint, fightType:int, alliesPreparation:Boolean):void
        {
            this._fightContext = true;
            if (this.uiApi.getUi(UIEnum.TREASURE_HUNT))
            {
                this.uiApi.getUi(UIEnum.TREASURE_HUNT).visible = false;
            };
        }

        public function onGameFightEnd(params:Object):void
        {
            this._fightContext = false;
            if (this.uiApi.getUi(UIEnum.TREASURE_HUNT))
            {
                this.uiApi.getUi(UIEnum.TREASURE_HUNT).visible = true;
            };
        }

        public function onSpectatorWantLeave():void
        {
            this._fightContext = false;
            if (this.uiApi.getUi(UIEnum.TREASURE_HUNT))
            {
                this.uiApi.getUi(UIEnum.TREASURE_HUNT).visible = true;
            };
        }


    }
}

