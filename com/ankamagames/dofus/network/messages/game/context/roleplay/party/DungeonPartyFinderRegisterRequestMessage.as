package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DungeonPartyFinderRegisterRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DungeonPartyFinderRegisterRequestMessage() {
         this.dungeonIds = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6249;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var dungeonIds:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6249;
      }
      
      public function initDungeonPartyFinderRegisterRequestMessage(dungeonIds:Vector.<uint> = null) : DungeonPartyFinderRegisterRequestMessage {
         this.dungeonIds = dungeonIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.dungeonIds = new Vector.<uint>();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_DungeonPartyFinderRegisterRequestMessage(output);
      }
      
      public function serializeAs_DungeonPartyFinderRegisterRequestMessage(output:IDataOutput) : void {
         output.writeShort(this.dungeonIds.length);
         var _i1:uint = 0;
         while(_i1 < this.dungeonIds.length)
         {
            if(this.dungeonIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.dungeonIds[_i1] + ") on element 1 (starting at 1) of dungeonIds.");
            }
            else
            {
               output.writeShort(this.dungeonIds[_i1]);
               _i1++;
               continue;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DungeonPartyFinderRegisterRequestMessage(input);
      }
      
      public function deserializeAs_DungeonPartyFinderRegisterRequestMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         var _dungeonIdsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _dungeonIdsLen)
         {
            _val1 = input.readShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of dungeonIds.");
            }
            else
            {
               this.dungeonIds.push(_val1);
               _i1++;
               continue;
            }
         }
      }
   }
}
