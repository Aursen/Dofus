package com.ankamagames.dofus.logic.game.common.managers
{
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.jerakine.interfaces.IRectangle;
    import com.ankamagames.dofus.internalDatacenter.communication.ChatBubble;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ChatHookList;

    public class SpeakingEntitiesManager 
    {

        private static var _instance:SpeakingEntitiesManager;

        private var _entitiesAssoc:Dictionary = new Dictionary();


        public static function getInstance():SpeakingEntitiesManager
        {
            if (_instance == null)
            {
                _instance = new (SpeakingEntitiesManager)();
                _instance.init();
            };
            return (_instance);
        }


        private function init():void
        {
        }

        public function triggerEvent(nEvent:int):void
        {
            var entityRef:Dictionary;
            var mixedEntityId:uint;
            var entity:GameContextActorInformations;
            var entityId:*;
            var fef:FightEntitiesFrame;
            var trigger:EntityTrigger;
            var totalProba:Number;
            var random:Number;
            var i:uint;
            var matchTrigger:Dictionary = new Dictionary();
            var ref:RoleplayEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
            if (ref)
            {
                entityRef = ref.getEntitiesDictionnary();
            }
            else
            {
                fef = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
                if (fef)
                {
                    entityRef = fef.getEntitiesDictionnary();
                }
                else
                {
                    return;
                };
            };
            var triggers:Array = [];
            for each (entity in entityRef)
            {
                triggers = null;
                mixedEntityId = entity.contextualId;
                if (((((entity is GameRolePlayNpcInformations) && (this._entitiesAssoc[EntityTrigger.ENTITY_TYPE_NPC])) && (this._entitiesAssoc[EntityTrigger.ENTITY_TYPE_NPC][GameRolePlayNpcInformations(entity).npcId])) && (this._entitiesAssoc[EntityTrigger.ENTITY_TYPE_NPC][GameRolePlayNpcInformations(entity).npcId][nEvent])))
                {
                    triggers = this._entitiesAssoc[EntityTrigger.ENTITY_TYPE_NPC][GameRolePlayNpcInformations(entity).npcId][nEvent];
                }
                else
                {
                    if (((((entity is GameFightMonsterInformations) && (this._entitiesAssoc[EntityTrigger.ENTITY_TYPE_MONSTER])) && (this._entitiesAssoc[EntityTrigger.ENTITY_TYPE_MONSTER][GameFightMonsterInformations(entity).creatureGenericId])) && (this._entitiesAssoc[EntityTrigger.ENTITY_TYPE_MONSTER][GameFightMonsterInformations(entity).creatureGenericId][nEvent])))
                    {
                        triggers = this._entitiesAssoc[EntityTrigger.ENTITY_TYPE_MONSTER][GameFightMonsterInformations(entity).creatureGenericId][nEvent];
                    };
                };
                if (triggers)
                {
                    for each (trigger in triggers)
                    {
                        if (((!(trigger.criterions == null)) && (!(trigger.criterions.isRespected))))
                        {
                        }
                        else
                        {
                            if (!matchTrigger[mixedEntityId])
                            {
                                matchTrigger[mixedEntityId] = [];
                            };
                            matchTrigger[mixedEntityId].push(trigger);
                        };
                    };
                };
            };
            for (entityId in matchTrigger)
            {
                totalProba = 0;
                for each (trigger in matchTrigger[entityId])
                {
                    totalProba = (totalProba + trigger.probability);
                };
                random = (Math.random() * ((totalProba > 1) ? totalProba : 1));
                i = 1;
                while (i <= matchTrigger[entityId].length)
                {
                    trigger = matchTrigger[entityId][(i - 1)];
                    if (random > (i * trigger.probability))
                    {
                    }
                    else
                    {
                        this.speak(trigger.text, entityId, trigger.entityName, trigger.displayInChat);
                        break;
                    };
                    i++;
                };
            };
        }

        private function speak(text:String, entityContextualId:int, entityName:String=null, displayInChat:Boolean=false):void
        {
            var entitesBound:IRectangle;
            var bubble:ChatBubble;
            var entite:IDisplayable = (DofusEntities.getEntity(entityContextualId) as IDisplayable);
            if (entite)
            {
                entitesBound = entite.absoluteBounds;
                bubble = new ChatBubble(text);
                TooltipManager.show(bubble, entitesBound, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, ("entityBubble" + entityContextualId), LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_TOPRIGHT, 0, true, null, null, null, null, false, StrataEnum.STRATA_WORLD);
            };
            if (displayInChat)
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.LivingObjectMessage, entityName, text, TimeManager.getInstance().getTimestamp());
            };
        }


    }
}

import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
import com.ankamagames.dofus.datacenter.npcs.Npc;
import com.ankamagames.dofus.datacenter.monsters.Monster;

class EntityTrigger 
{

    public static const ENTITY_TYPE_NPC:uint = 0;
    public static const ENTITY_TYPE_MONSTER:uint = 1;

    public var criterions:GroupItemCriterion;
    public var probability:Number;
    public var text:String;
    public var displayInChat:Boolean = false;
    public var entityType:uint;
    public var entityId:uint;
    public var entityName:String;

    public function EntityTrigger(entityType:uint, entityId:uint, criterions:String, probability:Number, text:String, displayInChat:Boolean=false)
    {
        this.entityType = entityType;
        this.entityId = entityId;
        this.criterions = new GroupItemCriterion(criterions);
        this.probability = probability;
        this.text = text;
        this.displayInChat = displayInChat;
        try
        {
            if (entityType == ENTITY_TYPE_NPC)
            {
                this.entityName = Npc.getNpcById(entityId).name;
            }
            else
            {
                if (entityType == ENTITY_TYPE_MONSTER)
                {
                    this.entityName = Monster.getMonsterById(entityId).name;
                };
            };
        }
        catch(e:Error)
        {
        };
    }

}


