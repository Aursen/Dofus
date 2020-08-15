package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMount;
    import com.ankama.dofus.enums.ActionIds;

    public class MountInfoRequestAction implements Action 
    {

        public var item:ItemWrapper;
        public var mountId:Number;
        public var time:Number;


        public static function create(item:ItemWrapper):MountInfoRequestAction
        {
            var effect:EffectInstance;
            var o:MountInfoRequestAction = new (MountInfoRequestAction)();
            o.item = item;
            for each (effect in item.effects)
            {
                switch (effect.effectId)
                {
                    case ActionIds.ACTION_RIDE_DETAILS:
                        o.time = (effect as EffectInstanceMount).expirationDate;
                        o.mountId = (effect as EffectInstanceMount).id;
                        break;
                };
            };
            return (o);
        }


    }
}

