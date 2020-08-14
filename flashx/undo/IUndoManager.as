package flashx.undo
{
    public interface IUndoManager 
    {

        function clearAll():void;
        function get undoAndRedoItemLimit():int;
        function set undoAndRedoItemLimit(_arg_1:int):void;
        function canUndo():Boolean;
        function peekUndo():IOperation;
        function popUndo():IOperation;
        function pushUndo(_arg_1:IOperation):void;
        function clearRedo():void;
        function canRedo():Boolean;
        function peekRedo():IOperation;
        function popRedo():IOperation;
        function pushRedo(_arg_1:IOperation):void;
        function undo():void;
        function redo():void;

    }
} flashx.undo

