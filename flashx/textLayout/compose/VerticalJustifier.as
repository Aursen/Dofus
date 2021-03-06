package flashx.textLayout.compose
{
    import flashx.textLayout.formats.BlockProgression;
    import flashx.textLayout.formats.VerticalAlign;
    import flashx.textLayout.tlf_internal;
    import flashx.textLayout.formats.Float;
    import flashx.textLayout.container.ContainerController;

    use namespace tlf_internal;

    public final class VerticalJustifier 
    {


        public static function applyVerticalAlignmentToColumn(controller:ContainerController, verticalAlignAttr:String, lines:Array, startIndex:int, numLines:int, beginFloatIndex:int, endFloatIndex:int):Number
        {
            var helper:IVerticalAdjustmentHelper;
            var i:int;
            var rslt:Number;
            var lastLine:IVerticalJustificationLine;
            var bottom:Number;
            var floatIndex:int;
            var floatInfo:FloatCompositionData;
            if (controller.rootElement.computedFormat.blockProgression == BlockProgression.RL)
            {
                helper = new RL_VJHelper(controller);
            }
            else
            {
                helper = new TB_VJHelper(controller);
            };
            switch (verticalAlignAttr)
            {
                case VerticalAlign.MIDDLE:
                case VerticalAlign.BOTTOM:
                    lastLine = lines[((startIndex + numLines) - 1)];
                    bottom = helper.getBottom(lastLine, controller, beginFloatIndex, endFloatIndex);
                    rslt = ((verticalAlignAttr == VerticalAlign.MIDDLE) ? helper.computeMiddleAdjustment(bottom) : helper.computeBottomAdjustment(bottom));
                    i = startIndex;
                    while (i < (startIndex + numLines))
                    {
                        helper.applyAdjustment(lines[i]);
                        i++;
                    };
                    floatIndex = beginFloatIndex;
                    while (floatIndex < endFloatIndex)
                    {
                        floatInfo = controller.getFloatAt(floatIndex);
                        if (floatInfo.floatType != Float.NONE)
                        {
                            helper.applyAdjustmentToFloat(floatInfo);
                        };
                        floatIndex++;
                    };
                    break;
                case VerticalAlign.JUSTIFY:
                    rslt = helper.computeJustifyAdjustment(lines, startIndex, numLines);
                    helper.applyJustifyAdjustment(lines, startIndex, numLines);
                    break;
            };
            return (rslt);
        }


    }
}

import flashx.textLayout.compose.IVerticalJustificationLine;
import flashx.textLayout.container.ContainerController;
import flashx.textLayout.compose.FloatCompositionData;
import flashx.textLayout.elements.InlineGraphicElement;
import flashx.textLayout.tlf_internal;
import flashx.textLayout.formats.Float;
import flashx.textLayout.compose.TextFlowLine;

use namespace tlf_internal;

interface IVerticalAdjustmentHelper 
{

    function getBottom(_arg_1:IVerticalJustificationLine, _arg_2:ContainerController, _arg_3:int, _arg_4:int):Number;
    function computeMiddleAdjustment(_arg_1:Number):Number;
    function applyAdjustment(_arg_1:IVerticalJustificationLine):void;
    function applyAdjustmentToFloat(_arg_1:FloatCompositionData):void;
    function computeBottomAdjustment(_arg_1:Number):Number;
    function computeJustifyAdjustment(_arg_1:Array, _arg_2:int, _arg_3:int):Number;
    function applyJustifyAdjustment(_arg_1:Array, _arg_2:int, _arg_3:int):void;

}

class TB_VJHelper implements IVerticalAdjustmentHelper 
{

    /*private*/ var _textFrame:ContainerController;
    /*private*/ var adj:Number;

    public function TB_VJHelper(tf:ContainerController):void
    {
        this._textFrame = tf;
    }

    public function getBottom(line:IVerticalJustificationLine, controller:ContainerController, beginFloat:int, endFloat:int):Number
    {
        var floatInfo:FloatCompositionData;
        var ilg:InlineGraphicElement;
        var maxBottom:Number = (this.getBaseline(line) + line.descent);
        var i:int = beginFloat;
        while (i < endFloat)
        {
            floatInfo = controller.getFloatAt(i);
            if (floatInfo.floatType != Float.NONE)
            {
                ilg = (controller.rootElement.findLeaf(floatInfo.absolutePosition) as InlineGraphicElement);
                maxBottom = Math.max(maxBottom, (floatInfo.y + ilg.elementHeightWithMarginsAndPadding()));
            };
            i++;
        };
        return (maxBottom);
    }

    public function getBottomOfLine(line:IVerticalJustificationLine):Number
    {
        return (this.getBaseline(line) + line.descent);
    }

    /*private*/ function getBaseline(line:IVerticalJustificationLine):Number
    {
        if ((line is TextFlowLine))
        {
            return (line.y + line.ascent);
        };
        return (line.y);
    }

    /*private*/ function setBaseline(line:IVerticalJustificationLine, pos:Number):void
    {
        if ((line is TextFlowLine))
        {
            line.y = (pos - line.ascent);
        }
        else
        {
            line.y = pos;
        };
    }

