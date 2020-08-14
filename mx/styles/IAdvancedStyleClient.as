package mx.styles
{
    public interface IAdvancedStyleClient extends IStyleClient 
    {

        function get id():String;
        function get styleParent():IAdvancedStyleClient;
        function set styleParent(_arg_1:IAdvancedStyleClient):void;
        function stylesInitialized():void;
        function matchesCSSState(_arg_1:String):Boolean;
        function matchesCSSType(_arg_1:String):Boolean;
        function hasCSSState():Boolean;

    }
} mx.styles

