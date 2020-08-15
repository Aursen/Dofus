package flashx.textLayout.edit
{
    import flashx.undo.IUndoManager;
    import flashx.textLayout.formats.ITextLayoutFormat;
    import flashx.textLayout.elements.TCYElement;
    import flashx.textLayout.elements.LinkElement;
    import flashx.textLayout.elements.FlowElement;
    import flashx.textLayout.elements.InlineGraphicElement;
    import flashx.textLayout.elements.TableElement;
    import flashx.textLayout.elements.ParagraphElement;
    import flashx.textLayout.elements.FlowGroupElement;
    import flashx.textLayout.elements.DivElement;
    import flashx.textLayout.elements.ListElement;
    import flashx.textLayout.elements.SubParagraphGroupElement;
    import flashx.textLayout.operations.FlowOperation;
    import flashx.undo.IOperation;

    [Exclude(name="delayedOperations", kind="property")]
    public interface IEditManager extends ISelectionManager 
    {

        function get undoManager():IUndoManager;
        function applyFormat(_arg_1:ITextLayoutFormat, _arg_2:ITextLayoutFormat, _arg_3:ITextLayoutFormat, _arg_4:SelectionState=null):void;
        function clearFormat(_arg_1:ITextLayoutFormat, _arg_2:ITextLayoutFormat, _arg_3:ITextLayoutFormat, _arg_4:SelectionState=null):void;
        function applyLeafFormat(_arg_1:ITextLayoutFormat, _arg_2:SelectionState=null):void;
        function applyTCY(_arg_1:Boolean, _arg_2:SelectionState=null):TCYElement;
        function applyLink(_arg_1:String, _arg_2:String=null, _arg_3:Boolean=false, _arg_4:SelectionState=null):LinkElement;
        function changeElementID(_arg_1:String, _arg_2:FlowElement, _arg_3:int=0, _arg_4:int=-1, _arg_5:SelectionState=null):void;
        function changeStyleName(_arg_1:String, _arg_2:FlowElement, _arg_3:int=0, _arg_4:int=-1, _arg_5:SelectionState=null):void;
        function changeTypeName(_arg_1:String, _arg_2:FlowElement, _arg_3:int=0, _arg_4:int=-1, _arg_5:SelectionState=null):void;
        function deleteNextCharacter(_arg_1:SelectionState=null):void;
        function deletePreviousCharacter(_arg_1:SelectionState=null):void;
        function deleteNextWord(_arg_1:SelectionState=null):void;
        function deletePreviousWord(_arg_1:SelectionState=null):void;
        function deleteText(_arg_1:SelectionState=null):void;
        function insertInlineGraphic(_arg_1:Object, _arg_2:Object, _arg_3:Object, _arg_4:Object=null, _arg_5:SelectionState=null):InlineGraphicElement;
        function insertTableElement(_arg_1:TableElement, _arg_2:SelectionState=null):void;
        function modifyInlineGraphic(_arg_1:Object, _arg_2:Object, _arg_3:Object, _arg_4:Object=null, _arg_5:SelectionState=null):void;
        function insertText(_arg_1:String, _arg_2:SelectionState=null):void;
        function overwriteText(_arg_1:String, _arg_2:SelectionState=null):void;
        function applyParagraphFormat(_arg_1:ITextLayoutFormat, _arg_2:SelectionState=null):void;
        function applyContainerFormat(_arg_1:ITextLayoutFormat, _arg_2:SelectionState=null):void;
        function applyFormatToElement(_arg_1:FlowElement, _arg_2:ITextLayoutFormat, _arg_3:int=0, _arg_4:int=-1, _arg_5:SelectionState=null):void;
        function clearFormatOnElement(_arg_1:FlowElement, _arg_2:ITextLayoutFormat, _arg_3:SelectionState=null):void;
        function splitParagraph(_arg_1:SelectionState=null):ParagraphElement;
        function splitElement(_arg_1:FlowGroupElement, _arg_2:SelectionState=null):FlowGroupElement;
        function createDiv(_arg_1:FlowGroupElement=null, _arg_2:ITextLayoutFormat=null, _arg_3:SelectionState=null):DivElement;
        function createList(_arg_1:FlowGroupElement=null, _arg_2:ITextLayoutFormat=null, _arg_3:SelectionState=null):ListElement;
        function moveChildren(_arg_1:FlowGroupElement, _arg_2:int, _arg_3:int, _arg_4:FlowGroupElement, _arg_5:int, _arg_6:SelectionState=null):void;
        function createSubParagraphGroup(_arg_1:FlowGroupElement=null, _arg_2:ITextLayoutFormat=null, _arg_3:SelectionState=null):SubParagraphGroupElement;
        function cutTextScrap(_arg_1:SelectionState=null):TextScrap;
        function pasteTextScrap(_arg_1:TextScrap, _arg_2:SelectionState=null):void;
        function beginCompositeOperation():void;
        function endCompositeOperation():void;
        function doOperation(_arg_1:FlowOperation):void;
        function undo():void;
        function redo():void;
        function performUndo(_arg_1:IOperation):void;
        function performRedo(_arg_1:IOperation):void;
        function get delayUpdates():Boolean;
        function set delayUpdates(_arg_1:Boolean):void;
        function get allowDelayedOperations():Boolean;
        function set allowDelayedOperations(_arg_1:Boolean):void;
        function updateAllControllers():void;

    }
}

