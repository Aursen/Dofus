package com.ankamagames.dofus.network.types.game.guild.tax
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.fight.ProtectedEntityWaitingForHelpInfo;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class TaxCollectorWaitingForHelpInformations extends TaxCollectorComplementaryInformations implements INetworkType 
    {

        public static const protocolId:uint = 447;

        public var waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
        private var _waitingForHelpInfotree:FuncTree;


        override public function getTypeId():uint
        {
            return (447);
        }

        public function initTaxCollectorWaitingForHelpInformations(waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo=null):TaxCollectorWaitingForHelpInformations
        {
            this.waitingForHelpInfo = waitingForHelpInfo;
            return (this);
        }

        override public function reset():void
        {
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_TaxCollectorWaitingForHelpInformations(output);
        }

        public function serializeAs_TaxCollectorWaitingForHelpInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_TaxCollectorComplementaryInformations(output);
            this.waitingForHelpInfo.serializeAs_ProtectedEntityWaitingForHelpInfo(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TaxCollectorWaitingForHelpInformations(input);
        }

        public function deserializeAs_TaxCollectorWaitingForHelpInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            this.waitingForHelpInfo.deserialize(input);
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_TaxCollectorWaitingForHelpInformations(tree);
        }

        public function deserializeAsyncAs_TaxCollectorWaitingForHelpInformations(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._waitingForHelpInfotree = tree.addChild(this._waitingForHelpInfotreeFunc);
        }

        private function _waitingForHelpInfotreeFunc(input:ICustomDataInput):void
        {
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            this.waitingForHelpInfo.deserializeAsync(this._waitingForHelpInfotree);
        }


    }
} com.ankamagames.dofus.network.types.game.guild.tax

