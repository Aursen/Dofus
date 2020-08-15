package com.ankamagames.dofus.datacenter.spells
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.data.GameData;

    public class SpellConversion implements IDataCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellConversion));
        public static const MODULE:String = "SpellConversions";

        public var oldSpellId:uint;
        public var newSpellId:uint;


        public static function getSpellConversionById(id:int):SpellConversion
        {
            return (GameData.getObject(MODULE, id) as SpellConversion);
        }


    }
}

