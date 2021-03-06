package com.ankamagames.tiphon.engine
{
    import flash.events.EventDispatcher;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.newCache.impl.InfiniteCache;
    import com.ankamagames.jerakine.types.Uri;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
    import __AS3__.vec.Vector;
    import flash.utils.Timer;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
    import com.ankamagames.tiphon.types.GraphicLibrary;
    import com.ankamagames.tiphon.TiphonConstants;
    import com.ankamagames.tiphon.types.AnimLibrary;
    import com.ankamagames.jerakine.types.Callback;
    import com.ankamagames.jerakine.types.Swl;
    import com.ankamagames.tiphon.events.SwlEvent;
    import flash.events.Event;
    import __AS3__.vec.*;

    public class LibrariesManager extends EventDispatcher 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(LibrariesManager));
        public static const TYPE_BONE:uint = 0;
        public static const TYPE_SKIN:uint = 1;
        private static var _cache:InfiniteCache = new InfiniteCache();
        private static var _uri:Uri;
        private static var numLM:int = 0;

        private var _aResources:Dictionary;
        private var _aResourceLoadFail:Dictionary;
        private var _aResourcesUri:Array;
        private var _aResourceStates:Array;
        private var _aWaiting:Array;
        private var _aWaitingResourceUri:Dictionary;
        private var _loader:IResourceLoader;
        private var _waitingResources:Vector.<Uri> = new Vector.<Uri>();
        private var _type:uint;
        private var _GarbageCollectorTimer:Timer;
        private var _currentCacheSize:int = 0;
        private var _libCurrentlyUsed:Dictionary = new Dictionary(true);
        public var name:String;

        public function LibrariesManager(n:String, _arg_2:uint)
        {
            this.name = n;
            this._aResources = new Dictionary();
            this._aResourceLoadFail = new Dictionary();
            this._aResourceStates = new Array();
            this._aWaiting = new Array();
            this._aWaitingResourceUri = new Dictionary();
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoadResource);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadFailedResource);
            this._type = _arg_2;
            numLM++;
        }

        public function addResource(id:uint, uri:Uri):void
        {
            var gl:GraphicLibrary;
            if (uri == null)
            {
                uri = new Uri((TiphonConstants.SWF_SKULL_PATH + "666.swl"));
            };
            if (!this._aResources[id])
            {
                if (this._type == TYPE_BONE)
                {
                    gl = new AnimLibrary(id, true);
                }
                else
                {
                    gl = new GraphicLibrary(id, false);
                };
                this._aResources[id] = gl;
            }
            else
            {
                gl = this._aResources[id];
            };
            if (!gl.hasSwl(uri))
            {
                if (uri.tag == null)
                {
                    uri.tag = new Object();
                };
                uri.tag.id = id;
                gl.updateSwfState(uri);
                this._waitingResources.push(uri);
            };
        }

        public function askResource(id:uint, className:String=null, callback:Callback=null, errorCallback:Callback=null):void
        {
            var gl:GraphicLibrary;
            var callbackUri:String;
            var waitCallback:Array;
            var ok:Boolean;
            var c:Callback;
            var allMatch:Boolean;
            var index:uint;
            if (!this.hasResource(id, className))
            {
                return;
            };
            gl = this._aResources[id];
            if (gl.hasClassAvaible(className))
            {
                if (callback != null)
                {
                    callback.exec();
                };
            }
            else
            {
                if (!this._aWaiting[id])
                {
                    this._aWaiting[id] = new Object();
                    this._aWaiting[id]["ok"] = new Array();
                    this._aWaiting[id]["ko"] = new Array();
                };
                if (((this._type == TYPE_BONE) && (BoneIndexManager.getInstance().hasCustomBone(id))))
                {
                    callbackUri = BoneIndexManager.getInstance().getBoneFile(id, className).uri;
                };
                waitCallback = this._aWaiting[id]["ok"];
                ok = true;
                for each (c in waitCallback)
                {
                    if (((c.method == callback.method) && (callback.args.length == c.args.length)))
                    {
                        allMatch = true;
                        while (index < c.args.length)
                        {
                            if (c.args[index] != callback.args[index])
                            {
                                allMatch = false;
                                break;
                            };
                            index++;
                        };
                        if (((allMatch) && ((!(callbackUri)) || (this._aWaitingResourceUri[c] == callbackUri))))
                        {
                            ok = false;
                            break;
                        };
                    };
                };
                if (ok)
                {
                    if (callbackUri)
                    {
                        this._aWaitingResourceUri[callback] = callbackUri;
                    };
                    this._aWaiting[id]["ok"].push(callback);
                };
                if (errorCallback)
                {
                    this._aWaiting[id]["ko"].push(errorCallback);
                };
                while (this._waitingResources.length)
                {
                    this._loader.load(this._waitingResources.shift(), _cache);
                };
            };
        }

        public function removeResource(id:uint):void
        {
            if (this._aWaiting[id])
            {
                delete this._aWaiting[id];
            };
            delete this._aResources[id];
        }

        public function isLoaded(id:uint, animClass:String=null):Boolean
        {
            if (this._aResources[id] == false)
            {
                return (false);
            };
            var lib:GraphicLibrary = this._aResources[id];
            if (animClass)
            {
                return ((!(lib == null)) && (lib.hasClassAvaible(animClass)));
            };
            return ((lib) && (!(lib.getSwl() == null)));
        }

        public function hasError(id:uint):Boolean
        {
            return (this._aResourceLoadFail[id]);
        }

        public function hasResource(id:uint, animClass:String=null):Boolean
        {
            var lib:GraphicLibrary = this._aResources[id];
            return ((lib) && (lib.hasClass(animClass)));
        }

        public function getResourceById(resName:uint, animClass:String=null, waitForIt:Boolean=false):Swl
        {
            var swl:Swl;
            var lib:GraphicLibrary = this._aResources[resName];
            if (!lib)
            {
                _log.info((((("La librairie ne semble pas exister. (ressource: " + resName) + ", anim:") + animClass) + ")"));
                return (null);
            };
            if (((lib.isSingleFile) && (!(waitForIt))))
            {
                swl = lib.getSwl(null);
            };
            swl = lib.getSwl(animClass, waitForIt);
            if (((swl == null) && (waitForIt)))
            {
                lib.addEventListener(SwlEvent.SWL_LOADED, this.onSwfLoaded);
            };
            return (swl);
        }

        private function onSwfLoaded(pEvt:Event):void
        {
            pEvt.currentTarget.removeEventListener(SwlEvent.SWL_LOADED, this.onSwfLoaded);
            dispatchEvent(pEvt);
        }

        public function hasAnim(bonesId:int, animName:String, direction:int=-1):Boolean
        {
            var swl:Swl;
            var classList:Array;
            var fullAnimationName:String;
            var className:String;
            var hasAnimation:Boolean;
            var lib:GraphicLibrary = this._aResources[bonesId];
            if (((lib) && (lib.isSingleFile)))
            {
                swl = lib.getSwl();
                if (!swl)
                {
                    _log.info((((("On test si une librairie contient une anim sans l'avoir en mémoire. (bones: " + bonesId) + ", anim:") + animName) + ")"));
                    return (hasAnimation);
                };
                classList = swl.getDefinitions();
                fullAnimationName = (animName + ((direction != -1) ? ("_" + direction) : ""));
                for each (className in classList)
                {
                    if (className.indexOf(fullAnimationName) == 0)
                    {
                        hasAnimation = true;
                        break;
                    };
                };
            }
            else
            {
                hasAnimation = BoneIndexManager.getInstance().hasAnim(bonesId, animName, direction);
            };
            return (hasAnimation);
        }

        private function onLoadResource(re:ResourceLoadedEvent):void
        {
            var size:uint;
            var i:uint;
            var c:Callback;
            var callbacksToRemove:Vector.<Callback>;
            var tagId:int = ((re.uri.tag.id == null) ? re.uri.tag : re.uri.tag.id);
            _log.info(("Loaded " + re.uri));
            GraphicLibrary(this._aResources[tagId]).addSwl(re.resource, re.uri.uri);
            if (((this._aWaiting[tagId]) && (this._aWaiting[tagId]["ok"])))
            {
                size = this._aWaiting[tagId]["ok"].length;
                callbacksToRemove = new Vector.<Callback>(0);
                i = 0;
                while (i < size)
                {
                    c = Callback(this._aWaiting[tagId]["ok"][i]);
                    if (((c) && ((!(this._aWaitingResourceUri[c])) || (this._aWaitingResourceUri[c] == re.uri.uri))))
                    {
                        c.exec();
                        callbacksToRemove.push(c);
                    };
                    i++;
                };
                for each (c in callbacksToRemove)
                {
                    this._aWaiting[tagId]["ok"].splice(this._aWaiting[tagId]["ok"].indexOf(c), 1);
                    delete this._aWaitingResourceUri[c];
                };
                if (this._aWaiting[tagId]["ok"].length == 0)
                {
                    delete this._aWaiting[tagId];
                };
            };
        }

        private function onLoadFailedResource(re:ResourceErrorEvent):void
        {
            var callBackList:Array;
            var num:int;
            var i:int;
            var tagId:int = ((isNaN(re.uri.tag)) ? re.uri.tag.id : re.uri.tag);
            _log.error((((("Unable to load " + re.uri) + " (") + re.errorMsg) + ")"));
            delete this._aResources[tagId];
            this._aResourceLoadFail[tagId] = true;
            this.addResource(tagId, _uri);
            if (this._aWaiting[tagId])
            {
                callBackList = this._aWaiting[tagId]["ko"];
                if (callBackList)
                {
                    num = callBackList.length;
                    i = 0;
                    while (i < num)
                    {
                        (callBackList[i] as Callback).exec();
                        i++;
                    };
                    delete this._aWaiting[tagId];
                };
            };
        }


    }
}

