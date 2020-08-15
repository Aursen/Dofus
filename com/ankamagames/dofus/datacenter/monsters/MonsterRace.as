package com.ankamagames.dofus.datacenter.monsters
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;

    public class MonsterRace implements IDataCenter 
    {

        public static const MODULE:String = "MonsterRaces";
        public static var idAccessors:IdAccessors = new IdAccessors(getMonsterRaceById, getMonsterRaces);

        public var id:int;
        public var superRaceId:int;
        public var nameId:uint;
        public var monsters:Vector.<uint>;
        public var aggressiveZoneSize:int;
        public var aggressiveLevelDiff:int;
        public var aggressiveImmunityCriterion:String;
        public var aggressiveAttackDelay:int;
        private var _name:String;


        public static function getMonsterRaceById(id:uint):MonsterRace
        {
            return (GameData.getObject(MODULE, id) as MonsterRace);
        }

        public static function getMonsterRaces():Array
        {
            return (GameData.getObjects(MODULE));
        }


        public function get name():String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            };
            return (this._name);
        }

        public function get canAttack():Boolean
        {
            var criterions:GroupItemCriterion;
            if (this.aggressiveImmunityCriterion)
            {
                criterions = new GroupItemCriterion(this.aggressiveImmunityCriterion);
                if (criterions.isRespected)
                {
                    return (false);
                };
            };
            return (true);
        }


    }
}

