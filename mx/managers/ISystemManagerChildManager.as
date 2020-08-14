package mx.managers
{
    import flash.display.DisplayObject;

    [ExcludeClass]
    public interface ISystemManagerChildManager 
    {

        function addingChild(_arg_1:DisplayObject):void;
        function childAdded(_arg_1:DisplayObject):void;
        function childRemoved(_arg_1:DisplayObject):void;
        function removingChild(_arg_1:DisplayObject):void;
        function initializeTopLevelWindow(_arg_1:Number, _arg_2:Number):void;

    }
} mx.managers

