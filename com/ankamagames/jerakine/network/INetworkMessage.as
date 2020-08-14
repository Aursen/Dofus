package com.ankamagames.jerakine.network
{
    import com.ankamagames.jerakine.messages.IdentifiedMessage;
    import com.ankamagames.jerakine.messages.QueueableMessage;
    import com.ankamagames.jerakine.network.utils.FuncTree;

    public interface INetworkMessage extends IdentifiedMessage, QueueableMessage 
    {

        function pack(_arg_1:ICustomDataOutput):void;
        function unpack(_arg_1:ICustomDataInput, _arg_2:uint):void;
        function unpackAsync(_arg_1:ICustomDataInput, _arg_2:uint):FuncTree;
        function get isInitialized():Boolean;
        function get unpacked():Boolean;
        function set unpacked(_arg_1:Boolean):void;

    }
} com.ankamagames.jerakine.network

