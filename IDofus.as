package 
{
    import com.ankamagames.berilia.interfaces.IApplicationContainer;
    import flash.utils.ByteArray;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.dofus.types.DofusOptions;
    import flash.display.DisplayObject;
    import flash.display.LoaderInfo;
    import flash.display.Stage;

    public interface IDofus extends IApplicationContainer 
    {

        function getRawSignatureData():ByteArray;
        function getUiContainer():DisplayObjectContainer;
        function get useMiniLoader():Boolean;
        function get initialized():Boolean;
        function getWorldContainer():DisplayObjectContainer;
        function get options():DofusOptions;
        function get instanceId():uint;
        function get forcedLang():String;
        function setDisplayOptions(_arg_1:DofusOptions):void;
        function init(_arg_1:DisplayObject, _arg_2:uint=0, _arg_3:String=null, _arg_4:Array=null):void;
        function quit(_arg_1:int=0):void;
        function clearCache(_arg_1:Boolean=false, _arg_2:Boolean=false):void;
        function reboot():void;
        function renameApp(_arg_1:String):void;
        function get rootContainer():DisplayObjectContainer;
        function get loaderInfo():LoaderInfo;
        function addChild(_arg_1:DisplayObject):DisplayObject;
        function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void;
        function get stage():Stage;

    }
} 

