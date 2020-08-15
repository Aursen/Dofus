package com.ankamagames.jerakine.utils.crypto
{
    import flash.events.EventDispatcher;
    import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
    import flash.filesystem.File;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
    import flash.events.ErrorEvent;
    import flash.events.Event;

    public class FolderHashChecker extends EventDispatcher 
    {

        public static const ERROR_SIG:uint = 0;
        public static const ERROR_SIZE:uint = 1;
        public static const ERROR_HASH:uint = 2;

        private var _loader:IResourceLoader;
        private var _hashRoot:File;
        private var _metaUri:Uri;
        private var _onInit:Function;

        public function FolderHashChecker(metaPath:Uri, onInit:Function=null)
        {
            this._onInit = onInit;
            this._metaUri = metaPath;
            this._hashRoot = metaPath.toFile().parent;
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onMetaLoaded, false, 0, true);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onMetaLoadFailed, false, 0, true);
            this._loader.load(metaPath);
        }

        private function onMetaLoadFailed(e:ResourceErrorEvent):void
        {
            dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, ("Invalid signature for " + this._metaUri), ERROR_HASH));
        }

        private function onMetaLoaded(e:ResourceLoadedEvent):void
        {
            this.processXML(e.resource);
        }

        private function processXML(xml:XML):void
        {
            var node:XML;
            var fileSize:uint;
            for each (node in xml.filesVersions..file)
            {
                fileSize = this._hashRoot.resolvePath(node.@name).size;
                if (parseInt(node.toString()) != fileSize)
                {
                    dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, ("Invalid file size for " + this._hashRoot.resolvePath(node.@name).nativePath), ERROR_SIZE));
                    return;
                };
            };
            if (this._onInit != null)
            {
                this._onInit();
            }
            else
            {
                dispatchEvent(new Event(Event.INIT));
            };
        }


    }
}

