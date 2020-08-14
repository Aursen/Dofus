package com.ankamagames.jerakine.network
{
    public interface RawDataParser 
    {

        function parse(_arg_1:ICustomDataInput, _arg_2:uint, _arg_3:uint):INetworkMessage;
        function parseAsync(_arg_1:ICustomDataInput, _arg_2:uint, _arg_3:uint, _arg_4:Function):INetworkMessage;
        function getUnpackMode(_arg_1:uint):uint;

    }
} com.ankamagames.jerakine.network

