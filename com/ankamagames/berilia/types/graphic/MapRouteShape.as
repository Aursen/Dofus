package com.ankamagames.berilia.types.graphic
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import flash.filters.GlowFilter;
    import com.ankamagames.berilia.components.Texture;
    import flash.display.Graphics;

    public class MapRouteShape extends MapDisplayableElement 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapRouteShape));

        private var _coordList:Vector.<int>;
        private var _lineColor:uint;
        private var _lineAlpha:Number;
        private var _thickness:int;
        private var _completionColor:uint;
        private var _completionAlpha:Number;

        public function MapRouteShape(id:String, layer:String, texture:Texture, x:int, y:int, coordList:Vector.<int>, owner:*, lineColor:uint, lineAlpha:Number=1, thickness:int=4, completionColor:uint=0, completionAlpha:Number=0.5)
        {
            this._coordList = coordList;
            this._lineColor = lineColor;
            this._lineAlpha = lineAlpha;
            this._thickness = thickness;
            this._completionColor = completionColor;
            this._completionAlpha = completionAlpha;
            super(id, x, y, layer, owner, texture);
            texture.filters = [new GlowFilter(0xFFFFFF, 0.5, 3, 3, 2, 3)];
        }

        public function updateCompletion(lastMapX:int, lastMapY:int, mapWidth:Number, mapHeight:Number):void
        {
            var i:int;
            var posX:int;
            var posY:int;
            if (((this._coordList.length < 2) || ((lastMapX == this._coordList[0]) && (lastMapY == this._coordList[1]))))
            {
                return;
            };
            var graphic:Graphics = _texture.graphics;
            graphic.clear();
            graphic.lineStyle(this._thickness, this._completionColor, this._completionAlpha, true);
            graphic.moveTo(((this._coordList[0] * mapWidth) + (mapWidth / 2)), ((this._coordList[1] * mapHeight) + (mapHeight / 2)));
            var coordCount:int = this._coordList.length;
            i = 2;
            while (i < coordCount)
            {
                posX = this._coordList[i];
                posY = this._coordList[(i + 1)];
                graphic.lineTo(((posX * mapWidth) + (mapWidth / 2)), ((posY * mapHeight) + (mapHeight / 2)));
                if (((lastMapX == posX) && (lastMapY == posY)))
                {
                    graphic.lineStyle(this._thickness, this._lineColor, this._lineAlpha, true);
                };
                i = (i + 2);
            };
        }

        override public function remove():void
        {
            super.remove();
        }


    }
} com.ankamagames.berilia.types.graphic

