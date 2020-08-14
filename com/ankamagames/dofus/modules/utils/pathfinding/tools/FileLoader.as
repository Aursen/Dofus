package com.ankamagames.dofus.modules.utils.pathfinding.tools
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
    import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;

    public final class FileLoader 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(FileLoader));


        public static function loadExternalFile(path:String, onLoaded:Function):void
        {
            var uri:Uri = new Uri(path);
            var loader:IResourceLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            loader.addEventListener(ResourceErrorEvent.ERROR, loaderError, false, 0, true);
            loader.addEventListener(ResourceLoadedEvent.LOADED, loaderComplete, false, 0, true);
            if (onLoaded != null)
            {
                loader.addEventListener(ResourceLoadedEvent.LOADED, function loaderComplete (e:ResourceLoadedEvent):void
                {
                    onLoaded(e);
                }, false, 0);
            };
            try
            {
                loader.load(uri);
            }
            catch(error:Error)
            {
                _log.error(("Unable to load requested document. " + error));
            };
        }

        private static function loaderComplete(e:ResourceLoadedEvent):void
        {
            _log.info((e.uri + "successfully loaded !"));
        }

        private static function loaderError(e:ResourceErrorEvent):void
        {
            _log.error(((e.uri + " loading failed => ") + e.errorMsg));
        }


    }
} com.ankamagames.dofus.modules.utils.pathfinding.tools

