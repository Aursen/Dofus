package com.ankamagames.dofus.logic.game.common.misc
{
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;

    public final class SpellModificator 
    {

        public var apCost:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var castInterval:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var castIntervalSet:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var maxCastPerTurn:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var maxCastPerTarget:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();


        public function getTotalBonus(pCharac:CharacterBaseCharacteristic):int
        {
            if (!pCharac)
            {
                return (0);
            };
            return ((((pCharac.alignGiftBonus + pCharac.base) + pCharac.additionnal) + pCharac.contextModif) + pCharac.objectsAndMountBonus);
        }


    }
} com.ankamagames.dofus.logic.game.common.misc

