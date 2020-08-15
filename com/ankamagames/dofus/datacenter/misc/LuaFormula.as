package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class LuaFormula implements IDataCenter 
    {

        public static const MODULE:String = "LuaFormulas";
        public static var idAccessors:IdAccessors = new IdAccessors(getLuaFormulaById, getLuaFormulas);

        public var id:int;
        public var formulaName:String;
        public var luaFormula:String;


        public static function getLuaFormulaById(id:int):LuaFormula
        {
            return (GameData.getObject(MODULE, id) as LuaFormula);
        }

        public static function getLuaFormulas():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}

