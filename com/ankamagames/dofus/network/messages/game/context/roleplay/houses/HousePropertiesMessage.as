﻿package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.house.HouseInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    [Trusted]
    public class HousePropertiesMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5734;

        private var _isInitialized:Boolean = false;
        public var properties:HouseInformations;

        public function HousePropertiesMessage()
        {
            this.properties = new HouseInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5734);
        }

        public function initHousePropertiesMessage(properties:HouseInformations=null):HousePropertiesMessage
        {
            this.properties = properties;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.properties = new HouseInformations();
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
            this.serializeAs_HousePropertiesMessage(output);
        }

        public function serializeAs_HousePropertiesMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.properties.getTypeId());
            this.properties.serialize(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HousePropertiesMessage(input);
        }

        public function deserializeAs_HousePropertiesMessage(input:ICustomDataInput):void
        {
            var _id1:uint = input.readUnsignedShort();
            this.properties = ProtocolTypeManager.getInstance(HouseInformations, _id1);
            this.properties.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.houses

