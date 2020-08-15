package flashx.textLayout.elements
{
    import flash.utils.Dictionary;
    import flash.geom.Rectangle;
    import flashx.textLayout.compose.IFlowComposer;
    import __AS3__.vec.Vector;
    import flashx.textLayout.tlf_internal;
    import flashx.textLayout.compose.TextFlowTableBlock;
    import flashx.textLayout.container.ContainerController;
    import flash.text.engine.TextBlock;
    import flashx.textLayout.compose.TextFlowLine;
    import flash.text.engine.TextLine;
    import flashx.textLayout.container.TextContainerManager;
    import flashx.textLayout.compose.StandardFlowComposer;
    import flashx.textLayout.factory.FactoryDisplayComposer;
    import flashx.textLayout.compose.ParcelList;
    import flashx.textLayout.formats.ITextLayoutFormat;
    import flashx.textLayout.formats.BackgroundColor;
    import flashx.textLayout.formats.BorderColor;
    import flash.display.Graphics;
    import flash.display.CapsStyle;
    import flash.display.Shape;
    import flash.display.Sprite;

    use namespace tlf_internal;

    public class BackgroundManager 
    {

        public static var BACKGROUND_MANAGER_CACHE:Dictionary = null;
        public static var TOP_EXCLUDED:String = "topExcluded";
        public static var BOTTOM_EXCLUDED:String = "bottomExcluded";
        public static var TOP_AND_BOTTOM_EXCLUDED:String = "topAndBottomExcluded";

        protected var _lineDict:Dictionary;
        protected var _blockElementDict:Dictionary;
        protected var _rectArray:Array;

        public function BackgroundManager()
        {
            this._lineDict = new Dictionary(true);
            this._blockElementDict = new Dictionary(true);
            this._rectArray = new Array();
        }

        public static function collectTableBlock(_textFlow:TextFlow, block:TextFlowTableBlock, controller:ContainerController):void
        {
            var bb:BackgroundManager;
            var r:Rectangle;
            var composer:IFlowComposer;
            var cell:TableCellElement;
            var row:TableRowElement;
            var cells:Vector.<TableCellElement> = block.getTableCells();
            for each (cell in cells)
            {
                if (BackgroundManager.hasBorderOrBackground(cell))
                {
                    if (!_textFlow.backgroundManager)
                    {
                        _textFlow.getBackgroundManager();
                    };
                    bb = _textFlow.backgroundManager;
                    bb.addBlockElement(cell);
                    row = cell.getRow();
                    r = new Rectangle(cell.x, (cell.y + block.y), cell.width, row.composedHeight);
                    bb.addBlockRect(cell, r, controller);
                };
            };
            block.y;
        }

        public static function collectBlock(_textFlow:TextFlow, elem:FlowGroupElement, _parcelList:ParcelList=null, tableComposeNotFromBeginning:Boolean=false, tableOutOfView:Boolean=false):void
        {
            var bb:BackgroundManager;
            var r:Rectangle;
            var controller:ContainerController;
            var composer:IFlowComposer;
            var tab:TableElement;
            var tb:TextBlock;
            var p:ParagraphElement;
            var firstLine:TextFlowLine;
            var lastLine:TextFlowLine;
            var leaf:FlowLeafElement;
            var startColumnIndex:int;
            var startController:ContainerController;
            var endColumnIndex:int;
            var endController:ContainerController;
            var passFirstController:Boolean;
            var aidx:Number;
            var sIdx:int;
            var cc:ContainerController;
            var cidx:int;
            var eIdx:int;
            var fLine:TextLine;
            var lLine:TextLine;
            var leafF:FlowLeafElement;
            var tcm:TextContainerManager;
            if (elem)
            {
                if (BackgroundManager.hasBorderOrBackground(elem))
                {
                    if (!_textFlow.backgroundManager)
                    {
                        _textFlow.getBackgroundManager();
                    };
                    bb = _textFlow.backgroundManager;
                    bb.addBlockElement(elem);
                    composer = _textFlow.flowComposer;
                    if (((composer) && (elem.textLength > 1)))
                    {
                        if ((elem is TableElement))
                        {
                            tab = (elem as TableElement);
                        }
                        else
                        {
                            tb = null;
                            p = elem.getFirstLeaf().getParagraph();
                            if (p)
                            {
                                tb = p.getTextBlock();
                            };
                            while (((!(tb)) && (p)))
                            {
                                p = p.getNextParagraph();
                                tb = p.getTextBlock();
                            };
                            if (((composer is StandardFlowComposer) && (composer.numLines > 0)))
                            {
                                firstLine = null;
                                lastLine = null;
                                if (((tb) && (tb.firstLine)))
                                {
                                    firstLine = tb.firstLine.userData;
                                    do 
                                    {
                                        tb = p.getTextBlock();
                                        if (((tb) && (tb.lastLine)))
                                        {
                                            lastLine = tb.lastLine.userData;
                                        };
                                        leaf = p.getLastLeaf().getNextLeaf(elem);
                                        if (leaf)
                                        {
                                            p = leaf.getParagraph();
                                        }
                                        else
                                        {
                                            p = null;
                                        };
                                    } while (p);
                                };
                                if (((firstLine) && (lastLine)))
                                {
                                    startColumnIndex = firstLine.columnIndex;
                                    startController = firstLine.controller;
                                    endColumnIndex = lastLine.columnIndex;
                                    endController = lastLine.controller;
                                    if (((startController) && (endController)))
                                    {
                                        if (((startController == endController) && (endColumnIndex == startColumnIndex)))
                                        {
                                            r = startController.columnState.getColumnAt(startColumnIndex);
                                            r.top = firstLine.y;
                                            r.bottom = (lastLine.y + lastLine.height);
                                            bb.addBlockRect(elem, r, startController);
                                        }
                                        else
                                        {
                                            if (startController != endController)
                                            {
                                                sIdx = (startController.columnCount - 1);
                                                while (sIdx > startColumnIndex)
                                                {
                                                    r = startController.columnState.getColumnAt(sIdx);
                                                    bb.addBlockRect(elem, r, startController);
                                                    sIdx--;
                                                };
                                            };
                                            if (endColumnIndex != startColumnIndex)
                                            {
                                                r = startController.columnState.getColumnAt(startColumnIndex);
                                                r.top = firstLine.y;
                                                bb.addBlockRect(elem, r, startController);
                                            };
                                            passFirstController = false;
                                            aidx = 0;
                                            while (aidx < composer.numControllers)
                                            {
                                                cc = composer.getControllerAt(aidx);
                                                if (passFirstController)
                                                {
                                                    cidx = 0;
                                                    while (cidx < cc.columnCount)
                                                    {
                                                        r = cc.columnState.getColumnAt(cidx);
                                                        bb.addBlockRect(elem, r, cc);
                                                        cidx++;
                                                    };
                                                };
                                                if (cc == endController)
                                                {
                                                    break;
                                                };
                                                if (cc == startController)
                                                {
                                                    passFirstController = true;
                                                };
                                                aidx++;
                                            };
                                            if (startController != endController)
                                            {
                                                eIdx = 0;
                                                while (eIdx < endColumnIndex)
                                                {
                                                    r = endController.columnState.getColumnAt(eIdx);
                                                    bb.addBlockRect(elem, r, endController);
                                                    eIdx++;
                                                };
                                            };
                                            r = endController.columnState.getColumnAt(endColumnIndex);
                                            r.bottom = (lastLine.y + lastLine.height);
                                            bb.addBlockRect(elem, r, endController);
                                        };
                                    };
                                };
                            }
                            else
                            {
                                if ((composer is FactoryDisplayComposer))
                                {
                                    fLine = null;
                                    lLine = null;
                                    if (((tb) && (tb.firstLine)))
                                    {
                                        fLine = tb.firstLine;
                                        do 
                                        {
                                            tb = p.getTextBlock();
                                            if (((tb) && (tb.lastLine)))
                                            {
                                                lLine = tb.lastLine;
                                            };
                                            leafF = p.getLastLeaf().getNextLeaf(elem);
                                            if (leafF)
                                            {
                                                p = leafF.getParagraph();
                                            }
                                            else
                                            {
                                                p = null;
                                            };
                                        } while (p);
                                    };
                                    if (((fLine) && (lLine)))
                                    {
                                        if ((composer as Object).hasOwnProperty("tcm"))
                                        {
                                            tcm = (composer as Object).tcm;
                                            if (tcm)
                                            {
                                                r = new Rectangle(0, (fLine.y - fLine.height), tcm.compositionWidth, ((lLine.y - fLine.y) + fLine.height));
                                                bb.addBlockRect(elem, r, composer.getControllerAt(0));
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        public static function hasBorderOrBackground(elem:FlowElement):Boolean
        {
            var format:ITextLayoutFormat = elem.computedFormat;
            if (format.backgroundColor != BackgroundColor.TRANSPARENT)
            {
                return (true);
            };
            if (((((!(format.borderLeftWidth == 0)) || (!(format.borderRightWidth == 0))) || (!(format.borderTopWidth == 0))) || (!(format.borderBottomWidth == 0))))
            {
                if (((((!(format.borderLeftColor == BorderColor.TRANSPARENT)) || (!(format.borderRightColor == BorderColor.TRANSPARENT))) || (!(format.borderTopColor == BorderColor.TRANSPARENT))) || (!(format.borderBottomColor == BorderColor.TRANSPARENT))))
                {
                    return (true);
                };
            };
            return (false);
        }


        public function clearBlockRecord():void
        {
            this._rectArray.splice(0, this._rectArray.length);
        }

        public function addBlockRect(elem:FlowElement, r:Rectangle, cc:ContainerController=null, style:String=null):void
        {
            var rect:Object = new Object();
            rect.r = r;
            rect.elem = elem;
            rect.cc = cc;
            rect.style = style;
            this._rectArray.unshift(rect);
        }

        public function addBlockElement(elem:FlowElement):void
        {
            var format:ITextLayoutFormat;
            var record:Object;
            if (!this._blockElementDict.hasOwnProperty(elem))
            {
                format = elem.computedFormat;
                record = new Object();
                record.backgroundColor = format.backgroundColor;
                record.backgroundAlpha = format.backgroundAlpha;
                record.borderLeftWidth = format.borderLeftWidth;
                record.borderRightWidth = format.borderRightWidth;
                record.borderTopWidth = format.borderTopWidth;
                record.borderBottomWidth = format.borderBottomWidth;
                record.borderLeftColor = format.borderLeftColor;
                record.borderRightColor = format.borderRightColor;
                record.borderTopColor = format.borderTopColor;
                record.borderBottomColor = format.borderBottomColor;
                this._blockElementDict[elem] = record;
            };
        }

        public function addRect(tl:TextLine, fle:FlowLeafElement, r:Rectangle, color:uint, alpha:Number):void
        {
            var currRecord:Object;
            var entry:Array = this._lineDict[tl];
            if (entry == null)
            {
                entry = (this._lineDict[tl] = new Array());
            };
            var record:Object = new Object();
            record.rect = r;
            record.fle = fle;
            record.color = color;
            record.alpha = alpha;
            var fleAbsoluteStart:int = fle.getAbsoluteStart();
            var i:int;
            while (i < entry.length)
            {
                currRecord = entry[i];
                if (((currRecord.hasOwnProperty("fle")) && (currRecord.fle.getAbsoluteStart() == fleAbsoluteStart)))
                {
                    entry[i] = record;
                    return;
                };
                i++;
            };
            entry.push(record);
        }

        public function addNumberLine(tl:TextLine, numberLine:TextLine):void
        {
            var entry:Array = this._lineDict[tl];
            if (entry == null)
            {
                entry = (this._lineDict[tl] = new Array());
            };
            entry.push({"numberLine":numberLine});
        }

        public function finalizeLine(line:TextFlowLine):void
        {
        }

        tlf_internal function getEntry(line:TextLine):*
        {
            return ((this._lineDict) ? this._lineDict[line] : undefined);
        }

        public function drawAllRects(textFlow:TextFlow, bgShape:Shape, constrainWidth:Number, constrainHeight:Number):void
        {
            var block:Object;
            var rec:Rectangle;
            var style:Object;
            var line:Object;
            var g:Graphics;
            var entry:Array;
            var columnRect:Rectangle;
            var r:Rectangle;
            var record:Object;
            var i:int;
            var numberLine:TextLine;
            var backgroundManager:BackgroundManager;
            var numberEntry:Array;
            var ii:int;
            var numberRecord:Object;
            var idx:int;
            while (idx < this._rectArray.length)
            {
                block = this._rectArray[idx];
                rec = block.r;
                style = this._blockElementDict[block.elem];
                if (((rec) && (style)))
                {
                    g = bgShape.graphics;
                    if (style.backgroundColor != BackgroundColor.TRANSPARENT)
                    {
                        g.lineStyle(NaN, style.backgroundColor, style.backgroundAlpha, true);
                        g.beginFill(style.backgroundColor, style.backgroundAlpha);
                        g.drawRect(rec.x, rec.y, rec.width, rec.height);
                        g.endFill();
                    };
                    g.moveTo((rec.x + Math.floor((style.borderLeftWidth / 2))), (rec.y + Math.floor((style.borderTopWidth / 2))));
                    if (((((!(block.style == BackgroundManager.TOP_EXCLUDED)) && (!(block.style == BackgroundManager.TOP_AND_BOTTOM_EXCLUDED))) && (!(style.borderTopWidth == 0))) && (!(style.borderTopColor == BorderColor.TRANSPARENT))))
                    {
                        g.lineStyle(style.borderTopWidth, style.borderTopColor, style.backgroundAlpha, true, "normal", CapsStyle.SQUARE);
                        g.lineTo(((rec.x + rec.width) - Math.floor((style.borderLeftWidth / 2))), (rec.y + Math.floor((style.borderTopWidth / 2))));
                    };
                    g.moveTo(((rec.x + rec.width) - Math.floor((style.borderRightWidth / 2))), (rec.y + Math.floor((style.borderTopWidth / 2))));
                    if (((!(style.borderRightWidth == 0)) && (!(style.borderRightColor == BorderColor.TRANSPARENT))))
                    {
                        g.lineStyle(style.borderRightWidth, style.borderRightColor, style.backgroundAlpha, true, "normal", CapsStyle.SQUARE);
                        g.lineTo(((rec.x + rec.width) - Math.floor((style.borderRightWidth / 2))), ((rec.y + rec.height) - Math.floor((style.borderTopWidth / 2))));
                    };
                    g.moveTo(((rec.x + rec.width) - Math.floor((style.borderLeftWidth / 2))), ((rec.y + rec.height) - Math.floor((style.borderBottomWidth / 2))));
                    if (((((!(block.style == BackgroundManager.BOTTOM_EXCLUDED)) && (!(block.style == BackgroundManager.TOP_AND_BOTTOM_EXCLUDED))) && (!(style.borderBottomWidth == 0))) && (!(style.borderBottomColor == BorderColor.TRANSPARENT))))
                    {
                        g.lineStyle(style.borderBottomWidth, style.borderBottomColor, style.backgroundAlpha, true, "normal", CapsStyle.SQUARE);
                        g.lineTo((rec.x + Math.floor((style.borderLeftWidth / 2))), ((rec.y + rec.height) - Math.floor((style.borderBottomWidth / 2))));
                    };
                    g.moveTo((rec.x + Math.floor((style.borderLeftWidth / 2))), ((rec.y + rec.height) - Math.floor((style.borderTopWidth / 2))));
                    if (((!(style.borderLeftWidth == 0)) && (!(style.borderLeftColor == BorderColor.TRANSPARENT))))
                    {
                        g.lineStyle(style.borderLeftWidth, style.borderLeftColor, style.backgroundAlpha, true, "normal", CapsStyle.SQUARE);
                        g.lineTo((rec.x + Math.floor((style.borderLeftWidth / 2))), (rec.y + Math.floor((style.borderTopWidth / 2))));
                    };
                };
                idx++;
            };
            for (line in this._lineDict)
            {
                entry = this._lineDict[line];
                if (entry.length)
                {
                    columnRect = entry[0].columnRect;
                    i = 0;
                    while (i < entry.length)
                    {
                        record = entry[i];
                        if (record.hasOwnProperty("numberLine"))
                        {
                            numberLine = record.numberLine;
                            backgroundManager = TextFlowLine.getNumberLineBackground(numberLine);
                            numberEntry = backgroundManager._lineDict[numberLine];
                            ii = 0;
                            while (ii < numberEntry.length)
                            {
                                numberRecord = numberEntry[ii];
                                r = numberRecord.rect;
                                r.x = (r.x + (line.x + numberLine.x));
                                r.y = (r.y + (line.y + numberLine.y));
                                TextFlowLine.constrainRectToColumn(textFlow, r, columnRect, 0, 0, constrainWidth, constrainHeight);
                                bgShape.graphics.beginFill(numberRecord.color, numberRecord.alpha);
                                bgShape.graphics.drawRect(r.x, r.y, r.width, r.height);
                                bgShape.graphics.endFill();
                                ii++;
                            };
                        }
                        else
                        {
                            r = record.rect;
                            r.x = (r.x + line.x);
                            r.y = (r.y + line.y);
                            TextFlowLine.constrainRectToColumn(textFlow, r, columnRect, 0, 0, constrainWidth, constrainHeight);
                            bgShape.graphics.beginFill(record.color, record.alpha);
                            bgShape.graphics.drawRect(r.x, r.y, r.width, r.height);
                            bgShape.graphics.endFill();
                        };
                        i++;
                    };
                };
            };
        }

        public function removeLineFromCache(tl:TextLine):void
        {
            delete this._lineDict[tl];
        }

        public function onUpdateComplete(controller:ContainerController):void
        {
            var bgShape:Shape;
            var rec:Rectangle;
            var style:Object;
            var block:Object;
            var idx:int;
            var childIdx:int;
            var g:Graphics;
            var line:*;
            var tl:TextLine;
            var entry:Array;
            var r:Rectangle;
            var tfl:TextFlowLine;
            var i:int;
            var record:Object;
            var numberLine:TextLine;
            var backgroundManager:BackgroundManager;
            var numberEntry:Array;
            var ii:int;
            var numberRecord:Object;
            var container:Sprite = controller.container;
            if (((container) && (container.numChildren)))
            {
                bgShape = controller.getBackgroundShape();
                bgShape.graphics.clear();
                idx = 0;
                while (idx < this._rectArray.length)
                {
                    block = this._rectArray[idx];
                    if (block.cc == controller)
                    {
                        style = this._blockElementDict[block.elem];
                        if (style != null)
                        {
                            rec = block.r;
                            g = bgShape.graphics;
                            if (style.backgroundColor != BackgroundColor.TRANSPARENT)
                            {
                                g.lineStyle(NaN, style.backgroundColor, style.backgroundAlpha, true);
                                g.beginFill(style.backgroundColor, style.backgroundAlpha);
                                g.drawRect(rec.x, rec.y, rec.width, rec.height);
                                g.endFill();
                            };
                            g.moveTo((rec.x + Math.floor((style.borderLeftWidth / 2))), (rec.y + Math.floor((style.borderTopWidth / 2))));
                            if (((((!(block.style == BackgroundManager.TOP_EXCLUDED)) && (!(block.style == BackgroundManager.TOP_AND_BOTTOM_EXCLUDED))) && (!(style.borderTopWidth == 0))) && (!(style.borderTopColor == BorderColor.TRANSPARENT))))
                            {
                                g.lineStyle(style.borderTopWidth, style.borderTopColor, style.backgroundAlpha, true, "normal", CapsStyle.SQUARE);
                                g.lineTo(((rec.x + rec.width) - Math.floor((style.borderLeftWidth / 2))), (rec.y + Math.floor((style.borderTopWidth / 2))));
                            };
                            g.moveTo(((rec.x + rec.width) - Math.floor((style.borderRightWidth / 2))), (rec.y + Math.floor((style.borderTopWidth / 2))));
                            if (((!(style.borderRightWidth == 0)) && (!(style.borderRightColor == BorderColor.TRANSPARENT))))
                            {
                                g.lineStyle(style.borderRightWidth, style.borderRightColor, style.backgroundAlpha, true, "normal", CapsStyle.SQUARE);
                                g.lineTo(((rec.x + rec.width) - Math.floor((style.borderRightWidth / 2))), ((rec.y + rec.height) - Math.floor((style.borderTopWidth / 2))));
                            };
                            g.moveTo(((rec.x + rec.width) - Math.floor((style.borderLeftWidth / 2))), ((rec.y + rec.height) - Math.floor((style.borderBottomWidth / 2))));
                            if (((((!(block.style == BackgroundManager.BOTTOM_EXCLUDED)) && (!(block.style == BackgroundManager.TOP_AND_BOTTOM_EXCLUDED))) && (!(style.borderBottomWidth == 0))) && (!(style.borderBottomColor == BorderColor.TRANSPARENT))))
                            {
                                g.lineStyle(style.borderBottomWidth, style.borderBottomColor, style.backgroundAlpha, true, "normal", CapsStyle.SQUARE);
                                g.lineTo((rec.x + Math.floor((style.borderLeftWidth / 2))), ((rec.y + rec.height) - Math.floor((style.borderBottomWidth / 2))));
                            };
                            g.moveTo((rec.x + Math.floor((style.borderLeftWidth / 2))), ((rec.y + rec.height) - Math.floor((style.borderTopWidth / 2))));
                            if (((!(style.borderLeftWidth == 0)) && (!(style.borderLeftColor == BorderColor.TRANSPARENT))))
                            {
                                g.lineStyle(style.borderLeftWidth, style.borderLeftColor, style.backgroundAlpha, true, "normal", CapsStyle.SQUARE);
                                g.lineTo((rec.x + Math.floor((style.borderLeftWidth / 2))), (rec.y + Math.floor((style.borderTopWidth / 2))));
                            };
                        };
                    };
                    idx++;
                };
                childIdx = 0;
                while (childIdx < controller.textLines.length)
                {
                    line = controller.textLines[childIdx];
                    if (!(line is TextLine))
                    {
                    }
                    else
                    {
                        tl = line;
                        entry = this._lineDict[tl];
                        if (entry)
                        {
                            tfl = (tl.userData as TextFlowLine);
                            i = 0;
                            while (i < entry.length)
                            {
                                record = entry[i];
                                if (record.hasOwnProperty("numberLine"))
                                {
                                    numberLine = record.numberLine;
                                    backgroundManager = TextFlowLine.getNumberLineBackground(numberLine);
                                    numberEntry = backgroundManager._lineDict[numberLine];
                                    if (numberEntry)
                                    {
                                        ii = 0;
                                        while (ii < numberEntry.length)
                                        {
                                            numberRecord = numberEntry[ii];
                                            r = numberRecord.rect.clone();
                                            r.x = (r.x + numberLine.x);
                                            r.y = (r.y + numberLine.y);
                                            tfl.convertLineRectToContainer(r, true);
                                            bgShape.graphics.beginFill(numberRecord.color, numberRecord.alpha);
                                            bgShape.graphics.drawRect(r.x, r.y, r.width, r.height);
                                            bgShape.graphics.endFill();
                                            ii++;
                                        };
                                    };
                                }
                                else
                                {
                                    r = record.rect.clone();
                                    tfl.convertLineRectToContainer(r, true);
                                    bgShape.graphics.beginFill(record.color, record.alpha);
                                    bgShape.graphics.drawRect(r.x, r.y, r.width, r.height);
                                    bgShape.graphics.endFill();
                                };
                                i++;
                            };
                        };
                    };
                    childIdx++;
                };
            };
        }

        public function getShapeRectArray():Array
        {
            return (this._rectArray);
        }


    }
}

