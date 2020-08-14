package flashx.textLayout.edit
{
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.FocusEvent;
    import flash.events.TextEvent;
    import flash.events.IMEEvent;
    import flash.events.MouseEvent;
    import flash.events.ContextMenuEvent;

    public interface IInteractionEventHandler 
    {

        function editHandler(_arg_1:Event):void;
        function keyDownHandler(_arg_1:KeyboardEvent):void;
        function keyUpHandler(_arg_1:KeyboardEvent):void;
        function keyFocusChangeHandler(_arg_1:FocusEvent):void;
        function textInputHandler(_arg_1:TextEvent):void;
        function imeStartCompositionHandler(_arg_1:IMEEvent):void;
        function softKeyboardActivatingHandler(_arg_1:Event):void;
        function mouseDownHandler(_arg_1:MouseEvent):void;
        function mouseMoveHandler(_arg_1:MouseEvent):void;
        function mouseUpHandler(_arg_1:MouseEvent):void;
        function mouseDoubleClickHandler(_arg_1:MouseEvent):void;
        function mouseOverHandler(_arg_1:MouseEvent):void;
        function mouseOutHandler(_arg_1:MouseEvent):void;
        function focusInHandler(_arg_1:FocusEvent):void;
        function focusOutHandler(_arg_1:FocusEvent):void;
        function activateHandler(_arg_1:Event):void;
        function deactivateHandler(_arg_1:Event):void;
        function focusChangeHandler(_arg_1:FocusEvent):void;
        function menuSelectHandler(_arg_1:ContextMenuEvent):void;
        function mouseWheelHandler(_arg_1:MouseEvent):void;

    }
} flashx.textLayout.edit

