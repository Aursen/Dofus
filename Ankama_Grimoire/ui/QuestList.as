package Ankama_Grimoire.ui
{
    import com.ankamagames.dofus.uiApi.QuestApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.ChatApi;
    import com.ankamagames.dofus.uiApi.ConfigApi;
    import flash.geom.ColorTransform;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import flash.events.MouseEvent;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.types.graphic.ScrollContainer;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import d2hooks.QuestValidated;
    import d2hooks.QuestObjectiveValidated;
    import d2hooks.QuestStepValidated;
    import d2hooks.QuestStarted;
    import d2hooks.QuestInfosUpdated;
    import d2hooks.FontActiveTypeChanged;
    import d2hooks.RemoveAllFlags;
    import d2hooks.FlagRemoved;
    import d2hooks.FlagAdded;
    import com.ankamagames.dofus.datacenter.quest.QuestObjective;
    import com.ankamagames.dofus.datacenter.quest.Quest;
    import d2hooks.RemoveMapFlag;
    import d2hooks.AddMapFlag;
    import d2actions.FollowQuest;
    import flash.geom.Rectangle;
    import d2actions.QuestInfosRequest;
    import com.ankamagames.berilia.components.gridRenderer.MultiGridRenderer;
    import d2actions.RefreshFollowedQuestsOrder;
    import com.ankamagames.dofus.datacenter.quest.QuestStep;
    import d2hooks.OpenBook;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.berilia.enums.StrataEnum;
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;
    import com.ankamagames.dofus.network.enums.CompassTypeEnum;
    import __AS3__.vec.*;

    public class QuestList extends AbstractQuestList 
    {

        private static const MAX_OBJECTIVES:uint = 3;
        private static const QUEST_TYPE:String = "ctr_quest";
        private static const OBJECTIVE_TYPE:String = "ctr_objective";
        private static const RIGHT_MARGIN:uint = 40;
        private static const BOTTOM_MARGIN:uint = 15;
        public static const MAX_FOLLOWED_QUESTS_DATA_ID:String = "maxFollowedQuests";
        private static const FOLLOWED_QUESTS_RESIZE_MODE_DATA_ID:String = "followedQuestsResizeMode";
        private static const OPACITY_DATA_ID:String = "followedQuestsBackgroundOpacity";
        private static const FONT_SIZE_DATA_ID:String = "followedQuestsFontSize";
        private static const QUEST_LIST_MINIMIZED_DATA_ID:String = "questListMinimized";
        private static const AUTO_RESIZE_MODE:uint = 1;
        private static const FREE_RESIZE_MODE:uint = 2;
        private static const FONT_SMALL_SIZE:uint = 15;
        private static const FONT_MEDIUM_SIZE:uint = 16;
        private static const ITEM_ID_REGEXP:RegExp = /\d+/g;

        [Api(name="QuestApi")]
        public var questApi:QuestApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="ChatApi")]
        public var chatApi:ChatApi;
        [Api(name="ConfigApi")]
        public var configApi:ConfigApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Module(name="Ankama_Cartography")]
        public var modCartography:Object;
        private var _quests:Array;
        private var _maxQuests:uint;
        private var _offsetY:Number;
        private var _listRendered:Boolean;
        private var _colors:Array;
        private var _defaultColorTransform:ColorTransform;
        private var _numQuests:uint;
        private var _previousItemIsQuest:Boolean;
        private var _components:Dictionary;
        private var _updating:Boolean;
        private var _startedQuests:Vector.<uint>;
        private var _resizeMode:uint;
        private var _flagsQuestData:Dictionary;
        private var _opacity:Number;
        private var _fontSize:uint;
        private var _mouseScrollEvent:MouseEvent;
        public var tx_minMax:TextureBitmap;
        public var tx_title:TextureBitmap;
        public var ctr_list:GraphicContainer;
        public var ctr_main:GraphicContainer;
        public var btn_options:ButtonContainer;
        public var btn_minimize:ButtonContainer;
        public var gd_quests:Grid;
        public var lbl_title:Label;
        public var gridScrollContainer:ScrollContainer;


        override public function main(params:Object):void
        {
            var i:int;
            var questParam:Object;
            var needInfosQuestsIds:Vector.<uint>;
            super.main(params);
            this._maxQuests = sysApi.getSetData(MAX_FOLLOWED_QUESTS_DATA_ID, 5, DataStoreEnum.BIND_ACCOUNT);
            this._resizeMode = sysApi.getSetData(FOLLOWED_QUESTS_RESIZE_MODE_DATA_ID, AUTO_RESIZE_MODE, DataStoreEnum.BIND_ACCOUNT);
            this.ctr_list.getResizeController().bottomResize = (this._resizeMode == FREE_RESIZE_MODE);
            this._opacity = sysApi.getSetData(OPACITY_DATA_ID, 0.7, DataStoreEnum.BIND_ACCOUNT);
            this.changeOpacity(this._opacity);
            this._fontSize = sysApi.getSetData(FONT_SIZE_DATA_ID, FONT_MEDIUM_SIZE, DataStoreEnum.BIND_ACCOUNT);
            this._mouseScrollEvent = new MouseEvent(MouseEvent.MOUSE_WHEEL);
            this.gridScrollContainer.verticalScrollSpeed = 20;
            this.gridScrollContainer.addContent(this.gd_quests);
            sysApi.addHook(QuestValidated, this.onQuestValidated);
            sysApi.addHook(QuestObjectiveValidated, this.onQuestObjectiveValidated);
            sysApi.addHook(QuestStepValidated, this.onQuestStepValidated);
            sysApi.addHook(QuestStarted, this.onQuestStarted);
            sysApi.addHook(QuestInfosUpdated, this.onQuestInfosUpdated);
            sysApi.addHook(FontActiveTypeChanged, this.onFontActiveTypeChanged);
            sysApi.addHook(RemoveAllFlags, this.removeAllFlags);
            sysApi.addHook(FlagRemoved, this.onFlagRemoved);
            sysApi.addHook(FlagAdded, this.onFlagAdded);
            this._quests = new Array();
            this._startedQuests = new Vector.<uint>();
            this._components = new Dictionary();
            this._colors = [false, false, false, false, false];
            this._defaultColorTransform = new ColorTransform();
            this._flagsQuestData = new Dictionary();
            if (params)
            {
                i = (params.quests.length - 1);
                while (i >= 0)
                {
                    questParam = params.quests[i];
                    if (!questParam.hasOwnProperty("objectives"))
                    {
                        if (!needInfosQuestsIds)
                        {
                            needInfosQuestsIds = new Vector.<uint>();
                        };
                        needInfosQuestsIds.push(questParam.questId);
                    }
                    else
                    {
                        this.addQuest(params.quests[i]);
                    };
                    i--;
                };
                if (this._numQuests > 0)
                {
                    this.update();
                };
                if (((needInfosQuestsIds) && (needInfosQuestsIds.length)))
                {
                    i = 0;
                    while (i < needInfosQuestsIds.length)
                    {
                        this.onQuestStarted(needInfosQuestsIds[i]);
                        i++;
                    };
                };
                if (((!(params.visible)) && (!(sysApi.isFightContext()))))
                {
                    this.minimize();
                };
            };
        }

        public function unload():void
        {
        }

        public function update():void
        {
            this._updating = true;
            this._listRendered = false;
            this._offsetY = 0;
            this.gd_quests.finalized = false;
            this.gd_quests.height = (this._quests.length * this.gd_quests.slotHeight);
            this.gd_quests.dataProvider = this._quests;
            this.updateListSize();
            this._listRendered = true;
            this._updating = false;
            this.restrictPosition();
        }

        public function updateLine(data:*, componentsRef:*, selected:Boolean, line:uint):void
        {
            var questOffset:Number;
            var objectiveY:Number;
            var objectiveCssClass:String;
            var objectiveText:String;
            var objective:QuestObjective;
            var itemLink:String;
            this._components[data] = componentsRef;
            if (this._listRendered)
            {
                return;
            };
            var lineType:String = this.getLineType(data, line);
            var offset:Number = 0;
            if (lineType.length)
            {
                if (lineType == QUEST_TYPE)
                {
                    questOffset = ((this._quests.indexOf(data) > 0) ? 10 : 0);
                    componentsRef.lbl_quest.setCssSize(this._fontSize, "questtitle");
                    componentsRef.lbl_quest.width = (this.ctr_list.width - RIGHT_MARGIN);
                    componentsRef.lbl_quest.y = (this._offsetY + questOffset);
                    componentsRef.lbl_quest.text = (this.dataApi.getQuest(data.id).name + ((sysApi.getPlayerManager().hasRights) ? ((" (" + data.id) + ")") : ""));
                    offset = ((componentsRef.lbl_quest.textHeight - (this.gd_quests.slotHeight - 5)) + questOffset);
                    this._previousItemIsQuest = true;
                }
                else
                {
                    objectiveY = this._offsetY;
                    if (this._previousItemIsQuest)
                    {
                        objectiveY = (objectiveY - 2);
                        this._previousItemIsQuest = false;
                    }
                    else
                    {
                        objectiveY = (objectiveY - 3);
                    };
                    componentsRef.lbl_objective.width = (this.ctr_list.width - RIGHT_MARGIN);
                    componentsRef.lbl_objective.x = ((componentsRef.btn_loc.x + componentsRef.btn_loc.width) - 5);
                    componentsRef.lbl_objective.y = (componentsRef.btn_loc.y = objectiveY);
                    if (data.hasOwnProperty("seeLess"))
                    {
                        objectiveCssClass = "seemore";
                        objectiveText = uiApi.getText("ui.quest.seeLess");
                    }
                    else
                    {
                        if (data.visible)
                        {
                            objective = this.dataApi.getQuestObjective(data.id);
                            objectiveCssClass = "questobjective";
                            objectiveText = (objective.text + ((sysApi.getPlayerManager().hasRights) ? ((" (" + data.id) + ")") : ""));
                            itemLink = objectiveText.substring(objectiveText.indexOf("{item"), (objectiveText.indexOf("}") + 1));
                            if (itemLink.length)
                            {
                                objectiveText = objectiveText.replace("{item,", "{encyclopediaItem,");
                            };
                            this.setFlagColor(componentsRef.btn_loc, data.color, (!(data.follow)));
                        }
                        else
                        {
                            objectiveCssClass = "seemore";
                            objectiveText = uiApi.getText("ui.quest.seeMore");
                        };
                    };
                    componentsRef.lbl_objective.cssClass = objectiveCssClass;
                    componentsRef.lbl_objective.setCssSize(this._fontSize, objectiveCssClass);
                    componentsRef.lbl_objective.text = objectiveText;
                    offset = (componentsRef.lbl_objective.textHeight - (this.gd_quests.slotHeight - 5));
                    componentsRef.lbl_objective.fullSize(componentsRef.lbl_objective.width);
                    componentsRef.btn_loc.visible = ((data.visible) && (data.flagData));
                };
                if (offset < 0)
                {
                    offset = 0;
                };
                this._offsetY = (this._offsetY + offset);
            };
        }

        public function getLineType(data:*, line:uint):String
        {
            if (!data)
            {
                return ("");
            };
            return ((data.isQuest) ? QUEST_TYPE : OBJECTIVE_TYPE);
        }

        public function addQuest(questParams:Object, toTheTop:Boolean=true):void
        {
            var i:int;
            var j:int;
            var questData:Object;
            var questExists:Boolean;
            var flagColor:uint;
            var objectiveParam:Object;
            var objectiveData:Object;
            var objectiveExists:Boolean;
            var objectiveIndex:int;
            var maxObjectivesReached:Boolean;
            var singleObjectiveAdded:Boolean;
            var flag:Object;
            var flagExists:Boolean;
            var addFlag:Boolean;
            var flagSavedData:*;
            var quest:Quest = this.dataApi.getQuest(questParams.questId);
            if (!quest.followable)
            {
                return;
            };
            for each (questData in this._quests)
            {
                if (((questData.isQuest) && (questData.id == questParams.questId)))
                {
                    questExists = true;
                    break;
                };
            };
            if (!questExists)
            {
                questData = {
                    "id":questParams.questId,
                    "isQuest":true,
                    "color":this.getUnusedColor()
                };
                questData.objectives = new Array();
                if (toTheTop)
                {
                    this._quests.unshift(questData);
                }
                else
                {
                    this._quests.push(questData);
                };
                this._numQuests++;
            };
            flagColor = questData.color;
            var numObjectives:uint = questParams.objectives.length;
            i = 0;
            while (i < numObjectives)
            {
                objectiveParam = questParams.objectives[i];
                for each (objectiveData in questData.objectives)
                {
                    if (objectiveData.id == objectiveParam.id)
                    {
                        objectiveExists = true;
                        break;
                    };
                };
                if (!objectiveExists)
                {
                    questData.objectives.push({
                        "id":objectiveParam.id,
                        "flagData":objectiveParam.flagData,
                        "isQuest":false,
                        "questId":questData.id,
                        "color":flagColor
                    });
                };
                i++;
            };
            var numObjectivesData:uint = questData.objectives.length;
            var objectivesStartIndex:int = (this._quests.indexOf(questData) + 1);
            var followAll:* = (questParams.objectives.length > 1);
            i = 0;
            for (;i < numObjectivesData;i++)
            {
                if (followAll)
                {
                    questData.objectives[i].visible = ((i + 1) <= MAX_OBJECTIVES);
                    if (questData.objectives[i].flagData)
                    {
                        flagSavedData = sysApi.getData(((playerApi.getPlayedCharacterInfo().id + "-questFlag-") + questData.objectives[i].flagData.id));
                        questData.objectives[i].follow = ((flagSavedData != null) ? (flagSavedData == true) : questData.objectives[i].visible);
                    }
                    else
                    {
                        questData.objectives[i].follow = false;
                    };
                }
                else
                {
                    if (questData.objectives[i].id == questParams.objectives[0].id)
                    {
                        j = 0;
                        while (j < i)
                        {
                            questData.objectives[j].visible = true;
                            j++;
                        };
                        questData.objectives[i].visible = true;
                        questData.objectives[i].follow = ((!(questData.objectives[i].flagData == null)) && ((objectiveExists) || (sysApi.getSetData(((playerApi.getPlayedCharacterInfo().id + "-questFlag-") + questData.objectives[i].flagData.id), true))));
                        maxObjectivesReached = false;
                    };
                };
                flagExists = false;
                if (questData.objectives[i].flagData)
                {
                    this._flagsQuestData[questData.objectives[i].flagData.id] = questData.objectives[i];
                    flag = this.getFlag(questData.objectives[i].flagData.id, questData.objectives[i].flagData.worldMapId);
                    flagExists = (!(flag == null));
                    if (!questData.objectives[i].follow)
                    {
                        if (flagExists)
                        {
                            sysApi.dispatchHook(RemoveMapFlag, questData.objectives[i].flagData.id, questData.objectives[i].flagData.worldMapId);
                        };
                    }
                    else
                    {
                        addFlag = false;
                        if (!flagExists)
                        {
                            addFlag = true;
                        }
                        else
                        {
                            if (flag.color != questData.objectives[i].color)
                            {
                                sysApi.dispatchHook(RemoveMapFlag, questData.objectives[i].flagData.id, questData.objectives[i].flagData.worldMapId);
                                addFlag = true;
                            };
                        };
                        if (addFlag)
                        {
                            sysApi.dispatchHook(AddMapFlag, questData.objectives[i].flagData.id, questData.objectives[i].flagData.text, questData.objectives[i].flagData.worldMapId, questData.objectives[i].flagData.x, questData.objectives[i].flagData.y, questData.objectives[i].color);
                        };
                    };
                };
                if (((!(maxObjectivesReached)) && (((followAll) && (!(questData.objectives[i].visible))) || (singleObjectiveAdded))))
                {
                    maxObjectivesReached = true;
                }
                else
                {
                    if (maxObjectivesReached)
                    {
                        continue;
                    };
                };
                singleObjectiveAdded = ((!(followAll)) && (questData.objectives[i].id == questParams.objectives[0].id));
                objectiveIndex = (objectivesStartIndex + i);
                this._quests.splice((objectivesStartIndex + i), (((this._quests.length > objectiveIndex) && (!(this._quests[objectiveIndex].isQuest))) ? 1 : 0), questData.objectives[i]);
            };
            if (!questParams.hasOwnProperty("fromServer"))
            {
                sysApi.sendAction(new FollowQuest(questParams.questId, ((followAll) ? -1 : questParams.objectives[0].id), true));
            };
        }

        public function unfollowQuest(questId:uint):void
        {
            this.removeQuest(questId);
            if (!this._quests.length)
            {
                if (sysApi.getData(QUEST_LIST_MINIMIZED_DATA_ID, DataStoreEnum.BIND_ACCOUNT))
                {
                    uiApi.unloadUi("questListMinimized");
                };
                uiApi.unloadUi(uiApi.me().name);
            }
            else
            {
                this.update();
            };
        }

        public function renderUpdate():void
        {
            var i:int;
            var dataLen:uint;
            this.tx_title.width = this.ctr_list.width;
            this.ctr_list.x--;
            this.lbl_title.x = this.tx_title.x;
            this.lbl_title.y = 3;
            this.lbl_title.width = (this.tx_title.width - 15);
            this.btn_options.x = (((this.tx_title.x + this.tx_title.width) - this.btn_options.width) - 22);
            this.btn_options.y = 0;
            this.btn_minimize.x = (((this.tx_title.x + this.tx_title.width) - this.btn_minimize.width) - 5);
            this.btn_minimize.y = 4;
            if (((this._quests) && (!(this._updating))))
            {
                dataLen = this._quests.length;
                this._listRendered = false;
                this._offsetY = 0;
                while (i < dataLen)
                {
                    if (this._components[this._quests[i]])
                    {
                        this.updateLine(this._quests[i], this._components[this._quests[i]], false, 0);
                    };
                    i++;
                };
                this.updateListSize();
                this._listRendered = true;
            };
            this.restrictPosition();
        }

        public function restrictPosition():void
        {
            var visibleBounds:Rectangle = uiApi.getVisibleStageBounds();
            var x:Number = (this.ctr_main.x + this.ctr_list.x);
            if ((x + this.ctr_list.width) > visibleBounds.right)
            {
                this.ctr_main.x = (visibleBounds.right - (this.ctr_list.x + this.ctr_list.width));
            };
            if (x < visibleBounds.left)
            {
                this.ctr_main.x = (visibleBounds.left - this.ctr_list.x);
            };
            if (this.ctr_main.y < visibleBounds.top)
            {
                this.ctr_main.y = 0;
            };
            if ((this.ctr_main.y + this.ctr_list.height) > visibleBounds.bottom)
            {
                this.ctr_main.y = (visibleBounds.bottom - Math.min(this.ctr_list.height, visibleBounds.bottom));
            };
        }

        private function getFlag(flagId:String, worldMapId:int):Object
        {
            var flag:Object;
            var flagList:* = this.modCartography.getFlags(worldMapId);
            for each (flag in flagList)
            {
                if (flag.id == flagId)
                {
                    return (flag);
                };
            };
            return (null);
        }

        private function updateListSize():void
        {
            var useScrollBar:Boolean;
            var height:Number;
            this.gridScrollContainer.width = (this.ctr_list.width - 11);
            if (this._resizeMode == AUTO_RESIZE_MODE)
            {
                height = ((this._quests.length * this.gd_quests.slotHeight) + this._offsetY);
                if (((this.gridScrollContainer.y + height) + BOTTOM_MARGIN) > uiApi.getVisibleStageBounds().height)
                {
                    height = ((uiApi.getVisibleStageBounds().height - this.gridScrollContainer.y) - BOTTOM_MARGIN);
                    useScrollBar = true;
                };
                this.gridScrollContainer.useVerticalScroll = useScrollBar;
                this.gridScrollContainer.height = height;
                this.gridScrollContainer.finalize();
                this.ctr_list.height = ((this.gridScrollContainer.y + height) + BOTTOM_MARGIN);
            }
            else
            {
                if (this._resizeMode == FREE_RESIZE_MODE)
                {
                    this.gridScrollContainer.height = ((this.ctr_list.height - this.gridScrollContainer.y) - BOTTOM_MARGIN);
                    this.gridScrollContainer.useVerticalScroll = true;
                    this.gridScrollContainer.finalize();
                };
            };
            if (((this.gridScrollContainer.useVerticalScroll) && (this.gridScrollContainer.hasVerticalScrollBar)))
            {
                this.gridScrollContainer.verticalScrollbarValue = this.gridScrollContainer.lastVerticalScrollValue;
            };
        }

        private function removeLastQuests(numQuestsToDelete:uint):void
        {
            var numDeletedQuests:uint;
            var i:int = (this._quests.length - 1);
            while (numDeletedQuests < numQuestsToDelete)
            {
                if (this._quests[i].isQuest)
                {
                    this.removeQuest(this._quests[i].id);
                    numDeletedQuests++;
                    i = (this._quests.length - 1);
                }
                else
                {
                    i--;
                };
            };
        }

        private function removeQuest(questId:uint, removeColorAndFlags:Boolean=true):Array
        {
            var i:int;
            var j:int;
            var endIndex:int;
            var deletedQuest:Array;
            var deletedQuestLen:uint;
            var dataLen:uint = this._quests.length;
            var numColors:uint = this._colors.length;
            var startIndex:int = -1;
            while (i < dataLen)
            {
                if (((this._quests[i].isQuest) && (this._quests[i].id == questId)))
                {
                    startIndex = i;
                };
                if (((!(startIndex == -1)) && (((this._quests[i].isQuest) && (!(i == startIndex))) || (i == (dataLen - 1)))))
                {
                    endIndex = (((this._quests[i].isQuest) && (i < (dataLen - 1))) ? i : (i + 1));
                    deletedQuest = this._quests.slice(startIndex, endIndex);
                    deletedQuestLen = deletedQuest.length;
                    this._quests.splice(startIndex, deletedQuestLen);
                    if (removeColorAndFlags)
                    {
                        delete this._components[deletedQuest[0]];
                        j = 0;
                        while (j < numColors)
                        {
                            if (this._colors[j] == deletedQuest[0].color)
                            {
                                this._colors[j] = false;
                                break;
                            };
                            j++;
                        };
                        j = 1;
                        while (j < deletedQuestLen)
                        {
                            delete this._components[deletedQuest[j]];
                            if (deletedQuest[j].flagData)
                            {
                                delete this._flagsQuestData[deletedQuest[j].flagData.id];
                                sysApi.dispatchHook(RemoveMapFlag, deletedQuest[j].flagData.id, deletedQuest[j].flagData.worldMapId);
                                sysApi.setData(((playerApi.getPlayedCharacterInfo().id + "-questFlag-") + deletedQuest[j].flagData.id), null);
                            };
                            j++;
                        };
                        this._numQuests--;
                        sysApi.sendAction(new FollowQuest(questId, -1, false));
                    };
                    return (deletedQuest);
                };
                i++;
            };
            return (null);
        }

        private function removeObjective(objectiveData:Object, askInfos:Boolean=false):void
        {
            var i:int;
            var questData:Object;
            var numObjectives:uint;
            var lastVisibleObjective:Object;
            var hiddenObjective:Object;
            var endIndex:int;
            var dataLen:uint = this._quests.length;
            var deletedObjectiveIndex:int = -1;
            i = 0;
            while (i < dataLen)
            {
                if (((this._quests[i].isQuest) && (this._quests[i].id == objectiveData.questId)))
                {
                    questData = this._quests[i];
                }
                else
                {
                    if (this._quests[i].id == objectiveData.id)
                    {
                        deletedObjectiveIndex = i;
                        break;
                    };
                };
                i++;
            };
            questData.objectives.splice(questData.objectives.indexOf(objectiveData), 1);
            if (deletedObjectiveIndex != -1)
            {
                this._quests.splice(deletedObjectiveIndex, 1);
            };
            delete this._components[objectiveData];
            if (objectiveData.flagData)
            {
                delete this._flagsQuestData[objectiveData.flagData.id];
                if (objectiveData.follow)
                {
                    sysApi.dispatchHook(RemoveMapFlag, objectiveData.flagData.id, objectiveData.flagData.worldMapId);
                };
                sysApi.setData(((playerApi.getPlayedCharacterInfo().id + "-questFlag-") + objectiveData.flagData.id), null);
            };
            if (questData.objectives.length)
            {
                sysApi.sendAction(new FollowQuest(questData.id, objectiveData.id, false));
                numObjectives = questData.objectives.length;
                i = 0;
                while (i < numObjectives)
                {
                    if (i < MAX_OBJECTIVES)
                    {
                        questData.objectives[i].visible = true;
                        lastVisibleObjective = questData.objectives[i];
                    }
                    else
                    {
                        if (((!(questData.objectives[i].visible)) && (!(hiddenObjective))))
                        {
                            hiddenObjective = questData.objectives[i];
                        };
                    };
                    i++;
                };
                endIndex = (this._quests.indexOf(lastVisibleObjective) + 1);
                if (((!(deletedObjectiveIndex == -1)) && (hiddenObjective)))
                {
                    this._quests.splice(endIndex, 0, hiddenObjective);
                }
                else
                {
                    if ((((numObjectives == MAX_OBJECTIVES) && (endIndex < this._quests.length)) && (this._quests[endIndex].hasOwnProperty("seeLess"))))
                    {
                        this._quests.splice(endIndex, 1);
                    };
                };
            };
            if (askInfos)
            {
                sysApi.sendAction(new QuestInfosRequest(questData.id));
            }
            else
            {
                if (!questData.objectives.length)
                {
                    this.unfollowQuest(questData.id);
                };
            };
        }

        private function getUnusedColor():int
        {
            var i:int;
            var color:uint;
            var numColors:uint = this._colors.length;
            i = (numColors - 1);
            while (i >= 0)
            {
                if (this._colors[i] == false)
                {
                    color = parseInt(sysApi.getConfigEntry(("colors.flag.quest" + (i + 1))), 16);
                    this._colors[i] = color;
                    return (color);
                };
                i--;
            };
            return (-1);
        }

        private function setFlagColor(target:Object, color:uint, remove:Boolean=false):void
        {
            var R:int;
            var G:int;
            var B:int;
            if (!remove)
            {
                R = ((color >> 16) & 0xFF);
                G = ((color >> 8) & 0xFF);
                B = ((color >> 0) & 0xFF);
                target.transform.colorTransform = new ColorTransform(0.6, 0.6, 0.6, 1, (R - 80), (G - 80), (B - 80));
            }
            else
            {
                target.transform.colorTransform = this._defaultColorTransform;
            };
        }

        private function getDataFromTarget(target:Object):Object
        {
            var i:int = (this.gd_quests.renderer as MultiGridRenderer).getItemIndex(target);
            if (((!(i == -1)) && (i <= (this._quests.length - 1))))
            {
                return (this._quests[i]);
            };
            return (null);
        }

        private function moveQuestToTheTop(questId:uint):void
        {
            var i:int;
            var deletedQuest:Array = this.removeQuest(questId, false);
            i = (deletedQuest.length - 1);
            while (i >= 0)
            {
                this._quests.unshift(deletedQuest[i]);
                i--;
            };
            this.update();
            var questsIds:Vector.<uint> = new Vector.<uint>();
            var dataLen:uint = this._quests.length;
            i = 0;
            while (i < dataLen)
            {
                if (this._quests[i].isQuest)
                {
                    questsIds.push(this._quests[i].id);
                };
                i++;
            };
            sysApi.sendAction(new RefreshFollowedQuestsOrder(questsIds));
        }

        private function removeAllFlags():void
        {
            var i:int;
            var j:int;
            var numObjectives:uint;
            var dataLen:uint = this._quests.length;
            i = 0;
            while (i < dataLen)
            {
                if (this._quests[i].isQuest)
                {
                    numObjectives = this._quests[i].objectives.length;
                    j = 0;
                    while (j < numObjectives)
                    {
                        if (this._quests[i].objectives[j].flagData)
                        {
                            sysApi.dispatchHook(RemoveMapFlag, this._quests[i].objectives[j].flagData.id, this._quests[i].objectives[j].flagData.worldMapId);
                        };
                        j++;
                    };
                };
                i++;
            };
        }

        private function changeMaxDisplayedQuests(max:uint):void
        {
            if (this._numQuests > max)
            {
                this.removeLastQuests((this._numQuests - max));
                this.update();
            };
            this._maxQuests = max;
            sysApi.setData(MAX_FOLLOWED_QUESTS_DATA_ID, this._maxQuests, DataStoreEnum.BIND_ACCOUNT);
        }

        private function changeResizeMode(resizeMode:uint):void
        {
            this._resizeMode = resizeMode;
            this.ctr_list.getResizeController().bottomResize = (this._resizeMode == FREE_RESIZE_MODE);
            sysApi.setData(FOLLOWED_QUESTS_RESIZE_MODE_DATA_ID, this._resizeMode, DataStoreEnum.BIND_ACCOUNT);
            this.updateListSize();
        }

        private function changeOpacity(opacity:Number):void
        {
            this.ctr_list.bgAlpha = opacity;
            this._opacity = opacity;
            sysApi.setData(OPACITY_DATA_ID, this._opacity, DataStoreEnum.BIND_ACCOUNT);
        }

        private function changeFontSize(fontSize:uint):void
        {
            this._fontSize = fontSize;
            sysApi.setData(FONT_SIZE_DATA_ID, this._fontSize, DataStoreEnum.BIND_ACCOUNT);
            this.update();
        }

        private function minimize():void
        {
            if (!sysApi.getData(QUEST_LIST_MINIMIZED_DATA_ID, DataStoreEnum.BIND_ACCOUNT))
            {
                uiApi.me().visible = false;
                uiApi.me().isMagnetic = false;
                this.ctr_list.isMagnetic = false;
                sysApi.setData(QUEST_LIST_MINIMIZED_DATA_ID, true, DataStoreEnum.BIND_ACCOUNT);
            };
        }

        public function maximize():void
        {
            if (sysApi.getData(QUEST_LIST_MINIMIZED_DATA_ID, DataStoreEnum.BIND_ACCOUNT))
            {
                uiApi.me().visible = true;
                uiApi.me().isMagnetic = true;
                this.ctr_list.isMagnetic = true;
                sysApi.setData(QUEST_LIST_MINIMIZED_DATA_ID, false, DataStoreEnum.BIND_ACCOUNT);
            };
        }

        private function hasFlags():Boolean
        {
            var i:int;
            var dataLen:uint = this._quests.length;
            i = 0;
            while (i < dataLen)
            {
                if ((((!(this._quests[i].isQuest)) && (this._quests[i].flagData)) && (this._quests[i].follow)))
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        private function getQuestActiveObjectivesData(questId:uint):Array
        {
            var questObjectives:Array;
            var i:int;
            var objective:QuestObjective;
            var objectiveFlagInfos:Object;
            var questInfos:Object = this.questApi.getQuestInformations(questId);
            if (!questInfos)
            {
                return (null);
            };
            var step:QuestStep = this.dataApi.getQuestStep(questInfos.stepId);
            if (((step) && (step.objectives.length)))
            {
                questObjectives = new Array();
                i = 0;
                while (i < step.objectives.length)
                {
                    objective = this.dataApi.getQuestObjective(step.objectives[i].id);
                    if (questInfos.objectives[objective.id])
                    {
                        objectiveFlagInfos = (((objective.coords) || (objective.mapId)) ? this.questApi.getQuestObjectiveFlagInfos(questId, objective.id) : null);
                        questObjectives.push({
                            "id":objective.id,
                            "flagData":((objectiveFlagInfos) ? ({
"id":objectiveFlagInfos.id,
"text":objectiveFlagInfos.text,
"worldMapId":objectiveFlagInfos.worldMapId,
"x":objectiveFlagInfos.x,
"y":objectiveFlagInfos.y
}) : (null)),
                            "isQuest":false,
                            "questId":questId
                        });
                    };
                    i++;
                };
            };
            return (questObjectives);
        }

        override protected function setVisible(value:Boolean):void
        {
            var isInTutorial:Boolean;
            var hasQuest:Boolean;
            if (!sysApi.getData(QUEST_LIST_MINIMIZED_DATA_ID, DataStoreEnum.BIND_ACCOUNT))
            {
                isInTutorial = playerApi.isInTutorialArea();
                hasQuest = ((this._quests) && (this._quests.length > 0));
                super.setVisible((((value) && (!(isInTutorial))) && (hasQuest)));
                this.ctr_list.isMagnetic = ((value) && (!(isInTutorial)));
            };
        }

        private function addObjectiveFlag(objectiveData:Object):void
        {
            var followed:Boolean = objectiveData.follow;
            sysApi.dispatchHook(AddMapFlag, objectiveData.flagData.id, objectiveData.flagData.text, objectiveData.flagData.worldMapId, objectiveData.flagData.x, objectiveData.flagData.y, objectiveData.color, true);
            if (followed == objectiveData.follow)
            {
                if (((objectiveData.visible) && (this._components[objectiveData])))
                {
                    this.setFlagColor(this._components[objectiveData].btn_loc, objectiveData.color);
                };
                objectiveData.follow = true;
            };
        }

        private function questHasFlags(questData:Object):Boolean
        {
            var i:int;
            var objectiveData:Object;
            var numObjectives:uint = questData.objectives.length;
            i = 0;
            while (i < numObjectives)
            {
                objectiveData = questData.objectives[i];
                if (objectiveData.flagData)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        private function showQuestFlags(questData:Object, show:Boolean):void
        {
            var i:int;
            var objectiveData:Object;
            var numObjectives:uint = questData.objectives.length;
            i = 0;
            while (i < numObjectives)
            {
                objectiveData = questData.objectives[i];
                if (objectiveData.flagData)
                {
                    if (show)
                    {
                        if (!objectiveData.follow)
                        {
                            this.addObjectiveFlag(objectiveData);
                        };
                    }
                    else
                    {
                        if (objectiveData.follow)
                        {
                            sysApi.dispatchHook(RemoveMapFlag, objectiveData.flagData.id, objectiveData.flagData.worldMapId);
                        };
                    };
                };
                i++;
            };
        }

        public function onWheel(target:Object, delta:int):void
        {
            if (((this.gridScrollContainer.useVerticalScroll) && (this.gridScrollContainer.hasVerticalScrollBar)))
            {
                this._mouseScrollEvent.delta = delta;
                this.gridScrollContainer.verticalScrollBar.onWheel(this._mouseScrollEvent);
            };
        }

        public function onQuestValidated(questId:uint):void
        {
            var followedQuests:Object = this.questApi.getFollowedQuests();
            if (followedQuests.indexOf(questId) != -1)
            {
                this.unfollowQuest(questId);
            };
        }

        public function onQuestObjectiveValidated(questId:uint, objectiveId:uint):void
        {
            var i:int;
            var dataLen:uint;
            var objectiveData:Object;
            var followedQuests:Object = this.questApi.getFollowedQuests();
            if (followedQuests.indexOf(questId) != -1)
            {
                dataLen = this._quests.length;
                i = 0;
                while (i < dataLen)
                {
                    if (((this._quests[i].isQuest) && (this._quests[i].id == questId)))
                    {
                        for each (objectiveData in this._quests[i].objectives)
                        {
                            if (objectiveData.id == objectiveId)
                            {
                                this.removeObjective(objectiveData, true);
                                return;
                            };
                        };
                    };
                    i++;
                };
            };
        }

        public function onQuestStepValidated(questId:uint, stepId:uint):void
        {
            var i:int;
            var dataLen:uint;
            var followedQuests:Object = this.questApi.getFollowedQuests();
            if (followedQuests.indexOf(questId) != -1)
            {
                dataLen = this._quests.length;
                i = 0;
                while (i < dataLen)
                {
                    if (((this._quests[i].isQuest) && (this._quests[i].id == questId)))
                    {
                        while (this._quests[i].objectives.length)
                        {
                            this.removeObjective(this._quests[i].objectives[0], true);
                        };
                        return;
                    };
                    i++;
                };
            };
        }

        public function onQuestStarted(questId:uint):void
        {
            var followedQuests:Object;
            var requestInfos:Boolean;
            var followQuest:Boolean = this.configApi.getConfigProperty("dofus", "followQuestOnStarted");
            if (followQuest)
            {
                followedQuests = this.questApi.getFollowedQuests();
                if (followedQuests.indexOf(questId) != -1)
                {
                    requestInfos = true;
                }
                else
                {
                    if (((this._numQuests + this._startedQuests.length) + 1) <= this._maxQuests)
                    {
                        this._startedQuests.push(questId);
                        requestInfos = true;
                    };
                };
                if (requestInfos)
                {
                    sysApi.sendAction(new QuestInfosRequest(questId));
                };
            };
        }

        public function onQuestInfosUpdated(questId:uint, infosAvailable:Boolean):void
        {
            var questObjectives:Array;
            var questData:Object;
            var i:int;
            var j:int;
            var numNewObjectives:int;
            var numCurrentObjectives:int;
            var numCurrentFlags:int;
            var flag:Object;
            var objectiveIndex:int;
            var hasSeeLess:Boolean;
            var currentObjective:Object;
            var removedObjectives:Array;
            var seeLessIndex:int;
            if (this.questApi.getFollowedQuests().indexOf(questId) != -1)
            {
                for each (questData in this._quests)
                {
                    if (((questData.isQuest) && (questData.id == questId)))
                    {
                        questObjectives = this.getQuestActiveObjectivesData(questId);
                        if ((((infosAvailable) && (questObjectives)) && (questObjectives.length)))
                        {
                            numNewObjectives = questObjectives.length;
                            numCurrentObjectives = questData.objectives.length;
                            numCurrentFlags = 0;
                            objectiveIndex = -1;
                            hasSeeLess = false;
                            removedObjectives = new Array();
                            if (numCurrentObjectives > 0)
                            {
                                seeLessIndex = ((this._quests.indexOf(questData) + 1) + numCurrentObjectives);
                                if (seeLessIndex < this._quests.length)
                                {
                                    hasSeeLess = this._quests[seeLessIndex].hasOwnProperty("seeLess");
                                };
                                i = 0;
                                while (i < numCurrentObjectives)
                                {
                                    if (questData.objectives[i].follow)
                                    {
                                        numCurrentFlags++;
                                    };
                                    i++;
                                };
                            };
                            i = 0;
                            for (;i < numNewObjectives;i++)
                            {
                                if (((numCurrentObjectives == 0) || ((i > (numCurrentObjectives - 1)) && ((hasSeeLess) || (numCurrentObjectives <= MAX_OBJECTIVES)))))
                                {
                                    objectiveIndex = -1;
                                }
                                else
                                {
                                    if (((i < questData.objectives.length) && (!(questData.objectives[i].id == questObjectives[i].id))))
                                    {
                                        objectiveIndex = this._quests.indexOf(questData.objectives[i]);
                                    }
                                    else
                                    {
                                        continue;
                                    };
                                };
                                currentObjective = null;
                                j = 0;
                                while (j < removedObjectives.length)
                                {
                                    if (removedObjectives[j].id == questObjectives[i].id)
                                    {
                                        currentObjective = removedObjectives[j];
                                        break;
                                    };
                                    j++;
                                };
                                if (!currentObjective)
                                {
                                    currentObjective = questObjectives[i];
                                };
                                currentObjective.visible = ((hasSeeLess) || (i < MAX_OBJECTIVES));
                                if (removedObjectives.indexOf(currentObjective) == -1)
                                {
                                    currentObjective.follow = (numCurrentFlags < MAX_OBJECTIVES);
                                    currentObjective.color = questData.color;
                                    if (currentObjective.flagData)
                                    {
                                        this._flagsQuestData[currentObjective.flagData.id] = currentObjective;
                                        flag = this.getFlag(currentObjective.flagData.id, currentObjective.flagData.worldMapId);
                                        if (flag)
                                        {
                                            sysApi.dispatchHook(RemoveMapFlag, currentObjective.flagData.id, currentObjective.flagData.worldMapId);
                                        };
                                        if (questObjectives[i].follow)
                                        {
                                            sysApi.dispatchHook(AddMapFlag, questObjectives[i].flagData.id, questObjectives[i].flagData.text, questObjectives[i].flagData.worldMapId, questObjectives[i].flagData.x, questObjectives[i].flagData.y, questObjectives[i].color);
                                            numCurrentFlags++;
                                        };
                                    };
                                    sysApi.sendAction(new FollowQuest(questId, currentObjective.id, true));
                                };
                                if (objectiveIndex == -1)
                                {
                                    questData.objectives.push(currentObjective);
                                    if (((hasSeeLess) || ((questData.objectives.length - 1) <= MAX_OBJECTIVES)))
                                    {
                                        this._quests.splice(((this._quests.indexOf(questData) + 1) + i), 0, currentObjective);
                                    };
                                }
                                else
                                {
                                    removedObjectives.push(questData.objectives[i]);
                                    questData.objectives[i] = currentObjective;
                                    this._quests.splice(objectiveIndex, 1, currentObjective);
                                };
                            };
                            this.update();
                        }
                        else
                        {
                            this.unfollowQuest(questId);
                        };
                        break;
                    };
                };
            }
            else
            {
                if (((this._startedQuests.length) && (!(this._startedQuests.indexOf(questId) == -1))))
                {
                    if (((infosAvailable) && ((this._numQuests + 1) <= this._maxQuests)))
                    {
                        questObjectives = this.getQuestActiveObjectivesData(questId);
                        if (((questObjectives) && (questObjectives.length)))
                        {
                            this.addQuest({
                                "questId":questId,
                                "objectives":questObjectives
                            }, false);
                            this.update();
                            if (!sysApi.getData(QUEST_LIST_MINIMIZED_DATA_ID, DataStoreEnum.BIND_ACCOUNT))
                            {
                                this.maximize();
                            };
                        };
                    };
                    this._startedQuests.splice(this._startedQuests.indexOf(questId), 1);
                };
            };
        }

        public function onRelease(target:Object):void
        {
            var targetData:Object;
            var questId:int;
            var numObjectives:uint;
            var i:int;
            var param:Object;
            var data:Object;
            var j:int;
            var startIndex:int;
            var tmpIndex:int;
            var hiddenObjectives:Array;
            var menu:Array;
            var followQuestOnStarted:Boolean;
            var nResizeMode:uint;
            var fontSizes:Array;
            var opacities:Array;
            var questListMinimized:*;
            if (((target.name.indexOf("btn_quest") == 0) || (target.name.indexOf("btn_objective") == 0)))
            {
                targetData = this.getDataFromTarget(target);
                if (targetData)
                {
                    questId = ((targetData.isQuest) ? targetData.id : targetData.questId);
                    if (targetData.isQuest)
                    {
                        param = {
                            "quest":this.dataApi.getQuest(questId),
                            "forceOpen":true
                        };
                        sysApi.dispatchHook(OpenBook, "questTab", param);
                    }
                    else
                    {
                        if (targetData.hasOwnProperty("seeLess"))
                        {
                            for each (data in this._quests)
                            {
                                if (((data.isQuest) && (data.id == questId)))
                                {
                                    numObjectives = data.objectives.length;
                                    i = MAX_OBJECTIVES;
                                    while (i < numObjectives)
                                    {
                                        data.objectives[i].visible = false;
                                        i++;
                                    };
                                    startIndex = ((this._quests.indexOf(data) + 1) + MAX_OBJECTIVES);
                                    this._quests.splice(startIndex, (numObjectives - MAX_OBJECTIVES));
                                    this._quests[startIndex] = data.objectives[MAX_OBJECTIVES];
                                    break;
                                };
                            };
                            this.update();
                        }
                        else
                        {
                            if (!targetData.visible)
                            {
                                for each (data in this._quests)
                                {
                                    if (((data.isQuest) && (data.id == questId)))
                                    {
                                        startIndex = (this._quests.indexOf(data) + 1);
                                        numObjectives = data.objectives.length;
                                        i = 0;
                                        while (i < numObjectives)
                                        {
                                            tmpIndex = (startIndex + i);
                                            if (tmpIndex < this._quests.length)
                                            {
                                                if (((data.objectives[i].id == this._quests[tmpIndex].id) && (!(this._quests[tmpIndex].visible))))
                                                {
                                                    this._quests[tmpIndex].visible = true;
                                                    if ((i + 1) < data.objectives.length)
                                                    {
                                                        hiddenObjectives = data.objectives.slice((i + 1), data.objectives.length);
                                                        j = (hiddenObjectives.length - 1);
                                                        while (j >= 0)
                                                        {
                                                            hiddenObjectives[j].visible = true;
                                                            hiddenObjectives[j].follow = ((hiddenObjectives[j].flagData) && (!(this.getFlag(hiddenObjectives[j].flagData.id, hiddenObjectives[j].flagData.worldMapId) == null)));
                                                            this._quests.splice((tmpIndex + 1), 0, hiddenObjectives[j]);
                                                            j--;
                                                        };
                                                    };
                                                };
                                            };
                                            i++;
                                        };
                                        this._quests.splice((tmpIndex + 1), 0, {
                                            "isQuest":false,
                                            "seeLess":true,
                                            "questId":questId
                                        });
                                        break;
                                    };
                                };
                                this.update();
                            };
                        };
                    };
                };
            }
            else
            {
                if (target.name.indexOf("btn_loc") == 0)
                {
                    targetData = this.getDataFromTarget(target);
                    if (targetData)
                    {
                        this.addObjectiveFlag(targetData);
                    };
                }
                else
                {
                    switch (target)
                    {
                        case this.btn_options:
                            menu = new Array();
                            menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.followMaxQuests", 3), this.changeMaxDisplayedQuests, [3], false, null, (this._maxQuests == 3)));
                            menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.followMaxQuests", 5), this.changeMaxDisplayedQuests, [5], false, null, (this._maxQuests == 5)));
                            menu.push(this.modContextMenu.createContextMenuSeparatorObject());
                            followQuestOnStarted = this.configApi.getConfigProperty("dofus", "followQuestOnStarted");
                            menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.followOnStarted"), this.configApi.setConfigProperty, ["dofus", "followQuestOnStarted", (!(followQuestOnStarted))], false, null, (followQuestOnStarted == true), false));
                            menu.push(this.modContextMenu.createContextMenuSeparatorObject());
                            if (this._resizeMode == AUTO_RESIZE_MODE)
                            {
                                nResizeMode = FREE_RESIZE_MODE;
                            }
                            else
                            {
                                if (this._resizeMode == FREE_RESIZE_MODE)
                                {
                                    nResizeMode = AUTO_RESIZE_MODE;
                                };
                            };
                            menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.followedQuests.autoResize"), this.changeResizeMode, [nResizeMode], false, null, (this._resizeMode == AUTO_RESIZE_MODE), false));
                            menu.push(this.modContextMenu.createContextMenuSeparatorObject());
                            menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.removeAllFlags"), this.removeAllFlags, null, (!(this.hasFlags()))));
                            menu.push(this.modContextMenu.createContextMenuSeparatorObject());
                            fontSizes = new Array();
                            fontSizes.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.option.small"), this.changeFontSize, [FONT_SMALL_SIZE], false, null, (this._fontSize == FONT_SMALL_SIZE)));
                            fontSizes.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.option.medium"), this.changeFontSize, [FONT_MEDIUM_SIZE], false, null, (this._fontSize == FONT_MEDIUM_SIZE)));
                            menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.option.fontSize"), null, null, false, fontSizes));
                            menu.push(this.modContextMenu.createContextMenuSeparatorObject());
                            opacities = new Array();
                            opacities.push(this.modContextMenu.createContextMenuItemObject("50%", this.changeOpacity, [0.5], false, null, (this._opacity == 0.5)));
                            opacities.push(this.modContextMenu.createContextMenuItemObject("70%", this.changeOpacity, [0.7], false, null, (this._opacity == 0.7)));
                            opacities.push(this.modContextMenu.createContextMenuItemObject("90%", this.changeOpacity, [0.9], false, null, (this._opacity == 0.9)));
                            menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.cartography.opacitymenu"), null, null, false, opacities));
                            this.modContextMenu.createContextMenu(menu);
                            break;
                        case this.btn_minimize:
                            this.minimize();
                            questListMinimized = uiApi.getUi(UIEnum.QUEST_LIST_MINIMIZED);
                            if (((questListMinimized) && (questListMinimized.uiClass)))
                            {
                                questListMinimized.uiClass.visible = true;
                            }
                            else
                            {
                                uiApi.loadUi(UIEnum.QUEST_LIST_MINIMIZED, UIEnum.QUEST_LIST_MINIMIZED, null, StrataEnum.STRATA_TOP);
                            };
                            break;
                    };
                };
            };
        }

        public function onRightClick(target:Object):void
        {
            var menu:Array;
            var objective:QuestObjective;
            var targetData:Object = this.getDataFromTarget(target);
            if (((targetData) && ((targetData.isQuest) || ((targetData.visible) && (!(targetData.hasOwnProperty("seeLess")))))))
            {
                if (target.name.indexOf("btn_quest") == 0)
                {
                    menu = new Array();
                    menu.push(this.modContextMenu.createContextMenuTitleObject(this.dataApi.getQuest(targetData.id).name));
                    menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.unfollow"), this.unfollowQuest, [targetData.id]));
                    if (this._quests.indexOf(targetData) > 0)
                    {
                        menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.moveToTheTop"), this.moveQuestToTheTop, [targetData.id]));
                    };
                    if (this.questHasFlags(targetData))
                    {
                        menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.showQuestObjectivesFlags"), this.showQuestFlags, [targetData, true]));
                        menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.hideQuestObjectivesFlags"), this.showQuestFlags, [targetData, false]));
                    };
                    this.modContextMenu.createContextMenu(menu);
                }
                else
                {
                    if (target.name.indexOf("btn_objective") == 0)
                    {
                        objective = this.dataApi.getQuestObjective(targetData.id);
                        menu = new Array();
                        menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.removeObjective"), this.removeObjective, [targetData]));
                        if (targetData.flagData)
                        {
                            if (targetData.follow)
                            {
                                menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.removeFlag"), sysApi.dispatchHook, [RemoveMapFlag, targetData.flagData.id, targetData.flagData.worldMapId]));
                            }
                            else
                            {
                                menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.addFlag"), this.addObjectiveFlag, [targetData]));
                            };
                        };
                        this.modContextMenu.createContextMenu(menu);
                    };
                };
            };
        }

        public function onRollOver(target:Object):void
        {
            var targetData:Object = this.getDataFromTarget(target);
            if (((targetData) && ((targetData.hasOwnProperty("seeLess")) || (!(targetData.visible)))))
            {
                Mouse.cursor = MouseCursor.BUTTON;
            };
        }

        public function onRollOut(target:Object):void
        {
            var targetData:Object = this.getDataFromTarget(target);
            if (((targetData) && ((targetData.hasOwnProperty("seeLess")) || (!(targetData.visible)))))
            {
                Mouse.cursor = MouseCursor.AUTO;
            };
        }

        public function onFontActiveTypeChanged():void
        {
            this.renderUpdate();
        }

        public function onFlagRemoved(flagId:String, worldmapId:int):void
        {
            var objectiveData:Object;
            if (flagId.indexOf(("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST)) == 0)
            {
                objectiveData = this._flagsQuestData[flagId];
                if (((objectiveData) && (!(this._quests.indexOf(objectiveData) == -1))))
                {
                    objectiveData.follow = false;
                    this.setFlagColor(this._components[objectiveData].btn_loc, objectiveData.color, true);
                    sysApi.setData(((playerApi.getPlayedCharacterInfo().id + "-questFlag-") + flagId), false);
                };
            };
        }

        public function onFlagAdded(flagId:String, worldmapId:int, x:int, y:int, color:int, flagLegend:String, canBeManuallyRemoved:Boolean=true, allowDuplicate:Boolean=false):void
        {
            var objectiveData:Object;
            if (flagId.indexOf(("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST)) == 0)
            {
                objectiveData = this._flagsQuestData[flagId];
                if (((objectiveData) && (!(this._quests.indexOf(objectiveData) == -1))))
                {
                    sysApi.setData(((playerApi.getPlayedCharacterInfo().id + "-questFlag-") + flagId), true);
                };
            };
        }


    }
}

