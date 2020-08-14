package Ankama_Admin.ui
{
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.ComboBox;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Input;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import d2enums.ComponentHookList;
    import d2actions.OpenInventory;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;

    public class AdminSelectItem 
    {

        private static const RESOURCE_ITEM:uint = 0;
        private static const RESOURCE_MONSTER:uint = 1;
        private static const RESOURCE_LOOK:uint = 2;
        private static const RESOURCE_FIREWORKS:uint = 3;
        private static const RESOURCE_SPELL:uint = 4;
        private static var _itemsCached:Array = [];
        private static var _typesCached:Array = [];
        private static var _iconUri:Dictionary = new Dictionary();

        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        public var btn_close:ButtonContainer;
        public var lbl_title:Label;
        public var lbl_command:Label;
        public var gd_items:Grid;
        public var cb_category:ComboBox;
        public var ctr_search:GraphicContainer;
        public var inp_search:Input;
        public var btn_closeSearch:ButtonContainer;
        public var btn_itemsFilter:ButtonContainer;
        private var _items:Array;
        private var _types:Array;
        private var _searchTimer:Timer = new Timer(200, 1);
        private var _nonFilteredDataProvider:Array;
        private var _callback:Function;
        private var _tmp:Object;
        private var _tmpTypes:Array;
        private var _parsedItems:uint;
        private var _title:String;
        private var _command:String;
        private var _resourceType:uint;
        private var _iconBaseUri:String;
        private var _iconType:String = ".png";
        private var _openInventory:Boolean;
        private var _providerFct:Function;


        public function main(args:Array):void
        {
            this._callback = args[0];
            this._command = args[1];
            this._openInventory = args[2];
            if (args[1].indexOf("#monster") != -1)
            {
                this._resourceType = RESOURCE_MONSTER;
                this._title = "Monstres";
            }
            else
            {
                if (args[1].indexOf("#item") != -1)
                {
                    this._resourceType = RESOURCE_ITEM;
                    this._title = "Objets";
                }
                else
                {
                    if (args[1].indexOf("#fireworks") != -1)
                    {
                        this._resourceType = RESOURCE_FIREWORKS;
                        this._title = "Feux d'artifice";
                    }
                    else
                    {
                        if (args[1].indexOf("#look") != -1)
                        {
                            this._resourceType = RESOURCE_LOOK;
                            this._title = "Look";
                        }
                        else
                        {
                            if (args[1].indexOf("#spell") != -1)
                            {
                                this._resourceType = RESOURCE_SPELL;
                                this._title = "Sorts";
                            };
                        };
                    };
                };
            };
            this.lbl_title.text = this._title;
            this.lbl_command.text = args[1];
            switch (this._resourceType)
            {
                case RESOURCE_ITEM:
                case RESOURCE_FIREWORKS:
                    this._iconBaseUri = this.sysApi.getConfigKey("gfx.path.item.bitmap");
                    this._providerFct = this.dataApi.getItems;
                    break;
                case RESOURCE_SPELL:
                    this._iconBaseUri = this.sysApi.getConfigKey("content.path").concat("gfx/spells/all.swf|sort_");
                    this._providerFct = this.dataApi.getSpells;
                    this._iconType = "";
                    break;
                case RESOURCE_LOOK:
                case RESOURCE_MONSTER:
                    this._iconBaseUri = this.sysApi.getConfigKey("gfx.path.monsters");
                    this._providerFct = this.dataApi.getMonsters;
                    break;
            };
            if (!_iconUri[this._resourceType])
            {
                _iconUri[this._resourceType] = new Dictionary();
            };
            this._items = _itemsCached[this._resourceType];
            this._types = _typesCached[this._resourceType];
            if (!this._items)
            {
                this._types = (_typesCached[this._resourceType] = new Array());
                this._items = (_itemsCached[this._resourceType] = new Array());
                this._tmp = this._providerFct();
                this._tmpTypes = [];
                this.sysApi.addEventListener(this.parseItems, "parseItems");
                this.parseItems();
            }
            else
            {
                this.init();
            };
        }

        public function updateItemLine(data:*, components:*, selected:Boolean):void
        {
            if (data)
            {
                if (!_iconUri[this._resourceType][data.id])
                {
                    _iconUri[this._resourceType][data.id] = this.uiApi.createUri(((this._iconBaseUri + data.iconId) + this._iconType));
                };
                components.tx_item.uri = _iconUri[this._resourceType][data.id];
                components.lbl_name.text = data.name;
                components.btn_item.selected = selected;
            }
            else
            {
                components.lbl_name.text = "";
                components.tx_item.uri = null;
                components.btn_item.selected = false;
            };
        }

        private function init():void
        {
            this.cb_category.dataProvider = this._types;
            this.cb_category.selectedIndex = 0;
            this.gd_items.dataProvider = this._items;
            this._nonFilteredDataProvider = this._items;
            this._searchTimer.addEventListener(TimerEvent.TIMER, this.onTick);
            this.uiApi.addComponentHook(this.gd_items, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.cb_category, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.inp_search, ComponentHookList.ON_CHANGE);
            if (this._openInventory)
            {
                this.sysApi.sendAction(new OpenInventory());
            };
        }

        private function parseItems(e:*=null):void
        {
            var o:Object;
            var skip:Boolean;
            var nameTypeField:String;
            var _local_7:Object;
            var item:Object;
            var stepMaxIndex:uint = (this._parsedItems + 200);
            var max:uint = this._tmp.length;
            while (((this._parsedItems < stepMaxIndex) && (this._parsedItems < max)))
            {
                nameTypeField = "name";
                skip = false;
                item = this._tmp[this._parsedItems];
                o = {};
                o.id = item.id;
                o.name = ((item.name + " - ") + o.id);
                o.lowerName = String(o.name).toLowerCase();
                if (((item.hasOwnProperty("type")) && (item.type)))
                {
                    o.typeId = (item.type as ItemWrapper).id;
                }
                else
                {
                    o.typeId = 0;
                };
                switch (this._resourceType)
                {
                    case RESOURCE_FIREWORKS:
                        skip = (!(o.typeId == 74));
                        o.iconId = item.iconId;
                        o.sortData = item.id;
                        o.returnData = o.id;
                        break;
                    case RESOURCE_ITEM:
                        o.iconId = item.iconId;
                        o.sortData = item.id;
                        o.returnData = o.id;
                        break;
                    case RESOURCE_MONSTER:
                        o.iconId = item.id;
                        o.sortData = o.lowerName;
                        o.returnData = o.id;
                        break;
                    case RESOURCE_LOOK:
                        o.iconId = item.id;
                        o.sortData = o.lowerName;
                        o.returnData = item.look;
                        break;
                    case RESOURCE_SPELL:
                        o.iconId = item.iconId;
                        o.sortData = o.lowerName;
                        o.returnData = item.id;
                        nameTypeField = "longName";
                        break;
                };
                if (skip)
                {
                }
                else
                {
                    this._items.push(o);
                    if (!this._tmpTypes[o.typeId])
                    {
                        this._tmpTypes[o.typeId] = item.type;
                    };
                };
                this._parsedItems++;
            };
            this.lbl_title.text = (Math.ceil(((this._parsedItems / max) * 100)) + " %");
            if (max != this._parsedItems)
            {
                return;
            };
            this.lbl_title.text = this._title;
            this.sysApi.removeEventListener(this.parseItems);
            for each (_local_7 in this._tmpTypes)
            {
                this._types.push({
                    "typeId":_local_7.id,
                    "label":_local_7[nameTypeField]
                });
            };
            this._types.sortOn("label");
            this._types.unshift({
                "typeId":null,
                "label":"Tous"
            });
            this._items.sortOn("sortData", ((o.sortData is String) ? 0 : Array.NUMERIC));
            this.sysApi.setData("AdminCachedItemsList", this._items, DataStoreEnum.BIND_ACCOUNT);
            this.sysApi.setData("AdminCachedItemTypesList", this._types, DataStoreEnum.BIND_ACCOUNT);
            this.init();
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onChange(target:Object):void
        {
            this._searchTimer.reset();
            this._searchTimer.start();
        }

        private function onTick(e:TimerEvent):void
        {
            var tmpDP:Array;
            var item:Object;
            var searchTerm:String = this.inp_search.text.toLowerCase();
            if (searchTerm.length)
            {
                tmpDP = [];
                for each (item in this._nonFilteredDataProvider)
                {
                    if (this.utilApi.noAccent(item.lowerName).indexOf(this.utilApi.noAccent(searchTerm)) != -1)
                    {
                        tmpDP.push(item);
                    };
                };
                this.gd_items.dataProvider = tmpDP;
            }
            else
            {
                this.gd_items.dataProvider = this._nonFilteredDataProvider;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var typeId:uint;
            var item:Object;
            switch (target)
            {
                case this.cb_category:
                    if (target.value.typeId === null)
                    {
                        this.gd_items.dataProvider = this._items;
                        this._nonFilteredDataProvider = this._items;
                    }
                    else
                    {
                        this._nonFilteredDataProvider = [];
                        typeId = target.value.typeId;
                        for each (item in this._items)
                        {
                            if (item.typeId == typeId)
                            {
                                this._nonFilteredDataProvider.push(item);
                            };
                        };
                        this.gd_items.dataProvider = this._nonFilteredDataProvider;
                    };
                    break;
                case this.gd_items:
                    if (selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)
                    {
                        this._callback(this.gd_items.selectedItem.returnData, this._command);
                    };
                    break;
            };
        }


    }
} Ankama_Admin.ui

