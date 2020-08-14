package damageCalculation.damageManagement
{
    import damageCalculation.tools.Interval;
    import damageCalculation.fighterManagement.HaxeFighter;

    public class EffectOutput 
    {

        public var isLifeAffected:Boolean;
        public var fighterId:Number;
        public var areMaxLifePointsAffected:Boolean;
        public var areLifePointsAffected:Boolean;
        public var areErodedLifePointsAffected:Boolean;

        public var isSummoning:Boolean = false;
        public var summon:SummonInfos = null;
        public var unknown:Boolean = false;
        public var carriedBy:Number = 0;
        public var throwedBy:Number = 0;
        public var death:Boolean = false;
        public var dispell:Boolean = false;
        public var lostStateId:int = -1;
        public var newStateId:int = -1;
        public var rangeStolen:int = 0;
        public var amStolen:int = 0;
        public var apStolen:int = 0;
        public var attemptedAmTheft:Boolean = false;
        public var attemptedApTheft:Boolean = false;
        public var throughPortal:Boolean = false;
        public var isPulled:Boolean = false;
        public var isPushed:Boolean = false;
        public var movement:MovementInfos = null;
        public var shield:Interval = null;
        public var damageRange:DamageRange = null;

        public function EffectOutput(_arg_1:Number):void
        {
            fighterId = _arg_1;
        }

        public static function fromMovement(_arg_1:Number, _arg_2:int, _arg_3:int, _arg_4:HaxeFighter=undefined):EffectOutput
        {
            var _local_5:EffectOutput = new EffectOutput(_arg_1);
            _local_5.movement = new MovementInfos(_arg_2, _arg_3, _arg_4);
            return (_local_5);
        }

        public static function fromDamageRange(_arg_1:Number, _arg_2:DamageRange):EffectOutput
        {
            var _local_3:EffectOutput = new EffectOutput(_arg_1);
            _local_3.damageRange = _arg_2;
            return (_local_3);
        }

        public static function fromApTheft(_arg_1:Number, _arg_2:int):EffectOutput
        {
            var _local_3:EffectOutput = new EffectOutput(_arg_1);
            _local_3.apStolen = _arg_2;
            _local_3.attemptedApTheft = true;
            return (_local_3);
        }

        public static function fromAmTheft(_arg_1:Number, _arg_2:int):EffectOutput
        {
            var _local_3:EffectOutput = new EffectOutput(_arg_1);
            _local_3.amStolen = _arg_2;
            _local_3.attemptedAmTheft = true;
            return (_local_3);
        }

        public static function fromStateChange(_arg_1:Number, _arg_2:int, _arg_3:Boolean):EffectOutput
        {
            var _local_4:EffectOutput = new EffectOutput(_arg_1);
            if (_arg_3)
            {
                _local_4.newStateId = _arg_2;
            }
            else
            {
                _local_4.lostStateId = _arg_2;
            };
            return (_local_4);
        }

        public static function deathOf(_arg_1:Number):EffectOutput
        {
            var _local_2:EffectOutput = new EffectOutput(_arg_1);
            _local_2.death = true;
            return (_local_2);
        }

        public static function fromDispell(_arg_1:Number):EffectOutput
        {
            var _local_2:EffectOutput = new EffectOutput(_arg_1);
            _local_2.dispell = true;
            return (_local_2);
        }

        public static function fromSummon(_arg_1:Number, _arg_2:int, _arg_3:int, _arg_4:Number=0):EffectOutput
        {
            var _local_5:EffectOutput = new EffectOutput(_arg_1);
            _local_5.summon = new SummonInfos(_arg_2, _arg_3, _arg_4);
            return (_local_5);
        }

        public static function fromSummoning(_arg_1:Number):EffectOutput
        {
            var _local_2:EffectOutput = new EffectOutput(_arg_1);
            _local_2.isSummoning = true;
            return (_local_2);
        }

        public static function fromAffectedLifePoints(_arg_1:Number):EffectOutput
        {
            var _local_2:EffectOutput = new EffectOutput(_arg_1);
            _local_2.areLifePointsAffected = true;
            return (_local_2);
        }

        public static function fromAffectedMaxLifePoints(_arg_1:Number):EffectOutput
        {
            var _local_2:EffectOutput = new EffectOutput(_arg_1);
            _local_2.areMaxLifePointsAffected = true;
            return (_local_2);
        }

        public static function fromErodedLifePoints(_arg_1:Number):EffectOutput
        {
            var _local_2:EffectOutput = new EffectOutput(_arg_1);
            _local_2.areErodedLifePointsAffected = true;
            return (_local_2);
        }


        public function get_isLifeAffected():Boolean
        {
            if (!((areLifePointsAffected) || (areMaxLifePointsAffected)))
            {
                return (areErodedLifePointsAffected);
            };
            return (true);
        }

        public function computeShieldDamage():DamageRange
        {
            if (((damageRange == (null)) || (shield == null)))
            {
                return (DamageRange.ZERO);
            };
            var _local_1:DamageRange = damageRange.copy();
            _local_1.maximizeByInterval(shield);
            _local_1.isShieldDamage = true;
            return (_local_1);
        }

        public function computeLifeDamage():DamageRange
        {
            if (damageRange == null)
            {
                return (DamageRange.ZERO);
            };
            var _local_1:DamageRange = damageRange.copy();
            if (shield != null)
            {
                _local_1.subInterval(shield);
                _local_1.minimizeBy(0);
            };
            return (_local_1);
        }


    }
} damageCalculation.damageManagement