    public function computeMiddleAdjustment(contentBottom:Number):Number
    {
        var frameBottom:Number = (this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom()));
        this.adj = ((frameBottom - contentBottom) / 2);
        if (this.adj < 0)
        {
            this.adj = 0;
        };
        return (this.adj);
    }

    public function computeBottomAdjustment(contentBottom:Number):Number
    {
        var frameBottom:Number = (this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom()));
        this.adj = (frameBottom - contentBottom);
        if (this.adj < 0)
        {
            this.adj = 0;
        };
        return (this.adj);
    }

    public function applyAdjustment(line:IVerticalJustificationLine):void
    {
        line.y = (line.y + this.adj);
    }

    public function applyAdjustmentToFloat(floatInfo:FloatCompositionData):void
    {
        floatInfo.y = (floatInfo.y + this.adj);
    }

    public function computeJustifyAdjustment(lineArray:Array, firstLineIndex:int, numLines:int):Number
    {
        this.adj = 0;
        if (numLines == 1)
        {
            return (0);
        };
        var firstLine:IVerticalJustificationLine = lineArray[firstLineIndex];
        var firstBaseLine:Number = this.getBaseline(firstLine);
        var lastLine:IVerticalJustificationLine = lineArray[((firstLineIndex + numLines) - 1)];
        var frameBottom:Number = (this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom()));
        var allowance:Number = (frameBottom - this.getBottomOfLine(lastLine));
        if (allowance < 0)
        {
            return (0);
        };
        var lastBaseLine:Number = this.getBaseline(lastLine);
        this.adj = (allowance / (lastBaseLine - firstBaseLine));
        return (this.adj);
    }

    public function applyJustifyAdjustment(lineArray:Array, firstLineIndex:int, numLines:int):void
    {
        var line:IVerticalJustificationLine;
        var currBaseLine:Number;
        var currBaseLineUnjustified:Number;
        if (((numLines == 1) || (this.adj == 0)))
        {
            return;
        };
        var firstLine:IVerticalJustificationLine = lineArray[firstLineIndex];
        var prevBaseLine:Number = this.getBaseline(firstLine);
        var prevBaseLineUnjustified:Number = prevBaseLine;
        var i:int = 1;
        while (i < numLines)
        {
            line = lineArray[(i + firstLineIndex)];
            currBaseLineUnjustified = this.getBaseline(line);
            currBaseLine = (prevBaseLine + ((currBaseLineUnjustified - prevBaseLineUnjustified) * (1 + this.adj)));
            this.setBaseline(line, currBaseLine);
            prevBaseLineUnjustified = currBaseLineUnjustified;
            prevBaseLine = currBaseLine;
            i++;
        };
    }


}

class RL_VJHelper implements IVerticalAdjustmentHelper 
{

    /*private*/ var _textFrame:ContainerController;
    /*private*/ var adj:Number = 0;

    public function RL_VJHelper(tf:ContainerController):void
    {
        this._textFrame = tf;
    }

    public function getBottom(lastLine:IVerticalJustificationLine, controller:ContainerController, beginFloat:int, endFloat:int):Number
    {
        var floatInfo:FloatCompositionData;
        var frameWidth:Number = (this._textFrame.compositionWidth - Number(this._textFrame.getTotalPaddingLeft()));
        var maxLeft:Number = ((frameWidth + lastLine.x) - lastLine.descent);
        var i:int = beginFloat;
        while (i < endFloat)
        {
            floatInfo = controller.getFloatAt(i);
            if (floatInfo.floatType != Float.NONE)
            {
                maxLeft = Math.min(maxLeft, (floatInfo.x + frameWidth));
            };
            i++;
        };
        return (maxLeft);
    }

    public function computeMiddleAdjustment(contentLeft:Number):Number
    {
        this.adj = (contentLeft / 2);
        if (this.adj < 0)
        {
            this.adj = 0;
        };
        return (-(this.adj));
    }

    public function computeBottomAdjustment(contentLeft:Number):Number
    {
        this.adj = contentLeft;
        if (this.adj < 0)
        {
            this.adj = 0;
        };
        return (-(this.adj));
    }

    public function applyAdjustment(line:IVerticalJustificationLine):void
    {
        line.x = (line.x - this.adj);
    }

    public function applyAdjustmentToFloat(floatInfo:FloatCompositionData):void
    {
        floatInfo.x = (floatInfo.x - this.adj);
    }

    public function computeJustifyAdjustment(lineArray:Array, firstLineIndex:int, numLines:int):Number
    {
        this.adj = 0;
        if (numLines == 1)
        {
            return (0);
        };
        var firstLine:IVerticalJustificationLine = lineArray[firstLineIndex];
        var firstBaseLine:Number = firstLine.x;
        var lastLine:IVerticalJustificationLine = lineArray[((firstLineIndex + numLines) - 1)];
        var frameLeft:Number = (Number(this._textFrame.getTotalPaddingLeft()) - this._textFrame.compositionWidth);
        var allowance:Number = ((lastLine.x - lastLine.descent) - frameLeft);
        if (allowance < 0)
        {
            return (0);
        };
        var lastBaseLine:Number = lastLine.x;
        this.adj = (allowance / (firstBaseLine - lastBaseLine));
        return (-(this.adj));
    }

    public function applyJustifyAdjustment(lineArray:Array, firstLineIndex:int, numLines:int):void
    {
        var line:IVerticalJustificationLine;
        var currBaseLine:Number;
        var currBaseLineUnjustified:Number;
        if (((numLines == 1) || (this.adj == 0)))
        {
            return;
        };
        var firstLine:IVerticalJustificationLine = lineArray[firstLineIndex];
        var prevBaseLine:Number = firstLine.x;
        var prevBaseLineUnjustified:Number = prevBaseLine;
        var i:int = 1;
        while (i < numLines)
        {
            line = lineArray[(i + firstLineIndex)];
            currBaseLineUnjustified = line.x;
            currBaseLine = (prevBaseLine - ((prevBaseLineUnjustified - currBaseLineUnjustified) * (1 + this.adj)));
            line.x = currBaseLine;
            prevBaseLineUnjustified = currBaseLineUnjustified;
            prevBaseLine = currBaseLine;
            i++;
        };
    }


}


