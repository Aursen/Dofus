﻿package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeMultiCraftCrafterCanUseHisRessourcesMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6020;

        private var _isInitialized:Boolean = false;
        public var allowed:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6020);
        }

        public function initExchangeMultiCraftCrafterCanUseHisRessourcesMessage(allowed:Boolean=false):ExchangeMultiCraftCrafterCanUseHisRessourcesMessage
        {
            this.allowed = allowed;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.allowed = false;
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
            this.serializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(output);
        }

        public function serializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.allowed);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(input);
        }

        public function deserializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(input:ICustomDataInput):void
        {
            this.allowed = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

