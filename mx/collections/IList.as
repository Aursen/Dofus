package mx.collections
{
    import flash.events.IEventDispatcher;

    [Event(name="collectionChange", type="mx.events.CollectionEvent")]
    public interface IList extends IEventDispatcher 
    {

        function get length():int;
        function addItem(_arg_1:Object):void;
        function addItemAt(_arg_1:Object, _arg_2:int):void;
        function getItemAt(_arg_1:int, _arg_2:int=0):Object;
        function getItemIndex(_arg_1:Object):int;
        function itemUpdated(_arg_1:Object, _arg_2:Object=null, _arg_3:Object=null, _arg_4:Object=null):void;
        function removeAll():void;
        function removeItemAt(_arg_1:int):Object;
        function setItemAt(_arg_1:Object, _arg_2:int):Object;
        function toArray():Array;

    }
}

