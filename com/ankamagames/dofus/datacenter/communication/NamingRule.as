package com.ankamagames.dofus.datacenter.communication
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class NamingRule implements IDataCenter 
    {

        public static const MODULE:String = "NamingRules";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NamingRule));
        public static var idAccessors:IdAccessors = new IdAccessors(getNamingRuleById, getNamingRules);

        public var id:uint;
        public var minLength:uint;
        public var maxLength:uint;
        public var regexp:String;


        public static function getNamingRuleById(id:int):NamingRule
        {
            return (GameData.getObject(MODULE, id) as NamingRule);
        }

        public static function getNamingRules():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
} com.ankamagames.dofus.datacenter.communication

