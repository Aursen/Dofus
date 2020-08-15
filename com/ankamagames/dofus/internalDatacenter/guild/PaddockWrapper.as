package com.ankamagames.dofus.internalDatacenter.guild
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockBuyableInformations;
    import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockInstancesInformations;

    public class PaddockWrapper implements IDataCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PaddockWrapper));

        public var maxOutdoorMount:uint;
        public var maxItems:uint;
        public var paddockInstances:Array;


        public static function create(paddockInformations:PaddockInstancesInformations):PaddockWrapper
        {
            var paddockInstanceInfo:PaddockBuyableInformations;
            var myGuildId:int;
            var myInstances:Array;
            var instancesLength:int;
            var i:int;
            var instanceWrapper:PaddockInstanceWrapper;
            var piw:Array;
            var paddock:PaddockWrapper = new (PaddockWrapper)();
            paddock.maxOutdoorMount = paddockInformations.maxOutdoorMount;
            paddock.maxItems = paddockInformations.maxItems;
            paddock.paddockInstances = new Array();
            for each (paddockInstanceInfo in paddockInformations.paddocks)
            {
                paddock.paddockInstances.push(PaddockInstanceWrapper.create(paddockInstanceInfo));
            };
            paddock.paddockInstances.sortOn("guildNameForSorting", Array.CASEINSENSITIVE);
            if (SocialFrame.getInstance().guild)
            {
                myGuildId = SocialFrame.getInstance().guild.guildId;
                myInstances = new Array();
                instancesLength = paddock.paddockInstances.length;
                i = (instancesLength - 1);
                while (i >= 0)
                {
                    if (((paddock.paddockInstances[i].guildIdentity) && (paddock.paddockInstances[i].guildIdentity.guildId == myGuildId)))
                    {
                        myInstances.push(paddock.paddockInstances[i]);
                        piw = paddock.paddockInstances.splice(i, 1);
                    };
                    i--;
                };
                for each (instanceWrapper in myInstances)
                {
                    paddock.paddockInstances.unshift(instanceWrapper);
                };
            };
            return (paddock);
        }


    }
}

