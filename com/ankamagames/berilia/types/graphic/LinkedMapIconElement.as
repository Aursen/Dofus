package com.ankamagames.berilia.types.graphic
{
    import com.ankamagames.berilia.components.TextureBase;
    import flash.display.Sprite;
    import flash.display.DisplayObjectContainer;
    import flash.geom.ColorTransform;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.display.LineScaleMode;
    import flash.filters.GlowFilter;

    public class LinkedMapIconElement extends MapIconElement 
    {

        public var link:LinkedMapIconElement;
        public var tex:TextureBase;
        private var _sprite:Sprite;
        private var _root:DisplayObjectContainer;

        public function LinkedMapIconElement(link:LinkedMapIconElement, id:String, x:int, y:int, layer:String, texture:TextureBase, color:int, legend:String, owner:*, canBeManuallyRemoved:Boolean=true, mouseEnabled:Boolean=false, allowDuplicate:Boolean=false, priority:uint=0)
        {
            var R:int;
            var V:int;
            var B:int;
            var ct:ColorTransform;
            if (texture)
            {
                super(id, x, y, layer, texture, color, legend, owner, canBeManuallyRemoved, mouseEnabled, allowDuplicate, priority);
                this.tex = texture;
                this.tex.alpha = 0.9;
                this.tex.scale = 0.4;
                if (color != -1)
                {
                    R = ((color >> 16) & 0xFF);
                    V = ((color >> 8) & 0xFF);
                    B = ((color >> 0) & 0xFF);
                    ct = new ColorTransform(0.6, 0.6, 0.6, 1, (R - 80), (V - 80), (B - 80));
                    texture.transform.colorTransform = ct;
                };
            };
            this.link = link;
            if (link != null)
            {
                this._sprite = new Sprite();
                if (this.tex)
                {
                    this.tex.addEventListener(Event.ENTER_FRAME, this.update, false, 0, true);
                };
            };
        }

        public function update(e:Event):void
        {
            if (((((this.link.tex.parent == null) || (this.tex.parent == null)) || (this.tex.width == 0)) || (this.link.tex.width == 0)))
            {
                return;
            };
            if (this._root == null)
            {
                this._root = this.tex.parent.parent.parent;
                this._root.addChild(this._sprite);
                this.tex.removeEventListener(Event.ENTER_FRAME, this.update);
            };
            var _local_2:Rectangle = this.link.tex.getRect(this._root);
            var from:Rectangle = this.tex.getRect(this._root);
            this._sprite.graphics.clear();
            this._sprite.graphics.lineStyle(10, color, 1, false, LineScaleMode.NONE, null, null, 3);
            this._sprite.graphics.moveTo((from.x + (from.width * 0.5)), (from.y + (from.height * 0.5)));
            this._sprite.graphics.lineTo((_local_2.x + (_local_2.width * 0.5)), (_local_2.y + (_local_2.height * 0.5)));
            this._sprite.filters = new Array(new GlowFilter(0, 1, 3, 3, 2, 3));
        }

        override public function remove():void
        {
            if (((!(this._sprite == null)) && (!(this._root == null))))
            {
                this._root.removeChild(this._sprite);
            };
            super.remove();
        }


    }
}

