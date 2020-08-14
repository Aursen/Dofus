package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.common.managers.AbstractItemFilterManager;
    import luaAlchemy.LuaAlchemy;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.datacenter.misc.LuaFormula;
    import com.ankamagames.dofus.logic.common.managers.*;

    public class LuaScriptManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractItemFilterManager));
        private static var _self:LuaScriptManager;

        private var _luaAlchemy:LuaAlchemy;

        public function LuaScriptManager()
        {
            if (_self)
            {
                throw (new SingletonError());
            };
            this.init();
        }

        public static function getInstance():LuaScriptManager
        {
            if (!_self)
            {
                _self = new (LuaScriptManager)();
            };
            return (_self);
        }


        private function init():void
        {
            this._luaAlchemy = new LuaAlchemy();
        }

        private function formatScriptToLuaFunction(scriptCode:String, functionName:String="main"):String
        {
            var functionString:* = ((((scriptCode + "\n") + "return ") + functionName) + "()\n");
            return (functionString);
        }

        public function executeScript(luaFunction:String, params:Dictionary):Object
        {
            var luaResult:Array;
            var key:String;
            if (params != null)
            {
                for (key in params)
                {
                    this._luaAlchemy.setGlobalLuaValue(key, params[key]);
                };
            };
            luaResult = this._luaAlchemy.doString(luaFunction);
            if (params != null)
            {
                for (key in params)
                {
                    this._luaAlchemy.setGlobal(key, null);
                };
            };
            var success:Boolean = luaResult.shift();
            if (!success)
            {
                throw (new Error(luaResult[0]));
            };
            return (luaResult[0]);
        }

        public function executeLuaFormula(luaFormulaId:uint, params:Dictionary):Object
        {
            return (this.executeScript(this.getLuaFunctionFromFormulaId(luaFormulaId), params));
        }

        public function getLuaFunctionFromFormulaId(luaFormulaId:uint):String
        {
            var formula:LuaFormula = LuaFormula.getLuaFormulaById(luaFormulaId);
            return (this.formatScriptToLuaFunction(formula.luaFormula));
        }


    }
} com.ankamagames.dofus.misc.utils

