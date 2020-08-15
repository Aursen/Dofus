package damageCalculation.damageManagement
{
    import damageCalculation.fighterManagement.HaxeFighter;

    public class MovementInfos 
    {

        public var swappedWith:HaxeFighter;
        public var newPosition:int;
        public var direction:int;

        public function MovementInfos(_arg_1:int, _arg_2:int, _arg_3:HaxeFighter=undefined):void
        {
            newPosition = _arg_1;
            swappedWith = _arg_3;
            direction = _arg_2;
        }

    }
}

