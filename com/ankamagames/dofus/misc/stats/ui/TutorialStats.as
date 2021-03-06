package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.dofus.misc.stats.IHookStats;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.datacenter.quest.Quest;
    import com.ankamagames.dofus.misc.stats.StatisticsManager;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.dofus.logic.game.common.actions.OpenInventoryAction;
    import com.ankamagames.dofus.network.messages.game.context.GameMapMovementMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSpellCastMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestValidatedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeQuitRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightStartingMessage;
    import com.ankamagames.dofus.logic.game.fight.actions.GameFightReadyAction;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.misc.lists.QuestHookList;
    import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
    import com.ankamagames.dofus.misc.lists.InventoryHookList;
    import com.ankamagames.berilia.utils.BeriliaHookList;
    import com.ankamagames.dofus.misc.lists.FightHookList;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.berilia.types.data.Hook;
    import com.ankamagames.dofus.misc.utils.HaapiKeyManager;

    public class TutorialStats implements IUiStats, IHookStats 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(TutorialStats));
        private static const START_QUEST_ID:uint = 489;
        public static const ARRIVES_ON_TUTORIAL_EVENT_ID:uint = 8;
        private static const TUTORIAL_STEP_VALIDATION_EVENT_ID:uint = 9;
        private static const LEAVES_TUTORIAL_EVENT_ID:uint = 10;
        private static const STEP_DETAIL:String = "stepDetail";
        private static const FOLLOW_INSTRUCTIONS:String = "followInstructions";
        private static const TUTORIAL_STEP_PLAYER_MOVE:uint = 500;
        private static const TUTORIAL_STEP_CLICK_ON_JORIS:uint = 600;
        private static const TUTORIAL_STEP_TALK_TO_NPC:uint = 700;
        private static const TUTORIAL_STEP_OPEN_INVENTORY:uint = 800;
        private static const TUTORIAL_STEP_EQUIP_RING:uint = 900;
        private static const TUTORIAL_STEP_CLOSE_INVENTORY:uint = 1000;
        private static const TUTORIAL_STEP_CHANGE_MAP:uint = 1100;
        private static const TUTORIAL_STEP_START_FIGHT:uint = 1200;
        private static const TUTORIAL_STEP_FIGHT_START_POSITION:uint = 1300;
        private static const TUTORIAL_STEP_FIGHT_MOVE:uint = 1400;
        private static const TUTORIAL_STEP_FIGHT_USE_SPELL:uint = 1500;
        private static const TUTORIAL_STEP_FIGHT_END_TURN:uint = 1600;
        private static const TUTORIAL_STEP_FIGHT_WIN:uint = 1700;
        private static const TUTORIAL_STEP_FIGHT_CLOSE_FIGHTEND_UI:uint = 1800;
        private static const TUTORIAL_STEP_CLICK_ON_JORIS_2:uint = 1900;
        private static const TUTORIAL_STEP_START_QUEST:uint = 2000;
        private static const TUTORIAL_STEP_OPEN_INVENTORY_2:uint = 2100;
        private static const TUTORIAL_STEP_EQUIP_FIRST_ITEM:uint = 2200;
        private static const TUTORIAL_STEP_EQUIP_ALL_ITEMS:uint = 2300;
        private static const TUTORIAL_STEP_CLOSE_INVENTORY_2:uint = 2400;
        private static const TUTORIAL_STEP_CHANGE_MAP_2:uint = 2500;
        private static const TUTORIAL_STEP_START_FIGHT_2:uint = 2600;
        private static const TUTORIAL_STEP_FIGHT_WIN_2:uint = 2700;
        private static const TUTORIAL_STEP_FIGHT_CLOSE_FIGHTEND_UI_2:uint = 2800;
        private static const TUTORIAL_STEP_CLICK_ON_JORIS_3:uint = 2900;
        private static const TUTORIAL_STEP_END_BASE_TUTORIAL:uint = 3000;
        private static const FIGHT_MOVE_TARGET_CELLS:Object = {
            "171":185,
            "214":229,
            "243":258
        };

        private var _arrivalAction:StatsAction;
        private var _quitAction:StatsAction;
        private var _currentStep:uint;
        private var _currentFightId:int;
        private var _stepInfos:Dictionary = new Dictionary(true);
        private var _quest:Quest;
        private var _fightPosition:Number;

        public function TutorialStats(pUi:UiRootContainer)
        {
            var firstTutorialCharacter:* = StatisticsManager.getInstance().getData(("firstTutorialCharacter-" + PlayerManager.getInstance().accountId));
            if (firstTutorialCharacter == null)
            {
                this._arrivalAction = StatsAction.get(ARRIVES_ON_TUTORIAL_EVENT_ID);
                this._arrivalAction.setParam("account_id", PlayerManager.getInstance().accountId);
                this._arrivalAction.setParam("server_id", PlayerManager.getInstance().server.id);
                this._arrivalAction.setParam("character_id", PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
                this._arrivalAction.setParam("step_id", 400);
                this._arrivalAction.start();
                this._arrivalAction.send();
                StatisticsManager.getInstance().setData(("firstTutorialCharacter-" + PlayerManager.getInstance().accountId), PlayedCharacterManager.getInstance().infos.id);
            }
            else
            {
                if (PlayedCharacterManager.getInstance().infos.id != firstTutorialCharacter)
                {
                    StatisticsManager.getInstance().removeStats("tutorial");
                    return;
                };
            };
            this._quitAction = StatsAction.get(LEAVES_TUTORIAL_EVENT_ID);
            this._quitAction.setParam("account_id", PlayerManager.getInstance().accountId);
            this._quitAction.setParam("server_id", PlayerManager.getInstance().server.id);
            this._quitAction.start();
            this._quest = Quest.getQuestById(START_QUEST_ID);
        }

        public function process(pMessage:Message, pArgs:Array=null):void
        {
            var oiaction:OpenInventoryAction;
            var gmmmsg:GameMapMovementMessage;
            var gafscmsg:GameActionFightSpellCastMessage;
            var mcidmsg:MapComplementaryInformationsDataMessage;
            var qvmsg:QuestValidatedMessage;
            var spells:Array;
            switch (true)
            {
                case (pMessage is GuidedModeQuitRequestAction):
                    this._quitAction.setParam("step_id", this._currentStep);
                    this._quitAction.send();
                    break;
                case (pMessage is OpenInventoryAction):
                    oiaction = (pMessage as OpenInventoryAction);
                    if (oiaction.behavior == "bag")
                    {
                        if (this._currentStep == TUTORIAL_STEP_TALK_TO_NPC)
                        {
                            this.sendStepValidation(TUTORIAL_STEP_OPEN_INVENTORY);
                        }
                        else
                        {
                            if (this._currentStep == TUTORIAL_STEP_START_QUEST)
                            {
                                this.sendStepValidation(TUTORIAL_STEP_OPEN_INVENTORY_2);
                            };
                        };
                    };
                    break;
                case (pMessage is GameFightStartingMessage):
                    this._currentFightId = (pMessage as GameFightStartingMessage).fightId;
                    break;
                case (pMessage is GameFightReadyAction):
                    if (this._currentStep == TUTORIAL_STEP_START_FIGHT)
                    {
                        this.setStepInfo(TUTORIAL_STEP_FIGHT_START_POSITION, STEP_DETAIL, 1);
                    };
                    break;
                case (pMessage is GameMapMovementMessage):
                    gmmmsg = (pMessage as GameMapMovementMessage);
                    if (gmmmsg.actorId == PlayedCharacterManager.getInstance().id)
                    {
                        if (this._currentStep == TUTORIAL_STEP_FIGHT_START_POSITION)
                        {
                            if (FIGHT_MOVE_TARGET_CELLS[this._fightPosition] == gmmmsg.keyMovements[(gmmmsg.keyMovements.length - 1)])
                            {
                                this.setStepInfo(TUTORIAL_STEP_FIGHT_MOVE, FOLLOW_INSTRUCTIONS, true);
                            };
                        }
                        else
                        {
                            if (this._currentStep == TUTORIAL_STEP_FIGHT_USE_SPELL)
                            {
                                this.setStepInfo(TUTORIAL_STEP_FIGHT_END_TURN, FOLLOW_INSTRUCTIONS, false);
                            };
                        };
                    };
                    break;
                case (pMessage is GameActionFightSpellCastMessage):
                    gafscmsg = (pMessage as GameActionFightSpellCastMessage);
                    if (this._currentStep == TUTORIAL_STEP_FIGHT_MOVE)
                    {
                        spells = InventoryManager.getInstance().shortcutBarSpells;
                        if ((((spells) && (spells.length > 2)) && (gafscmsg.spellId == ((spells[1] as ShortcutWrapper).realItem as SpellWrapper).id)))
                        {
                            this.setStepInfo(TUTORIAL_STEP_FIGHT_USE_SPELL, FOLLOW_INSTRUCTIONS, true);
                        };
                    }
                    else
                    {
                        if (this._currentStep == TUTORIAL_STEP_FIGHT_USE_SPELL)
                        {
                            this.setStepInfo(TUTORIAL_STEP_FIGHT_END_TURN, FOLLOW_INSTRUCTIONS, false);
                        };
                    };
                    break;
                case (pMessage is MapComplementaryInformationsDataMessage):
                    mcidmsg = (pMessage as MapComplementaryInformationsDataMessage);
                    if ((((mcidmsg.mapId == 152307712) && (this._currentStep >= TUTORIAL_STEP_EQUIP_ALL_ITEMS)) && (this._currentStep < TUTORIAL_STEP_CHANGE_MAP_2)))
                    {
                        this.sendStepValidation(TUTORIAL_STEP_CHANGE_MAP_2);
                    };
                    break;
                case (pMessage is QuestValidatedMessage):
                    qvmsg = (pMessage as QuestValidatedMessage);
                    if ((((qvmsg.questId == START_QUEST_ID) && (this._currentStep >= TUTORIAL_STEP_FIGHT_WIN_2)) && (this._currentStep < TUTORIAL_STEP_END_BASE_TUTORIAL)))
                    {
                        this.sendStepValidation(TUTORIAL_STEP_END_BASE_TUTORIAL);
                    };
                    break;
            };
        }

        public function onHook(pHook:Hook, pArgs:Array):void
        {
            var item:ItemWrapper;
            var obj:*;
            var stepId:uint;
            var items:Vector.<ItemWrapper>;
            var nbItems:uint;
            var itemw:ItemWrapper;
            var entitiesFrame:RoleplayEntitiesFrame;
            var infos:GameContextActorInformations;
            var step:uint;
            switch (pHook.name)
            {
                case QuestHookList.QuestStepValidated.name:
                    if (pArgs[0] == START_QUEST_ID)
                    {
                        stepId = this.getStepEventId(pArgs[1]);
                        if (stepId > this._currentStep)
                        {
                            switch (stepId)
                            {
                                case TUTORIAL_STEP_START_FIGHT:
                                case TUTORIAL_STEP_FIGHT_MOVE:
                                case TUTORIAL_STEP_FIGHT_USE_SPELL:
                                case TUTORIAL_STEP_FIGHT_END_TURN:
                                case TUTORIAL_STEP_FIGHT_WIN:
                                case TUTORIAL_STEP_START_FIGHT_2:
                                case TUTORIAL_STEP_FIGHT_WIN_2:
                                    this.setStepInfo(stepId, STEP_DETAIL, this._currentFightId);
                                    break;
                            };
                            if (((stepId == TUTORIAL_STEP_FIGHT_END_TURN) && (!(this._stepInfos[TUTORIAL_STEP_FIGHT_END_TURN].hasOwnProperty(FOLLOW_INSTRUCTIONS)))))
                            {
                                this.setStepInfo(TUTORIAL_STEP_FIGHT_END_TURN, FOLLOW_INSTRUCTIONS, true);
                            };
                            this.sendStepValidation(stepId, (((this._stepInfos[stepId]) && (this._stepInfos[stepId].hasOwnProperty(STEP_DETAIL))) ? this._stepInfos[stepId].stepDetail : null), (((this._stepInfos[stepId]) && (this._stepInfos[stepId].hasOwnProperty(FOLLOW_INSTRUCTIONS))) ? this._stepInfos[stepId].followInstructions : null));
                        };
                    };
                    break;
                case InventoryHookList.EquipmentObjectMove.name:
                    item = pArgs[0];
                    if (item)
                    {
                        if (((item.objectGID == 10785) && (this._currentStep == TUTORIAL_STEP_OPEN_INVENTORY)))
                        {
                            this.sendStepValidation(TUTORIAL_STEP_EQUIP_RING);
                        }
                        else
                        {
                            if (this._currentStep == TUTORIAL_STEP_OPEN_INVENTORY_2)
                            {
                                this.sendStepValidation(TUTORIAL_STEP_EQUIP_FIRST_ITEM);
                            }
                            else
                            {
                                if (this._currentStep == TUTORIAL_STEP_EQUIP_FIRST_ITEM)
                                {
                                    items = InventoryManager.getInstance().inventory.getView("equipment").content;
                                    nbItems = 0;
                                    for each (itemw in items)
                                    {
                                        if (((itemw) && ((((((((itemw.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_LEFT) || (itemw.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_RIGHT)) || (itemw.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_AMULET)) || (itemw.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)) || (itemw.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_BELT)) || (itemw.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_BOOTS)) || (itemw.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_CAPE)) || (itemw.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD))))
                                        {
                                            nbItems++;
                                        };
                                    };
                                    if (nbItems == 7)
                                    {
                                        this.sendStepValidation(TUTORIAL_STEP_EQUIP_ALL_ITEMS);
                                    };
                                };
                            };
                        };
                    };
                    break;
                case BeriliaHookList.UiUnloaded.name:
                    if (((pArgs[0] == "storage") && (this._currentStep == TUTORIAL_STEP_EQUIP_ALL_ITEMS)))
                    {
                        this.sendStepValidation(TUTORIAL_STEP_CLOSE_INVENTORY_2);
                    }
                    else
                    {
                        if (pArgs[0] == "fightResultSimple")
                        {
                            if (this._currentStep == TUTORIAL_STEP_FIGHT_WIN)
                            {
                                this.sendStepValidation(TUTORIAL_STEP_FIGHT_CLOSE_FIGHTEND_UI);
                            }
                            else
                            {
                                if (this._currentStep == TUTORIAL_STEP_FIGHT_WIN_2)
                                {
                                    this.sendStepValidation(TUTORIAL_STEP_FIGHT_CLOSE_FIGHTEND_UI_2);
                                };
                            };
                        };
                    };
                    break;
                case FightHookList.GameEntityDisposition.name:
                    if (((pArgs[0] == PlayedCharacterManager.getInstance().id) && (this._currentStep == TUTORIAL_STEP_START_FIGHT)))
                    {
                        if (!isNaN(this._fightPosition))
                        {
                            this.setStepInfo(TUTORIAL_STEP_FIGHT_START_POSITION, FOLLOW_INSTRUCTIONS, true);
                        };
                        this._fightPosition = pArgs[1];
                    };
                    break;
                case BeriliaHookList.MouseClick.name:
                    obj = pArgs[0];
                    if (((obj) && (obj is AnimatedCharacter)))
                    {
                        entitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
                        if (entitiesFrame)
                        {
                            infos = (entitiesFrame.getEntityInfos(obj.id) as GameContextActorInformations);
                            if ((((infos) && (infos is GameRolePlayNpcInformations)) && ((infos as GameRolePlayNpcInformations).npcId == 2897)))
                            {
                                if (this._currentStep == TUTORIAL_STEP_PLAYER_MOVE)
                                {
                                    this.sendStepValidation(TUTORIAL_STEP_CLICK_ON_JORIS);
                                }
                                else
                                {
                                    if (((this._currentStep >= TUTORIAL_STEP_FIGHT_WIN) && (this._currentStep < TUTORIAL_STEP_CLICK_ON_JORIS_2)))
                                    {
                                        this.sendStepValidation(TUTORIAL_STEP_CLICK_ON_JORIS_2);
                                    }
                                    else
                                    {
                                        if (((this._currentStep >= TUTORIAL_STEP_FIGHT_WIN_2) && (this._currentStep < TUTORIAL_STEP_CLICK_ON_JORIS_3)))
                                        {
                                            this.sendStepValidation(TUTORIAL_STEP_CLICK_ON_JORIS_3);
                                        };
                                    };
                                };
                            };
                        };
                    };
                    break;
                case HookList.TutorialStep.name:
                    if (pArgs[0] > 1)
                    {
                        step = this.getStepEventId(this._quest.steps[(pArgs[0] - 2)].id);
                        if (step > this._currentStep)
                        {
                            this._currentStep = step;
                        };
                    };
                    break;
            };
        }

        public function remove():void
        {
        }

        private function sendStepValidation(pStep:uint, pStepDetail:*=null, pFollowInstructions:*=null):void
        {
            var stepAction:StatsAction = new StatsAction(TUTORIAL_STEP_VALIDATION_EVENT_ID);
            stepAction.user = StatsAction.getUserId();
            stepAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
            stepAction.setParam("account_id", PlayerManager.getInstance().accountId);
            stepAction.setParam("server_id", PlayerManager.getInstance().server.id);
            stepAction.setParam("character_id", PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
            stepAction.setParam("map_id", PlayedCharacterManager.getInstance().currentMap.mapId);
            stepAction.setParam("character_level", PlayedCharacterManager.getInstance().infos.level);
            stepAction.setParam("step_id", pStep);
            stepAction.setParam("step_detail", pStepDetail);
            stepAction.setParam("follow_instructions", pFollowInstructions);
            stepAction.send();
            this._currentStep = pStep;
        }

        private function getStepEventId(pQuestStep:uint):uint
        {
            var stepId:uint;
            switch (pQuestStep)
            {
                case 1042:
                    stepId = TUTORIAL_STEP_PLAYER_MOVE;
                    break;
                case 1043:
                    stepId = TUTORIAL_STEP_TALK_TO_NPC;
                    break;
                case 1044:
                    stepId = TUTORIAL_STEP_CLOSE_INVENTORY;
                    break;
                case 1045:
                    stepId = TUTORIAL_STEP_CHANGE_MAP;
                    break;
                case 1046:
                    stepId = TUTORIAL_STEP_START_FIGHT;
                    break;
                case 1047:
                    stepId = TUTORIAL_STEP_FIGHT_START_POSITION;
                    break;
                case 1048:
                    stepId = TUTORIAL_STEP_FIGHT_MOVE;
                    break;
                case 1049:
                    stepId = TUTORIAL_STEP_FIGHT_USE_SPELL;
                    break;
                case 1050:
                    stepId = TUTORIAL_STEP_FIGHT_END_TURN;
                    break;
                case 1051:
                    stepId = TUTORIAL_STEP_FIGHT_WIN;
                    break;
                case 1052:
                    stepId = TUTORIAL_STEP_START_QUEST;
                    break;
                case 1053:
                    stepId = TUTORIAL_STEP_START_FIGHT_2;
                    break;
                case 1059:
                    stepId = TUTORIAL_STEP_END_BASE_TUTORIAL;
                    break;
                case 1060:
                    stepId = TUTORIAL_STEP_EQUIP_ALL_ITEMS;
                    break;
                case 1061:
                    stepId = TUTORIAL_STEP_FIGHT_WIN_2;
                    break;
            };
            return (stepId);
        }

        private function setStepInfo(pStep:uint, pPropertyName:String, pValue:*):void
        {
            if (!this._stepInfos[pStep])
            {
                this._stepInfos[pStep] = new Object();
            };
            this._stepInfos[pStep][pPropertyName] = pValue;
        }


    }
}

