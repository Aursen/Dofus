package com.ankamagames.dofus.logic.game.fight.types
{
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import flash.utils.Dictionary;
    import damageCalculation.fighterManagement.HaxeFighter;
    import haxe.ds._List.ListNode;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import damageCalculation.damageManagement.EffectOutput;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.datacenter.monsters.Companion;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import damageCalculation.fighterManagement.PlayerTypeEnum;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.dofus.kernel.Kernel;
    import __AS3__.vec.*;

    public class FightSummonPreview 
    {

        private var _previews:Vector.<AnimatedCharacter>;
        private var _previewsIdAssoc:Dictionary;
        private var _summonedFighters:Vector.<HaxeFighter>;

        public function FightSummonPreview(summonedFighters:Vector.<HaxeFighter>)
        {
            this._previewsIdAssoc = new Dictionary();
            this._summonedFighters = summonedFighters;
            this._previews = new Vector.<AnimatedCharacter>(0);
        }

        public function get previews():Vector.<AnimatedCharacter>
        {
            return (this._previews);
        }

        public function getSummonPreview(pEntityId:Number):AnimatedCharacter
        {
            var id:Number;
            var preview:AnimatedCharacter;
            if (this._previewsIdAssoc[pEntityId])
            {
                id = this._previewsIdAssoc[pEntityId];
            }
            else
            {
                id = pEntityId;
            };
            for each (preview in this.previews)
            {
                if (preview.id == id)
                {
                    return (preview);
                };
            };
            return (null);
        }

        public function isPreview(pEntityId:Number):Boolean
        {
            var previewEntity:AnimatedCharacter;
            if (this._previewsIdAssoc[pEntityId])
            {
                return (true);
            };
            for each (previewEntity in this._previews)
            {
                if (previewEntity.id == pEntityId)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function show():void
        {
            var summonedFighter:HaxeFighter;
            var currentCell:uint;
            var entitiesOnCell:Array;
            var currentCellEntity:AnimatedCharacter;
            var direction:uint;
            var lookId:Number;
            var cursor:ListNode;
            var casterInfos:GameFightFighterInformations;
            var animatedEntity:AnimatedCharacter;
            var entityOnCell:AnimatedCharacter;
            var output:EffectOutput;
            var look:String;
            var monster:Monster;
            var entityId:uint;
            var companion:Companion;
            var entitiesFrame:FightEntitiesFrame;
            if (this._summonedFighters.length > 0)
            {
                for each (summonedFighter in this._summonedFighters)
                {
                    currentCell = summonedFighter.getCurrentPositionCell();
                    entitiesOnCell = EntitiesManager.getInstance().getEntitiesOnCell(currentCell, AnimatedCharacter);
                    if (entitiesOnCell.length > 0)
                    {
                        for each (entityOnCell in entitiesOnCell)
                        {
                            if (entityOnCell.id == summonedFighter.id)
                            {
                                currentCellEntity = entityOnCell;
                                break;
                            };
                        };
                    }
                    else
                    {
                        currentCellEntity = null;
                    };
                    direction = 0;
                    lookId = 0;
                    cursor = summonedFighter.totalEffects.h;
                    while (cursor != null)
                    {
                        output = (cursor.item as EffectOutput);
                        if (output.summon != null)
                        {
                            direction = output.summon.direction;
                            lookId = output.summon.lookId;
                            if (summonedFighter.getCurrentPositionCell() != output.summon.position)
                            {
                                currentCell = output.summon.position;
                            };
                            break;
                        };
                        cursor = cursor.next;
                    };
                    if (currentCellEntity)
                    {
                        currentCellEntity.visible = false;
                        TooltipManager.hide(("tooltipOverEntity_" + currentCellEntity.id));
                    };
                    casterInfos = (FightEntitiesFrame.getCurrentInstance().getEntityInfos(CurrentPlayedFighterManager.getInstance().currentFighterId) as GameFightFighterInformations);
                    if (summonedFighter.playerType == PlayerTypeEnum.HUMAN)
                    {
                        if (lookId == 0)
                        {
                            lookId = summonedFighter.id;
                        };
                        look = EntitiesManager.getInstance().getDeadLook(lookId);
                        if (look == null)
                        {
                            return;
                        };
                        animatedEntity = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(), new TiphonEntityLook(look));
                    }
                    else
                    {
                        if (summonedFighter.playerType == PlayerTypeEnum.MONSTER)
                        {
                            monster = Monster.getMonsterById(summonedFighter.breed);
                            animatedEntity = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(), new TiphonEntityLook(monster.look));
                        }
                        else
                        {
                            if (summonedFighter.playerType == PlayerTypeEnum.SIDEKICK)
                            {
                                entityId = summonedFighter.getModelId();
                                if (entityId == 0)
                                {
                                    return;
                                };
                                companion = Companion.getCompanionById(entityId);
                                animatedEntity = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(), new TiphonEntityLook(companion.look));
                            };
                        };
                    };
                    if (animatedEntity)
                    {
                        animatedEntity.setCanSeeThrough(true);
                        animatedEntity.transparencyAllowed = true;
                        animatedEntity.alpha = 0.65;
                        animatedEntity.mouseEnabled = false;
                        animatedEntity.visible = true;
                        animatedEntity.position = MapPoint.fromCellId(currentCell);
                        animatedEntity.setDirection(MapPoint.fromCellId(casterInfos.disposition.cellId).advancedOrientationTo(MapPoint.fromCellId(currentCell), true));
                        animatedEntity.display(PlacementStrataEnums.STRATA_PLAYER);
                        entitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
                        entitiesFrame.addCircleToFighter(animatedEntity, FightEntitiesFrame.getTeamCircleColor(casterInfos.spawnInfo.teamId));
                        this._previewsIdAssoc[summonedFighter.id] = animatedEntity.id;
                        this._previews.push(animatedEntity);
                    };
                };
            };
        }

        public function remove():void
        {
            var ac:AnimatedCharacter;
            var pos:MapPoint;
            var entitiesOnCell:Array;
            var entityOnCell:AnimatedCharacter;
            if (this._previews)
            {
                for each (ac in this._previews)
                {
                    pos = ac.position;
                    ac.quickDestroy();
                    entitiesOnCell = EntitiesManager.getInstance().getEntitiesOnCell(pos.cellId, AnimatedCharacter);
                    entityOnCell = ((entitiesOnCell.length > 0) ? (FightTeleportationPreview.getParentEntity(entitiesOnCell[0]) as AnimatedCharacter) : null);
                    if (entityOnCell)
                    {
                        entityOnCell.visible = true;
                    };
                };
                this._previews = new Vector.<AnimatedCharacter>(0);
            };
        }


    }
}

