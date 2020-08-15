package com.ankamagames.dofus.logic.game.common.managers
{
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.network.types.game.character.debt.DebtInformation;
    import com.ankamagames.dofus.network.types.game.character.debt.KamaDebtInformation;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.utils.misc.DictionaryUtils;

    public class DebtManager 
    {

        public static var _self:DebtManager;

        private var _debtList:Dictionary;

        public function DebtManager()
        {
            this._debtList = new Dictionary();
        }

        public static function getInstance():DebtManager
        {
            if (!_self)
            {
                _self = new (DebtManager)();
            };
            return (_self);
        }

        public static function clean():void
        {
            _self = null;
        }


        public function removeDebt(id:uint):void
        {
            if ((this._debtList[id] as DebtInformation).getTypeId() == DebtTypeEnum.KAMA_DEBT)
            {
                InventoryManager.getInstance().bankInventory.kamas = (InventoryManager.getInstance().bankInventory.localKamas - (this._debtList[id] as KamaDebtInformation).kamas);
            };
            delete this._debtList[id];
        }

        public function removeDebts(ids:Vector.<Number>):void
        {
            var id:Number;
            for each (id in ids)
            {
                this.removeDebt(id);
            };
        }

        public function getTotalKamaDebt():uint
        {
            var debt:DebtInformation;
            var tot:uint;
            for each (debt in this._debtList)
            {
                if (debt.getTypeId() == DebtTypeEnum.KAMA_DEBT)
                {
                    tot = (tot + (debt as KamaDebtInformation).kamas);
                };
            };
            return (tot);
        }

        public function updateDebts(debts:Vector.<DebtInformation>):void
        {
            var debt:DebtInformation;
            for each (debt in debts)
            {
                this._debtList[debt.id] = debt;
            };
        }

        public function hasDebt():Boolean
        {
            return (DictionaryUtils.getLength(this._debtList) > 0);
        }


    }
}

class DebtTypeEnum 
{

    public static const KAMA_DEBT:uint = 580;


}


