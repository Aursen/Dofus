package com.ankamagames.berilia.types.data
{
    import com.ankamagames.jerakine.newCache.ICache;
    import __AS3__.vec.Vector;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.jerakine.resources.loaders.impl.ParallelRessourceLoader;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.berilia.utils.UriCacheFactory;
    import com.ankamagames.jerakine.newCache.impl.Cache;
    import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import flash.geom.Rectangle;
    import __AS3__.vec.*;

    public class Map 
    {

        private static var _cache:ICache;

        public var currentScale:Number;
        public var initialWidth:uint;
        public var initialHeight:uint;
        public var chunckWidth:uint;
        public var chunckHeight:uint;
        public var zoom:Number;
        private var _areas:Vector.<MapArea>;
        public var container:DisplayObjectContainer;
        public var numXChunck:uint;
        public var numYChunck:uint;
        private var _visibleAreas:Vector.<MapArea>;
        private var _loader:ParallelRessourceLoader;

        public function Map(zoom:Number, srcFolder:String, container:DisplayObjectContainer, initialWidth:uint, initialHeight:uint, chunckWidth:uint, chunckHeight:uint)
        {
            var i:uint;
            var j:uint;
            var w:Number;
            var h:Number;
            var bitmapFolder:String;
            super();
            if (!_cache)
            {
                bitmapFolder = XmlConfig.getInstance().getEntry("config.gfx.path.maps");
                _cache = UriCacheFactory.init(bitmapFolder, new Cache(50, new LruGarbageCollector()));
            };
            this.zoom = zoom;
            this.container = container;
            this.initialHeight = initialHeight;
            this.initialWidth = initialWidth;
            this.chunckHeight = chunckHeight;
            this.chunckWidth = chunckWidth;
            this._visibleAreas = new Vector.<MapArea>();
            this._loader = new ParallelRessourceLoader(6);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoad);
            container.doubleClickEnabled = true;
            this.numXChunck = Math.ceil(((initialWidth * zoom) / chunckWidth));
            this.numYChunck = Math.ceil(((initialHeight * zoom) / chunckHeight));
            this._areas = new Vector.<MapArea>((this.numXChunck * this.numYChunck), true);
            var chunckId:uint = 1;
            j = 0;
            while (j < this.numYChunck)
            {
                i = 0;
                while (i < this.numXChunck)
                {
                    w = (chunckWidth / zoom);
                    h = (chunckHeight / zoom);
                    this.areas[(chunckId - 1)] = new MapArea(((srcFolder + chunckId) + ".jpg"), (i * w), (j * h), w, h, this);
                    chunckId++;
                    i++;
                };
                j++;
            };
        }

        public function get areas():Vector.<MapArea>
        {
            return (this._areas);
        }

        public function loadAreas(pViewRect:Rectangle):Vector.<MapArea>
        {
            var area:MapArea;
            this._visibleAreas.length = 0;
            var uris:Array = new Array();
            for each (area in this._areas)
            {
                if (pViewRect.intersects(area))
                {
                    if (!area.isUsed)
                    {
                        this.container.addChild(area.getBitmap());
                        uris.push(area.src);
                    };
                    this._visibleAreas.push(area);
                }
                else
                {
                    if (area.isUsed)
                    {
                        area.free();
                    };
                };
            };
            if (uris.length > 0)
            {
                this._loader.load(uris, _cache, null, true);
            };
            return (this._visibleAreas);
        }

        private function onLoad(pEvent:ResourceLoadedEvent):void
        {
            var area:MapArea;
            for each (area in this._visibleAreas)
            {
                if (pEvent.uri == area.src)
                {
                    area.setBitmap(pEvent.resource);
                    break;
                };
            };
        }


    }
}

