package damageCalculation.spellManagement
{
    import mapTools.SpellZone;
    import tools.enumeration.ElementEnum;
    import damageCalculation.tools.Interval;

    public class HaxeSpellEffect 
    {

        public static var INVALID_ACTION_ID:int = -1;

        public var zone:SpellZone;
        public var triggers:Array;
        public var rawZone:String;
        public var randomWeight:int;
        public var randomGroup:int;
        public var param3:int;
        public var param2:int;
        public var param1:int;
        public var order:int;
        public var masks:Array;
        public var level:int;
        public var isDispellable:Boolean;
        public var isCritical:Boolean;
        public var id:uint;
        public var duration:int;
        public var delay:int;
        public var category:int;
        public var actionId:int;

        public function HaxeSpellEffect(_arg_1:uint, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:Boolean, _arg_10:String, _arg_11:String, _arg_12:String, _arg_13:int, _arg_14:int, _arg_15:Boolean, _arg_16:int, _arg_17:int):void
        {
            id = _arg_1;
            level = _arg_2;
            order = _arg_3;
            actionId = _arg_4;
            param1 = _arg_5;
            param2 = _arg_6;
            param3 = _arg_7;
            duration = _arg_8;
            isCritical = _arg_9;
            triggers = SpellManager.splitTriggers(_arg_10);
            rawZone = _arg_11;
            masks = SpellManager.splitMasks(_arg_12);
            masks.sort(function (_arg_1:String, _arg_2:String):int
            {
                return (HaxeSpellEffect.sortMasks(_arg_1, _arg_2));
            });
            randomWeight = _arg_13;
            randomGroup = _arg_14;
            isDispellable = _arg_15;
            delay = _arg_16;
            category = _arg_17;
            zone = SpellZone.fromRawZone(_arg_11);
        }

        public static function sortMasks(_arg_1:String, _arg_2:String):int
        {
            if ("*bBeEfFzZKoOPpTWUvVrRQq".indexOf(_arg_1.charAt(0)) != -1)
            {
                if ("*bBeEfFzZKoOPpTWUvVrRQq".indexOf(_arg_2.charAt(0)) != -1)
                {
                    if (((_arg_1.charCodeAt(0) == ("*".charCodeAt(0))) && (!(_arg_2.charCodeAt(0) == "*".charCodeAt(0)))))
                    {
                        return (-1);
                    };
                    if (((_arg_2.charCodeAt(0) == ("*".charCodeAt(0))) && (!(_arg_1.charCodeAt(0) == "*".charCodeAt(0)))))
                    {
                        return (1);
                    };
                };
                return (-1);
            };
            if ("*bBeEfFzZKoOPpTWUvVrRQq".indexOf(_arg_2.charAt(0)) != -1)
            {
                return (1);
            };
            return (0);
        }


        public function isRandom():Boolean
        {
            return (randomWeight > 0);
        }

        public function isAOE():Boolean
        {
            return (zone.radius >= 1);
        }

        public function getRandomRoll():int
        {
            var _local_1:int = getMinRoll();
            var _local_2:int = getMaxRoll();
            var _local_3:Number = Math.random();
            var _local_4:Number = (_local_3 * (_local_2 - _local_1));
            return (Math.floor(((_local_1 + _local_4) + 0.5)));
        }

        public function getMinRoll():int
        {
            return (param1 + param3);
        }

        public function getMaxRoll():int
        {
            return ((param1 * param2) + param3);
        }

        public function getElement():int
        {
            return (ElementEnum.getElementFromActionId(actionId));
        }

        public function getDamageInterval():Interval
        {
            return (new Interval(getMinRoll(), getMaxRoll()));
        }

        public function clone():HaxeSpellEffect
        {
            var _local_1:HaxeSpellEffect = new HaxeSpellEffect(id, level, order, actionId, param1, param2, param3, duration, isCritical, "", rawZone, "", randomWeight, randomGroup, isDispellable, delay, category);
            _local_1.triggers = triggers;
            _local_1.masks = masks;
            return (_local_1);
        }


    }
} damageCalculation.spellManagement

