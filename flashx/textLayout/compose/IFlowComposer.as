package flashx.textLayout.compose
{
    import flashx.textLayout.elements.ContainerFormattedElement;
    import flashx.textLayout.container.ContainerController;
    import flashx.textLayout.edit.ISelectionManager;

    public interface IFlowComposer 
    {

        function get rootElement():ContainerFormattedElement;
        function setRootElement(_arg_1:ContainerFormattedElement):void;
        function get damageAbsoluteStart():int;
        function updateAllControllers():Boolean;
        function updateToController(_arg_1:int=2147483647):Boolean;
        function setFocus(_arg_1:int, _arg_2:Boolean=false):void;
        function compose():Boolean;
        function composeToPosition(_arg_1:int=2147483647):Boolean;
        function composeToController(_arg_1:int=2147483647):Boolean;
        function get numControllers():int;
        function addController(_arg_1:ContainerController):void;
        function addControllerAt(_arg_1:ContainerController, _arg_2:int):void;
        function removeController(_arg_1:ContainerController):void;
        function removeControllerAt(_arg_1:int):void;
        function removeAllControllers():void;
        function getControllerAt(_arg_1:int):ContainerController;
        function getControllerIndex(_arg_1:ContainerController):int;
        function findControllerIndexAtPosition(_arg_1:int, _arg_2:Boolean=false):int;
        function findLineIndexAtPosition(_arg_1:int, _arg_2:Boolean=false):int;
        function findLineAtPosition(_arg_1:int, _arg_2:Boolean=false):TextFlowLine;
        function getLineAt(_arg_1:int):TextFlowLine;
        function get numLines():int;
        function isDamaged(_arg_1:int):Boolean;
        function isPotentiallyDamaged(_arg_1:int):Boolean;
        function get composing():Boolean;
        function get swfContext():ISWFContext;
        function set swfContext(_arg_1:ISWFContext):void;
        function interactionManagerChanged(_arg_1:ISelectionManager):void;
        function updateLengths(_arg_1:int, _arg_2:int):void;
        function damage(_arg_1:int, _arg_2:int, _arg_3:String):void;

    }
}

