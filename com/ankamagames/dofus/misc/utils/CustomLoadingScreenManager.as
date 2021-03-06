package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.DataStoreType;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
    import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.dofus.Constants;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.resources.ResourceType;

    public class CustomLoadingScreenManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CustomLoadingScreenManager));
        private static var _singleton:CustomLoadingScreenManager;

        private var _dataStore:DataStoreType = new DataStoreType("LoadingScreen", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
        private var _loader:IResourceLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);

        public function CustomLoadingScreenManager()
        {
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadError);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoad);
        }

        public static function getInstance():CustomLoadingScreenManager
        {
            if (!_singleton)
            {
                _singleton = new (CustomLoadingScreenManager)();
            };
            return (_singleton);
        }


        public function get currentLoadingScreen():CustomLoadingScreen
        {
            var currentName:String = (StoreDataManager.getInstance().getData(this._dataStore, "currentLoadingScreen") as String);
            var current:CustomLoadingScreen = CustomLoadingScreen.recover(this._dataStore, currentName);
            var lang:String = XmlConfig.getInstance().getEntry("config.lang.current");
            if (!lang)
            {
                lang = StoreDataManager.getInstance().getData(Constants.DATASTORE_LANG_VERSION, "lastLang");
            };
            if (((current) && (!(current.canBeRead()))))
            {
                StoreDataManager.getInstance().setData(this._dataStore, "currentLoadingScreen", null);
                current = null;
            };
            if (((current) && (!(current.lang == lang))))
            {
                StoreDataManager.getInstance().setData(this._dataStore, "currentLoadingScreen", null);
                current = null;
            };
            return (current);
        }

        public function get dataStore():DataStoreType
        {
            return (this._dataStore);
        }

        public function set currentLoadingScreen(loadingScreen:CustomLoadingScreen):void
        {
            if (loadingScreen)
            {
                StoreDataManager.getInstance().setData(this._dataStore, "currentLoadingScreen", loadingScreen.name);
            }
            else
            {
                StoreDataManager.getInstance().setData(this._dataStore, "currentLoadingScreen", null);
            };
        }

        public function loadCustomScreenList(nickname:String=null):void
        {
            var uri:Uri;
            var lang:String = XmlConfig.getInstance().getEntry("config.lang.current");
            var url:String = XmlConfig.getInstance().getEntry("config.customLoadingScreen");
            url = url.split("{lang}").join(lang);
            url = url.split("{nickname}").join(((nickname == null) ? "" : ("nickname=" + nickname)));
            uri = new Uri(url);
            this._loader.load(uri);
        }

        private function onLoad(e:ResourceLoadedEvent):void
        {
            var selected:CustomLoadingScreen;
            var xml:XML;
            var screens:Array;
            var loadingScreenXml:XML;
            var oldLoadingScreen:CustomLoadingScreen;
            var loadingScreen:CustomLoadingScreen;
            if (e.resourceType == ResourceType.RESOURCE_XML)
            {
                selected = null;
                try
                {
                    xml = e.resource;
                    if (!xml)
                    {
                        return;
                    };
                    screens = new Array();
                    for each (loadingScreenXml in xml.child("loadingScreen"))
                    {
                        oldLoadingScreen = CustomLoadingScreen.recover(this._dataStore, loadingScreenXml.@name);
                        loadingScreen = CustomLoadingScreen.loadFromXml(loadingScreenXml);
                        if (oldLoadingScreen)
                        {
                            loadingScreen.count = oldLoadingScreen.count;
                        };
                        if ((((((!(oldLoadingScreen)) || (!(loadingScreen.backgroundUrl == oldLoadingScreen.backgroundUrl))) || (!(oldLoadingScreen.backgroundImg))) || (!(loadingScreen.foregroundUrl == oldLoadingScreen.foregroundUrl))) || ((oldLoadingScreen.foregroundUrl) && (!(oldLoadingScreen.foregroundImg)))))
                        {
                            loadingScreen.loadData();
                        }
                        else
                        {
                            loadingScreen.backgroundImg = oldLoadingScreen.backgroundImg;
                            loadingScreen.foregroundImg = oldLoadingScreen.foregroundImg;
                            loadingScreen.store();
                        };
                        if (((!(selected)) && (loadingScreen.canBeRead())))
                        {
                            selected = loadingScreen;
                        };
                    };
                }
                catch(e:Error)
                {
                    _log.error(("Can't load loading screen XML : " + e));
                    return;
                };
                if (selected)
                {
                    this.currentLoadingScreen = selected;
                };
            }
            else
            {
                _log.error("Invalid XML");
            };
        }

        private function onLoadError(e:ResourceErrorEvent):void
        {
            _log.error(("Can't load XML file : " + e));
            StoreDataManager.getInstance().setData(this._dataStore, "currentLoadingScreen", null);
        }


    }
}

