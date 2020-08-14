package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.types.data.UiModule;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.misc.utils.LuaScriptManager;
    import com.ankamagames.dofus.misc.utils.enums.LuaFormulasEnum;
    import com.ankamagames.dofus.datacenter.characteristics.Characteristic;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;

    [InstanciedApi]
    public class LuaApi implements IApi 
    {

        protected static var _log:Logger = Log.getLogger(getQualifiedClassName(DataApi));

        private var _module:UiModule;


        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        public function destroy():void
        {
            this._module = null;
        }

        public function getCurrentMonsterXp(monsterLvl:uint, isBoss:Boolean):uint
        {
            var params:Dictionary = new Dictionary();
            params["monster_level"] = monsterLvl;
            params["monster_is_boss"] = isBoss;
            return (LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.MONSTER_XP, params) as uint);
        }

        public function getMonsterLifeScale(monsterLvl:uint, monster:Monster, characId:uint):int
        {
            var params:Dictionary = new Dictionary();
            params["monster_level"] = monsterLvl;
            params["stat_ratio"] = monster.getCharacRatio(characId);
            return (LuaScriptManager.getInstance().executeLuaFormula(Characteristic.getCharacteristicById(characId).scaleFormulaId, params) as int);
        }

        public function getMonsterStatScale(monster:Monster, characId:uint):int
        {
            var params:Dictionary = new Dictionary();
            params["monster_level"] = monster.grades[(monster.scaleGradeRef - 1)].level;
            params["stat_ratio"] = monster.getCharacRatio(characId);
            params["stat_base"] = this.getGradeStatValueById(monster, characId);
            return (0);
        }

        public function getMonsterMovementPointsScale(monster:Monster, monsterLevel:uint, characId:uint):int
        {
            var params:Dictionary = new Dictionary();
            params["monster_level"] = monsterLevel;
            params["monster_grade_hidden_level"] = monster.grades[(monster.scaleGradeRef - 1)].hiddenLevel;
            params["stat_base"] = this.getGradeStatValueById(monster, characId);
            params["monster_grade_level"] = monster.grades[(monster.scaleGradeRef - 1)].level;
            return (LuaScriptManager.getInstance().executeLuaFormula(Characteristic.getCharacteristicById(characId).scaleFormulaId, params) as int);
        }

        public function getMonsterBonusRangeScale(monster:Monster, monsterLevel:uint, characId:uint):int
        {
            var params:Dictionary = new Dictionary();
            params["monster_level"] = monsterLevel;
            params["monster_grade_hidden_level"] = monster.grades[(monster.scaleGradeRef - 1)].hiddenLevel;
            params["stat_base"] = this.getGradeStatValueById(monster, characId);
            params["monster_grade_level"] = monster.grades[(monster.scaleGradeRef - 1)].level;
            return (LuaScriptManager.getInstance().executeLuaFormula(Characteristic.getCharacteristicById(characId).scaleFormulaId, params) as int);
        }

        public function getGradeStatValueById(monster:Monster, characId:uint):int
        {
            switch (characId)
            {
                case DataEnum.CHARAC_MOVEMENT_POINT_ID:
                    return (monster.grades[(monster.scaleGradeRef - 1)].movementPoints);
                case DataEnum.CHARAC_VITALITY_ID:
                    return (monster.grades[(monster.scaleGradeRef - 1)].vitality);
                case DataEnum.CHARAC_HEALTH_POINT_ID:
                    return (monster.grades[(monster.scaleGradeRef - 1)].lifePoints);
                case DataEnum.CHARAC_RANGE_ID:
                    return (monster.grades[(monster.scaleGradeRef - 1)].bonusRange);
            };
            return (0);
        }

        public function getScoreDifficulty(floor:int, score:int, relativeScore:int):int
        {
            var params:Dictionary = new Dictionary();
            params["ib_floor"] = floor;
            params["ib_room_absolute_score"] = score;
            params["ib_room_relative_score"] = relativeScore;
            return (LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.BREACH_ROOM_DIFFICULTY, params) as int);
        }

        public function getFightExpMultiplier(floor:int, score:int, relativeScore:int):Number
        {
            var params:Dictionary = new Dictionary();
            params["ib_floor"] = floor;
            params["ib_room_absolute_score"] = score;
            params["ib_room_relative_score"] = relativeScore;
            return (LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.BREACH_EXP_MULTIPLIER, params) as Number);
        }

        public function getMonsterHiddenLevel(monsterLevel:int, monster:Monster):int
        {
            var params:Dictionary = new Dictionary();
            params["monster_level"] = monsterLevel;
            params["monster_grade_hidden_level"] = monster.grades[(monster.scaleGradeRef - 1)].hiddenLevel;
            params["monster_grade_level"] = monster.grades[(monster.scaleGradeRef - 1)].level;
            return (LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.BREACH_MONSTER_HIDDEN_LEVEL, params) as int);
        }


    }
} com.ankamagames.dofus.uiApi

