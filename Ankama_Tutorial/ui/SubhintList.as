package Ankama_Tutorial.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.ComboBox;
    import com.ankamagames.berilia.components.Grid;
    import d2hooks.UiLoaded;
    import d2hooks.UiUnloaded;
    import d2hooks.SubhintUpdated;
    import d2enums.ComponentHookList;
    import flash.events.TimerEvent;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.internalDatacenter.tutorial.SubhintWrapper;

    public class SubhintList 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        private var _subhintEditorUi:*;
        private var _subhintEditorUiX:Number = 0;
        private var _subhintEditorUiY:Number = 0;
        private var _componentsList:Dictionary = new Dictionary(true);
        private var _uiChoice:Array;
        private var _sortCriteria:String = "parent";
        private var _descendingSort:Boolean = false;
        private var _lastTargetRollOver:String = "";
        private var _lastElementHighlighted:String = "";
        private var _timerHighLight:Timer;
        private var _lastRenderStart:uint;
        private var _selectedSubhint:int = -1;
        public var subhintList:GraphicContainer;
        public var btn_close_subhintList:ButtonContainer;
        public var btn_refresh:ButtonContainer;
        public var cb_uiChoice:ComboBox;
        public var gd_subhints:Grid;
        public var btn_tabOrder:ButtonContainer;
        public var btn_tabElem:ButtonContainer;
        public var btn_tabParent:ButtonContainer;
        public var btn_gridSubhint:ButtonContainer;
        public var btn_moveUp:ButtonContainer;
        public var btn_moveDown:ButtonContainer;


        public function main(params:Object):void
        {
            this.sysApi.addEventListener(this.onEnterFrame, "SubhintList");
            this.sysApi.addHook(UiLoaded, this.onUiLoaded);
            this.sysApi.addHook(UiUnloaded, this.onUiUnloaded);
            this.sysApi.addHook(SubhintUpdated, this.onSubhintUpdated);
            this.uiApi.addComponentHook(this.subhintList, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_close_subhintList, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.gd_subhints, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.gd_subhints, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.gd_subhints, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.cb_uiChoice, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.cb_uiChoice, ComponentHookList.ON_RELEASE);
            this.subhintList.visible = false;
            this._subhintEditorUi = this.uiApi.getUi("SubhintEditorUi");
            this.uiApi.me().setOnTopAfterMe.push(this._subhintEditorUi);
            this.initComboBox();
            this.cb_uiChoice.value = this._uiChoice[0];
            this.gd_subhints.dataProvider = [];
            this.gd_subhints.dataProvider = this.sortSubhints("parent");
        }

        private function onEnterFrame():void
        {
            var subhintEditorUiRect:Object;
            var rect:*;
            if (this._subhintEditorUi)
            {
                subhintEditorUiRect = this._subhintEditorUi.getStageRect();
                if (((!(subhintEditorUiRect.x == this._subhintEditorUiX)) || (!(subhintEditorUiRect.y == this._subhintEditorUiY))))
                {
                    rect = this.uiApi.getVisibleStageBounds();
                    if ((((subhintEditorUiRect.x + 457) + this.subhintList.width) - rect.x) < rect.width)
                    {
                        this.subhintList.x = (subhintEditorUiRect.x + 457);
                    }
                    else
                    {
                        this.subhintList.x = ((subhintEditorUiRect.x - this.subhintList.width) + 40);
                    };
                    this.subhintList.y = subhintEditorUiRect.y;
                    this._subhintEditorUiX = subhintEditorUiRect.x;
                    this._subhintEditorUiY = subhintEditorUiRect.y;
                    this.subhintList.visible = true;
                };
            };
        }

        private function onUiLoaded(uiName:String):void
        {
            if (!(((uiName.indexOf("tooltip_") == -1) || (uiName.indexOf("popup") == -1)) || (uiName.indexOf("extNotif") == -1)))
            {
                this.updateSubhintList();
            };
        }

        private function onUiUnloaded(uiName:String):void
        {
            if (!(((uiName.indexOf("tooltip_") == -1) || (uiName.indexOf("popup") == -1)) || (uiName.indexOf("extNotif") == -1)))
            {
                this.updateSubhintList();
            };
        }

        private function onSubhintUpdated():void
        {
            this.updateSubhintList();
        }

        private function updateSubhintList():void
        {
            var indexOfSelectedItem:uint;
            if (this.cb_uiChoice.selectedItem)
            {
                indexOfSelectedItem = this.cb_uiChoice.dataProvider.indexOf(this.cb_uiChoice.selectedItem);
            }
            else
            {
                indexOfSelectedItem = 0;
            };
            this.initComboBox();
            this.displaySubhintsSelected(indexOfSelectedItem);
        }

        public function unload():void
        {
            this.sysApi.removeEventListener(this.onEnterFrame);
        }

        public function onRelease(target:Object):void
        {
            var data:Object = new Object();
            var shw:Object = new Object();
            switch (target)
            {
                case this.btn_close_subhintList:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_refresh:
                    this._subhintEditorUi.uiClass.updateChangeButton(false);
                    this.hintsApi.closeSubhintPreview();
                    this.hintsApi.getSubhints();
                    this.updateSubhintList();
                    break;
                case this.cb_uiChoice:
                    this.initComboBox();
                    break;
                case this.btn_tabOrder:
                    if (this._sortCriteria == "order")
                    {
                        this._descendingSort = (!(this._descendingSort));
                    };
                    this.gd_subhints.dataProvider = this.sortSubhints("order");
                    this._subhintEditorUi.uiClass.allSubhintsInUisOpened = this.sortSubhints("order");
                    if (this._subhintEditorUi.uiClass.currentSubhint)
                    {
                        this._subhintEditorUi.uiClass.subhintEditorUpdated(this._subhintEditorUi.uiClass.currentSubhint);
                    };
                    break;
                case this.btn_tabElem:
                    if (this._sortCriteria == "element")
                    {
                        this._descendingSort = (!(this._descendingSort));
                    };
                    this.gd_subhints.dataProvider = this.sortSubhints("element");
                    this._subhintEditorUi.uiClass.allSubhintsInUisOpened = this.sortSubhints("element");
                    if (this._subhintEditorUi.uiClass.currentSubhint)
                    {
                        this._subhintEditorUi.uiClass.subhintEditorUpdated(this._subhintEditorUi.uiClass.currentSubhint);
                    };
                    break;
                case this.btn_tabParent:
                    if (this._sortCriteria == "parent")
                    {
                        this._descendingSort = (!(this._descendingSort));
                    };
                    this.gd_subhints.dataProvider = this.sortSubhints("parent");
                    this._subhintEditorUi.uiClass.allSubhintsInUisOpened = this.sortSubhints("parent");
                    if (this._subhintEditorUi.uiClass.currentSubhint)
                    {
                        this._subhintEditorUi.uiClass.subhintEditorUpdated(this._subhintEditorUi.uiClass.currentSubhint);
                    };
                    break;
                case this.btn_moveDown:
                    if (this.gd_subhints.selectedItem.hint_order < this.hintsApi.getSubhintDataArrayWithParentUID(this.gd_subhints.selectedItem.hint_parent_uid).length)
                    {
                        data.hint_id = this.gd_subhints.selectedItem.hint_id;
                        data.hint_order = (this.gd_subhints.selectedItem.hint_order + 1);
                        this._selectedSubhint = this.gd_subhints.selectedItem.hint_id;
                        this.hintsApi.moveSubhint(data);
                    };
                    break;
                case this.btn_moveUp:
                    if (this.gd_subhints.selectedItem.hint_order > 1)
                    {
                        data.hint_id = this.gd_subhints.selectedItem.hint_id;
                        this.gd_subhints.selectedItem.hint_order--;
                        this._selectedSubhint = this.gd_subhints.selectedItem.hint_id;
                        this.hintsApi.moveSubhint(data);
                    };
                    break;
            };
        }

        public function updateSubhintLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (data)
            {
                if (!this._componentsList[componentsRef.btn_gridSubhint.name])
                {
                    this.uiApi.addComponentHook(componentsRef.btn_gridSubhint, ComponentHookList.ON_RELEASE);
                    this.uiApi.addComponentHook(componentsRef.btn_gridSubhint, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(componentsRef.btn_gridSubhint, ComponentHookList.ON_ROLL_OUT);
                };
                this._componentsList[componentsRef.btn_gridSubhint.name] = data;
                componentsRef.lbl_order.text = data.hint_order;
                componentsRef.lbl_anchoredElement.text = data.hint_anchored_element;
                componentsRef.lbl_parentName.text = data.hint_parent_uid;
                componentsRef.btn_gridSubhint.selected = selected;
                componentsRef.btn_gridSubhint.disabled = false;
                return;
            };
            componentsRef.lbl_order.text = "";
            componentsRef.lbl_anchoredElement.text = "";
            componentsRef.lbl_parentName.text = "";
            componentsRef.btn_gridSubhint.selected = false;
            componentsRef.btn_gridSubhint.disabled = true;
        }

        private function initComboBox():void
        {
            var key:*;
            var uiName:Array;
            this._uiChoice = ["Tous"];
            var dict:Dictionary = (this.hintsApi.getSubhintData() as Dictionary);
            for (key in dict)
            {
                uiName = key.split("_");
                if (this.uiApi.getUiByName(uiName[0]))
                {
                    this._uiChoice.push(key);
                };
            };
            this.cb_uiChoice.dataProvider = this._uiChoice;
        }

        public function displaySubhintsSelected(selectedIndex:uint):void
        {
            var sh:*;
            var i:uint;
            var j:uint;
            var k:uint;
            var subhint:*;
            var currentUiSubhints:Array = [];
            var allSubhints:Array = [];
            if (((selectedIndex <= 0) && (this._uiChoice.length > 1)))
            {
                i = 1;
                while (i < this._uiChoice.length)
                {
                    currentUiSubhints = this.hintsApi.getSubhintDataArrayWithParentUID(this._uiChoice[i]);
                    if (currentUiSubhints)
                    {
                        j = 0;
                        while (j < currentUiSubhints.length)
                        {
                            if (currentUiSubhints[j])
                            {
                                allSubhints.push(currentUiSubhints[j]);
                            };
                            j++;
                        };
                    };
                    i++;
                };
            }
            else
            {
                currentUiSubhints = this.hintsApi.getSubhintDataArrayWithParentUID(this._uiChoice[selectedIndex]);
                if (currentUiSubhints)
                {
                    k = 0;
                    while (k < currentUiSubhints.length)
                    {
                        if (currentUiSubhints[k])
                        {
                            allSubhints.push(currentUiSubhints[k]);
                        };
                        k++;
                    };
                };
            };
            var sameList:Boolean = true;
            for (sh in allSubhints)
            {
                if (this.gd_subhints.dataProvider[sh] != allSubhints[sh])
                {
                    sameList = false;
                };
            };
            if (((!(sameList)) || (allSubhints.length == 0)))
            {
                this.gd_subhints.dataProvider = allSubhints;
            };
            if (this._selectedSubhint >= 0)
            {
                for each (subhint in this.gd_subhints.dataProvider)
                {
                    if (subhint.hint_id == this._selectedSubhint)
                    {
                        this.gd_subhints.selectedItem = subhint;
                    };
                };
                this._selectedSubhint = -1;
            };
        }

        public function onSelectItem(target:*, method:uint, selected:Boolean):void
        {
            var selectedSubhint:Object;
            switch (target)
            {
                case this.gd_subhints:
                    if (this._subhintEditorUi)
                    {
                        selectedSubhint = this.gd_subhints.selectedItem;
                        if (((selectedSubhint) && (!(selectedSubhint.hint_id == this._selectedSubhint))))
                        {
                            this._selectedSubhint = selectedSubhint.hint_id;
                            this._subhintEditorUi.uiClass.subhintEditorUpdated(selectedSubhint);
                            if (selectedSubhint.hint_order == 1)
                            {
                                this.btn_moveUp.disabled = true;
                            }
                            else
                            {
                                this.btn_moveUp.disabled = false;
                            };
                            if (selectedSubhint.hint_order == this.hintsApi.getSubhintDataArrayWithParentUID(selectedSubhint.hint_parent_uid).length)
                            {
                                this.btn_moveDown.disabled = true;
                            }
                            else
                            {
                                this.btn_moveDown.disabled = false;
                            };
                        };
                    };
                    break;
                case this.cb_uiChoice:
                    this.displaySubhintsSelected(this.cb_uiChoice.selectedIndex);
                    break;
            };
        }

        public function onRollOver(target:*):void
        {
            var selectedSubhintData:Object;
            switch (true)
            {
                case (target is ButtonContainer):
                    if (target.name.indexOf("gd_subhints") != -1)
                    {
                        if (this._lastTargetRollOver != target.name)
                        {
                            this._lastTargetRollOver = target.name;
                            selectedSubhintData = this._componentsList[target.name];
                            this._lastElementHighlighted = selectedSubhintData.hint_highlighted_element;
                            this.startTimer(100);
                        };
                    };
                    break;
            };
        }

        public function onRollOut(target:*):void
        {
            switch (true)
            {
                case (target is ButtonContainer):
                    if (target.name.indexOf("gd_subhints") != -1)
                    {
                        if (this._timerHighLight)
                        {
                            this._timerHighLight.removeEventListener(TimerEvent.TIMER, this.onTimerEnd);
                            this._timerHighLight = null;
                        };
                        this.hintsApi.highLightSubhint(this._lastElementHighlighted, false);
                        this._lastElementHighlighted = "";
                        this._lastTargetRollOver = "";
                    };
                    break;
            };
        }

        private function sortSubhints(sortField:String):Array
        {
            this._sortCriteria = sortField;
            var dataProvider:Array = this.gd_subhints.dataProvider;
            switch (sortField)
            {
                case "order":
                    if (this._descendingSort)
                    {
                        dataProvider.sort(this.sortByOrder, Array.DESCENDING);
                    }
                    else
                    {
                        dataProvider.sort(this.sortByOrder);
                    };
                    break;
                case "element":
                    if (this._descendingSort)
                    {
                        dataProvider.sort(this.sortByElementName, Array.DESCENDING);
                    }
                    else
                    {
                        dataProvider.sort(this.sortByElementName);
                    };
                    break;
                case "parent":
                    if (this._descendingSort)
                    {
                        dataProvider.sort(this.sortByParentName, Array.DESCENDING);
                    }
                    else
                    {
                        dataProvider.sort(this.sortByParentName);
                    };
                    break;
            };
            return (dataProvider);
        }

        private function startTimer(duration:uint):void
        {
            this._timerHighLight = new Timer(duration);
            this._timerHighLight.addEventListener(TimerEvent.TIMER, this.onTimerEnd);
            this._timerHighLight.start();
            this._lastRenderStart = getTimer();
        }

        private function onTimerEnd(pEvent:TimerEvent):void
        {
            var timer:uint;
            if (this._timerHighLight)
            {
                timer = (getTimer() - this._lastRenderStart);
                this._timerHighLight.removeEventListener(TimerEvent.TIMER, this.onTimerEnd);
                this._timerHighLight = null;
                this.hintsApi.highLightSubhint(this._lastElementHighlighted, true);
            };
        }

        private function sortByOrder(firstSubhint:SubhintWrapper, secondSubhint:SubhintWrapper):Number
        {
            var firstName:String;
            var secondName:String;
            if (firstSubhint.hint_order > secondSubhint.hint_order)
            {
                return (1);
            };
            if (firstSubhint.hint_order < secondSubhint.hint_order)
            {
                return (-1);
            };
            firstName = this.utilApi.noAccent(firstSubhint.hint_parent_uid);
            secondName = this.utilApi.noAccent(secondSubhint.hint_parent_uid);
            if (firstName > secondName)
            {
                return (1);
            };
            if (firstName < secondName)
            {
                return (-1);
            };
            return (0);
        }

        private function sortByElementName(firstSubhint:SubhintWrapper, secondSubhint:SubhintWrapper):Number
        {
            var firstName:String = this.utilApi.noAccent(firstSubhint.hint_anchored_element);
            var secondName:String = this.utilApi.noAccent(secondSubhint.hint_anchored_element);
            if (firstName > secondName)
            {
                return (1);
            };
            if (firstName < secondName)
            {
                return (-1);
            };
            return (0);
        }

        private function sortByParentName(firstSubhint:SubhintWrapper, secondSubhint:SubhintWrapper):Number
        {
            var firstName:String = this.utilApi.noAccent(firstSubhint.hint_parent_uid);
            var secondName:String = this.utilApi.noAccent(secondSubhint.hint_parent_uid);
            if (firstName > secondName)
            {
                return (1);
            };
            if (firstName < secondName)
            {
                return (-1);
            };
            if (firstSubhint.hint_order > secondSubhint.hint_order)
            {
                return (1);
            };
            if (firstSubhint.hint_order < secondSubhint.hint_order)
            {
                return (-1);
            };
            return (0);
        }


    }
}

