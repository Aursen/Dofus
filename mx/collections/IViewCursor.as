package mx.collections
{
    import flash.events.IEventDispatcher;

    [Event(name="cursorUpdate", type="mx.events.FlexEvent")]
    public interface IViewCursor extends IEventDispatcher 
    {

        [Bindable("cursorUpdate")]
        function get afterLast():Boolean;
        [Bindable("cursorUpdate")]
        function get beforeFirst():Boolean;
        [Bindable("cursorUpdate")]
        function get bookmark():CursorBookmark;
        [Bindable("cursorUpdate")]
        function get current():Object;
        function get view():ICollectionView;
        function findAny(_arg_1:Object):Boolean;
        function findFirst(_arg_1:Object):Boolean;
        function findLast(_arg_1:Object):Boolean;
        function insert(_arg_1:Object):void;
        function moveNext():Boolean;
        function movePrevious():Boolean;
        function remove():Object;
        function seek(_arg_1:CursorBookmark, _arg_2:int=0, _arg_3:int=0):void;

    }
}

