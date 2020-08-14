package flashx.textLayout.edit
{
    import flashx.textLayout.elements.TextFlow;
    import flashx.textLayout.elements.TableElement;
    import flashx.textLayout.elements.CellCoordinates;
    import flashx.textLayout.elements.CellRange;
    import flashx.textLayout.elements.TextRange;
    import flashx.textLayout.formats.TextLayoutFormat;

    public interface ISelectionManager extends IInteractionEventHandler 
    {

        function get textFlow():TextFlow;
        function set textFlow(_arg_1:TextFlow):void;
        function get currentTable():TableElement;
        function set currentTable(_arg_1:TableElement):void;
        function hasCellRangeSelection():Boolean;
        function selectCellRange(_arg_1:CellCoordinates, _arg_2:CellCoordinates):void;
        function getCellRange():CellRange;
        function setCellRange(_arg_1:CellRange):void;
        function get anchorCellPosition():CellCoordinates;
        function set anchorCellPosition(_arg_1:CellCoordinates):void;
        function get activeCellPosition():CellCoordinates;
        function set activeCellPosition(_arg_1:CellCoordinates):void;
        function get absoluteStart():int;
        function get absoluteEnd():int;
        function selectRange(_arg_1:int, _arg_2:int):void;
        function selectAll():void;
        function selectLastPosition():void;
        function selectFirstPosition():void;
        function deselect():void;
        function get anchorPosition():int;
        function get activePosition():int;
        function hasSelection():Boolean;
        function hasAnySelection():Boolean;
        function get selectionType():String;
        function isRangeSelection():Boolean;
        function getSelectionState():SelectionState;
        function setSelectionState(_arg_1:SelectionState):void;
        function refreshSelection():void;
        function clearSelection():void;
        function setFocus():void;
        function get focused():Boolean;
        function get windowActive():Boolean;
        function get currentSelectionFormat():SelectionFormat;
        function get currentCellSelectionFormat():SelectionFormat;
        function getCommonCharacterFormat(_arg_1:TextRange=null):TextLayoutFormat;
        function getCommonParagraphFormat(_arg_1:TextRange=null):TextLayoutFormat;
        function getCommonContainerFormat(_arg_1:TextRange=null):TextLayoutFormat;
        function get editingMode():String;
        function get focusedSelectionFormat():SelectionFormat;
        function set focusedSelectionFormat(_arg_1:SelectionFormat):void;
        function get unfocusedSelectionFormat():SelectionFormat;
        function set unfocusedSelectionFormat(_arg_1:SelectionFormat):void;
        function get inactiveSelectionFormat():SelectionFormat;
        function set inactiveSelectionFormat(_arg_1:SelectionFormat):void;
        function get focusedCellSelectionFormat():SelectionFormat;
        function set focusedCellSelectionFormat(_arg_1:SelectionFormat):void;
        function get unfocusedCellSelectionFormat():SelectionFormat;
        function set unfocusedCellSelectionFormat(_arg_1:SelectionFormat):void;
        function get inactiveCellSelectionFormat():SelectionFormat;
        function set inactiveCellSelectionFormat(_arg_1:SelectionFormat):void;
        function flushPendingOperations():void;
        function notifyInsertOrDelete(_arg_1:int, _arg_2:int):void;
        function get subManager():ISelectionManager;
        function set subManager(_arg_1:ISelectionManager):void;
        function get superManager():ISelectionManager;
        function set superManager(_arg_1:ISelectionManager):void;

    }
} flashx.textLayout.edit

