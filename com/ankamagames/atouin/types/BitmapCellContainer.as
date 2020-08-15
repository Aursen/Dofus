package com.ankamagames.atouin.types
{
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class BitmapCellContainer implements ICellContainer 
    {

        private var _destPoint:Point;
        private var _srcRect:Rectangle;
        private var _cellId:int = 0;
        private var _layerId:int = 0;
        private var _startX:int = 0;
        private var _startY:int = 0;
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _depth:int = 0;
        public var datas:Array = new Array();
        public var bitmaps:Array = new Array();
        public var colorTransforms:Array = new Array();
        private var _numChildren:int = 0;

        public function BitmapCellContainer(id:uint)
        {
        }

        public function get cacheAsBitmap():Boolean
        {
            return (false);
        }

        public function set cacheAsBitmap(val:Boolean):void
        {
        }

        public function get mouseChildren():Boolean
        {
            return (false);
        }

        public function set mouseChildren(val:Boolean):void
        {
        }

        public function get mouseEnabled():Boolean
        {
            return (false);
        }

        public function set mouseEnabled(val:Boolean):void
        {
        }

        public function get cellId():uint
        {
            return (this._cellId);
        }

        public function set cellId(val:uint):void
        {
            this._cellId = val;
        }

        public function get layerId():int
        {
            return (this._layerId);
        }

        public function set layerId(val:int):void
        {
            this._layerId = val;
        }

        public function get startX():int
        {
            return (this._startX);
        }

        public function set startX(val:int):void
        {
            this._startX = val;
        }

        public function get startY():int
        {
            return (this._startY);
        }

        public function set startY(val:int):void
        {
            this._startY = val;
        }

        public function get x():Number
        {
            return (this._x);
        }

        public function set x(val:Number):void
        {
            this._x = val;
        }

        public function get y():Number
        {
            return (this._y);
        }

        public function set y(val:Number):void
        {
            this._y = val;
        }

        public function get depth():int
        {
            return (this._depth);
        }

        public function set depth(val:int):void
        {
            this._depth = val;
        }

        public function get numChildren():int
        {
            return (this._numChildren);
        }

        public function addFakeChild(child:Object, data:Object, colors:Object):void
        {
            this.colorTransforms[this._numChildren] = colors;
            this.datas[this._numChildren] = data;
            var _local_4:* = this._numChildren++;
            this.bitmaps[_local_4] = child;
        }


    }
}

