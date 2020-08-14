package Ankama_Tutorial.managers
{
    import com.ankamagames.dofus.datacenter.quest.Quest;
    import flash.utils.Timer;
    import Ankama_Tutorial.Api;
    import d2hooks.UiLoaded;
    import d2hooks.UiUnloaded;
    import d2hooks.CurrentMap;
    import d2hooks.LeaveDialog;
    import d2hooks.QuestStarted;
    import d2hooks.GameFightEnd;
    import d2hooks.GameFightJoin;
    import d2hooks.GameFightStart;
    import d2hooks.GameFightLeave;
    import d2hooks.QuestValidated;
    import d2hooks.JobsExpUpdated;
    import d2hooks.NpcDialogCreation;
    import d2hooks.QuestInfosUpdated;
    import d2hooks.ExchangeObjectAdded;
    import d2hooks.GiftsWaitingAllocation;
    import d2hooks.QuestObjectiveValidated;
    import d2hooks.AchievementRewardSuccess;
    import d2hooks.RewardableAchievementsVisible;
    import d2hooks.MapComplementaryInformationsData;
    import d2hooks.RewardsOpenClose;
    import flash.events.TimerEvent;
    import Ankama_Tutorial.TutorialAdvancedConstants;
    import d2actions.QuestInfosRequest;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import flash.geom.Rectangle;
    import d2hooks.AdvancedTutorialStep;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;

    public class AdvancedTutorialStepManager 
    {

        private static const COURAGEOUS_RING_ID:int = 19622;
        private static var _instance:AdvancedTutorialStepManager;

        private const DEFAULT_STEP:int = -1;

        private var _quest:Quest;
        private var _questInfo:Object;
        private var _currentStepNumber:int = -1;
        private var _currentSubtepNumber:int = -1;
        private var _mapId:Number = 0xFFFFFFFF;
        private var _inDialog:Boolean = false;
        private var _questActionTimer:Timer = new Timer(50, 1);
        private var _questRequested:Array = [];


        public static function getInstance(implciteInit:Boolean=true):AdvancedTutorialStepManager
        {
            if (((!(_instance)) && (implciteInit)))
            {
                _instance = new (AdvancedTutorialStepManager)();
                _instance.init();
            };
            return (_instance);
        }


        public function set currentMapId(id:Number):void
        {
            this._mapId = id;
            Api.system.startStats("advancedTutorial", this);
        }

        private function init():void
        {
            Api.system.addHook(UiLoaded, this.onUiLoaded);
            Api.system.addHook(UiUnloaded, this.onUnloaded);
            Api.system.addHook(CurrentMap, this.onCurrentMap);
            Api.system.addHook(LeaveDialog, this.onLeaveDialog);
            Api.system.addHook(QuestStarted, this.onQuestStarted);
            Api.system.addHook(GameFightEnd, this.onGameFightEnd);
            Api.system.addHook(GameFightJoin, this.onGameFightJoin);
            Api.system.addHook(GameFightStart, this.onGameFightStart);
            Api.system.addHook(GameFightLeave, this.onGameFightLeave);
            Api.system.addHook(QuestValidated, this.onQuestValidated);
            Api.system.addHook(JobsExpUpdated, this.onJobExperienceUpdate);
            Api.system.addHook(NpcDialogCreation, this.onNpcDialogCreation);
            Api.system.addHook(QuestInfosUpdated, this.onQuestInfosUpdated);
            Api.system.addHook(ExchangeObjectAdded, this.onExchangeObjectAdded);
            Api.system.addHook(GiftsWaitingAllocation, this.onGiftsWaitingAllocation);
            Api.system.addHook(QuestObjectiveValidated, this.onQuestObjectiveValidated);
            Api.system.addHook(AchievementRewardSuccess, this.onAchievementRewardSuccess);
            Api.system.addHook(RewardableAchievementsVisible, this.onRewardableAchievementsVisible);
            Api.system.addHook(MapComplementaryInformationsData, this.onMapComplementaryInformationsData);
            Api.system.addHook(RewardsOpenClose, this.onRewardsOpenClose);
            this._questActionTimer.addEventListener(TimerEvent.TIMER, this.onQuestTimerTick);
            this.askQuestInfo();
        }

        public function destroy():void
        {
            _instance = null;
            if (Api.highlight)
            {
                Api.highlight.stop();
            };
            if (this._questActionTimer)
            {
                this._questActionTimer.stop();
                this._questActionTimer.removeEventListener(TimerEvent.TIMER, this.onQuestTimerTick);
            };
            Api.system.removeStats("advancedTutorial");
            Api.system.removeHook(RewardsOpenClose);
        }

        private function askQuestInfo(questId:int=-1):Boolean
        {
            if (questId != -1)
            {
                this.sendQuestAction(questId);
                return (true);
            };
            var questList:Object = Api.quest.getActiveQuests();
            for each (questId in questList)
            {
                if (TutorialAdvancedConstants.QUEST_IDS.indexOf(questId) != -1)
                {
                    this.sendQuestAction(questId);
                    return (true);
                };
            };
            if (this._currentStepNumber != -1)
            {
                this.prepareStep(this._currentStepNumber, this._currentSubtepNumber);
                return (true);
            };
            return (false);
        }

        private function sendQuestAction(questId:uint):void
        {
            if (this._questRequested.indexOf(questId) == -1)
            {
                this._questRequested.push(questId);
            };
            this._questActionTimer.reset();
            this._questActionTimer.start();
        }

        protected function onQuestTimerTick(event:TimerEvent):void
        {
            var questId:uint;
            for each (questId in this._questRequested)
            {
                Api.system.sendAction(new QuestInfosRequest(questId));
            };
            this._questRequested = [];
        }

        private function prepareStep(stepNumber:int, subStep:int=0):void
        {
            var btnPosition:uint;
            var harvestCells:Array;
            var qq:Object;
            var objectiveId:*;
            var craftUi:*;
            var positionInGrid:int;
            var gridLineHeight:int;
            Api.highlight.stop();
            this._currentStepNumber = stepNumber;
            this._currentSubtepNumber = subStep;
            if (this._inDialog)
            {
                return;
            };
            if (this.waitingForRewards())
            {
                if (((!(Api.ui.getUi(UIEnum.REWARDS) == null)) && (Api.ui.getUi(UIEnum.REWARDS).uiClass.ctr_mainWindow.visible)))
                {
                    Api.highlight.highlightUi(UIEnum.REWARDS, "btn_acceptAll", 1, 1, 6, true);
                }
                else
                {
                    Api.highlight.highlightUi(UIEnum.REWARDS, "btn_rewards", 1, 0, 5, true);
                };
                return;
            };
            switch (true)
            {
                case (stepNumber == TutorialAdvancedConstants.JOB_STEP_GOTO_MAP):
                    this.hightlightPath(TutorialAdvancedConstants.JOB_MAP_ID);
                    break;
                case (stepNumber == TutorialAdvancedConstants.JOB_STEP_FIRST_NPC_DIALOG):
                    if (this.hightlightPath(TutorialAdvancedConstants.JOB_MAP_ID))
                    {
                        return;
                    };
                    Api.highlight.highlightNpc(TutorialAdvancedConstants.NPC_HOBOULO, true);
                    break;
                case (!(TutorialAdvancedConstants.JOB_STEP_HARVEST.indexOf(stepNumber) == -1)):
                    if (this.hightlightPath(TutorialAdvancedConstants.JOB_MAP_ID))
                    {
                        return;
                    };
                    harvestCells = [];
                    for (objectiveId in this._questInfo.objectives)
                    {
                        if (((this._questInfo.objectives[objectiveId]) && (!(TutorialAdvancedConstants.HARVEST_CELL_BY_OBJECTIVE[objectiveId] == undefined))))
                        {
                            harvestCells.push(TutorialAdvancedConstants.HARVEST_CELL_BY_OBJECTIVE[objectiveId]);
                        };
                    };
                    Api.highlight.highlightCell(harvestCells, true);
                    break;
                case (stepNumber == TutorialAdvancedConstants.JOB_STEP_CRAFT):
                    if (this.hightlightPath(TutorialAdvancedConstants.JOB_MAP_ID))
                    {
                        return;
                    };
                    switch (subStep)
                    {
                        case TutorialAdvancedConstants.JOB_STEP_CRAFT__OPEN_UI:
                            Api.highlight.highlightAbsolute(new Rectangle(TutorialAdvancedConstants.JOB_TOOL_X, TutorialAdvancedConstants.JOB_TOOL_Y), 0, 0, 0, true);
                            break;
                        case TutorialAdvancedConstants.JOB_STEP_CRAFT__ADD_INGREDIENT:
                            craftUi = Api.ui.getUiByName(UIEnum.CRAFT);
                            positionInGrid = craftUi.uiClass.getPositionFromRecipes(COURAGEOUS_RING_ID);
                            gridLineHeight = craftUi.uiClass.getRecipeLineHeight();
                            Api.highlight.highlightAbsolute(new Rectangle(50, (185 + (positionInGrid * gridLineHeight))), 1, 1, 5, true);
                            break;
                        case TutorialAdvancedConstants.JOB_STEP_CRAFT__FUSION:
                            Api.highlight.highlightUi(UIEnum.CRAFT, "btn_ok", 7, 0, 5, true);
                            break;
                        case TutorialAdvancedConstants.JOB_STEP_CRAFT__QUIT:
                            Api.highlight.highlightUi(UIEnum.STORAGE_UI, "btn_close", 7, 0, 5, true);
                            break;
                    };
                    break;
                case (stepNumber == TutorialAdvancedConstants.JOB_STEP_SHOW_CRAFT):
                    if (this.hightlightPath(TutorialAdvancedConstants.JOB_MAP_ID))
                    {
                        return;
                    };
                    Api.highlight.highlightNpc(TutorialAdvancedConstants.NPC_HOBOULO, true);
                    break;
                case (stepNumber == TutorialAdvancedConstants.JOB_STEP_GO_JORIS):
                    if (this.hightlightPath(TutorialAdvancedConstants.HUB_MAP_ID))
                    {
                        return;
                    };
                    Api.highlight.highlightNpc(TutorialAdvancedConstants.NPC_JORIS, true);
                    break;
                case (stepNumber == TutorialAdvancedConstants.FIGHT_STEP_GOTO_MAP):
                    if (this.hightlightPath(TutorialAdvancedConstants.FIGHT_MAP_ID))
                    {
                        return;
                    };
                    break;
                case (stepNumber == TutorialAdvancedConstants.FIGHT_STEP_NPC_DIALOG_1):
                case (stepNumber == TutorialAdvancedConstants.FIGHT_STEP_NPC_DIALOG_2):
                    if (this.hightlightPath(TutorialAdvancedConstants.FIGHT_MAP_ID))
                    {
                        return;
                    };
                    Api.highlight.highlightNpc(TutorialAdvancedConstants.NPC_DARM, true);
                    break;
                case (this._currentStepNumber == TutorialAdvancedConstants.FIGHT_STEP_FIGHT):
                    if (this.hightlightPath(TutorialAdvancedConstants.FIGHT_MAP_ID))
                    {
                        return;
                    };
                    Api.highlight.highlightNpc(TutorialAdvancedConstants.NPC_MONSTER, true);
                    break;
                case (this._currentStepNumber == TutorialAdvancedConstants.FIGHT_STEP_GO_JORIS):
                    if (this.hightlightPath(TutorialAdvancedConstants.HUB_MAP_ID))
                    {
                        return;
                    };
                    Api.highlight.highlightNpc(TutorialAdvancedConstants.NPC_JORIS, true);
                    break;
                default:
                    qq = Api.quest.getCompletedQuests();
                    if ((((((qq) && (stepNumber == this.DEFAULT_STEP)) && (qq.indexOf(TutorialAdvancedConstants.QUEST_FIGHT_ID) == -1)) && (qq.indexOf(TutorialAdvancedConstants.QUEST_JOB_ID) == -1)) && (this._mapId == TutorialAdvancedConstants.HUB_MAP_ID)))
                    {
                        Api.highlight.highlightNpc(TutorialAdvancedConstants.NPC_JORIS, true);
                    };
            };
            Api.system.dispatchHook(AdvancedTutorialStep, this._currentStepNumber, this._currentSubtepNumber);
        }

        private function waitingForRewards():Boolean
        {
            var rewards:* = Api.quest.getRewardableAchievements();
            var gifts:* = Api.player.getWaitingGifts();
            return (((rewards) && (rewards.length > 0)) || ((gifts) && (gifts.length > 0)));
        }

        private function hightlightPath(targetMapId:Number):Boolean
        {
            if (targetMapId == this._mapId)
            {
                return (false);
            };
            var genericStatueMapId:Number = 1;
            var path:Dictionary = new Dictionary();
            path[((TutorialAdvancedConstants.FIGHT_MAP_ID + ">") + TutorialAdvancedConstants.HUB_MAP_ID)] = (path[((TutorialAdvancedConstants.JOB_MAP_ID + ">") + TutorialAdvancedConstants.HUB_MAP_ID)] = function ():void
            {
                Api.highlight.highlightAbsolute(new Rectangle(400, 700), 1, 0, 1, true);
            });
            path[((TutorialAdvancedConstants.HUB_MAP_ID + ">") + TutorialAdvancedConstants.FIGHT_MAP_ID)] = function ():void
            {
                Api.highlight.highlightAbsolute(new Rectangle(760, 280), 1, 1, 1, true);
            };
            path[((TutorialAdvancedConstants.HUB_MAP_ID + ">") + TutorialAdvancedConstants.JOB_MAP_ID)] = function ():void
            {
                Api.highlight.highlightAbsolute(new Rectangle(1000, 425), 1, 1, 1, true);
            };
            path[((TutorialAdvancedConstants.HUB_MAP_ID + ">") + genericStatueMapId)] = function ():void
            {
                Api.highlight.highlightAbsolute(new Rectangle(400, 700), 1, 0, 1, true);
            };
            path[((genericStatueMapId + ">") + TutorialAdvancedConstants.HUB_MAP_ID)] = function ():void
            {
                Api.highlight.highlightAbsolute(new Rectangle(1000, 325), 1, 1, 1, true);
            };
            path[((TutorialAdvancedConstants.EXIT_MAP_ID + ">") + genericStatueMapId)] = function ():void
            {
                Api.highlight.highlightAbsolute(new Rectangle(0x0100, 300), 1, 1, 1, true);
            };
            var intermediateMapTarged:Dictionary = new Dictionary();
            intermediateMapTarged[((genericStatueMapId + ">") + TutorialAdvancedConstants.FIGHT_MAP_ID)] = TutorialAdvancedConstants.HUB_MAP_ID;
            intermediateMapTarged[((genericStatueMapId + ">") + TutorialAdvancedConstants.JOB_MAP_ID)] = TutorialAdvancedConstants.HUB_MAP_ID;
            intermediateMapTarged[((TutorialAdvancedConstants.FIGHT_MAP_ID + ">") + genericStatueMapId)] = TutorialAdvancedConstants.HUB_MAP_ID;
            intermediateMapTarged[((TutorialAdvancedConstants.JOB_MAP_ID + ">") + genericStatueMapId)] = TutorialAdvancedConstants.HUB_MAP_ID;
            intermediateMapTarged[((TutorialAdvancedConstants.EXIT_MAP_ID + ">") + TutorialAdvancedConstants.FIGHT_MAP_ID)] = genericStatueMapId;
            intermediateMapTarged[((TutorialAdvancedConstants.EXIT_MAP_ID + ">") + TutorialAdvancedConstants.JOB_MAP_ID)] = genericStatueMapId;
            intermediateMapTarged[((TutorialAdvancedConstants.EXIT_MAP_ID + ">") + TutorialAdvancedConstants.HUB_MAP_ID)] = genericStatueMapId;
            if (TutorialAdvancedConstants.STATUE_MAP_ID.indexOf(targetMapId) != -1)
            {
                targetMapId = genericStatueMapId;
            };
            var mapId:Number = this._mapId;
            if (TutorialAdvancedConstants.STATUE_MAP_ID.indexOf(mapId) != -1)
            {
                mapId = genericStatueMapId;
            };
            if (intermediateMapTarged[((mapId + ">") + targetMapId)])
            {
                targetMapId = intermediateMapTarged[((mapId + ">") + targetMapId)];
            };
            if (path[((mapId + ">") + targetMapId)])
            {
                var _local_3:* = path;
                (_local_3[((mapId + ">") + targetMapId)]());
                return (true);
            };
            Api.system.log(16, (targetMapId + " : map de destination inconnue."));
            return (false);
        }

        private function onCurrentMap(mapId:Number):void
        {
            Api.highlight.stop();
            this.currentMapId = mapId;
        }

        private function onUiLoaded(name:String):void
        {
            var craftUi:*;
            if (_instance == null)
            {
                return;
            };
            if (name == UIEnum.REWARDS)
            {
                this.prepareStep(this._currentStepNumber, this._currentSubtepNumber);
                return;
            };
            switch (true)
            {
                case (TutorialAdvancedConstants.JOB_STEP_CRAFT == this._currentStepNumber):
                    if (name == UIEnum.CRAFT)
                    {
                        craftUi = Api.ui.getUiByName(UIEnum.CRAFT);
                        this.prepareStep(TutorialAdvancedConstants.JOB_STEP_CRAFT, TutorialAdvancedConstants.JOB_STEP_CRAFT__ADD_INGREDIENT);
                    };
                    break;
            };
        }

        private function onUnloaded(name:String):void
        {
            if (_instance == null)
            {
                return;
            };
            if (((name == UIEnum.REWARDS) && (this.waitingForRewards())))
            {
                this.prepareStep(this._currentStepNumber, this._currentSubtepNumber);
                return;
            };
            switch (true)
            {
                case (TutorialAdvancedConstants.JOB_STEP_CRAFT == this._currentStepNumber):
                    if (((name == UIEnum.CRAFT) && ((this._currentSubtepNumber == TutorialAdvancedConstants.JOB_STEP_CRAFT__ADD_INGREDIENT) || (this._currentSubtepNumber == TutorialAdvancedConstants.JOB_STEP_CRAFT__FUSION))))
                    {
                        this.prepareStep(TutorialAdvancedConstants.JOB_STEP_CRAFT, TutorialAdvancedConstants.JOB_STEP_CRAFT__OPEN_UI);
                    };
                    break;
            };
        }

        private function onRewardsOpenClose():void
        {
            this.prepareStep(this._currentStepNumber, this._currentSubtepNumber);
        }

        private function onQuestStarted(questId:uint):void
        {
            if (_instance == null)
            {
                return;
            };
            if (TutorialAdvancedConstants.QUEST_IDS.indexOf(questId) != -1)
            {
                this.askQuestInfo(questId);
            };
        }

        private function onQuestValidated(questId:uint):void
        {
            if (_instance == null)
            {
                return;
            };
            if (questId == TutorialAdvancedConstants.QUEST_FIGHT_ID)
            {
                this._currentStepNumber = -1;
                this._currentSubtepNumber = -1;
            };
        }

        private function onQuestInfosUpdated(questId:uint, infosAvailable:Boolean):void
        {
            var objectiveId:*;
            var objectiveStatus:Boolean;
            if (_instance == null)
            {
                return;
            };
            if (((!(TutorialAdvancedConstants.QUEST_IDS.indexOf(questId) == -1)) && (infosAvailable)))
            {
                this._questInfo = Api.quest.getQuestInformations(questId);
                for (objectiveId in this._questInfo.objectives)
                {
                    objectiveStatus = this._questInfo.objectives[objectiveId];
                    if (this._questInfo.objectives[objectiveId] == true)
                    {
                        this.prepareStep(objectiveId);
                        break;
                    };
                };
            };
        }

        private function onQuestObjectiveValidated(questId:uint, ... args):void
        {
            if (_instance == null)
            {
                return;
            };
            if (TutorialAdvancedConstants.QUEST_IDS.indexOf(questId) != -1)
            {
                this.askQuestInfo(questId);
            };
        }

        public function onNpcDialogCreation(... rest):void
        {
            if (_instance == null)
            {
                return;
            };
            Api.highlight.stop();
            this._inDialog = true;
        }

        public function onLeaveDialog(... rest):void
        {
            if (_instance == null)
            {
                return;
            };
            this._inDialog = false;
            this.prepareStep(this._currentStepNumber, this._currentSubtepNumber);
        }

        private function onExchangeObjectAdded(... args):void
        {
            if (_instance == null)
            {
                return;
            };
            if (((this._currentStepNumber == TutorialAdvancedConstants.JOB_STEP_CRAFT) && (this._currentSubtepNumber == TutorialAdvancedConstants.JOB_STEP_CRAFT__ADD_INGREDIENT)))
            {
                this.prepareStep(TutorialAdvancedConstants.JOB_STEP_CRAFT, TutorialAdvancedConstants.JOB_STEP_CRAFT__FUSION);
            };
        }

        private function onJobExperienceUpdate(... args):void
        {
            if (_instance == null)
            {
                return;
            };
            if (this._currentStepNumber == TutorialAdvancedConstants.JOB_STEP_CRAFT)
            {
                this.prepareStep(TutorialAdvancedConstants.JOB_STEP_CRAFT, TutorialAdvancedConstants.JOB_STEP_CRAFT__QUIT);
            };
        }

        private function onMapComplementaryInformationsData(worldPoint:WorldPointWrapper, ... args):void
        {
            if (_instance == null)
            {
                return;
            };
            this.currentMapId = worldPoint.mapId;
            if (!this.askQuestInfo())
            {
                this.prepareStep(this._currentStepNumber, this._currentSubtepNumber);
            };
        }

        private function onGameFightJoin(... args):void
        {
            if (_instance == null)
            {
                return;
            };
            Api.highlight.stop();
        }

        private function onGameFightStart(... args):void
        {
            if (_instance == null)
            {
                return;
            };
            Api.highlight.stop();
        }

        public function onGameFightEnd(... rest):void
        {
            if (_instance == null)
            {
                return;
            };
            this.prepareStep(this._currentStepNumber, this._currentSubtepNumber);
        }

        public function onGameFightLeave(charId:Number):void
        {
            if (_instance == null)
            {
                return;
            };
            this.prepareStep(this._currentStepNumber, this._currentSubtepNumber);
        }

        private function onRewardableAchievementsVisible(b:Boolean):void
        {
            if (_instance == null)
            {
                return;
            };
            this.prepareStep(this._currentStepNumber, this._currentSubtepNumber);
        }

        private function onAchievementRewardSuccess(... rest):void
        {
            if (_instance == null)
            {
                return;
            };
            this.prepareStep(this._currentStepNumber, this._currentSubtepNumber);
        }

        private function onGiftsWaitingAllocation(b:Boolean):void
        {
            if (_instance == null)
            {
                return;
            };
            this.prepareStep(this._currentStepNumber, this._currentSubtepNumber);
        }


    }
} Ankama_Tutorial.managers

