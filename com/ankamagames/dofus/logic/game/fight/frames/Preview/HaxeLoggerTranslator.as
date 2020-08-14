package com.ankamagames.dofus.logic.game.fight.frames.Preview
{
    import tools.LoggerInterface;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;

    public class HaxeLoggerTranslator implements LoggerInterface 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HaxeLoggerTranslator));


        public function logError(message:String):void
        {
            _log.trace(message);
        }


    }
} com.ankamagames.dofus.logic.game.fight.frames.Preview

