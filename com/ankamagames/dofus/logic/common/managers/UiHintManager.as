package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.components.SubhintComponent;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.dofus.internalDatacenter.tutorial.SubhintWrapper;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import flash.geom.Rectangle;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.jerakine.types.DataStoreType;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.dofus.logic.game.common.managers.SubhintManager;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.managers.*;

    public class UiHintManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiHintManager));
        public static var currentTarget:UiRootContainer;
        public static var guidedAlreadyDone:Dictionary = new Dictionary();
        public static var specificGuidedAlreadyDone:Dictionary = new Dictionary();
        public static var subHints:Array = [];
        public static var firstTuto:Boolean;
        public static var nameId:String;
        private static var _allTargets:Array;
        private static var _shPreview:SubhintComponent;


        public static function get allTargets():Array
        {
            if (!_allTargets)
            {
                _allTargets = [];
            };
            return (_allTargets);
        }

        private static function myLocalToGlobal(point:Point, target:DisplayObject, lastContainerToLookAt:DisplayObject):Point
        {
            var coord:Point = point;
            while ((((target) && (!(target == lastContainerToLookAt))) && (target.parent)))
            {
                coord.x = (coord.x + target.parent.x);
                coord.y = (coord.y + target.parent.y);
                target = target.parent;
            };
            return (coord);
        }

        public static function getNameId(uiRoot:UiRootContainer, Id:String):String
        {
            if (uiRoot.parentUiRoot)
            {
                Id = ((uiRoot.parentUiRoot.uiData.name + "_") + Id);
                return (getNameId(uiRoot.parentUiRoot, Id));
            };
            return (Id);
        }

        public static function createSubHints(target:UiRootContainer, uiModule:UiModule, tab:String="", guidedTuto:Boolean=true):void
        {
            var baseRoot:UiRootContainer;
            var parentCont:GraphicContainer;
            var anchor:Point;
            var cont:GraphicContainer;
            var highlight:GraphicContainer;
            var uiRoot:UiRootContainer;
            var j:uint;
            var copyOfCurrentSubhintData:SubhintWrapper;
            var button:ButtonContainer;
            var sh:SubhintComponent;
            var root:GraphicContainer = target.getHintContainer();
            if (!root)
            {
                currentTarget = null;
                subHints = null;
                _allTargets = null;
                return;
            };
            subHints = [];
            if (tab != "")
            {
                nameId = getNameId(target, ((target.uiData.name + "_") + tab));
            }
            else
            {
                nameId = getNameId(target, target.uiData.name);
            };
            if (!_allTargets)
            {
                return;
            };
            baseRoot = _allTargets[0][0];
            if (baseRoot)
            {
                while (baseRoot.parentUiRoot)
                {
                    baseRoot = baseRoot.parentUiRoot;
                };
                parentCont = baseRoot.getHintContainer();
            };
            if (!parentCont)
            {
                return;
            };
            var rect:Rectangle;
            var index:uint;
            var i:uint;
            while (i < _allTargets.length)
            {
                uiRoot = _allTargets[i][0];
                if (((!(uiRoot)) || (_allTargets[i][1].length <= 0)))
                {
                    break;
                };
                root = uiRoot.getHintContainer();
                j = 0;
                while (j < _allTargets[i][1].length)
                {
                    index++;
                    cont = (uiRoot.getElement(_allTargets[i][1][j].hint_anchored_element) as GraphicContainer);
                    highlight = (uiRoot.getElement(_allTargets[i][1][j].hint_highlighted_element) as GraphicContainer);
                    if (((!(cont)) || (!(cont.visible))))
                    {
                        index--;
                    }
                    else
                    {
                        anchor = processAnchor(cont, _allTargets[i][1][j].hint_anchor);
                        if (highlight)
                        {
                            rect = new Rectangle((myLocalToGlobal(new Point(highlight.x, highlight.y), highlight, parentCont).x - parentCont.x), (myLocalToGlobal(new Point(highlight.x, highlight.y), highlight, parentCont).y - parentCont.y), highlight.width, highlight.height);
                        };
                        _allTargets[i][1][j].hint_tooltip_guided = ((guidedTuto) && (!(guidedAlreadyDone[nameId])));
                        copyOfCurrentSubhintData = (_allTargets[i][1][j] as SubhintWrapper).clone();
                        subHints.push(new SubhintComponent(index, copyOfCurrentSubhintData, uiModule, cont, copyOfCurrentSubhintData.hint_tooltip_guided, rect, (((myLocalToGlobal(new Point(cont.x, cont.y), cont, parentCont).x - parentCont.x) + anchor.x) + copyOfCurrentSubhintData.hint_position_x), (((myLocalToGlobal(new Point(cont.x, cont.y), cont, parentCont).y - parentCont.y) + anchor.y) + copyOfCurrentSubhintData.hint_position_y)));
                        parentCont.addChild(subHints[(subHints.length - 1)]);
                        rect = null;
                    };
                    j++;
                };
                i++;
            };
            if (subHints.length > 0)
            {
                currentTarget = target;
                button = (getHelpButton() as ButtonContainer);
                if (button)
                {
                    button.selected = true;
                };
                if (!guidedAlreadyDone[nameId])
                {
                    guidedAlreadyDone[nameId] = false;
                    if (subHints[0]._data.hint_tooltip_guided)
                    {
                        for each (sh in subHints)
                        {
                            sh.visible = false;
                        };
                        showNextSubHint(0);
                    }
                    else
                    {
                        disableUi(true, target);
                        for each (sh in subHints)
                        {
                            sh.visible = true;
                            sh.highLight(true);
                        };
                    };
                }
                else
                {
                    disableUi(true, target);
                    for each (sh in subHints)
                    {
                        sh.visible = true;
                        sh.highLight(true);
                    };
                };
                OptionManager.getOptionManager("dofus").setOption("resetUIHints", true);
            }
            else
            {
                _allTargets = null;
                subHints = null;
            };
        }

        public static function disableUi(disable:Boolean, target:UiRootContainer):void
        {
            var gc:GraphicContainer;
            var content:GraphicContainer;
            var uiRoot:UiRootContainer = target;
            while (uiRoot)
            {
                gc = uiRoot.getHintContainer();
                if (gc)
                {
                    content = uiRoot.getElement((gc.name + "_content"));
                    if (content)
                    {
                        content.disabledExceptHandCursor = disable;
                    }
                    else
                    {
                        gc.disabledExceptHandCursor = ((disable) && (uiRoot.parentUiRoot));
                    };
                };
                uiRoot = uiRoot.parentUiRoot;
            };
        }

        public static function processAnchor(target:GraphicContainer, location:uint):Point
        {
            var p:Point = new Point(0, 0);
            switch (location)
            {
                case LocationEnum.POINT_TOP:
                    p.x = (p.x + (target.width / 2));
                    break;
                case LocationEnum.POINT_TOPRIGHT:
                    p.x = (p.x + target.width);
                    break;
                case LocationEnum.POINT_LEFT:
                    p.y = (p.y + (target.height / 2));
                    break;
                case LocationEnum.POINT_CENTER:
                    p.x = (p.x + (target.width / 2));
                    p.y = (p.y + (target.height / 2));
                    break;
                case LocationEnum.POINT_RIGHT:
                    p.x = (p.x + target.width);
                    p.y = (p.y + (target.height / 2));
                    break;
                case LocationEnum.POINT_BOTTOMLEFT:
                    p.y = (p.y + target.height);
                    break;
                case LocationEnum.POINT_BOTTOM:
                    p.x = (p.x + (target.width / 2));
                    p.y = (p.y + target.height);
                    break;
                case LocationEnum.POINT_BOTTOMRIGHT:
                    p.x = (p.x + target.width);
                    p.y = (p.y + target.height);
                    break;
            };
            return (p);
        }

        public static function howManyGuidedAlreadyDone():int
        {
            var key:*;
            var n:int;
            for (key in guidedAlreadyDone)
            {
                n++;
            };
            return (n);
        }

        public static function reloadHintState():void
        {
            var hintsArray:Array;
            var values:Array;
            var keyValuePair:*;
            var stateText:String = StoreDataManager.getInstance().getData(new DataStoreType("AccountModule_HintsManager", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT), "uiHintsGuidedDone");
            if (((stateText) && (!(stateText == ""))))
            {
                hintsArray = stateText.split("$");
                values = [];
                for (keyValuePair in hintsArray)
                {
                    if (hintsArray[keyValuePair] != "")
                    {
                        values = (hintsArray[keyValuePair] as String).split("#");
                        guidedAlreadyDone[values[0]] = (values[1] == "true");
                    };
                };
            };
            stateText = StoreDataManager.getInstance().getData(new DataStoreType("AccountModule_HintsManager", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT), "specificUiHintsGuidedDone");
            if (((stateText) && (!(stateText == ""))))
            {
                hintsArray = stateText.split("$");
                values = [];
                for (keyValuePair in hintsArray)
                {
                    if (hintsArray[keyValuePair] != "")
                    {
                        values = (hintsArray[keyValuePair] as String).split("#");
                        specificGuidedAlreadyDone[values[0]] = (values[1] == "true");
                    };
                };
            };
            stateText = StoreDataManager.getInstance().getData(new DataStoreType("AccountModule_HintsManager", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT), "firstTimeSeeingSubhints");
            if (((!(stateText)) || (stateText == "")))
            {
                firstTuto = true;
            }
            else
            {
                firstTuto = (stateText == "true");
            };
        }

        public static function saveHintState():void
        {
            var name:*;
            var stateText:String = "";
            for (name in guidedAlreadyDone)
            {
                stateText = (stateText + (((name + "#") + guidedAlreadyDone[name]) + "$"));
            };
            StoreDataManager.getInstance().setData(new DataStoreType("AccountModule_HintsManager", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT), "uiHintsGuidedDone", stateText);
            stateText = "";
            for (name in specificGuidedAlreadyDone)
            {
                stateText = (stateText + (((name + "#") + specificGuidedAlreadyDone[name]) + "$"));
            };
            StoreDataManager.getInstance().setData(new DataStoreType("AccountModule_HintsManager", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT), "specificUiHintsGuidedDone", stateText);
            stateText = ((firstTuto) ? "true" : "false");
            StoreDataManager.getInstance().setData(new DataStoreType("AccountModule_HintsManager", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT), "firstTimeSeeingSubhints", stateText);
            OptionManager.getOptionManager("dofus").setOption("resetUIHints", true);
        }

        public static function resetHintState():void
        {
            var shortName:String;
            var name:String;
            skipHints();
            StoreDataManager.getInstance().setData(new DataStoreType("AccountModule_HintsManager", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT), "uiHintsGuidedDone", "");
            var stateText:String = "";
            for (name in SubhintManager.subhintDictionary)
            {
                shortName = name.split("_")[0];
                specificGuidedAlreadyDone[shortName] = false;
                stateText = (stateText + (((name + "#") + specificGuidedAlreadyDone[shortName]) + "$"));
            };
            StoreDataManager.getInstance().setData(new DataStoreType("AccountModule_HintsManager", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT), "specificUiHintsGuidedDone", stateText);
            StoreDataManager.getInstance().setData(new DataStoreType("AccountModule_HintsManager", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT), "firstTimeSeeingSubhints", "");
            guidedAlreadyDone = new Dictionary();
            firstTuto = true;
        }

        public static function getHelpButton(target:UiRootContainer=null):GraphicContainer
        {
            var ttTarget:GraphicContainer;
            var recursiveTarget:UiRootContainer = ((target) ? target : currentTarget);
            while (recursiveTarget)
            {
                ttTarget = recursiveTarget.getElement("btn_help");
                recursiveTarget = recursiveTarget.parentUiRoot;
            };
            return (ttTarget);
        }

        public static function skipHints():void
        {
            var sh:SubhintComponent;
            var i:uint;
            var ttData:Object;
            var ttTarget:GraphicContainer = getHelpButton();
            if (ttTarget)
            {
                (ttTarget as ButtonContainer).selected = false;
            };
            disableUi(false, currentTarget);
            if (TooltipManager.isVisible("end_tuto"))
            {
                TooltipManager.hide("end_tuto");
            };
            if ((((currentTarget) && (subHints)) && (subHints.length > 0)))
            {
                TooltipManager.hide("tuto_interface");
                guidedAlreadyDone[nameId] = true;
                i = 0;
                while (i < _allTargets.length)
                {
                    specificGuidedAlreadyDone[_allTargets[i][0].uiData.name] = true;
                    i++;
                };
                if (((subHints[0]._data.hint_tooltip_guided) && (firstTuto)))
                {
                    ttData = new Object();
                    ttData.hint_tooltip_text = I18n.getUiText("ui.uiTutorial.displayUiHints");
                    ttData.hint_tooltip_width = 300;
                    if (ttTarget)
                    {
                        firstTuto = false;
                        TooltipManager.show(ttData, ttTarget, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, "end_tuto", LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 3, true, "simpleInterfaceTuto", null, null, null, true, 4, 1, true, true);
                    };
                };
                saveHintState();
                for each (sh in subHints)
                {
                    sh.highLight(false);
                    sh.removeFromParent();
                };
                _allTargets = null;
                subHints = null;
            };
        }

        public static function closeHints(target:UiRootContainer=null):void
        {
            var sh:SubhintComponent;
            var button:ButtonContainer;
            if (!target)
            {
                target = currentTarget;
            };
            disableUi(false, currentTarget);
            if (TooltipManager.isVisible("end_tuto"))
            {
                TooltipManager.hide("end_tuto");
            };
            if ((((target == currentTarget) && (subHints)) && (subHints.length > 0)))
            {
                TooltipManager.hide("tuto_interface");
                for each (sh in subHints)
                {
                    sh.highLight(false);
                    sh.removeFromParent();
                };
                _allTargets = null;
                subHints = null;
                button = (UiHintManager.getHelpButton() as ButtonContainer);
                if (button)
                {
                    button.selected = false;
                };
            };
        }

        public static function showNextSubHint(order:int):void
        {
            if (subHints)
            {
                if (order < subHints.length)
                {
                    if (order > 0)
                    {
                        subHints[(order - 1)].visible = false;
                        subHints[(order - 1)].highLight(false);
                    };
                    subHints[order].visible = true;
                    subHints[order].showSubHint();
                    subHints[order].highLight(true);
                }
                else
                {
                    skipHints();
                };
            };
        }

        public static function closeEndTooltipHelp():void
        {
            TooltipManager.hide("end_tuto");
        }

        public static function subhintPreview(data:Object, target:UiRootContainer, uiModule:UiModule):void
        {
            var anchor:Point;
            var cont:GraphicContainer;
            var highlight:GraphicContainer;
            closeSubhintPreview();
            var root:GraphicContainer = target.getHintContainer();
            if (!root)
            {
                return;
            };
            var subhintWrapper:SubhintWrapper = SubhintWrapper.create(data);
            var rect:Rectangle;
            cont = (target.getElement(subhintWrapper.hint_anchored_element) as GraphicContainer);
            highlight = (target.getElement(subhintWrapper.hint_highlighted_element) as GraphicContainer);
            anchor = processAnchor(cont, subhintWrapper.hint_anchor);
            subhintWrapper.hint_tooltip_guided = data.hint_tooltip_guided;
            if (highlight)
            {
                rect = new Rectangle((myLocalToGlobal(new Point(highlight.x, highlight.y), highlight, root).x - root.x), (myLocalToGlobal(new Point(highlight.x, highlight.y), highlight, root).y - root.y), highlight.width, highlight.height);
            };
            _shPreview = new SubhintComponent(1, subhintWrapper, uiModule, cont, subhintWrapper.hint_tooltip_guided, rect, (((myLocalToGlobal(new Point(cont.x, cont.y), cont, root).x - root.x) + anchor.x) + subhintWrapper.hint_position_x), (((myLocalToGlobal(new Point(cont.x, cont.y), cont, root).y - root.y) + anchor.y) + subhintWrapper.hint_position_y));
            root.addChild(_shPreview);
            _shPreview.showSubHint(true);
            _shPreview.highLight(true);
        }

        public static function closeSubhintPreview():void
        {
            if (_shPreview)
            {
                TooltipManager.hide("tuto_interface");
                _shPreview.highLight(false);
                if (_shPreview.parent)
                {
                    _shPreview.parent.removeChild(_shPreview);
                };
                _shPreview = null;
            };
        }


    }
} com.ankamagames.dofus.logic.common.managers

