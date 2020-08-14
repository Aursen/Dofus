package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
    import com.ankamagames.berilia.types.data.UiModule;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
    import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import com.ankamagames.jerakine.utils.files.FileUtils;
    import com.ankamagames.berilia.utils.errors.ApiError;
    import com.ankamagames.jerakine.types.Uri;

    [InstanciedApi]
    public class FileApi implements IApi 
    {

        private var _loader:IResourceLoader;
        private var _module:UiModule;
        private var _openedFiles:Dictionary = new Dictionary();

        public function FileApi()
        {
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onError);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoaded);
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        public function destroy():void
        {
            var mfs:*;
            this._module = null;
            for (mfs in this._openedFiles)
            {
                if (mfs)
                {
                    try
                    {
                        mfs.close();
                    }
                    catch(e:Error)
                    {
                    };
                };
            };
            this._openedFiles = null;
        }

        public function loadXmlFile(url:String, loadSuccessCallBack:Function, loadErrorCallBack:Function=null):void
        {
            if (FileUtils.getExtension(url).toUpperCase() != "XML")
            {
                throw (new ApiError("loadXmlFile can only load file with XML extension"));
            };
            if (!url)
            {
                throw (new ApiError("loadXmlFile need a non-null url"));
            };
            if (loadSuccessCallBack == null)
            {
                throw (new ApiError("loadXmlFile need a non-null success callback function"));
            };
            var uri:Uri = new Uri(url);
            uri.tag = {
                "loadSuccessCallBack":loadSuccessCallBack,
                "loadErrorCallBack":loadErrorCallBack
            };
            this._loader.load(uri);
        }

        private function onLoaded(e:ResourceLoadedEvent):void
        {
            e.uri.tag.loadSuccessCallBack(e.resource);
        }

        private function onError(e:ResourceErrorEvent):void
        {
            if (e.uri.tag.loadErrorCallBack)
            {
                try
                {
                    e.uri.tag.loadErrorCallBack(e.errorCode, e.errorMsg);
                }
                catch(e:ArgumentError)
                {
                    throw (new ApiError("loadErrorCallBack on loadXmlFile function need two args : onError(errorCode : uint, errorMsg : String)"));
                };
            };
        }


    }
} com.ankamagames.dofus.uiApi

