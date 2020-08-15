package com.ankamagames.jerakine.managers
{
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    import flash.events.EventDispatcher;
    import com.ankamagames.jerakine.types.DataStoreType;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import com.ankamagames.jerakine.types.events.PropertyChangeEvent;

    public class OptionManager implements IEventDispatcher 
    {

        private static var _optionsManager:Array = [];

        private var _defaultValue:Dictionary = new Dictionary();
        private var _properties:Dictionary = new Dictionary();
        private var _useCache:Dictionary = new Dictionary();
        private var _allOptions:Array = [];
        private var _eventDispatcher:EventDispatcher;
        private var _customName:String;
        private var _dataStore:DataStoreType;

        public function OptionManager(customName:String=null)
        {
            if (customName)
            {
                this._customName = customName;
            }
            else
            {
                this._customName = getQualifiedClassName(this).split("::").join("_");
            };
            if (_optionsManager[this._customName])
            {
                throw (new Error((customName + " is already used by an other option manager.")));
            };
            _optionsManager[this._customName] = this;
            this._eventDispatcher = new EventDispatcher(this);
            this._dataStore = new DataStoreType(this._customName, true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT);
        }

        public static function getOptionManager(name:String):OptionManager
        {
            return (_optionsManager[name]);
        }

        public static function getOptionManagers():Array
        {
            var s:String;
            var managers:Array = [];
            for (s in _optionsManager)
            {
                managers.push(s);
            };
            return (managers);
        }

        public static function reset():void
        {
            _optionsManager = [];
        }


        public function add(name:String, value:*=null, useCache:Boolean=true):void
        {
            if (this._allOptions.indexOf(name) == -1)
            {
                this._allOptions.push(name);
            };
            this._useCache[name] = useCache;
            this._defaultValue[name] = value;
            if (((useCache) && (!(StoreDataManager.getInstance().getData(this._dataStore, name) == null))))
            {
                this._properties[name] = StoreDataManager.getInstance().getData(this._dataStore, name);
            }
            else
            {
                this._properties[name] = value;
            };
        }

        public function getDefaultValue(name:String):*
        {
            return (this._defaultValue[name]);
        }

        public function addEventListener(_arg_1:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            this._eventDispatcher.addEventListener(_arg_1, listener, useCapture, priority, useWeakReference);
        }

        public function dispatchEvent(event:Event):Boolean
        {
            return (this._eventDispatcher.dispatchEvent(event));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._eventDispatcher.hasEventListener(_arg_1));
        }

        public function removeEventListener(_arg_1:String, listener:Function, useCapture:Boolean=false):void
        {
            this._eventDispatcher.removeEventListener(_arg_1, listener, useCapture);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._eventDispatcher.willTrigger(_arg_1));
        }

        public function restaureDefaultValue(name:String):void
        {
            if (this._useCache[name] != null)
            {
                this.setOption(name, this._defaultValue[name]);
            };
        }

        public function getOption(name:String):*
        {
            return (this._properties[name]);
        }

        public function allOptions():Array
        {
            return (this._allOptions);
        }

        public function setOption(name:String, value:*):*
        {
            var oldValue:*;
            if (this._useCache[name] != null)
            {
                oldValue = this._properties[name];
                this._properties[name] = value;
                if (((this._useCache[name]) && (!(value is DisplayObject))))
                {
                    StoreDataManager.getInstance().setData(this._dataStore, name, value);
                };
                this._eventDispatcher.dispatchEvent(new PropertyChangeEvent(this, name, value, oldValue));
            };
        }


    }
}

