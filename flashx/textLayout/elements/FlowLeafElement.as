package flashx.textLayout.elements
{
    import flash.text.engine.ContentElement;
    import flashx.textLayout.tlf_internal;
    import flashx.textLayout.events.FlowElementEventDispatcher;
    import flashx.textLayout.formats.FormatValue;
    import flash.text.engine.TextRotation;
    import flash.text.engine.TextBaseline;
    import flashx.textLayout.utils.LocaleUtil;
    import flashx.textLayout.formats.ITextLayoutFormat;
    import flashx.textLayout.formats.ColorName;
    import flash.text.engine.FontMetrics;
    import flash.text.engine.ElementFormat;
    import flashx.textLayout.formats.TextLayoutFormat;
    import flash.text.engine.TypographicCase;
    import flashx.textLayout.formats.TLFTypographicCase;
    import flash.text.engine.FontDescription;
    import flashx.textLayout.compose.FlowComposerBase;
    import flashx.textLayout.formats.BaselineShift;
    import flashx.textLayout.compose.ISWFContext;
    import flash.geom.Rectangle;
    import flash.text.engine.TextLine;
    import flash.events.IEventDispatcher;
    import flashx.textLayout.events.ModelChange;
    import flash.text.engine.TextElement;
    import flashx.textLayout.formats.BlockProgression;
    import flashx.textLayout.compose.TextFlowLine;
    import flashx.textLayout.utils.CharacterUtil;
    import flash.display.Shape;
    import flashx.textLayout.formats.IMEStatus;
    import flashx.textLayout.formats.BackgroundColor;
    import flashx.textLayout.formats.TextDecoration;
    import flash.display.Graphics;

    use namespace tlf_internal;

    public class FlowLeafElement extends FlowElement 
    {

        protected var _blockElement:ContentElement;
        protected var _text:String;
        private var _hasAttachedListeners:Boolean = false;
        tlf_internal var _eventMirror:FlowElementEventDispatcher = null;


        tlf_internal static function resolveDomBaseline(computedFormat:ITextLayoutFormat, para:ParagraphElement):String
        {
            var domBase:String = computedFormat.dominantBaseline;
            if (domBase == FormatValue.AUTO)
            {
                if (computedFormat.textRotation == TextRotation.ROTATE_270)
                {
                    domBase = TextBaseline.IDEOGRAPHIC_CENTER;
                }
                else
                {
                    if (para != null)
                    {
                        domBase = para.getEffectiveDominantBaseline();
                    }
                    else
                    {
                        domBase = LocaleUtil.dominantBaseline(computedFormat.locale);
                    };
                };
            };
            return (domBase);
        }

        private static function translateColor(color:String):Number
        {
            var ret:Number = NaN;
            switch (color.toLowerCase())
            {
                case ColorName.BLACK:
                    ret = 0;
                    break;
                case ColorName.BLUE:
                    ret = 0xFF;
                    break;
                case ColorName.GREEN:
                    ret = 0x8000;
                    break;
                case ColorName.GRAY:
                    ret = 0x808080;
                    break;
                case ColorName.SILVER:
                    ret = 0xC0C0C0;
                    break;
                case ColorName.LIME:
                    ret = 0xFF00;
                    break;
                case ColorName.OLIVE:
                    ret = 0x808000;
                    break;
                case ColorName.WHITE:
                    ret = 0xFFFFFF;
                    break;
                case ColorName.YELLOW:
                    ret = 0xFFFF00;
                    break;
                case ColorName.MAROON:
                    ret = 0x800000;
                    break;
                case ColorName.NAVY:
                    ret = 128;
                    break;
                case ColorName.RED:
                    ret = 0xFF0000;
                    break;
                case ColorName.PURPLE:
                    ret = 0x800080;
                    break;
                case ColorName.TEAL:
                    ret = 0x8080;
                    break;
                case ColorName.FUCHSIA:
                    ret = 0xFF00FF;
                    break;
                case ColorName.AQUA:
                    ret = 0xFFFF;
                    break;
                case ColorName.MAGENTA:
                    ret = 0xFF00FF;
                    break;
                case ColorName.CYAN:
                    ret = 0xFFFF;
                    break;
            };
            return (ret);
        }

        tlf_internal static function computeElementFormatHelper(computedFormat:ITextLayoutFormat, para:ParagraphElement, swfContext:ISWFContext):ElementFormat
        {
            var fontMetrics:FontMetrics;
            var format:ElementFormat = new ElementFormat();
            format.alignmentBaseline = computedFormat.alignmentBaseline;
            format.alpha = Number(computedFormat.textAlpha);
            format.breakOpportunity = computedFormat.breakOpportunity;
            format.color = ((computedFormat.color is String) ? translateColor(computedFormat.color) : uint(computedFormat.color));
            format.dominantBaseline = resolveDomBaseline(computedFormat, para);
            format.digitCase = computedFormat.digitCase;
            format.digitWidth = computedFormat.digitWidth;
            format.ligatureLevel = computedFormat.ligatureLevel;
            format.fontSize = Number(computedFormat.fontSize);
            format.kerning = computedFormat.kerning;
            format.locale = computedFormat.locale;
            format.trackingLeft = TextLayoutFormat.trackingLeftProperty.computeActualPropertyValue(computedFormat.trackingLeft, format.fontSize);
            format.trackingRight = TextLayoutFormat.trackingRightProperty.computeActualPropertyValue(computedFormat.trackingRight, format.fontSize);
            format.textRotation = computedFormat.textRotation;
            format.baselineShift = -(TextLayoutFormat.baselineShiftProperty.computeActualPropertyValue(computedFormat.baselineShift, format.fontSize));
            switch (computedFormat.typographicCase)
            {
                case TLFTypographicCase.LOWERCASE_TO_SMALL_CAPS:
                    format.typographicCase = TypographicCase.CAPS_AND_SMALL_CAPS;
                    break;
                case TLFTypographicCase.CAPS_TO_SMALL_CAPS:
                    format.typographicCase = TypographicCase.SMALL_CAPS;
                    break;
                default:
                    format.typographicCase = computedFormat.typographicCase;
            };
            var fd:FontDescription = new FontDescription();
            fd.fontWeight = computedFormat.fontWeight;
            fd.fontPosture = computedFormat.fontStyle;
            fd.fontName = computedFormat.fontFamily;
            fd.renderingMode = computedFormat.renderingMode;
            fd.cffHinting = computedFormat.cffHinting;
            if (GlobalSettings.resolveFontLookupFunction == null)
            {
                fd.fontLookup = computedFormat.fontLookup;
            }
            else
            {
                fd.fontLookup = GlobalSettings.resolveFontLookupFunction(((swfContext) ? FlowComposerBase.computeBaseSWFContext(swfContext) : null), computedFormat);
            };
            var fontMapper:Function = GlobalSettings.fontMapperFunction;
            if (fontMapper != null)
            {
                (fontMapper(fd));
            };
            format.fontDescription = fd;
            if (((computedFormat.baselineShift == BaselineShift.SUPERSCRIPT) || (computedFormat.baselineShift == BaselineShift.SUBSCRIPT)))
            {
                if (swfContext)
                {
                    fontMetrics = swfContext.callInContext(format.getFontMetrics, format, null, true);
                }
                else
                {
                    fontMetrics = format.getFontMetrics();
                };
                if (computedFormat.baselineShift == BaselineShift.SUPERSCRIPT)
                {
                    format.baselineShift = (fontMetrics.superscriptOffset * format.fontSize);
                    format.fontSize = (fontMetrics.superscriptScale * format.fontSize);
                }
                else
                {
                    format.baselineShift = (fontMetrics.subscriptOffset * format.fontSize);
                    format.fontSize = (fontMetrics.subscriptScale * format.fontSize);
                };
            };
            return (format);
        }

        tlf_internal static function getCSSInlineBoxHelper(computedFormat:ITextLayoutFormat, metrics:FontMetrics, textLine:TextLine, para:ParagraphElement=null):Rectangle
        {
            var baselineShift:Number;
            var emBox:Rectangle = metrics.emBox;
            var ascent:Number = -(emBox.top);
            var descent:Number = emBox.bottom;
            var textHeight:Number = emBox.height;
            var fontSize:Number = computedFormat.fontSize;
            var lineHeight:Number = TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(computedFormat.lineHeight, fontSize);
            var halfLeading:Number = ((lineHeight - textHeight) / 2);
            emBox.top = (emBox.top - halfLeading);
            emBox.bottom = (emBox.bottom + halfLeading);
            var computedDominantBaseline:String = resolveDomBaseline(computedFormat, para);
            switch (computedDominantBaseline)
            {
                case TextBaseline.ASCENT:
                case TextBaseline.IDEOGRAPHIC_TOP:
                    emBox.offset(0, ascent);
                    break;
                case TextBaseline.IDEOGRAPHIC_CENTER:
                    emBox.offset(0, (ascent - (textHeight / 2)));
                    break;
                case TextBaseline.ROMAN:
                    break;
                case TextBaseline.DESCENT:
                case TextBaseline.IDEOGRAPHIC_BOTTOM:
                    emBox.offset(0, -(descent));
            };
            var computedAlignmentBaseline:String = ((computedFormat.alignmentBaseline == TextBaseline.USE_DOMINANT_BASELINE) ? computedDominantBaseline : computedFormat.alignmentBaseline);
            emBox.offset(0, textLine.getBaselinePosition(computedAlignmentBaseline));
            if (computedFormat.baselineShift == BaselineShift.SUPERSCRIPT)
            {
                baselineShift = (metrics.superscriptOffset * fontSize);
            }
            else
            {
                if (computedFormat.baselineShift == BaselineShift.SUBSCRIPT)
                {
                    baselineShift = (metrics.subscriptOffset * fontSize);
                }
                else
                {
                    baselineShift = -(computedFormat.baselineShift);
                };
            };
            emBox.offset(0, baselineShift);
            return (emBox);
        }


        override tlf_internal function createContentElement():void
        {
            if (_computedFormat)
            {
                this._blockElement.elementFormat = this.computeElementFormat();
            };
            if (parent)
            {
                parent.insertBlockElement(this, this._blockElement);
            };
        }

        override tlf_internal function releaseContentElement():void
        {
            this._blockElement = null;
            _computedFormat = null;
        }

        private function blockElementExists():Boolean
        {
            return (!(this._blockElement == null));
        }

        tlf_internal function getBlockElement():ContentElement
        {
            if (!this._blockElement)
            {
                this.createContentElement();
            };
            return (this._blockElement);
        }

        override tlf_internal function getEventMirror():IEventDispatcher
        {
            if (!this._eventMirror)
            {
                this._eventMirror = new FlowElementEventDispatcher(this);
            };
            return (this._eventMirror);
        }

        override tlf_internal function hasActiveEventMirror():Boolean
        {
            return ((this._eventMirror) && (!(this._eventMirror._listenerCount == 0)));
        }

        override tlf_internal function appendElementsForDelayedUpdate(tf:TextFlow, changeType:String):void
        {
            if (changeType == ModelChange.ELEMENT_ADDED)
            {
                if (this.hasActiveEventMirror())
                {
                    tf.incInteractiveObjectCount();
                    getParagraph().incInteractiveChildrenCount();
                };
            }
            else
            {
                if (changeType == ModelChange.ELEMENT_REMOVAL)
                {
                    if (this.hasActiveEventMirror())
                    {
                        tf.decInteractiveObjectCount();
                        getParagraph().decInteractiveChildrenCount();
                    };
                };
            };
            super.appendElementsForDelayedUpdate(tf, changeType);
        }

        public function get text():String
        {
            return (this._text);
        }

        tlf_internal function getElementFormat():ElementFormat
        {
            if (!this._blockElement)
            {
                this.createContentElement();
            };
            return (this._blockElement.elementFormat);
        }

        override tlf_internal function setParentAndRelativeStart(newParent:FlowGroupElement, newStart:int):void
        {
            if (newParent == parent)
            {
                return;
            };
            var hasBlock:* = (!(this._blockElement == null));
            if ((((this._blockElement) && (parent)) && (parent.hasBlockElement())))
            {
                parent.removeBlockElement(this, this._blockElement);
            };
            if ((((newParent) && (!(newParent.hasBlockElement()))) && (this._blockElement)))
            {
                newParent.createContentElement();
            };
            super.setParentAndRelativeStart(newParent, newStart);
            if (parent)
            {
                if (parent.hasBlockElement())
                {
                    if (!this._blockElement)
                    {
                        this.createContentElement();
                    }
                    else
                    {
                        if (hasBlock)
                        {
                            parent.insertBlockElement(this, this._blockElement);
                        };
                    };
                }
                else
                {
                    if (this._blockElement)
                    {
                        this.releaseContentElement();
                    };
                };
            };
        }

        tlf_internal function quickInitializeForSplit(sibling:FlowLeafElement, newSpanLength:int, newSpanTextElement:TextElement):void
        {
            setTextLength(newSpanLength);
            this._blockElement = newSpanTextElement;
            if (this._blockElement)
            {
                this._text = this._blockElement.text;
            };
            quickCloneTextLayoutFormat(sibling);
            var tf:TextFlow = sibling.getTextFlow();
            if (((tf == null) || (tf.formatResolver == null)))
            {
                _computedFormat = sibling._computedFormat;
                if (this._blockElement)
                {
                    this._blockElement.elementFormat = sibling.getElementFormat();
                };
            };
        }

        public function getNextLeaf(limitElement:FlowGroupElement=null):FlowLeafElement
        {
            if (!parent)
            {
                return (null);
            };
            return (parent.getNextLeafHelper(limitElement, this));
        }

        public function getPreviousLeaf(limitElement:FlowGroupElement=null):FlowLeafElement
        {
            if (!parent)
            {
                return (null);
            };
            return (parent.getPreviousLeafHelper(limitElement, this));
        }

        override public function getCharAtPosition(relativePosition:int):String
        {
            return ((this._text) ? this._text.charAt(relativePosition) : "");
        }

        override tlf_internal function normalizeRange(normalizeStart:uint, normalizeEnd:uint):void
        {
            if (this._blockElement)
            {
                this.computedFormat;
            };
        }

        public function getComputedFontMetrics():FontMetrics
        {
            if (!this._blockElement)
            {
                this.createContentElement();
            };
            if (!this._blockElement)
            {
                return (null);
            };
            var ef:ElementFormat = this._blockElement.elementFormat;
            if (!ef)
            {
                return (null);
            };
            var tf:TextFlow = getTextFlow();
            if ((((tf) && (tf.flowComposer)) && (tf.flowComposer.swfContext)))
            {
                return (tf.flowComposer.swfContext.callInContext(ef.getFontMetrics, ef, null, true));
            };
            return (ef.getFontMetrics());
        }

        tlf_internal function computeElementFormat():ElementFormat
        {
            var tf:TextFlow = getTextFlow();
            return (computeElementFormatHelper(_computedFormat, getParagraph(), (((tf) && (tf.flowComposer)) ? tf.flowComposer.swfContext : null)));
        }

        override public function get computedFormat():ITextLayoutFormat
        {
            if (!_computedFormat)
            {
                _computedFormat = doComputeTextLayoutFormat();
                if (this._blockElement)
                {
                    this._blockElement.elementFormat = this.computeElementFormat();
                };
            };
            return (_computedFormat);
        }

        tlf_internal function getEffectiveLineHeight(blockProgression:String):Number
        {
            if (((blockProgression == BlockProgression.RL) && (parent is TCYElement)))
            {
                return (0);
            };
            return (TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(this.computedFormat.lineHeight, this.getEffectiveFontSize()));
        }

        tlf_internal function getCSSInlineBox(blockProgression:String, textLine:TextLine, para:ParagraphElement=null, swfContext:ISWFContext=null):Rectangle
        {
            if (((blockProgression == BlockProgression.RL) && (parent is TCYElement)))
            {
                return (null);
            };
            return (getCSSInlineBoxHelper(this.computedFormat, this.getComputedFontMetrics(), textLine, para));
        }

        tlf_internal function getEffectiveFontSize():Number
        {
            return (Number(this.computedFormat.fontSize));
        }

        tlf_internal function getSpanBoundsOnLine(textLine:TextLine, blockProgression:String):Array
        {
            var spanText:String;
            var line:TextFlowLine = TextFlowLine(textLine.userData);
            var paraStart:int = line.paragraph.getAbsoluteStart();
            var lineEnd:int = ((line.absoluteStart + line.textLength) - paraStart);
            var spanStart:int = (getAbsoluteStart() - paraStart);
            var endPos:int = (spanStart + this.text.length);
            var startPos:int = Math.max(spanStart, (line.absoluteStart - paraStart));
            if (endPos >= lineEnd)
            {
                endPos = lineEnd;
                spanText = this.text;
                while (((endPos > startPos) && (CharacterUtil.isWhitespace(spanText.charCodeAt(((endPos - spanStart) - 1))))))
                {
                    endPos--;
                };
            };
            var mainRects:Array = [];
            line.calculateSelectionBounds(textLine, mainRects, startPos, endPos, blockProgression, [line.textHeight, 0]);
            return (mainRects);
        }

        tlf_internal function updateIMEAdornments(tLine:TextLine, blockProgression:String, imeStatus:String):void
        {
            var imeLineThickness:int;
            var imeLineColor:uint;
            var imeLineStartX:Number;
            var imeLineStartY:Number;
            var imeLineEndX:Number;
            var imeLineEndY:Number;
            var spanBounds:Rectangle;
            var stOffset:Number;
            var ulOffset:Number;
            var selObj:Shape;
            var line:TextFlowLine;
            var elemIdx:int;
            var tcyParent:TCYElement;
            var tcyAdornBounds:Rectangle;
            var baseULAdjustment:Number;
            var metrics:FontMetrics = this.getComputedFontMetrics();
            var spanBoundsArray:Array = this.getSpanBoundsOnLine(tLine, blockProgression);
            var i:int;
            while (i < spanBoundsArray.length)
            {
                imeLineThickness = 1;
                imeLineColor = 0;
                imeLineStartX = 0;
                imeLineStartY = 0;
                imeLineEndX = 0;
                imeLineEndY = 0;
                if (((imeStatus == IMEStatus.SELECTED_CONVERTED) || (imeStatus == IMEStatus.SELECTED_RAW)))
                {
                    imeLineThickness = 2;
                };
                if ((((imeStatus == IMEStatus.SELECTED_RAW) || (imeStatus == IMEStatus.NOT_SELECTED_RAW)) || (imeStatus == IMEStatus.DEAD_KEY_INPUT_STATE)))
                {
                    imeLineColor = 0xA6A6A6;
                };
                spanBounds = (spanBoundsArray[i] as Rectangle);
                stOffset = this.calculateStrikeThrough(tLine, blockProgression, metrics);
                ulOffset = this.calculateUnderlineOffset(stOffset, blockProgression, metrics, tLine);
                if (blockProgression != BlockProgression.RL)
                {
                    imeLineStartX = (spanBounds.topLeft.x + 1);
                    imeLineEndX = ((spanBounds.topLeft.x + spanBounds.width) - 1);
                    imeLineStartY = ulOffset;
                    imeLineEndY = ulOffset;
                }
                else
                {
                    line = (tLine.userData as TextFlowLine);
                    elemIdx = (this.getAbsoluteStart() - line.absoluteStart);
                    imeLineStartY = (spanBounds.topLeft.y + 1);
                    imeLineEndY = ((spanBounds.topLeft.y + spanBounds.height) - 1);
                    if ((((elemIdx < 0) || (tLine.atomCount <= elemIdx)) || (!(tLine.getAtomTextRotation(elemIdx) == TextRotation.ROTATE_0))))
                    {
                        imeLineStartX = ulOffset;
                        imeLineEndX = ulOffset;
                    }
                    else
                    {
                        tcyParent = (this.getParentByType(TCYElement) as TCYElement);
                        if ((this.getAbsoluteStart() + this.textLength) == (tcyParent.getAbsoluteStart() + tcyParent.textLength))
                        {
                            tcyAdornBounds = new Rectangle();
                            tcyParent.calculateAdornmentBounds(tcyParent, tLine, blockProgression, tcyAdornBounds);
                            baseULAdjustment = (metrics.underlineOffset + (metrics.underlineThickness / 2));
                            imeLineStartY = (tcyAdornBounds.top + 1);
                            imeLineEndY = (tcyAdornBounds.bottom - 1);
                            imeLineStartX = (spanBounds.bottomRight.x + baseULAdjustment);
                            imeLineEndX = (spanBounds.bottomRight.x + baseULAdjustment);
                        };
                    };
                };
                selObj = new Shape();
                selObj.alpha = 1;
                selObj.graphics.beginFill(imeLineColor);
                selObj.graphics.lineStyle(imeLineThickness, imeLineColor, selObj.alpha);
                selObj.graphics.moveTo(imeLineStartX, imeLineStartY);
                selObj.graphics.lineTo(imeLineEndX, imeLineEndY);
                selObj.graphics.endFill();
                tLine.addChild(selObj);
                i++;
            };
        }

        tlf_internal function updateAdornments(tLine:TextLine, blockProgression:String):int
        {
            var spanBoundsArray:Array;
            var i:int;
            if ((((_computedFormat.textDecoration == TextDecoration.UNDERLINE) || (_computedFormat.lineThrough)) || ((_computedFormat.backgroundAlpha > 0) && (!(_computedFormat.backgroundColor == BackgroundColor.TRANSPARENT)))))
            {
                spanBoundsArray = this.getSpanBoundsOnLine(tLine, blockProgression);
                i = 0;
                while (i < spanBoundsArray.length)
                {
                    this.updateAdornmentsOnBounds(tLine, blockProgression, spanBoundsArray[i]);
                    i++;
                };
                return (spanBoundsArray.length);
            };
            return (0);
        }

        private function updateAdornmentsOnBounds(tLine:TextLine, blockProgression:String, spanBounds:Rectangle):void
        {
            var shape:Shape;
            var g:Graphics;
            var stOffset:Number;
            var ulOffset:Number;
            var line:TextFlowLine;
            var elemIdx:int;
            var tcyParent:TCYElement;
            var tcyPara:ParagraphElement;
            var lowerLocale:String;
            var adornRight:Boolean;
            var tcyAdornBounds:Rectangle;
            var baseULAdjustment:Number;
            var xCoor:Number;
            var tcyMid:Number;
            var peekLine:TextLine;
            var metrics:FontMetrics = this.getComputedFontMetrics();
            var backgroundOnly:* = (!((_computedFormat.textDecoration == TextDecoration.UNDERLINE) || (_computedFormat.lineThrough)));
            if (!backgroundOnly)
            {
                shape = new Shape();
                shape.alpha = Number(_computedFormat.textAlpha);
                g = shape.graphics;
                stOffset = this.calculateStrikeThrough(tLine, blockProgression, metrics);
                ulOffset = this.calculateUnderlineOffset(stOffset, blockProgression, metrics, tLine);
            };
            if (blockProgression != BlockProgression.RL)
            {
                this.addBackgroundRect(tLine, metrics, spanBounds, true);
                if (_computedFormat.textDecoration == TextDecoration.UNDERLINE)
                {
                    g.lineStyle(metrics.underlineThickness, (_computedFormat.color as uint));
                    g.moveTo(spanBounds.topLeft.x, ulOffset);
                    g.lineTo((spanBounds.topLeft.x + spanBounds.width), ulOffset);
                };
                if (_computedFormat.lineThrough)
                {
                    g.lineStyle(metrics.strikethroughThickness, (_computedFormat.color as uint));
                    g.moveTo(spanBounds.topLeft.x, stOffset);
                    g.lineTo((spanBounds.topLeft.x + spanBounds.width), stOffset);
                };
            }
            else
            {
                line = (tLine.userData as TextFlowLine);
                elemIdx = (this.getAbsoluteStart() - line.absoluteStart);
                if ((((elemIdx < 0) || (tLine.atomCount <= elemIdx)) || (!(tLine.getAtomTextRotation(elemIdx) == TextRotation.ROTATE_0))))
                {
                    this.addBackgroundRect(tLine, metrics, spanBounds, false);
                    if (_computedFormat.textDecoration == TextDecoration.UNDERLINE)
                    {
                        g.lineStyle(metrics.underlineThickness, (_computedFormat.color as uint));
                        g.moveTo(ulOffset, spanBounds.topLeft.y);
                        g.lineTo(ulOffset, (spanBounds.topLeft.y + spanBounds.height));
                    };
                    if (_computedFormat.lineThrough == true)
                    {
                        g.lineStyle(metrics.strikethroughThickness, (_computedFormat.color as uint));
                        g.moveTo(-(stOffset), spanBounds.topLeft.y);
                        g.lineTo(-(stOffset), (spanBounds.topLeft.y + spanBounds.height));
                    };
                }
                else
                {
                    this.addBackgroundRect(tLine, metrics, spanBounds, true, true);
                    if (!backgroundOnly)
                    {
                        tcyParent = (this.getParentByType(TCYElement) as TCYElement);
                        tcyPara = (this.getParentByType(ParagraphElement) as ParagraphElement);
                        lowerLocale = tcyPara.computedFormat.locale.toLowerCase();
                        adornRight = (!(lowerLocale.indexOf("zh") == 0));
                        if ((this.getAbsoluteStart() + this.textLength) == (tcyParent.getAbsoluteStart() + tcyParent.textLength))
                        {
                            tcyAdornBounds = new Rectangle();
                            tcyParent.calculateAdornmentBounds(tcyParent, tLine, blockProgression, tcyAdornBounds);
                            if (_computedFormat.textDecoration == TextDecoration.UNDERLINE)
                            {
                                g.lineStyle(metrics.underlineThickness, (_computedFormat.color as uint));
                                baseULAdjustment = (metrics.underlineOffset + (metrics.underlineThickness / 2));
                                xCoor = ((adornRight) ? spanBounds.right : spanBounds.left);
                                if (!adornRight)
                                {
                                    baseULAdjustment = -(baseULAdjustment);
                                };
                                g.moveTo((xCoor + baseULAdjustment), tcyAdornBounds.top);
                                g.lineTo((xCoor + baseULAdjustment), tcyAdornBounds.bottom);
                            };
                            if (_computedFormat.lineThrough == true)
                            {
                                tcyMid = (spanBounds.bottomRight.x - tcyAdornBounds.x);
                                tcyMid = (tcyMid / 2);
                                tcyMid = (tcyMid + tcyAdornBounds.x);
                                g.lineStyle(metrics.strikethroughThickness, (_computedFormat.color as uint));
                                g.moveTo(tcyMid, tcyAdornBounds.top);
                                g.lineTo(tcyMid, tcyAdornBounds.bottom);
                            };
                        };
                    };
                };
            };
            if (shape)
            {
                peekLine = (tLine.userData as TextFlowLine).peekTextLine();
                if (((peekLine) && (!(tLine == peekLine))))
                {
                    tLine = peekLine;
                };
                tLine.addChild(shape);
            };
        }

        private function addBackgroundRect(tLine:TextLine, metrics:FontMetrics, spanBounds:Rectangle, horizontalText:Boolean, isTCY:Boolean=false):void
        {
            var desiredExtent:Number;
            var baselineShift:Number;
            var fontSize:Number;
            var baseStrikethroughOffset:Number;
            var glyphAscent:Number;
            var lineDescent:Number;
            var glyphDescent:Number;
            var lineAscent:Number;
            if (((_computedFormat.backgroundAlpha == 0) || (_computedFormat.backgroundColor == BackgroundColor.TRANSPARENT)))
            {
                return;
            };
            var tf:TextFlow = this.getTextFlow();
            if (!tf.getBackgroundManager())
            {
                return;
            };
            var r:Rectangle = spanBounds.clone();
            if (((!(isTCY)) && ((_computedFormat.baselineShift == BaselineShift.SUPERSCRIPT) || (_computedFormat.baselineShift == BaselineShift.SUBSCRIPT))))
            {
                fontSize = this.getEffectiveFontSize();
                baseStrikethroughOffset = (metrics.strikethroughOffset + (metrics.strikethroughThickness / 2));
                if (_computedFormat.baselineShift == BaselineShift.SUPERSCRIPT)
                {
                    glyphAscent = (-3 * baseStrikethroughOffset);
                    baselineShift = (-(metrics.superscriptOffset) * fontSize);
                    lineDescent = (tLine.getBaselinePosition(TextBaseline.DESCENT) - tLine.getBaselinePosition(TextBaseline.ROMAN));
                    desiredExtent = ((glyphAscent + baselineShift) + lineDescent);
                    if (horizontalText)
                    {
                        if (desiredExtent > r.height)
                        {
                            r.y = (r.y - (desiredExtent - r.height));
                            r.height = desiredExtent;
                        };
                    }
                    else
                    {
                        if (desiredExtent > r.width)
                        {
                            r.width = desiredExtent;
                        };
                    };
                }
                else
                {
                    glyphDescent = -(baseStrikethroughOffset);
                    baselineShift = (metrics.subscriptOffset * fontSize);
                    lineAscent = (tLine.getBaselinePosition(TextBaseline.ROMAN) - tLine.getBaselinePosition(TextBaseline.ASCENT));
                    desiredExtent = ((lineAscent + baselineShift) + glyphDescent);
                    if (horizontalText)
                    {
                        if (desiredExtent > r.height)
                        {
                            r.height = desiredExtent;
                        };
                    }
                    else
                    {
                        if (desiredExtent > r.width)
                        {
                            r.x = (r.x - (desiredExtent - r.width));
                            r.width = desiredExtent;
                        };
                    };
                };
            };
            tf.backgroundManager.addRect(tLine, this, r, _computedFormat.backgroundColor, _computedFormat.backgroundAlpha);
        }

        tlf_internal function calculateStrikeThrough(textLine:TextLine, blockProgression:String, metrics:FontMetrics):Number
        {
            var underlineAndStrikeThroughShift:int;
            var effectiveFontSize:Number = this.getEffectiveFontSize();
            if (_computedFormat.baselineShift == BaselineShift.SUPERSCRIPT)
            {
                underlineAndStrikeThroughShift = -(metrics.superscriptOffset * effectiveFontSize);
            }
            else
            {
                if (_computedFormat.baselineShift == BaselineShift.SUBSCRIPT)
                {
                    underlineAndStrikeThroughShift = int(-(metrics.subscriptOffset * (effectiveFontSize / metrics.subscriptScale)));
                }
                else
                {
                    underlineAndStrikeThroughShift = TextLayoutFormat.baselineShiftProperty.computeActualPropertyValue(_computedFormat.baselineShift, effectiveFontSize);
                };
            };
            var domBaselineString:String = resolveDomBaseline(this.computedFormat, getParagraph());
            var alignmentBaselineString:String = this.computedFormat.alignmentBaseline;
            var alignDomBaselineAdjustment:Number = textLine.getBaselinePosition(domBaselineString);
            if (((!(alignmentBaselineString == TextBaseline.USE_DOMINANT_BASELINE)) && (!(alignmentBaselineString == domBaselineString))))
            {
                alignDomBaselineAdjustment = textLine.getBaselinePosition(alignmentBaselineString);
            };
            var stOffset:Number = metrics.strikethroughOffset;
            if (domBaselineString == TextBaseline.IDEOGRAPHIC_CENTER)
            {
                stOffset = 0;
            }
            else
            {
                if (((domBaselineString == TextBaseline.IDEOGRAPHIC_TOP) || (domBaselineString == TextBaseline.ASCENT)))
                {
                    stOffset = (stOffset * -2);
                    stOffset = (stOffset - (2 * metrics.strikethroughThickness));
                }
                else
                {
                    if (((domBaselineString == TextBaseline.IDEOGRAPHIC_BOTTOM) || (domBaselineString == TextBaseline.DESCENT)))
                    {
                        stOffset = (stOffset * 2);
                        stOffset = (stOffset + (2 * metrics.strikethroughThickness));
                    }
                    else
                    {
                        stOffset = (stOffset - metrics.strikethroughThickness);
                    };
                };
            };
            stOffset = (stOffset + (alignDomBaselineAdjustment - underlineAndStrikeThroughShift));
            return (stOffset);
        }

        tlf_internal function calculateUnderlineOffset(stOffset:Number, blockProgression:String, metrics:FontMetrics, textLine:TextLine):Number
        {
            var para:ParagraphElement;
            var ulOffset:Number = (metrics.underlineOffset + metrics.underlineThickness);
            var baseSTAdjustment:Number = metrics.strikethroughOffset;
            if (blockProgression != BlockProgression.RL)
            {
                ulOffset = (ulOffset + ((stOffset - baseSTAdjustment) + (metrics.underlineThickness / 2)));
            }
            else
            {
                para = this.getParagraph();
                if (para.computedFormat.locale.toLowerCase().indexOf("zh") == 0)
                {
                    ulOffset = -(ulOffset);
                    ulOffset = (ulOffset - ((stOffset - baseSTAdjustment) + (metrics.underlineThickness * 2)));
                }
                else
                {
                    ulOffset = (ulOffset - (((-(ulOffset) + stOffset) + baseSTAdjustment) + (metrics.underlineThickness / 2)));
                };
            };
            return (ulOffset);
        }


    }
}

