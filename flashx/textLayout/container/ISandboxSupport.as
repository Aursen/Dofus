package flashx.textLayout.container
{
    import flash.events.Event;

    public interface ISandboxSupport 
    {

        function beginMouseCapture():void;
        function endMouseCapture():void;
        function mouseUpSomewhere(_arg_1:Event):void;
        function mouseMoveSomewhere(_arg_1:Event):void;

    }
}

