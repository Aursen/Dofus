package com.ankamagames.berilia.types.tooltip
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.jerakine.utils.display.Rectangle2;
    import flash.geom.Point;
    import flash.display.Sprite;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import flash.geom.Rectangle;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import com.ankamagames.jerakine.pools.PoolsManager;
    import com.ankamagames.jerakine.pools.PoolablePoint;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.jerakine.data.XmlConfig;
    import flash.display.DisplayObject;
    import com.ankamagames.jerakine.interfaces.IRectangle;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.berilia.types.event.UiRenderEvent;
    import flash.events.Event;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.types.tooltip.event.TooltipEvent;
    import __AS3__.vec.*;

    public class TooltipPlacer 
    {

        protected static var _log:Logger = Log.getLogger(getQualifiedClassName(TooltipPlacer));
        private static var _tooltips:Vector.<TooltipPosition> = new Vector.<TooltipPosition>(0);
        private static var _tooltipsRows:Dictionary = new Dictionary();
        private static var _tooltipsToWait:Vector.<String> = new Vector.<String>(0);
        public static var isMapZoomed:Boolean = false;
        public static var isInFight:Boolean = false;
        private static const _anchors:Array = [];
        private static var _init:Boolean;


        private static function init():void
        {
            var pt1:uint;
            var pt2:uint;
            if (_init)
            {
                return;
            };
            _init = true;
            var config:Array = [LocationEnum.POINT_TOPLEFT, LocationEnum.POINT_TOP, LocationEnum.POINT_TOPRIGHT, LocationEnum.POINT_LEFT, LocationEnum.POINT_CENTER, LocationEnum.POINT_RIGHT, LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_BOTTOMRIGHT];
            for each (pt1 in config)
            {
                for each (pt2 in config)
                {
                    _anchors.push({
                        "p1":pt1,
                        "p2":pt2
                    });
                };
            };
        }

        private static function getAnchors():Array
        {
            init();
            return (_anchors.concat());
        }

        public static function place(tooltip:DisplayObject, target:IRectangle, showDirectionalArrowInfo:Object, point:uint=6, relativePoint:uint=0, offset:*=3, alwaysDisplayed:Boolean=true):void
        {
            var showDirectionalArrow:Boolean;
            var hackIRectangle:Rectangle2;
            var offsetPt:Point;
            var tooltipZone:Rectangle2;
            var hitZoneSize:int;
            var newPt:Object;
            var smallerZone:Object;
            var obj:Object;
            var arrowInfos:Object;
            var arrow:Sprite;
            if ((tooltip as GraphicContainer).getChildByName("tooltipArrow"))
            {
                (tooltip as GraphicContainer).removeChild((tooltip as GraphicContainer).getChildByName("tooltipArrow"));
            };
            var ok:Boolean;
            var ttBounds:Rectangle = tooltip.getBounds(tooltip);
            var truePoint:uint = point;
            var trueRelativePoint:uint = relativePoint;
            var lastTurn:Boolean;
            if (showDirectionalArrowInfo.hasOwnProperty("showDirectionalArrow"))
            {
                showDirectionalArrow = showDirectionalArrowInfo.showDirectionalArrow;
            }
            else
            {
                showDirectionalArrow = showDirectionalArrowInfo;
            };
            var anchors:Array = getAnchors();
            var hitZones:Array = new Array();
            var screenBounds:Rectangle = StageShareManager.stageVisibleBounds;
            var pTarget:PoolablePoint = (PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint);
            var pTooltip:PoolablePoint = (PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint);
            while ((!(ok)))
            {
                pTarget.renew(target.x, target.y);
                pTooltip.renew(tooltip.x, tooltip.y);
                hackIRectangle = new Rectangle2(tooltip.x, tooltip.y, (tooltip as UiRootContainer).contentWidth, (tooltip as UiRootContainer).contentHeight);
                processAnchor(pTooltip, hackIRectangle, point);
                processAnchor(pTarget, target, relativePoint);
                offsetPt = makeOffset(point, offset);
                pTarget.x = (pTarget.x - ((pTooltip.x - offsetPt.x) + (ttBounds.left * (tooltip as UiRootContainer).scale)));
                pTarget.y = (pTarget.y - (pTooltip.y - offsetPt.y));
                tooltipZone = new Rectangle2(pTarget.x, pTarget.y, hackIRectangle.width, hackIRectangle.height);
                if (alwaysDisplayed)
                {
                    if (tooltipZone.y < screenBounds.top)
                    {
                        tooltipZone.y = screenBounds.top;
                    };
                    if (tooltipZone.x < screenBounds.left)
                    {
                        tooltipZone.x = screenBounds.left;
                    };
                    if ((tooltipZone.y + tooltipZone.height) > screenBounds.bottom)
                    {
                        tooltipZone.y = (tooltipZone.y - ((tooltipZone.height + tooltipZone.y) - screenBounds.bottom));
                    };
                    if ((tooltipZone.x + tooltipZone.width) > screenBounds.right)
                    {
                        tooltipZone.x = (tooltipZone.x - ((tooltipZone.width + tooltipZone.x) - screenBounds.right));
                    };
                };
                if (!lastTurn)
                {
                    hitZoneSize = hitTest(tooltipZone, target);
                    ok = (hitZoneSize == 0);
                    if (!ok)
                    {
                        newPt = anchors.shift();
                        if (!newPt)
                        {
                            smallerZone = {
                                "size":(target.width * target.height),
                                "point":{
                                    "p1":truePoint,
                                    "p2":trueRelativePoint
                                }
                            };
                            for each (obj in hitZones)
                            {
                                if (smallerZone.size > obj.size)
                                {
                                    smallerZone = obj;
                                };
                            };
                            lastTurn = true;
                            point = smallerZone.point.p1;
                            relativePoint = smallerZone.point.p2;
                        }
                        else
                        {
                            hitZones.push({
                                "size":hitZoneSize,
                                "point":{
                                    "p1":point,
                                    "p2":relativePoint
                                }
                            });
                            point = newPt.p1;
                            relativePoint = newPt.p2;
                        };
                    };
                }
                else
                {
                    ok = true;
                };
            };
            PoolsManager.getInstance().getPointPool().checkIn(pTarget);
            PoolsManager.getInstance().getPointPool().checkIn(pTooltip);
            tooltip.x = tooltipZone.x;
            tooltip.y = tooltipZone.y;
            if (showDirectionalArrow)
            {
                arrowInfos = DrawArrow(tooltip, target, showDirectionalArrowInfo, relativePoint, offset);
                arrow = new Sprite();
                arrow.name = "tooltipArrow";
                arrow.graphics.clear();
                arrow.graphics.lineStyle(0.1, 0xFFFFFF, 0);
                arrow.graphics.beginFill(XmlConfig.getInstance().getEntry("colors.tooltip.bg"), XmlConfig.getInstance().getEntry("colors.tooltip.bg.alpha"));
                arrow.graphics.drawTriangles(Vector.<Number>([arrowInfos.firstPoint.x, arrowInfos.firstPoint.y, arrowInfos.secondPoint.x, arrowInfos.secondPoint.y, arrowInfos.thirdPoint.x, arrowInfos.thirdPoint.y]));
                arrow.graphics.endFill();
                (tooltip as GraphicContainer).addChild(arrow);
            };
        }

        public static function DrawArrow(tooltip:DisplayObject, target:IRectangle, showDirectionalArrowInfo:Object, relativePoint:uint, offset:*):Object
        {
            var tooltipOffset:Point = new Point();
            var backgroundAnchors:Point = new Point();
            if (showDirectionalArrowInfo.hasOwnProperty("anchors"))
            {
                backgroundAnchors = showDirectionalArrowInfo.anchors;
            };
            if ((offset is int))
            {
                tooltipOffset = new Point(offset, offset);
            }
            else
            {
                tooltipOffset = offset;
            };
            var infos:Object = {
                "firstPoint":new Point(),
                "secondPoint":new Point(),
                "thirdPoint":new Point()
            };
            var diffX:int = int(((target.x + (target.width / 2)) - tooltip.x));
            if (tooltip.x < (target.x + (target.width / 2)))
            {
                if (diffX >= tooltip.width)
                {
                    infos.firstPoint = new Point(((tooltip.width - 3) - backgroundAnchors.x), Math.max(0, Math.min((((target.y + (target.height / 2)) - tooltip.y) - 10), (tooltip.height - 10))));
                    infos.secondPoint = new Point(((tooltip.width + Math.max(10, Math.min(tooltipOffset.x, 20))) - backgroundAnchors.x), Math.max(-10, Math.min(((target.y + (target.height / 2)) - tooltip.y), (tooltip.height + 10))));
                    infos.thirdPoint = new Point(((tooltip.width - 3) - backgroundAnchors.x), Math.max(10, Math.min((((target.y + (target.height / 2)) - tooltip.y) + 10), tooltip.height)));
                }
                else
                {
                    if (tooltip.y < target.y)
                    {
                        infos.firstPoint = new Point(Math.max(0, Math.min((((target.x + (target.width / 2)) - tooltip.x) - 10), (tooltip.width - 10))), ((tooltip.height - 3) + backgroundAnchors.y));
                        infos.secondPoint = new Point(Math.max(0, Math.min(((target.x + (target.width / 2)) - tooltip.x), (tooltip.width + 10))), ((tooltip.height + Math.max(10, Math.min(tooltipOffset.y, 20))) + backgroundAnchors.y));
                        infos.thirdPoint = new Point(Math.max(10, Math.min((((target.x + (target.width / 2)) - tooltip.x) + 10), tooltip.width)), ((tooltip.height - 3) + backgroundAnchors.y));
                    }
                    else
                    {
                        infos.firstPoint = new Point(Math.max(0, Math.min((((target.x + (target.width / 2)) - tooltip.x) - 10), (tooltip.width - 10))), (3 + backgroundAnchors.y));
                        infos.secondPoint = new Point(Math.max(0, Math.min(((target.x + (target.width / 2)) - tooltip.x), (tooltip.width + 10))), (-(Math.max(10, Math.min(tooltipOffset.y, 20))) + backgroundAnchors.y));
                        infos.thirdPoint = new Point(Math.max(10, Math.min((((target.x + (target.width / 2)) - tooltip.x) + 10), tooltip.width)), (3 + backgroundAnchors.y));
                    };
                };
            }
            else
            {
                if (tooltip.x >= target.x)
                {
                    infos.firstPoint = new Point((3 + backgroundAnchors.x), Math.max(0, Math.min((((target.y + (target.height / 2)) - tooltip.y) - 10), (tooltip.height - 10))));
                    infos.secondPoint = new Point((-(Math.max(10, Math.min(tooltipOffset.x, 20))) + backgroundAnchors.x), Math.max(-10, Math.min((((target.y + (target.height / 2)) - tooltip.y) + backgroundAnchors.y), (tooltip.height + 10))));
                    infos.thirdPoint = new Point((3 + backgroundAnchors.x), Math.max(10, Math.min((((target.y + (target.height / 2)) - tooltip.y) + 10), tooltip.height)));
                };
            };
            return (infos);
        }

        public static function placeWithArrow(tooltip:DisplayObject, target:IRectangle):Object
        {
            var pTooltip:Point = new Point(tooltip.x, tooltip.y);
            var info:Object = {
                "bottomFlip":false,
                "leftFlip":false
            };
            pTooltip.x = ((target.x + (target.width / 2)) + 5);
            pTooltip.y = (target.y - tooltip.height);
            if ((pTooltip.x + tooltip.width) > StageShareManager.startWidth)
            {
                info.leftFlip = true;
                pTooltip.x = (pTooltip.x - (tooltip.width + 10));
            };
            if (pTooltip.y < 0)
            {
                info.bottomFlip = true;
                pTooltip.y = (target.y + target.height);
            };
            tooltip.x = pTooltip.x;
            tooltip.y = pTooltip.y;
            return (info);
        }

        public static function waitBeforeOrder(pTooltipId:String):void
        {
            if (_tooltipsToWait.indexOf(pTooltipId) == -1)
            {
                _tooltipsToWait.push(pTooltipId);
            };
        }

        public static function addTooltipPosition(pTooltip:*, pTarget:IRectangle, pCellId:uint, pOffsetRect:IRectangle=null):void
        {
            var i:int;
            var nbTooltips:int = _tooltips.length;
            var exists:Boolean;
            var tooltipName:String = TooltipManager.getTooltipName(pTooltip);
            if (!tooltipName)
            {
                tooltipName = pTooltip.customUnicName;
            };
            i = 0;
            while (i < nbTooltips)
            {
                if (_tooltips[i].tooltip == pTooltip)
                {
                    exists = true;
                    _tooltips.splice(i, 1, new TooltipPosition(pTooltip, pTarget, pCellId, pOffsetRect));
                    break;
                };
                i++;
            };
            if (!exists)
            {
                _tooltips.push(new TooltipPosition(pTooltip, pTarget, pCellId, pOffsetRect));
            };
            var tIndex:int = _tooltipsToWait.indexOf(tooltipName);
            if (tIndex != -1)
            {
                _tooltipsToWait.splice(tIndex, 1);
            };
            if (_tooltipsToWait.length == 0)
            {
                checkRender();
            };
        }

        public static function checkRender(pEvent:Event=null):void
        {
            var tp:TooltipPosition;
            if (pEvent)
            {
                pEvent.currentTarget.removeEventListener(UiRenderEvent.UIRenderComplete, checkRender);
            };
            for each (tp in _tooltips)
            {
                if (!tp.tooltip.ready)
                {
                    tp.tooltip.addEventListener(UiRenderEvent.UIRenderComplete, checkRender);
                    return;
                };
            };
            orderTooltips();
        }

        public static function removeTooltipPosition(pTooltip:UiRootContainer):void
        {
            var tp:TooltipPosition;
            var tIndexWait:int;
            var tIndex:int = -1;
            for each (tp in _tooltips)
            {
                if (tp.tooltip == pTooltip)
                {
                    tIndex = _tooltips.indexOf(tp);
                    break;
                };
            };
            if (tIndex != -1)
            {
                _tooltips.splice(tIndex, 1);
            };
            var uiName:String = TooltipManager.getTooltipName(pTooltip);
            tIndexWait = _tooltipsToWait.indexOf(uiName);
            if (tIndexWait != -1)
            {
                _tooltipsToWait.splice(tIndexWait, 1);
            };
        }

        public static function removeTooltipPositionByName(pTooltipName:String):void
        {
            var tp:TooltipPosition;
            var tIndexWait:int;
            var tIndex:int = -1;
            for each (tp in _tooltips)
            {
                if (tp.tooltip.customUnicName == pTooltipName)
                {
                    tIndex = _tooltips.indexOf(tp);
                    break;
                };
            };
            if (tIndex != -1)
            {
                _tooltips.splice(tIndex, 1);
            };
            tIndexWait = _tooltipsToWait.indexOf(pTooltipName);
            if (tIndexWait != -1)
            {
                _tooltipsToWait.splice(tIndexWait, 1);
            };
        }

        private static function orderTooltips():void
        {
            var i:int;
            var j:int;
            var tooltipPosition:TooltipPosition;
            var tooltipPositions:Vector.<TooltipPosition>;
            var centerX:Number;
            var rowWidth:Number;
            var rowLen:int;
            var currentTooltipRow:int;
            var ok:Boolean;
            var newY:Number;
            var addToRow:Boolean;
            var prevX:Number;
            var offScreenX:Boolean;
            var tooltipHeight:Number;
            var tooltipY:Number;
            var row:Object;
            var len:int = _tooltips.length;
            var minX:Number = 0;
            var minTooltipY:Number = 0;
            var maxX:Number = 0;
            _tooltips.sort(compareVerticalPos);
            i = (len - 1);
            while (i >= 0)
            {
                currentTooltipRow = _tooltips[i].mapRow;
                if (!_tooltipsRows[currentTooltipRow])
                {
                    _tooltipsRows[currentTooltipRow] = new Vector.<TooltipPosition>(0);
                };
                tooltipPositions = isTooltipSuperposed(_tooltips[i]);
                addToRow = false;
                for each (tooltipPosition in tooltipPositions)
                {
                    if (((tooltipPosition.mapRow == currentTooltipRow) && (!(tooltipPosition.tooltip.customUnicName == _tooltips[i].tooltip.customUnicName))))
                    {
                        addToRow = true;
                        break;
                    };
                };
                if (addToRow)
                {
                    _tooltipsRows[currentTooltipRow].push(_tooltips[i]);
                };
                if ((i + 1) < len)
                {
                    rowLen = _tooltipsRows[currentTooltipRow].length;
                    if (rowLen > 1)
                    {
                        rowWidth = 0;
                        minX = 0;
                        maxX = 0;
                        minTooltipY = 0;
                        for each (tooltipPosition in _tooltipsRows[currentTooltipRow])
                        {
                            tooltipY = ((tooltipPosition.offsetRect) ? (tooltipPosition.y - tooltipPosition.offsetRect.y) : tooltipPosition.y);
                            if (((minTooltipY == 0) || (tooltipY < minTooltipY)))
                            {
                                minTooltipY = tooltipY;
                            };
                        };
                        j = (i + 1);
                        while (j < len)
                        {
                            tooltipY = ((_tooltips[j].offsetRect) ? (_tooltips[j].y - _tooltips[j].offsetRect.y) : _tooltips[j].y);
                            tooltipHeight = ((_tooltips[i].offsetRect) ? (_tooltips[i].height - _tooltips[i].offsetRect.height) : _tooltips[i].height);
                            if (((!(_tooltips[j].mapRow == currentTooltipRow)) && (minTooltipY > ((tooltipY - tooltipHeight) - 2))))
                            {
                                minTooltipY = ((tooltipY - tooltipHeight) - 2);
                                break;
                            };
                            j++;
                        };
                        minX = (maxX = _tooltips[i].target.x);
                        for each (tooltipPosition in _tooltipsRows[currentTooltipRow])
                        {
                            tooltipPosition.y = Math.max(0, minTooltipY);
                            if (tooltipPosition.target.x < minX)
                            {
                                minX = tooltipPosition.target.x;
                            }
                            else
                            {
                                if (tooltipPosition.target.x > maxX)
                                {
                                    maxX = tooltipPosition.target.x;
                                };
                            };
                            rowWidth = (rowWidth + tooltipPosition.width);
                        };
                        _tooltipsRows[currentTooltipRow].sort(compareHorizontalPos);
                        rowWidth = (rowWidth + (2 * (rowLen - 1)));
                        centerX = ((maxX + minX) / 2);
                        _tooltipsRows[currentTooltipRow][0].tooltip.x = ((centerX + 43) - (rowWidth / 2));
                        j = 1;
                        while (j < rowLen)
                        {
                            _tooltipsRows[currentTooltipRow][j].tooltip.x = ((_tooltipsRows[currentTooltipRow][(j - 1)].tooltip.x + _tooltipsRows[currentTooltipRow][(j - 1)].tooltip.width) + 2);
                            j++;
                        };
                    }
                    else
                    {
                        ok = false;
                        while ((!(ok)))
                        {
                            j = (i + 1);
                            while (j < len)
                            {
                                ok = true;
                                if (hitTest(_tooltips[i].rect, _tooltips[j].rect) != 0)
                                {
                                    ok = false;
                                    tooltipHeight = ((_tooltips[i].offsetRect) ? (_tooltips[i].height - _tooltips[i].offsetRect.height) : _tooltips[i].height);
                                    newY = ((_tooltips[j].y - tooltipHeight) - 2);
                                    if (newY < 0)
                                    {
                                        _tooltips[i].y = 0;
                                        tooltipPosition = _tooltips[j];
                                        prevX = _tooltips[i].x;
                                        if (_tooltips[i].originalX < tooltipPosition.originalX)
                                        {
                                            _tooltips[i].x = ((tooltipPosition.x - _tooltips[i].width) - 2);
                                        }
                                        else
                                        {
                                            _tooltips[i].x = ((tooltipPosition.x + tooltipPosition.width) + 2);
                                        };
                                        offScreenX = ((_tooltips[i].x < 0) || (((_tooltips[i].x + _tooltips[i].width) + 2) > StageShareManager.stage.stageWidth));
                                        if (!isInFight)
                                        {
                                            if (((!(isMapZoomed)) && ((offScreenX) || (isTooltipSuperposed(_tooltips[i])))))
                                            {
                                                _tooltips[i].x = prevX;
                                                ok = true;
                                            }
                                            else
                                            {
                                                if (((offScreenX) || (isTooltipSuperposed(_tooltips[i]))))
                                                {
                                                    _tooltips[i].x = prevX;
                                                    _tooltips[i].y = newY;
                                                };
                                            };
                                        }
                                        else
                                        {
                                            if (((offScreenX) || (isTooltipSuperposed(_tooltips[i]))))
                                            {
                                                _tooltips[i].x = prevX;
                                                _tooltips[i].y = newY;
                                            };
                                        };
                                    }
                                    else
                                    {
                                        _tooltips[i].y = newY;
                                    };
                                    break;
                                };
                                j++;
                            };
                        };
                    };
                };
                i--;
            };
            for (row in _tooltipsRows)
            {
                delete _tooltipsRows[row];
            };
            Berilia.getInstance().dispatchEvent(new TooltipEvent(TooltipEvent.TOOLTIPS_ORDERED));
        }

        private static function isTooltipSuperposed(pTooltipPosition:TooltipPosition):Vector.<TooltipPosition>
        {
            var tooltipPosition:TooltipPosition;
            var tooltipPositionsInCollision:Vector.<TooltipPosition>;
            for each (tooltipPosition in _tooltips)
            {
                if (((!(tooltipPosition == pTooltipPosition)) && (!(hitTest(tooltipPosition.rect, pTooltipPosition.rect) == 0))))
                {
                    if (!tooltipPositionsInCollision)
                    {
                        tooltipPositionsInCollision = new Vector.<TooltipPosition>(0);
                    };
                    tooltipPositionsInCollision.push(tooltipPosition);
                };
            };
            return (tooltipPositionsInCollision);
        }

        private static function compareVerticalPos(pTooltipPosA:TooltipPosition, pTooltipPosB:TooltipPosition):int
        {
            var result:int;
            if (pTooltipPosA.mapRow > pTooltipPosB.mapRow)
            {
                result = 1;
            }
            else
            {
                if (pTooltipPosA.mapRow < pTooltipPosB.mapRow)
                {
                    result = -1;
                }
                else
                {
                    result = 0;
                };
            };
            return (result);
        }

        private static function compareHorizontalPos(pTooltipPosA:TooltipPosition, pTooltipPosB:TooltipPosition):int
        {
            var result:int;
            if (pTooltipPosA.tooltip.x > pTooltipPosB.tooltip.x)
            {
                result = 1;
            }
            else
            {
                if (pTooltipPosA.tooltip.x < pTooltipPosB.tooltip.x)
                {
                    result = -1;
                }
                else
                {
                    result = 0;
                };
            };
            return (result);
        }

        private static function hitTest(item:IRectangle, zone:IRectangle):int
        {
            var r1:Rectangle = new Rectangle(item.x, item.y, item.width, item.height);
            var r2:Rectangle = new Rectangle(zone.x, zone.y, zone.width, zone.height);
            var r3:Rectangle = r1.intersection(r2);
            return (r3.width * r3.height);
        }

        private static function processAnchor(p:Point, target:IRectangle, location:uint):Point
        {
            switch (location)
            {
                case LocationEnum.POINT_TOPLEFT:
                    break;
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

        private static function makeOffset(point:uint, offset:*):Point
        {
            var offsetPt:Point = new Point();
            switch (point)
            {
                case LocationEnum.POINT_TOPLEFT:
                case LocationEnum.POINT_BOTTOMLEFT:
                case LocationEnum.POINT_LEFT:
                    if ((offset is int))
                    {
                        offsetPt.x = offset;
                    }
                    else
                    {
                        if ((offset is Point))
                        {
                            offsetPt.x = offset.x;
                        };
                    };
                    break;
                case LocationEnum.POINT_BOTTOMRIGHT:
                case LocationEnum.POINT_TOPRIGHT:
                case LocationEnum.POINT_RIGHT:
                    if ((offset is int))
                    {
                        offsetPt.x = -(offset);
                    }
                    else
                    {
                        if ((offset is Point))
                        {
                            offsetPt.x = -(offset.x);
                        };
                    };
                    break;
            };
            switch (point)
            {
                case LocationEnum.POINT_TOPLEFT:
                case LocationEnum.POINT_TOP:
                case LocationEnum.POINT_TOPRIGHT:
                    if ((offset is int))
                    {
                        offsetPt.y = offset;
                    }
                    else
                    {
                        if ((offset is Point))
                        {
                            offsetPt.y = offset.y;
                        };
                    };
                    break;
                case LocationEnum.POINT_BOTTOMLEFT:
                case LocationEnum.POINT_BOTTOMRIGHT:
                case LocationEnum.POINT_BOTTOM:
                    if ((offset is int))
                    {
                        offsetPt.y = -(offset);
                    }
                    else
                    {
                        if ((offset is Point))
                        {
                            offsetPt.y = -(offset.y);
                        };
                    };
                    break;
            };
            return (offsetPt);
        }


    }
} com.ankamagames.berilia.types.tooltip

