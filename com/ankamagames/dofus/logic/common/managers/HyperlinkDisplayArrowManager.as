package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.Berilia;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import flash.events.TimerEvent;
    import flash.geom.Point;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.jerakine.types.enums.DirectionsEnum;
    import flash.events.Event;
    import com.ankamagames.atouin.Atouin;

    public class HyperlinkDisplayArrowManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HyperlinkDisplayArrowManager));
        private static const ARROW_CLIP:Class = HyperlinkDisplayArrowManager_ARROW_CLIP;
        private static var _arrowClip:MovieClip;
        private static var _arrowStartX:int;
        private static var _arrowStartY:int;
        private static var _arrowStrata:int;
        private static var _arrowTimer:Timer;
        private static var _displayLastArrow:Boolean = false;
        private static var _lastArrowX:int;
        private static var _lastArrowY:int;
        private static var _lastArrowPos:int;
        private static var _lastStrata:int;
        private static var _lastReverse:int;
        private static var _arrowPositions:Dictionary = new Dictionary();
        private static var _arrowUiProperties:UiArrowProperties;


        public static function getArrowClip():MovieClip
        {
            return (_arrowClip);
        }

        public static function getArrowStartX():int
        {
            return (_arrowStartX);
        }

        public static function getArrowStartY():int
        {
            return (_arrowStartY);
        }

        public static function getArrowStrata():int
        {
            return (_arrowStrata);
        }

        public static function getArrowUiProperties():UiArrowProperties
        {
            return (_arrowUiProperties);
        }

        public static function showArrow(uiName:String, componentName:String, pos:int=0, reverse:int=0, strata:int=5, loop:int=0):MovieClip
        {
            var uirc:UiRootContainer;
            var components:Array;
            var displayObject:DisplayObject;
            var id:String;
            var rect:Rectangle;
            var gd:Grid;
            var i:int;
            var arrow:MovieClip = getArrow((loop == 1));
            _arrowStrata = strata;
            var container:DisplayObjectContainer = (Berilia.getInstance().docMain.getChildAt(strata) as DisplayObjectContainer);
            container.addChild(arrow);
            if (isNaN(Number(uiName)))
            {
                uirc = Berilia.getInstance().getUi(uiName);
                if (uirc)
                {
                    components = componentName.split("|");
                    displayObject = uirc.getElement(components[0]);
                    if (((displayObject) && (displayObject.visible)))
                    {
                        _arrowUiProperties = new UiArrowProperties(uiName, componentName, pos, reverse, strata, loop);
                        id = uiName;
                        if (components.length == 1)
                        {
                            rect = displayObject.getRect(container);
                            id = (id + ("_" + components[0]));
                        }
                        else
                        {
                            gd = (displayObject as Grid);
                            i = 0;
                            while (i < gd.dataProvider.length)
                            {
                                if ((((gd.dataProvider[i]) && (gd.dataProvider[i].hasOwnProperty(components[1]))) && (gd.dataProvider[i][components[1]] == components[2])))
                                {
                                    rect = (gd.slots[i] as DisplayObject).getRect(container);
                                    break;
                                };
                                i++;
                            };
                            if (!rect)
                            {
                                _log.error((((((("The arrow can't be displayed : no data with " + components[1]) + " = ") + components[2]) + " in ") + components[0]) + "."));
                                container.removeChild(arrow);
                                KernelEventsManager.getInstance().processCallback(HookList.DisplayUiArrow, _arrowUiProperties);
                                return (null);
                            };
                            KernelEventsManager.getInstance().processCallback(HookList.DisplayUiArrow, _arrowUiProperties);
                        };
                        if (_arrowPositions[id])
                        {
                            arrow.x = _arrowPositions[id].x;
                            arrow.y = _arrowPositions[id].y;
                        }
                        else
                        {
                            place(_arrowClip, rect, pos);
                        };
                        if (loop)
                        {
                            _arrowTimer = new Timer(20);
                            _arrowTimer.addEventListener(TimerEvent.TIMER, loopArrow);
                            _arrowTimer.start();
                        };
                    };
                };
            }
            else
            {
                return (showAbsoluteArrow(new Rectangle(int(uiName), int(componentName)), pos, reverse, strata, loop));
            };
            if (reverse == 1)
            {
                _arrowClip.scaleX = (_arrowClip.scaleX * -1);
            };
            if (loop)
            {
                _displayLastArrow = true;
                _lastArrowX = arrow.x;
                _lastArrowY = arrow.y;
                _lastArrowPos = pos;
                _lastStrata = strata;
                _lastReverse = _arrowClip.scaleX;
            };
            return (_arrowClip);
        }

        public static function showAbsoluteArrow(targetRect:Rectangle, pos:int=0, reverse:int=0, strata:int=5, loop:int=0):MovieClip
        {
            var arrow:MovieClip = getArrow((loop == 1));
            _arrowStrata = strata;
            DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt(strata)).addChild(arrow);
            place(arrow, targetRect, pos);
            if (reverse == 1)
            {
                _arrowClip.scaleX = (_arrowClip.scaleX * -1);
            };
            if (loop)
            {
                _displayLastArrow = true;
                _lastArrowX = arrow.x;
                _lastArrowY = arrow.y;
                _lastArrowPos = pos;
                _lastStrata = strata;
                _lastReverse = _arrowClip.scaleX;
            };
            return (arrow);
        }

        public static function setArrowPosition(pUiName:String, pComponentName:String, pPosition:Point):void
        {
            _arrowPositions[((pUiName + "_") + pComponentName)] = pPosition;
        }

        public static function showMapTransition(mapId:Number, shapeOrientation:int, position:int, reverse:int=0, strata:int=5, loop:int=0):MovieClip
        {
            var arrow:MovieClip;
            var x:uint;
            var y:uint;
            var orientation:uint;
            if (((mapId == -1) || (mapId == PlayedCharacterManager.getInstance().currentMap.mapId)))
            {
                arrow = getArrow((loop == 1));
                _arrowStrata = strata;
                DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt(strata)).addChild(arrow);
                switch (shapeOrientation)
                {
                    case DirectionsEnum.DOWN:
                        x = position;
                        y = 880;
                        orientation = 1;
                        break;
                    case DirectionsEnum.LEFT:
                        x = 0;
                        y = position;
                        orientation = 5;
                        break;
                    case DirectionsEnum.UP:
                        x = position;
                        y = 0;
                        orientation = 7;
                        break;
                    case DirectionsEnum.RIGHT:
                        x = 0x0500;
                        y = position;
                        orientation = 1;
                        break;
                };
                place(arrow, new Rectangle(x, y), orientation);
                if (reverse == 1)
                {
                    _arrowClip.scaleX = (_arrowClip.scaleX * -1);
                };
                if (loop)
                {
                    _displayLastArrow = true;
                    _lastArrowX = arrow.x;
                    _lastArrowY = arrow.y;
                    _lastArrowPos = orientation;
                    _lastStrata = strata;
                    _lastReverse = _arrowClip.scaleX;
                };
                return (arrow);
            };
            return (null);
        }

        public static function loopArrow(e:TimerEvent=null):void
        {
            var uirc:UiRootContainer;
            var components:Array;
            var displayObject:DisplayObject;
            var id:String;
            var rect:Rectangle;
            var gd:Grid;
            var i:int;
            if (e)
            {
                uirc = Berilia.getInstance().getUi(_arrowUiProperties.uiName);
                if (uirc)
                {
                    components = _arrowUiProperties.componentName.split("|");
                    displayObject = uirc.getElement(components[0]);
                    if (((displayObject) && (displayObject.visible)))
                    {
                        id = _arrowUiProperties.uiName;
                        if (components.length == 1)
                        {
                            rect = displayObject.getRect((_arrowClip.parent as DisplayObjectContainer));
                            id = (id + ("_" + components[0]));
                        }
                        else
                        {
                            gd = (displayObject as Grid);
                            i = 0;
                            while (i < gd.dataProvider.length)
                            {
                                if ((((gd.dataProvider[i]) && (gd.dataProvider[i].hasOwnProperty(components[1]))) && (gd.dataProvider[i][components[1]] == components[2])))
                                {
                                    rect = (gd.slots[i] as DisplayObject).getRect((_arrowClip.parent as DisplayObjectContainer));
                                    break;
                                };
                                i++;
                            };
                        };
                    };
                };
                place(_arrowClip, rect, _arrowUiProperties.pos);
                if (_arrowUiProperties.loop)
                {
                    _displayLastArrow = true;
                    _lastArrowX = _arrowClip.x;
                    _lastArrowY = _arrowClip.y;
                    _lastArrowPos = _arrowUiProperties.pos;
                    _lastStrata = _arrowUiProperties.strata;
                    _lastReverse = _arrowClip.scaleX;
                };
            };
        }

        public static function destroyArrow(e:Event=null):void
        {
            if (e)
            {
                e.currentTarget.removeEventListener(TimerEvent.TIMER, destroyArrow);
                if (_displayLastArrow)
                {
                    (Berilia.getInstance().docMain.getChildAt(_lastStrata) as DisplayObjectContainer).addChild(_arrowClip);
                    place(_arrowClip, new Rectangle(_lastArrowX, _lastArrowY), _lastArrowPos);
                    _arrowClip.scaleX = _lastReverse;
                    return;
                };
            }
            else
            {
                _displayLastArrow = false;
            };
            if (_arrowClip)
            {
                _arrowClip.gotoAndStop(1);
                if (_arrowClip.parent)
                {
                    _arrowClip.parent.removeChild(_arrowClip);
                };
            };
            if (((((_arrowUiProperties) && (_arrowUiProperties.loop)) && (_arrowTimer)) && (_arrowTimer.hasEventListener(TimerEvent.TIMER))))
            {
                _arrowTimer.removeEventListener(TimerEvent.TIMER, loopArrow);
            };
            if (_arrowTimer)
            {
                _arrowTimer.reset();
                _arrowTimer = null;
            };
            _arrowUiProperties = null;
        }

        private static function getArrow(loop:Boolean=false):MovieClip
        {
            if (_arrowClip)
            {
                _arrowClip.gotoAndPlay(1);
            }
            else
            {
                _arrowClip = (new ARROW_CLIP() as MovieClip);
                _arrowClip.mouseEnabled = false;
                _arrowClip.mouseChildren = false;
            };
            if (loop)
            {
                if (_arrowTimer)
                {
                    _arrowTimer.reset();
                    _arrowTimer = null;
                };
            }
            else
            {
                if (_arrowTimer)
                {
                    _arrowTimer.reset();
                }
                else
                {
                    _arrowTimer = new Timer(5000, 1);
                    _arrowTimer.addEventListener(TimerEvent.TIMER, destroyArrow);
                };
                _arrowTimer.start();
            };
            return (_arrowClip);
        }

        public static function place(arrow:MovieClip, rect:Rectangle, pos:int):void
        {
            var newPos:Point;
            if (rect)
            {
                if (pos == 0)
                {
                    arrow.scaleX = 1;
                    arrow.scaleY = 1;
                    arrow.x = int(rect.x);
                    arrow.y = int(rect.y);
                }
                else
                {
                    if (pos == 1)
                    {
                        arrow.scaleX = 1;
                        arrow.scaleY = 1;
                        arrow.x = int((rect.x + (rect.width / 2)));
                        arrow.y = int(rect.y);
                    }
                    else
                    {
                        if (pos == 2)
                        {
                            arrow.scaleX = -1;
                            arrow.scaleY = 1;
                            arrow.x = int((rect.x + rect.width));
                            arrow.y = int(rect.y);
                        }
                        else
                        {
                            if (pos == 3)
                            {
                                arrow.scaleX = 1;
                                arrow.scaleY = 1;
                                arrow.x = int(rect.x);
                                arrow.y = int((rect.y + (rect.height / 2)));
                            }
                            else
                            {
                                if (pos == 4)
                                {
                                    arrow.scaleX = 1;
                                    arrow.scaleY = 1;
                                    arrow.x = int((rect.x + (rect.width / 2)));
                                    arrow.y = int((rect.y + (rect.height / 2)));
                                }
                                else
                                {
                                    if (pos == 5)
                                    {
                                        arrow.scaleX = -1;
                                        arrow.scaleY = 1;
                                        arrow.x = int((rect.x + rect.width));
                                        arrow.y = int((rect.y + (rect.height / 2)));
                                    }
                                    else
                                    {
                                        if (pos == 6)
                                        {
                                            arrow.scaleX = 1;
                                            arrow.scaleY = -1;
                                            arrow.x = int(rect.x);
                                            arrow.y = int((rect.y + rect.height));
                                        }
                                        else
                                        {
                                            if (pos == 7)
                                            {
                                                arrow.scaleX = 1;
                                                arrow.scaleY = -1;
                                                arrow.x = int((rect.x + (rect.width / 2)));
                                                arrow.y = int((rect.y + rect.height));
                                            }
                                            else
                                            {
                                                if (pos == 8)
                                                {
                                                    arrow.scaleY = -1;
                                                    arrow.scaleX = -1;
                                                    arrow.x = int((rect.x + rect.width));
                                                    arrow.y = int((rect.y + rect.height));
                                                }
                                                else
                                                {
                                                    arrow.scaleX = 1;
                                                    arrow.scaleY = 1;
                                                    arrow.x = int(rect.x);
                                                    arrow.y = int(rect.y);
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                _arrowStartX = arrow.x;
                _arrowStartY = arrow.y;
                if (_arrowStrata != 5)
                {
                    newPos = Atouin.getInstance().rootContainer.localToGlobal(new Point(_arrowStartX, _arrowStartY));
                    arrow.x = newPos.x;
                    arrow.y = newPos.y;
                };
            };
        }


    }
} com.ankamagames.dofus.logic.common.managers

class UiArrowProperties 
{

    public var uiName:String;
    public var componentName:String;
    public var pos:int;
    public var reverse:int;
    public var strata:int;
    public var loop:int;

    public function UiArrowProperties(pUiName:String, pComponentName:String, pPos:int, pReverse:int, pStrata:int, pLoop:int)
    {
        this.uiName = pUiName;
        this.componentName = pComponentName;
        this.pos = pPos;
        this.reverse = pReverse;
        this.strata = pStrata;
        this.loop = pLoop;
    }

}


