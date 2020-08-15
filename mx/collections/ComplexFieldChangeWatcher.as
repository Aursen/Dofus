package mx.collections
{
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    import mx.binding.utils.ChangeWatcher;
    import mx.events.PropertyChangeEvent;
    import mx.core.mx_internal;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;

    use namespace mx_internal;

    public class ComplexFieldChangeWatcher extends EventDispatcher 
    {

        private var _complexFieldWatchers:Dictionary = new Dictionary(true);
        private var _list:IList;
        private var _listCollection:ICollectionView;


        public function stopWatchingForComplexFieldChanges():void
        {
            this.unwatchListForChanges();
            this.unwatchAllItems();
        }

        private function unwatchAllItems():void
        {
            var item:Object;
            for (item in this._complexFieldWatchers)
            {
                this.unwatchItem(item);
                delete this._complexFieldWatchers[item];
            };
        }

        private function unwatchArrayOfItems(items:Array):void
        {
            var i:int;
            while (i < items.length)
            {
                this.unwatchItem(items[i]);
                i++;
            };
        }

        private function unwatchItem(item:Object):void
        {
            var watcher:ChangeWatcher;
            var watchersForItem:Array = (this._complexFieldWatchers[item] as Array);
            while (((watchersForItem) && (watchersForItem.length)))
            {
                watcher = (watchersForItem.pop() as ChangeWatcher);
                if (watcher)
                {
                    watcher.unwatch();
                };
            };
        }

        public function startWatchingForComplexFieldChanges():void
        {
            this.watchListForChanges();
            this.watchAllItems();
        }

        private function watchAllItems():void
        {
            this.watchItems(this.list);
        }

        private function watchItems(items:IList):void
        {
            var i:int;
            if (this.sortFields)
            {
                i = 0;
                while (i < items.length)
                {
                    this.watchItem(items.getItemAt(i), this.sortFields);
                    i++;
                };
            };
        }

        private function watchArrayOfItems(items:Array):void
        {
            var i:int;
            if (this.sortFields)
            {
                i = 0;
                while (i < items.length)
                {
                    this.watchItem(items[i], this.sortFields);
                    i++;
                };
            };
        }

        private function watchItem(item:Object, fieldsToWatch:Array):void
        {
            var i:int;
            var sortField:IComplexSortField;
            if (item)
            {
                i = 0;
                while (i < fieldsToWatch.length)
                {
                    sortField = (fieldsToWatch[i] as IComplexSortField);
                    if (((sortField) && (sortField.nameParts)))
                    {
                        this.watchItemForField(item, sortField.nameParts);
                    };
                    i++;
                };
            };
        }

        private function watchItemForField(item:Object, chain:Array):void
        {
            var watcher:ChangeWatcher = ChangeWatcher.watch(item, chain, new Closure(item, this.onComplexValueChanged).callFunctionOnObject, false, true);
            if (watcher)
            {
                this.addWatcher(watcher, item);
            };
        }

        private function addWatcher(watcher:ChangeWatcher, forItem:Object):void
        {
            if (!this._complexFieldWatchers[forItem])
            {
                this._complexFieldWatchers[forItem] = [];
            };
            (this._complexFieldWatchers[forItem] as Array).push(watcher);
        }

        private function onComplexValueChanged(item:Object):void
        {
            dispatchEvent(PropertyChangeEvent.createUpdateEvent(item, null, null, null));
        }

        private function get sortFields():Array
        {
            return (((this._listCollection) && (this._listCollection.sort)) ? this._listCollection.sort.fields : null);
        }

        mx_internal function set list(value:IList):void
        {
            if (this._list != value)
            {
                this.stopWatchingForComplexFieldChanges();
                this._list = value;
                this._listCollection = (value as ICollectionView);
            };
        }

        protected function get list():IList
        {
            return (this._list);
        }

        private function watchListForChanges():void
        {
            if (this.list)
            {
                this.list.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onCollectionChanged, false, 0, true);
            };
        }

        private function unwatchListForChanges():void
        {
            if (this.list)
            {
                this.list.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.onCollectionChanged);
            };
        }

        private function onCollectionChanged(event:CollectionEvent):void
        {
            switch (event.kind)
            {
                case CollectionEventKind.ADD:
                    this.watchArrayOfItems(event.items);
                    break;
                case CollectionEventKind.REMOVE:
                    this.unwatchArrayOfItems(event.items);
                    break;
                case CollectionEventKind.REFRESH:
                case CollectionEventKind.RESET:
                    this.reset();
                    break;
            };
        }

        private function reset():void
        {
            this.unwatchAllItems();
            this.watchAllItems();
        }


    }
}

import flash.events.Event;

class Closure 
{

    /*private*/ var _object:Object;
    /*private*/ var _function:Function;

    public function Closure(cachedObject:Object, cachedFunction:Function)
    {
        this._object = cachedObject;
        this._function = cachedFunction;
    }

    public function callFunctionOnObject(event:Event):void
    {
        this._function.apply(null, [this._object]);
    }


}


