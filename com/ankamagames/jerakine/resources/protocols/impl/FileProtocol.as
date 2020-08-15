package com.ankamagames.jerakine.resources.protocols.impl
{
    import com.ankamagames.jerakine.resources.protocols.AbstractFileProtocol;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.resources.IResourceObserver;
    import com.ankamagames.jerakine.newCache.ICache;
    import flash.filesystem.File;
    import com.ankamagames.jerakine.utils.system.SystemManager;
    import com.ankamagames.jerakine.enum.OperatingSystem;

    public class FileProtocol extends AbstractFileProtocol 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FileProtocol));
        public static var localDirectory:String;


        override public function load(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, cache:ICache, forcedAdapter:Class, singleFile:Boolean):void
        {
            var url:String;
            if (((singleFile) && (((!(uri.fileType == "swf")) || (!(uri.subPath))) || (uri.subPath.length == 0))))
            {
                _singleFileObserver = observer;
                this.loadDirectly(uri, this, dispatchProgress, forcedAdapter);
            }
            else
            {
                url = getUrl(uri);
                if (loadingFile[url])
                {
                    loadingFile[url].push(observer);
                }
                else
                {
                    loadingFile[url] = [observer];
                    this.loadDirectly(uri, this, dispatchProgress, forcedAdapter);
                };
            };
        }

        override protected function loadDirectly(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, forcedAdapter:Class):void
        {
            getAdapter(uri, forcedAdapter);
            _adapter.loadDirectly(uri, this.extractPath(uri.path), observer, dispatchProgress);
        }

        override protected function extractPath(path:String):String
        {
            var absolutePath:String;
            var absoluteFile:File;
            var originalPath:String = path;
            if (path.indexOf("..") != -1)
            {
                if (path.indexOf("./") == 0)
                {
                    absolutePath = ((File.applicationDirectory.nativePath + File.separator) + path);
                }
                else
                {
                    if (path.indexOf("/./") != -1)
                    {
                        absolutePath = ((File.applicationDirectory.nativePath + File.separator) + path.substr((path.indexOf("/./") + 3)));
                    }
                    else
                    {
                        absolutePath = path;
                    };
                };
                absoluteFile = new File(absolutePath);
                path = absoluteFile.url.replace("file:///", "");
            };
            if (path.indexOf("\\\\") != -1)
            {
                path = ("file://" + path.substr(path.indexOf("\\\\")));
            };
            if (((!(localDirectory == null)) && (path.indexOf("./") == 0)))
            {
                path = (localDirectory + path.substr(2));
            };
            if ((((!(SystemManager.getSingleton().os == OperatingSystem.WINDOWS)) && (path.charAt(0) == "/")) && (!(path.charAt(1) == "/"))))
            {
                path = ("/" + path);
            };
            return (path);
        }

        override public function onLoaded(uri:Uri, resourceType:uint, resource:*):void
        {
            var url:String;
            var waiting:Array;
            var observer:IResourceObserver = _singleFileObserver;
            if (observer)
            {
                observer.onLoaded(uri, resourceType, resource);
                _singleFileObserver = null;
            }
            else
            {
                url = getUrl(uri);
                if (((loadingFile[url]) && (loadingFile[url].length)))
                {
                    waiting = loadingFile[url];
                    delete loadingFile[url];
                    for each (observer in waiting)
                    {
                        IResourceObserver(observer).onLoaded(uri, resourceType, resource);
                    };
                };
            };
        }

        override public function onFailed(uri:Uri, errorMsg:String, errorCode:uint):void
        {
            var url:String;
            var waiting:Array;
            _log.warn(("onFailed " + uri));
            var observer:IResourceObserver = _singleFileObserver;
            if (observer)
            {
                observer.onFailed(uri, errorMsg, errorCode);
                _singleFileObserver = null;
            }
            else
            {
                url = getUrl(uri);
                if (((loadingFile[url]) && (loadingFile[url].length)))
                {
                    waiting = loadingFile[url];
                    delete loadingFile[url];
                    for each (observer in waiting)
                    {
                        IResourceObserver(observer).onFailed(uri, errorMsg, errorCode);
                    };
                };
            };
        }

        override public function onProgress(uri:Uri, bytesLoaded:uint, bytesTotal:uint):void
        {
            var url:String;
            var waiting:Array;
            var observer:IResourceObserver = _singleFileObserver;
            if (observer)
            {
                observer.onProgress(uri, bytesLoaded, bytesTotal);
                _singleFileObserver = null;
            }
            else
            {
                url = getUrl(uri);
                if (((loadingFile[url]) && (loadingFile[url].length)))
                {
                    waiting = loadingFile[url];
                    delete loadingFile[url];
                    for each (observer in waiting)
                    {
                        IResourceObserver(observer).onProgress(uri, bytesLoaded, bytesTotal);
                    };
                };
            };
        }


    }
}

