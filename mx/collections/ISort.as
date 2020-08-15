package mx.collections
{
    public interface ISort 
    {

        function get compareFunction():Function;
        function set compareFunction(_arg_1:Function):void;
        function get fields():Array;
        function set fields(_arg_1:Array):void;
        function get unique():Boolean;
        function set unique(_arg_1:Boolean):void;
        function findItem(_arg_1:Array, _arg_2:Object, _arg_3:String, _arg_4:Boolean=false, _arg_5:Function=null):int;
        function propertyAffectsSort(_arg_1:String):Boolean;
        function reverse():void;
        function sort(_arg_1:Array):void;

    }
}

