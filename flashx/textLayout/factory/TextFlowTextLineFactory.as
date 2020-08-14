package flashx.textLayout.factory
{
    import flashx.textLayout.compose.SimpleCompose;
    import flashx.textLayout.tlf_internal;
    import flashx.textLayout.elements.TextFlow;
    import flashx.textLayout.elements.SpanElement;
    import flashx.textLayout.formats.ITextLayoutFormat;
    import flash.text.engine.TextLine;
    import flashx.textLayout.elements.FlowGroupElement;
    import flashx.textLayout.elements.FlowLeafElement;
    import flashx.textLayout.compose.IFlowComposer;
    import flashx.textLayout.container.ScrollPolicy;
    import flashx.textLayout.elements.ParagraphElement;
    import flash.geom.Rectangle;
    import flashx.textLayout.formats.BlockProgression;
    import flashx.textLayout.compose.FloatCompositionData;
    import flash.display.Sprite;
    import flashx.textLayout.formats.Float;

    use namespace tlf_internal;

    public class TextFlowTextLineFactory extends TextLineFactoryBase 
    {

        private var _truncatedTextFlowCallback:Function;


        public function createTextLines(callback:Function, textFlow:TextFlow):void
        {
            var saved:SimpleCompose = TextLineFactoryBase.beginFactoryCompose();
            try
            {
                this.createTextLinesInternal(callback, textFlow);
            }
            finally
            {
                textFlow.changeFlowComposer(null, false);
                _factoryComposer._lines.splice(0);
                if (_pass0Lines)
                {
                    _pass0Lines.splice(0);
                };
                TextLineFactoryBase.endFactoryCompose(saved);
            };
        }

        private function createTextLinesInternal(callback:Function, textFlow:TextFlow):void
        {
            var measureWidth:Boolean;
            var somethingFit:Boolean;
            var truncationIndicatorSpan:SpanElement;
            var hostFormat:ITextLayoutFormat;
            var line:TextLine;
            var truncateAtCharPosition:int;
            var parent:FlowGroupElement;
            var lastLeaf:FlowLeafElement;
            measureWidth = isNaN(compositionBounds.width);
            var bp:String = textFlow.computedFormat.blockProgression;
            var helper:IFlowComposer = createFlowComposer();
            helper.swfContext = swfContext;
            helper.addController(containerController);
            textFlow.flowComposer = helper;
            textFlow.clearBackgroundManager();
            _isTruncated = false;
            containerController.setCompositionSize(compositionBounds.width, compositionBounds.height);
            containerController.verticalScrollPolicy = ((truncationOptions) ? ScrollPolicy.OFF : verticalScrollPolicy);
            containerController.horizontalScrollPolicy = ((truncationOptions) ? ScrollPolicy.OFF : horizontalScrollPolicy);
            textFlow.normalize();
            textFlow.applyUpdateElements(true);
            helper.compose();
            if (((truncationOptions) && (!(doesComposedTextFit(truncationOptions.lineCountLimit, textFlow.textLength, bp)))))
            {
                _isTruncated = true;
                somethingFit = false;
                computeLastAllowedLineIndex(truncationOptions.lineCountLimit);
                if (_truncationLineIndex >= 0)
                {
                    truncationIndicatorSpan = new SpanElement();
                    truncationIndicatorSpan.text = truncationOptions.truncationIndicator;
                    truncationIndicatorSpan.id = "truncationIndicator";
                    if (truncationOptions.truncationIndicatorFormat)
                    {
                        truncationIndicatorSpan.format = truncationOptions.truncationIndicatorFormat;
                    };
                    hostFormat = textFlow.hostFormat;
                    line = (_factoryComposer._lines[_truncationLineIndex] as TextLine);
                    truncateAtCharPosition = (line.userData + line.rawTextLength);
                    if (!_pass0Lines)
                    {
                        _pass0Lines = new Array();
                    };
                    _pass0Lines = _factoryComposer.swapLines(_pass0Lines);
                    do 
                    {
                        textFlow = (textFlow.deepCopy(0, truncateAtCharPosition) as TextFlow);
                        if (hostFormat)
                        {
                            textFlow.hostFormat = hostFormat;
                        };
                        lastLeaf = textFlow.getLastLeaf();
                        if (lastLeaf)
                        {
                            parent = lastLeaf.parent;
                            if (!truncationOptions.truncationIndicatorFormat)
                            {
                                truncationIndicatorSpan.format = lastLeaf.format;
                            };
                        }
                        else
                        {
                            parent = new ParagraphElement();
                            textFlow.addChild(parent);
                        };
                        if (truncationIndicatorSpan.parent)
                        {
                            truncationIndicatorSpan.parent.removeChild(truncationIndicatorSpan);
                        };
                        parent.addChild(truncationIndicatorSpan);
                        textFlow.flowComposer = helper;
                        textFlow.normalize();
                        helper.compose();
                        if (doesComposedTextFit(truncationOptions.lineCountLimit, textFlow.textLength, bp))
                        {
                            somethingFit = true;
                            break;
                        };
                        if (truncateAtCharPosition == 0)
                        {
                            break;
                        };
                        truncateAtCharPosition = getNextTruncationPosition(truncateAtCharPosition, true);
                    } while (true);
                };
                if (this._truncatedTextFlowCallback != null)
                {
                    this._truncatedTextFlowCallback(((somethingFit) ? textFlow : null));
                };
                if (!somethingFit)
                {
                    _factoryComposer._lines.splice(0);
                };
            };
            var xadjust:Number = compositionBounds.x;
            var controllerBounds:Rectangle = containerController.getContentBounds();
            if (bp == BlockProgression.RL)
            {
                xadjust = (xadjust + ((measureWidth) ? controllerBounds.width : compositionBounds.width));
            };
            controllerBounds.left = (controllerBounds.left + xadjust);
            controllerBounds.right = (controllerBounds.right + xadjust);
            controllerBounds.top = (controllerBounds.top + compositionBounds.y);
            controllerBounds.bottom = (controllerBounds.bottom + compositionBounds.y);
            if (textFlow.backgroundManager)
            {
                processBackgroundColors(textFlow, callback, xadjust, compositionBounds.y, containerController.compositionWidth, containerController.compositionHeight);
            };
            this.callbackWithTextLines(callback, xadjust, compositionBounds.y);
            setContentBounds(controllerBounds);
            containerController.clearCompositionResults();
        }

        override protected function callbackWithTextLines(callback:Function, delx:Number, dely:Number):void
        {
            var floatInfo:FloatCompositionData;
            var inlineHolder:Sprite;
            super.callbackWithTextLines(callback, delx, dely);
            var numFloats:int = containerController.numFloats;
            var i:int;
            while (i < numFloats)
            {
                floatInfo = containerController.getFloatAt(i);
                inlineHolder = new Sprite();
                inlineHolder.alpha = floatInfo.alpha;
                if (floatInfo.matrix)
                {
                    inlineHolder.transform.matrix = floatInfo.matrix;
                };
                inlineHolder.x = (inlineHolder.x + floatInfo.x);
                inlineHolder.y = (inlineHolder.y + floatInfo.y);
                inlineHolder.addChild(floatInfo.graphic);
                if (floatInfo.floatType == Float.NONE)
                {
                    floatInfo.parent.addChild(inlineHolder);
                }
                else
                {
                    inlineHolder.x = (inlineHolder.x + delx);
                    inlineHolder.y = (inlineHolder.y + dely);
                    (callback(inlineHolder));
                };
                i++;
            };
        }

        tlf_internal function set truncatedTextFlowCallback(val:Function):void
        {
            this._truncatedTextFlowCallback = val;
        }


    }
} flashx.textLayout.factory

