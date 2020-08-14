package damageCalculation
{
    import damageCalculation.fighterManagement.HaxeFighter;
    import damageCalculation.spellManagement.HaxeSpell;
    import damageCalculation.spellManagement.HaxeSpellState;

    public interface DamageCalculationInterface 
    {

        function summonMonster(_arg_1:HaxeFighter, _arg_2:int, _arg_3:int=undefined):HaxeFighter;
        function getStartingSpell(_arg_1:HaxeFighter, _arg_2:int=undefined):HaxeSpell;
        function getLinkedExplosionSpellFromFighter(_arg_1:HaxeFighter):HaxeSpell;
        function getBombExplosionSpellFromFighter(_arg_1:HaxeFighter):HaxeSpell;
        function getBombCastOnFighterSpell(_arg_1:int, _arg_2:int):HaxeSpell;
        function createStateFromId(_arg_1:uint):HaxeSpellState;
        function createSpellFromId(_arg_1:uint, _arg_2:int):HaxeSpell;

    }
} damageCalculation

