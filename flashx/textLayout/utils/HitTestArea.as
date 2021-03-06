package flashx.textLayout.utils
{
    import flash.geom.Rectangle;
    import flashx.textLayout.elements.FlowElement;
    import flashx.textLayout.tlf_internal;

    use namespace tlf_internal;

    [ExcludeClass]
    public class HitTestArea 
    {

        private var tl:HitTestArea = null;
        private var tr:HitTestArea = null;
        private var bl:HitTestArea = null;
        private var br:HitTestArea = null;
        private var _rect:Rectangle;
        private var _xm:Number;
        private var _ym:Number;
        private var _owner:FlowElement = null;

        public function HitTestArea(objects:Object)
        {
            this.initialize(objects);
        }

        tlf_internal function initialize(objects:Object):void
        {
            var obj:Object;
            var r:Rectangle;
            var quadrant:Rectangle;
            var dxLower:Number;
            var dxUpper:Number;
            var dyLower:Number;
            var dyUpper:Number;
            var count:int;
            if (objects)
            {
                for (obj in objects)
                {
                    if (++count > 1)
                    {
                        break;
                    };
                };
            };
            if (count == 0)
            {
                this._rect = new Rectangle();
                this._xm = (this._ym = 0);
                return;
            };
            if (count == 1)
            {
                for each (obj in objects)
                {
                    this._rect = obj.rect;
                    this._xm = this._rect.left;
                    this._ym = this._rect.top;
                    this._owner = obj.owner;
                    return;
                };
            };
            for each (obj in objects)
            {
                r = obj.rect;
                if (!this._rect)
                {
                    this._rect = r;
                }
                else
                {
                    this._rect = this._rect.union(r);
                };
            };
            this._xm = Math.ceil((this._rect.left + (this._rect.width / 2)));
            this._ym = Math.ceil((this._rect.top + (this._rect.height / 2)));
            if (((this._rect.width <= 3) || (this._rect.height <= 3)))
            {
                for each (obj in objects)
                {
                    this._owner = obj.owner;
                    return;
                };
            };
            for each (obj in objects)
            {
                r = obj.rect;
                if (r.equals(this._rect))
                {
                }
                else
                {
                    if (r.contains(this._xm, this._ym))
                    {
                        dxLower = (this._xm - r.left);
                        dxUpper = (r.right - this._xm);
                        dyLower = (this._ym - r.top);
                        dyUpper = (r.bottom - this._ym);
                        this._xm = ((dxLower > dxUpper) ? (this._xm + dxUpper) : (this._xm - dxLower));
                        this._ym = ((dyLower > dyUpper) ? (this._ym + dyUpper) : (this._ym - dyLower));
                        break;
                    };
                };
            };
            quadrant = new Rectangle(this._rect.left, this._rect.top, (this._xm - this._rect.left), (this._ym - this._rect.top));
            this.addQuadrant(objects, "tl", quadrant);
            quadrant.left = this._xm;
            quadrant.right = this._rect.right;
            this.addQuadrant(objects, "tr", quadrant);
            quadrant.left = this._rect.left;
            quadrant.top = this._ym;
            quadrant.right = this._xm;
            quadrant.bottom = this._rect.bottom;
            this.addQuadrant(objects, "bl", quadrant);
            quadrant.left = this._xm;
            quadrant.right = this._rect.right;
            this.addQuadrant(objects, "br", quadrant);
        }

        public function hitTest(x:Number, y:Number):FlowElement
        {
            if (!this._rect.contains(x, y))
            {
                return (null);
            };
            if (this._owner)
            {
                return (this._owner);
            };
            var quadrantName:String = ((y < this._ym) ? "t" : "b");
            quadrantName = (quadrantName + ((x < this._xm) ? "l" : "r"));
            var quadrant:HitTestArea = this[quadrantName];
            if (quadrant == null)
            {
                return (null);
            };
            return (quadrant.hitTest(x, y));
        }

        private function addQuadrant(objects:Object, propName:String, quadrant:Rectangle):void
        {
            var obj:Object;
            var intersect:Rectangle;
            if (quadrant.isEmpty())
            {
                return;
            };
            var qrects:Object = {};
            var i:int;
            for each (obj in objects)
            {
                intersect = obj.rect.intersection(quadrant);
                if (!intersect.isEmpty())
                {
                    var _local_10:* = i++;
                    qrects[_local_10] = {
                        "owner":obj.owner,
                        "rect":intersect
                    };
                };
            };
            if (i > 0)
            {
                this[propName] = new HitTestArea(qrects);
            };
        }


    }
}

