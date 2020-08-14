package com.ankamagames.jerakine.data
{
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.utils.errors.SingletonError;

    public class CensoredContentManager 
    {

        private static var _self:CensoredContentManager;

        private var _data:Dictionary = new Dictionary();
        private var _emtptyData:Dictionary = new Dictionary();

        public function CensoredContentManager()
        {
            if (_self)
            {
                throw (new SingletonError());
            };
        }

        public static function getInstance():CensoredContentManager
        {
            if (!_self)
            {
                _self = new (CensoredContentManager)();
            };
            return (_self);
        }


        public function init(content:Array, lang:String):void
        {
            var censoredData:ICensoredDataItem;
            for each (censoredData in content)
            {
                if (censoredData.lang == lang)
                {
                    if (!this._data[censoredData.type])
                    {
                        this._data[censoredData.type] = new Dictionary();
                    };
                    this._data[censoredData.type][censoredData.oldValue] = censoredData.newValue;
                };
            };
        }

        public function getCensoredIndex(_arg_1:int):Dictionary
        {
            return ((this._data[_arg_1]) ? this._data[_arg_1] : this._emtptyData);
        }


    }
} com.ankamagames.jerakine.data

