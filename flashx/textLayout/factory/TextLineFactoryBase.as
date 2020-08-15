package flashx.textLayout.factory
{
    import flash.display.Sprite;
    import flashx.textLayout.compose.SimpleCompose;
    import flashx.textLayout.tlf_internal;
    import flash.geom.Rectangle;
    import flashx.textLayout.container.ContainerController;
    import flashx.textLayout.compose.ISWFContext;
    import flashx.textLayout.container.ScrollPolicy;
    import flash.text.engine.TextLine;
    import flash.text.engine.TextBlock;
    import flash.text.engine.TextLineValidity;
    import flashx.textLayout.compose.IFlowComposer;
    import flash.display.Shape;
    import flashx.textLayout.elements.TextFlow;

    use namespace tlf_internal;

    [Exclude(name="containerController", kind="property")]
    [Exclude(name="setContentBounds", kind="method")]
    [Exclude(name="callbackWithTextLines", kind="method")]
    [Exclude(name="doesComposedTextFit", kind="method")]
    [Exclude(name="getNextTruncationPosition", kind="method")]
    public class TextLineFactoryBase 
    {

        private static var _tc:Sprite = new Sprite();
        private static var _savedFactoryComposer:SimpleCompose;
        tlf_internal static var _factoryComposer:SimpleCompose;

        private var _compositionBounds:Rectangle;
        private var _contentBounds:Rectangle;
        protected var _isTruncated:Boolean = false;
        private var _horizontalScrollPolicy:String;
        private var _verticalScrollPolicy:String;
        private var _truncationOptions:TruncationOptions;
        private var _containerController:ContainerController;
        private var _swfContext:ISWFContext;
        protected var _truncationLineIndex:int;
        protected var _pass0Lines:Array;

        public function TextLineFactoryBase()
        {
            this._containerController = new ContainerController(_tc);
            this._horizontalScrollPolicy = (this._verticalScrollPolicy = String(ScrollPolicy.scrollPolicyPropertyDefinition.defaultValue));
        }

        tlf_internal static function peekFactoryCompose():SimpleCompose
        {
            if (_savedFactoryComposer == null)
            {
                _savedFactoryComposer = new SimpleCompose();
            };
            return (_savedFactoryComposer);
        }

        tlf_internal static function beginFactoryCompose():SimpleCompose
        {
            var rslt:SimpleCompose = _factoryComposer;
            _factoryComposer = peekFactoryCompose();
            _savedFactoryComposer = null;
            return (rslt);
        }

        tlf_internal static function endFactoryCompose(prevComposer:SimpleCompose):void
        {
            _savedFactoryComposer = _factoryComposer;
            _factoryComposer = prevComposer;
        }

        tlf_internal static function getDefaultFlowComposerClass():Class
        {
            return (FactoryDisplayComposer);
        }


        public function get compositionBounds():Rectangle
        {
            return (this._compositionBounds);
        }

        public function set compositionBounds(value:Rectangle):void
        {
            this._compositionBounds = value;
        }

        public function getContentBounds():Rectangle
        {
            return (this._contentBounds);
        }

        protected function setContentBounds(controllerBounds:Rectangle):void
        {
            this._contentBounds = controllerBounds;
            this._contentBounds.offset(this.compositionBounds.left, this.compositionBounds.top);
        }

        public function get swfContext():ISWFContext
        {
            return (this._swfContext);
        }

        public function set swfContext(value:ISWFContext):void
        {
            this._swfContext = value;
        }

        public function get truncationOptions():TruncationOptions
        {
            return (this._truncationOptions);
        }

        public function set truncationOptions(value:TruncationOptions):void
        {
            this._truncationOptions = value;
        }

        public function get isTruncated():Boolean
        {
            return (this._isTruncated);
        }

        public function get horizontalScrollPolicy():String
        {
            return (this._horizontalScrollPolicy);
        }

        public function set horizontalScrollPolicy(scrollPolicy:String):void
        {
            this._horizontalScrollPolicy = scrollPolicy;
        }

        public function get verticalScrollPolicy():String
        {
            return (this._verticalScrollPolicy);
        }

        public function set verticalScrollPolicy(scrollPolicy:String):void
        {
            this._verticalScrollPolicy = scrollPolicy;
        }

        protected function get containerController():ContainerController
        {
            return (this._containerController);
        }

        protected function callbackWithTextLines(callback:Function, delx:Number, dely:Number):void
        {
            var textLine:TextLine;
            var textBlock:TextBlock;
            for each (textLine in _factoryComposer._lines)
            {
                textBlock = textLine.textBlock;
                if (textBlock)
                {
                    textBlock.releaseLines(textBlock.firstLine, textBlock.lastLine);
                };
                textLine.userData = null;
                textLine.x = (textLine.x + delx);
                textLine.y = (textLine.y + dely);
                textLine.validity = TextLineValidity.STATIC;
                (callback(textLine));
            };
        }

        protected function doesComposedTextFit(lineCountLimit:int, textLength:uint, blockProgression:String):Boolean
        {
            if (((!(lineCountLimit == TruncationOptions.NO_LINE_COUNT_LIMIT)) && (_factoryComposer._lines.length > lineCountLimit)))
            {
                return (false);
            };
            var lines:Array = _factoryComposer._lines;
            if (!lines.length)
            {
                return ((textLength) ? false : true);
            };
            var lastLine:TextLine = (lines[(lines.length - 1)] as TextLine);
            return ((lastLine.userData + lastLine.rawTextLength) == textLength);
        }

        protected function getNextTruncationPosition(truncateAtCharPosition:int, multiPara:Boolean=false):int
        {
            truncateAtCharPosition--;
            var line:TextLine = (this._pass0Lines[this._truncationLineIndex] as TextLine);
            do 
            {
                if (((truncateAtCharPosition >= line.userData) && (truncateAtCharPosition < (line.userData + line.rawTextLength))))
                {
                    break;
                };
                if (truncateAtCharPosition < line.userData)
                {
                    line = (this._pass0Lines[--this._truncationLineIndex] as TextLine);
                };
            } while (true);
            var paraStart:int = ((multiPara) ? (line.userData - line.textBlockBeginIndex) : 0);
            var atomIndex:int = line.getAtomIndexAtCharIndex((truncateAtCharPosition - paraStart));
            var nextTruncationPosition:int = (line.getAtomTextBlockBeginIndex(atomIndex) + paraStart);
            return (nextTruncationPosition);
        }

        tlf_internal function createFlowComposer():IFlowComposer
        {
            return (new FactoryDisplayComposer());
        }

        tlf_internal function computeLastAllowedLineIndex(lineCountLimit:int):void
        {
            this._truncationLineIndex = (_factoryComposer._lines.length - 1);
            if (((!(lineCountLimit == TruncationOptions.NO_LINE_COUNT_LIMIT)) && (lineCountLimit <= this._truncationLineIndex)))
            {
                this._truncationLineIndex = (lineCountLimit - 1);
            };
        }

        tlf_internal function processBackgroundColors(textFlow:TextFlow, callback:Function, x:Number, y:Number, constrainWidth:Number, constrainHeight:Number):*
        {
            var bgShape:Shape = new Shape();
            textFlow.backgroundManager.drawAllRects(textFlow, bgShape, constrainWidth, constrainHeight);
            bgShape.x = x;
            bgShape.y = y;
            (callback(bgShape));
            textFlow.clearBackgroundManager();
        }


    }
}

