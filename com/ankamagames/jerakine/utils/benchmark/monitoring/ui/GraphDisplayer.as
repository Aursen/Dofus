package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
    import flash.display.Sprite;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.text.TextField;
    import flash.display.Bitmap;
    import flash.utils.Dictionary;
    import flash.text.TextFormat;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.text.TextFieldAutoSize;
    import flash.display.BitmapData;
    import flash.display.Shape;
    import flash.geom.Rectangle;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerUtils;
    import flash.utils.getTimer;
    import flash.events.Event;

    public class GraphDisplayer extends Sprite 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphDisplayer));

        private var _txtSprite:Sprite;
        private var _fpsTf:TextField;
        private var _memTf:TextField;
        public var previousFreeMem:Number;
        private var _graphSpr:Sprite;
        private var _graphDisplay:Bitmap;
        private var _graphToDisplay:Dictionary;
        private var _redrawRegionsVisible:Boolean = false;

        public function GraphDisplayer()
        {
            this._graphToDisplay = new Dictionary();
            this.initDisplay();
            this.initTexts();
        }

        private function initTexts():void
        {
            var tf:TextFormat;
            this._txtSprite = new Sprite();
            this._txtSprite.mouseEnabled = false;
            this._txtSprite.x = FpsManagerConst.PADDING_LEFT;
            this._txtSprite.y = FpsManagerConst.PADDING_TOP;
            tf = new TextFormat("Verdana", 13);
            tf.color = 0xFFFFFF;
            this._fpsTf = new TextField();
            this._fpsTf.y = -2;
            this._fpsTf.defaultTextFormat = tf;
            this._fpsTf.selectable = false;
            if (StageShareManager.stage)
            {
                this._fpsTf.text = (StageShareManager.stage.frameRate + " FPS");
            }
            else
            {
                this._fpsTf.text = "60 FPS";
            };
            this._txtSprite.addChild(this._fpsTf);
            this._memTf = new TextField();
            this._memTf.y = 32;
            this._memTf.defaultTextFormat = tf;
            this._memTf.selectable = false;
            this._memTf.text = "00 MB";
            this._memTf.autoSize = TextFieldAutoSize.LEFT;
            this._txtSprite.addChild(this._memTf);
            addChild(this._txtSprite);
        }

        private function initDisplay():void
        {
            graphics.beginFill(FpsManagerConst.BOX_COLOR, 0.7);
            graphics.lineStyle(FpsManagerConst.BOX_BORDER, 0);
            graphics.drawRoundRect(0, 0, FpsManagerConst.BOX_WIDTH, FpsManagerConst.BOX_HEIGHT, 8, 8);
            graphics.endFill();
            this._graphSpr = new Sprite();
            addChild(this._graphSpr);
            this._graphDisplay = new Bitmap(new BitmapData(FpsManagerConst.BOX_WIDTH, FpsManagerConst.BOX_HEIGHT, true, 0));
            this._graphDisplay.smoothing = true;
            addChild(this._graphDisplay);
            var spr:Shape = new Shape();
            spr.graphics.beginFill(0, 0.4);
            spr.graphics.drawRoundRect(0, 0, FpsManagerConst.BOX_FILTER_WIDTH, FpsManagerConst.BOX_HEIGHT, 8, 8);
            addChild(spr);
        }

        public function update(graphicalUpdate:Boolean=true):void
        {
            var py:int;
            var color:uint;
            var g:Graph;
            this.addConstValue(FpsManagerConst.SPECIAL_GRAPH[1].name, (1000 / StageShareManager.stage.frameRate));
            if (!graphicalUpdate)
            {
                return;
            };
            var px:int = (FpsManagerConst.BOX_WIDTH - 1);
            this._graphDisplay.bitmapData.lock();
            this._graphDisplay.bitmapData.scroll(-1, 0);
            this._graphDisplay.bitmapData.fillRect(new Rectangle(px, 1, 1, FpsManagerConst.BOX_HEIGHT), 0xFF0000);
            for each (g in this._graphToDisplay)
            {
                if (!FpsManagerUtils.isSpecialGraph(g.indice))
                {
                    this.addConstValue(g.indice);
                };
                g.setNewFrame();
                if (!((g.points.length == 0) || (!(g.graphVisible))))
                {
                    py = this.formateValue(g.points[(g.points.length - 1)]);
                    color = FpsManagerUtils.addAlphaToColor(g.color, 0xFFFFFFFF);
                    if (g.points.length >= 2)
                    {
                        this.linkGraphValues(px, py, this.formateValue(g.points[(g.points.length - 2)]), color);
                    };
                    this._graphDisplay.bitmapData.setPixel32(px, py, ((py == 1) ? 0xFFFF0000 : color));
                };
            };
            this._graphDisplay.bitmapData.unlock();
        }

        public function updateFpsValue(fpsValue:Number):void
        {
            this._fpsTf.text = (fpsValue.toFixed(1) + " FPS");
        }

        public function get memory():String
        {
            return (this._memTf.text);
        }

        public function set memory(val:String):void
        {
            this._memTf.text = val;
        }

        public function startTracking(pIndice:String, pColor:uint=0xFFFFFF):void
        {
            var graph:Graph = this._graphToDisplay[pIndice];
            if (graph == null)
            {
                graph = new Graph(pIndice, pColor);
                graph.addEventListener("showGraph", this.showGraph);
                graph.addEventListener("hideGraph", this.hideGraph);
                if (!FpsManagerUtils.isSpecialGraph(pIndice))
                {
                    graph.setMenuPosition(((FpsManagerUtils.countKeys(this._graphToDisplay) - FpsManagerUtils.numberOfSpecialGraphDisplayed(this._graphToDisplay)) * 24), -25);
                };
                this._graphSpr.addChild(graph);
                this._graphToDisplay[pIndice] = graph;
            };
            graph.startTime = getTimer();
        }

        public function stopTracking(pIndice:String):void
        {
            var graph:Graph = this._graphToDisplay[pIndice];
            if (graph == null)
            {
                return;
            };
            var step:int = (getTimer() - graph.startTime);
            graph.insertNewValue(step);
            graph.startTime = 0;
            if (graph.points.length > FpsManagerConst.BOX_WIDTH)
            {
                graph.points.shift();
            };
        }

        public function addConstValue(pIndice:String, cst:int=0):void
        {
            var graph:Graph = this._graphToDisplay[pIndice];
            if (graph == null)
            {
                return;
            };
            graph.insertNewValue(cst);
            if (graph.points.length > FpsManagerConst.BOX_WIDTH)
            {
                graph.points.shift();
            };
        }

        private function showGraph(pEvt:Event):void
        {
            var px:int;
            var py:int;
            var g:Graph = (pEvt.currentTarget as Graph);
            var len:int = g.points.length;
            var it:int;
            var color:uint = FpsManagerUtils.addAlphaToColor(g.color, 0xFFFFFFFF);
            this._graphDisplay.bitmapData.lock();
            it = 0;
            while (it < len)
            {
                px = ((len < FpsManagerConst.BOX_WIDTH) ? ((FpsManagerConst.BOX_WIDTH - len) + it) : it);
                py = this.formateValue(g.points[it]);
                if (g.points.length >= 2)
                {
                    this.linkGraphValues(px, py, this.formateValue(g.points[(g.points.length - 2)]), color);
                };
                this._graphDisplay.bitmapData.setPixel32(px, py, color);
                it++;
            };
            this._graphDisplay.bitmapData.unlock();
        }

        private function hideGraph(pEvt:Event):void
        {
        }

        private function formateValue(py:int):int
        {
            var bottom:int = (FpsManagerConst.BOX_HEIGHT - 1);
            if (py < 1)
            {
                py = 1;
            }
            else
            {
                if (py > bottom)
                {
                    py = bottom;
                };
            };
            return ((py * -1) + FpsManagerConst.BOX_HEIGHT);
        }

        private function linkGraphValues(px:int, py1:int, py2:int, pColor:uint):void
        {
            if (Math.abs((py1 - py2)) > 1)
            {
                this._graphDisplay.bitmapData.fillRect(new Rectangle((px - 1), (((py1 > py2) ? py2 : py1) + 1), 1, (Math.abs((py1 - py2)) - 1)), pColor);
            };
        }

        public function getExternalGraphs():Array
        {
            var g:Graph;
            var datas:Array = new Array();
            for each (g in this._graphToDisplay)
            {
                datas.push({
                    "name":g.indice,
                    "points":g.points,
                    "color":g.color
                });
            };
            return (datas);
        }


    }
}

