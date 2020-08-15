package mx.collections
{
    import flash.events.IEventDispatcher;

    [Event(name="collectionChange", type="mx.events.CollectionEvent")]
    public interface ICollectionView extends IEventDispatcher 
    {

        function get length():int;
        function get filterFunction():Function;
        function set filterFunction(_arg_1:Function):void;
        function get sort():ISort;
        function set sort(_arg_1:ISort):void;
        function createCursor():IViewCursor;
        function contains(_arg_1:Object):Boolean;
        function disableAutoUpdate():void;
        function enableAutoUpdate():void;
        function itemUpdated(_arg_1:Object, _arg_2:Object=null, _arg_3:Object=null, _arg_4:Object=null):void;
        function refresh():Boolean;

    }
}

