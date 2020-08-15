package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.berilia.frames.ShortcutsFrame;
    import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.types.event.UiRenderEvent;
    import com.ankamagames.berilia.types.event.UiUnloadEvent;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameContextRemoveElementMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameContextRemoveMultipleElementsMessage;
    import com.ankamagames.atouin.messages.EntityMovementStartMessage;
    import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
    import com.ankamagames.atouin.Atouin;
    import flash.events.Event;
    import com.ankamagames.tiphon.events.TiphonEvent;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPortalInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
    import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
    import __AS3__.vec.*;

    public class EntitiesTooltipsFrame implements Frame 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(EntitiesTooltipsFrame));

        private var _roleplayEntitiesFrame:RoleplayEntitiesFrame;
        private var _roleplayWorldFrame:RoleplayWorldFrame;
        private var _movingGroups:Vector.<Number> = new Vector.<Number>();
        private var _checkMovingGroups:Boolean;
        public var triggeredByShortcut:Boolean;


        public function pushed():Boolean
        {
            var shortcutsFrame:ShortcutsFrame = (Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame);
            this._roleplayWorldFrame = (Kernel.getWorker().getFrame(RoleplayWorldFrame) as RoleplayWorldFrame);
            if (((!(this._roleplayWorldFrame)) || ((this.triggeredByShortcut) && (shortcutsFrame.heldShortcuts.indexOf("showEntitiesTooltips") == -1))))
            {
                return (false);
            };
            this._roleplayEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
            if (((this._roleplayEntitiesFrame) && (this.getNonPlayableEntitiesIds().length > 0)))
            {
                this.update();
            };
            this._checkMovingGroups = true;
            EnterFrameDispatcher.addEventListener(this.updateTooltipPos, "EntitiesTooltips", StageShareManager.stage.frameRate);
            Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderComplete, this.onLoadUi);
            Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE, this.onUnLoadUi);
            KernelEventsManager.getInstance().processCallback(HookList.ShowEntitiesTooltips, true);
            return (true);
        }

        public function pulled():Boolean
        {
            var monsterId:*;
            var entitiesIds:Vector.<Number>;
            var entityId:Number;
            if (this._roleplayEntitiesFrame)
            {
                entitiesIds = this.getNonPlayableEntitiesIds();
                for each (entityId in entitiesIds)
                {
                    this._roleplayWorldFrame.process(new EntityMouseOutMessage((DofusEntities.getEntity(entityId) as AnimatedCharacter)));
                };
            };
            this._movingGroups.length = 0;
            EnterFrameDispatcher.removeEventListener(this.updateTooltipPos);
            Berilia.getInstance().removeEventListener(UiRenderEvent.UIRenderComplete, this.onLoadUi);
            Berilia.getInstance().removeEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE, this.onUnLoadUi);
            var shortcutsFrame:ShortcutsFrame = (Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame);
            var shortcutIndex:int = shortcutsFrame.heldShortcuts.indexOf("showEntitiesTooltips");
            if (shortcutIndex != -1)
            {
                shortcutsFrame.heldShortcuts.splice(shortcutIndex, 1);
            };
            KernelEventsManager.getInstance().processCallback(HookList.ShowEntitiesTooltips, false);
            return (true);
        }

        public function process(pMsg:Message):Boolean
        {
            var ac:AnimatedCharacter;
            var entityInfos:*;
            var emovm:EntityMouseOverMessage;
            var emoum:EntityMouseOutMessage;
            var gcrem:GameContextRemoveElementMessage;
            var gcrmem:GameContextRemoveMultipleElementsMessage;
            var emsm:EntityMovementStartMessage;
            var emcm:EntityMovementCompleteMessage;
            var id:Number;
            var groupIndex:int;
            if (!Kernel.getWorker().contains(RoleplayWorldFrame))
            {
                return (false);
            };
            switch (true)
            {
                case (pMsg is EntityMouseOverMessage):
                    emovm = (pMsg as EntityMouseOverMessage);
                    ac = (emovm.entity as AnimatedCharacter);
                    if (((ac) && (!(this.getNonPlayableEntitiesIds().indexOf(ac.getRootEntity().id) == -1))))
                    {
                        return (true);
                    };
                    break;
                case (pMsg is EntityMouseOutMessage):
                    emoum = (pMsg as EntityMouseOutMessage);
                    ac = (emoum.entity as AnimatedCharacter);
                    if (((ac) && (!(this.getNonPlayableEntitiesIds().indexOf(ac.getRootEntity().id) == -1))))
                    {
                        return (true);
                    };
                    break;
                case (pMsg is GameContextRemoveElementMessage):
                    gcrem = (pMsg as GameContextRemoveElementMessage);
                    TooltipManager.hide(("entity_" + gcrem.id));
                    break;
                case (pMsg is GameContextRemoveMultipleElementsMessage):
                    gcrmem = (pMsg as GameContextRemoveMultipleElementsMessage);
                    for each (id in gcrmem.elementsIds)
                    {
                        TooltipManager.hide(("entity_" + id));
                    };
                    break;
                case (pMsg is EntityMovementStartMessage):
                    emsm = (pMsg as EntityMovementStartMessage);
                    ac = (EntitiesManager.getInstance().getEntity(emsm.id) as AnimatedCharacter);
                    if (((!(this.isPlayer(ac.id))) && (ac == ac.getRootEntity())))
                    {
                        if (this._movingGroups.indexOf(ac.id) == -1)
                        {
                            this._movingGroups.push(ac.id);
                        };
                    };
                    break;
                case (pMsg is EntityMovementCompleteMessage):
                    emcm = (pMsg as EntityMovementCompleteMessage);
                    ac = (EntitiesManager.getInstance().getEntity(emcm.id) as AnimatedCharacter);
                    if (ac == null)
                    {
                        _log.warn((("AnimatedCharacter with id : " + emcm.id) + ", not found"));
                    };
                    if ((((ac) && (!(this.isPlayer(ac.id)))) && (ac == ac.getRootEntity())))
                    {
                        groupIndex = this._movingGroups.indexOf(ac.id);
                        if (groupIndex != -1)
                        {
                            this._movingGroups.splice(groupIndex, 1);
                        };
                    };
                    if (this.getNonPlayableEntitiesIds().indexOf(emcm.id) != -1)
                    {
                        this.update(true);
                    };
                    break;
            };
            return (false);
        }

        public function get priority():int
        {
            return (Priority.HIGH);
        }

        public function update(pForceRefresh:Boolean=false):void
        {
            var i:int;
            var entityId:Number;
            var entitiesIds:Vector.<Number> = this.getNonPlayableEntitiesIds();
            var len:int = entitiesIds.length;
            i = 0;
            while (i < len)
            {
                entityId = entitiesIds[i];
                if (((!(this.isPlayer(entityId))) && ((pForceRefresh) || (!(TooltipManager.isVisible(("entity_" + entityId)))))))
                {
                    TooltipPlacer.waitBeforeOrder(("tooltip_entity_" + entityId));
                };
                i++;
            };
            i = 0;
            while (i < len)
            {
                entityId = entitiesIds[i];
                if (((!(this.isPlayer(entityId))) && ((pForceRefresh) || (!(TooltipManager.isVisible(("entity_" + entityId)))))))
                {
                    this.showToolTip(entityId);
                };
                i++;
            };
        }

        private function onLoadUi(pEvent:UiRenderEvent):void
        {
            if (!Atouin.getInstance().worldIsVisible)
            {
                EnterFrameDispatcher.removeEventListener(this.updateTooltipPos);
                this._checkMovingGroups = false;
            };
        }

        private function onUnLoadUi(pEvent:UiUnloadEvent):void
        {
            if (pEvent.name.indexOf("tooltip") == -1)
            {
                this.update();
                if (!this._checkMovingGroups)
                {
                    this._checkMovingGroups = true;
                    EnterFrameDispatcher.addEventListener(this.updateTooltipPos, "EntitiesTooltips", StageShareManager.stage.frameRate);
                };
            };
        }

        private function updateTooltipPos(pEvent:Event):void
        {
            var movingEntityId:Number;
            if (this._movingGroups.length > 0)
            {
                for each (movingEntityId in this._movingGroups)
                {
                    this.showToolTip(movingEntityId);
                };
            };
        }

        private function showToolTip(pParam:Object):void
        {
            var entity:AnimatedCharacter;
            if ((pParam is TiphonEvent))
            {
                entity = pParam.currentTarget;
                entity.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.showToolTip);
            }
            else
            {
                entity = (DofusEntities.getEntity((pParam as Number)) as AnimatedCharacter);
            };
            if (entity)
            {
                if (entity.rendered)
                {
                    TooltipManager.hide(("entity_" + entity.id));
                    if (((entity.isMoving) && (this._movingGroups.indexOf(entity.id) == -1)))
                    {
                        this._movingGroups.push(entity.id);
                    };
                    this._roleplayWorldFrame.process(new EntityMouseOverMessage(entity, true, true));
                }
                else
                {
                    entity.addEventListener(TiphonEvent.RENDER_SUCCEED, this.showToolTip);
                };
            };
        }

        private function getNonPlayableEntitiesIds():Vector.<Number>
        {
            var i:int;
            var entityInfos:*;
            var entitiesIds:Vector.<Number> = this._roleplayEntitiesFrame.getEntitiesIdsList();
            var len:uint = entitiesIds.length;
            i = 0;
            while (i < len)
            {
                entityInfos = this._roleplayEntitiesFrame.getEntityInfos(entitiesIds[i]);
                if (!(((((entityInfos is GameRolePlayGroupMonsterInformations) || (entityInfos is GameRolePlayNpcInformations)) || (entityInfos is GameRolePlayTaxCollectorInformations)) || (entityInfos is GameRolePlayPrismInformations)) || (entityInfos is GameRolePlayPortalInformations)))
                {
                    entitiesIds.splice(i, 1);
                    len--;
                    i--;
                };
                i++;
            };
            return (entitiesIds);
        }

        private function isPlayer(pEntityId:Number):Boolean
        {
            var entityInfos:* = this._roleplayEntitiesFrame.getEntityInfos(pEntityId);
            return (((entityInfos is GameRolePlayCharacterInformations) || (entityInfos is GameRolePlayMerchantInformations)) || (entityInfos is GameRolePlayMutantInformations));
        }


    }
}

