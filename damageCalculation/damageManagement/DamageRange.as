package damageCalculation.damageManagement
{
    import damageCalculation.tools.Interval;
    import tools.enumeration.ElementEnum;
    import damageCalculation.spellManagement.HaxeSpellEffect;

    public class DamageRange extends Interval 
    {

        public static var ZERO:DamageRange = new DamageRange(0, 0);

        public var isInvulnerable:Boolean = false;
        public var group:int = 0;
        public var probability:int = 0;
        public var isCollision:Boolean = false;
        public var isCritical:Boolean = false;
        public var isHeal:Boolean = false;
        public var isShieldDamage:Boolean = false;
        public var elemId:int = -1;

        public function DamageRange(_arg_1:int=0, _arg_2:int=0):void
        {
            super(_arg_1, _arg_2);
        }

        public static function fromSpellEffect(_arg_1:HaxeSpellEffect, _arg_2:Boolean=false):DamageRange
        {
            var _local_3:DamageRange = new DamageRange(((_arg_2) ? _arg_1.getMinRoll() : _arg_1.getRandomRoll()), _arg_1.getMaxRoll());
            _local_3.isCollision = (_arg_1.actionId == 80);
            _local_3.elemId = ElementEnum.getElementFromActionId(_arg_1.actionId);
            _local_3.isCritical = _arg_1.isCritical;
            _local_3.probability = _arg_1.randomWeight;
            _local_3.group = _arg_1.randomGroup;
            return (_local_3);
        }

        public static function fromInterval(_arg_1:Interval):DamageRange
        {
            return (new DamageRange(_arg_1.min, _arg_1.max));
        }


        override public function copy():Interval
        {
            var _local_1:DamageRange = new DamageRange();
            _local_1.min = min;
            _local_1.max = max;
            _local_1.elemId = elemId;
            _local_1.isShieldDamage = isShieldDamage;
            _local_1.isHeal = isHeal;
            _local_1.isCritical = isCritical;
            _local_1.isCollision = isCollision;
            _local_1.isInvulnerable = isInvulnerable;
            _local_1.probability = probability;
            _local_1.group = group;
            return (_local_1);
        }


    }
} damageCalculation.damageManagement

