package com.ankamagames.dofus.datacenter.items
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;

    public class Weapon extends Item implements IDataCenter 
    {

        public static var idAccessors:IdAccessors = new IdAccessors(getWeaponById, getWeapons);

        public var apCost:int;
        public var minRange:int;
        public var range:int;
        public var maxCastPerTurn:uint;
        public var castInLine:Boolean;
        public var castInDiagonal:Boolean;
        public var castTestLos:Boolean;
        public var criticalHitProbability:int;
        public var criticalHitBonus:int;
        public var criticalFailureProbability:int;


        public static function getWeaponById(weaponId:int):Weapon
        {
            var item:Item = Item.getItemById(weaponId);
            if (((item) && (item.isWeapon)))
            {
                return (Weapon(item));
            };
            return (null);
        }

        public static function getWeapons():Array
        {
            var item:Item;
            var items:Array = Item.getItems();
            var result:Array = new Array();
            for each (item in items)
            {
                if (item.isWeapon)
                {
                    result.push(item);
                };
            };
            return (result);
        }


        override public function get isWeapon():Boolean
        {
            return (true);
        }

        override public function copy(from:Item, _arg_2:Item):void
        {
            super.copy(from, _arg_2);
            if (((_arg_2.hasOwnProperty("apCost")) && (from.hasOwnProperty("apCost"))))
            {
                Object(_arg_2).apCost = Object(from).apCost;
                Object(_arg_2).minRange = Object(from).minRange;
                Object(_arg_2).range = Object(from).range;
                Object(_arg_2).maxCastPerTurn = Object(from).maxCastPerTurn;
                Object(_arg_2).castInLine = Object(from).castInLine;
                Object(_arg_2).castInDiagonal = Object(from).castInDiagonal;
                Object(_arg_2).castTestLos = Object(from).castTestLos;
                Object(_arg_2).criticalHitProbability = Object(from).criticalHitProbability;
                Object(_arg_2).criticalHitBonus = Object(from).criticalHitBonus;
                Object(_arg_2).criticalFailureProbability = Object(from).criticalFailureProbability;
            }
            else
            {
                _log.error(((("Failed to properly copy weapon data " + from.id) + " to ") + _arg_2.id));
            };
        }


    }
} com.ankamagames.dofus.datacenter.items

