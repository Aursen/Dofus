package damageCalculation.fighterManagement
{
    public interface IFighterData 
    {

        function useSummonSlot():Boolean;
        function resolveDodge():int;
        function isSummon():Boolean;
        function getUsedPM():int;
        function getTurnBeginPosition():int;
        function getSummonerId():Number;
        function getStartedPositionCell():int;
        function getPreviousPosition():int;
        function getItemSpellDamageModification(_arg_1:int):int;
        function getItemSpellBaseDamageModification(_arg_1:int):int;
        function getBaseCharacteristicValue(_arg_1:String):int;
        function canBreedUsePortals():Boolean;
        function canBreedSwitchPos():Boolean;
        function canBreedBePushed():Boolean;
        function canBreedBeCarried():Boolean;

    }
}

