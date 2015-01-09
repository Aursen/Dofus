﻿package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeWeightMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5793;

        private var _isInitialized:Boolean = false;
        public var currentWeight:uint = 0;
        public var maxWeight:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5793);
        }

        public function initExchangeWeightMessage(currentWeight:uint=0, maxWeight:uint=0):ExchangeWeightMessage
        {
            this.currentWeight = currentWeight;
            this.maxWeight = maxWeight;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.currentWeight = 0;
            this.maxWeight = 0;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ExchangeWeightMessage(output);
        }

        public function serializeAs_ExchangeWeightMessage(output:ICustomDataOutput):void
        {
            if (this.currentWeight < 0)
            {
                throw (new Error((("Forbidden value (" + this.currentWeight) + ") on element currentWeight.")));
            };
            output.writeVarInt(this.currentWeight);
            if (this.maxWeight < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxWeight) + ") on element maxWeight.")));
            };
            output.writeVarInt(this.maxWeight);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeWeightMessage(input);
        }

        public function deserializeAs_ExchangeWeightMessage(input:ICustomDataInput):void
        {
            this.currentWeight = input.readVarUhInt();
            if (this.currentWeight < 0)
            {
                throw (new Error((("Forbidden value (" + this.currentWeight) + ") on element of ExchangeWeightMessage.currentWeight.")));
            };
            this.maxWeight = input.readVarUhInt();
            if (this.maxWeight < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxWeight) + ") on element of ExchangeWeightMessage.maxWeight.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

