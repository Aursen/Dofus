package com.ankamagames.dofus.logic.game.fight.miscs
{
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.Constants;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import mapTools.MapTools;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.dofus.network.types.game.context.FightEntityDispositionInformations;
    import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.jerakine.types.positions.PathElement;
    import com.ankamagames.jerakine.types.positions.MovementPath;

    public class TackleUtil 
    {


        public static function getTackle(playerInfos:GameFightFighterInformations, position:MapPoint):Number
        {
            var x:int;
            var y:int;
            var evade:int;
            var entities:Array;
            var evadePercent:Number;
            var entity:IEntity;
            var infos:GameFightFighterInformations;
            var tackle:int;
            var mod:Number;
            var entitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            if (Constants.DETERMINIST_TACKLE)
            {
                if (!canBeTackled(playerInfos, position))
                {
                    return (1);
                };
                x = position.x;
                y = position.y;
                evade = playerInfos.stats.tackleEvade;
                if (evade < 0)
                {
                    evade = 0;
                };
                entities = new Array();
                if (MapPoint.isInMap((x - 1), y))
                {
                    entities.push(getTacklerOnCell(MapTools.getCellIdByCoord((x - 1), y)));
                };
                if (MapPoint.isInMap((x + 1), y))
                {
                    entities.push(getTacklerOnCell(MapTools.getCellIdByCoord((x + 1), y)));
                };
                if (MapPoint.isInMap(x, (y - 1)))
                {
                    entities.push(getTacklerOnCell(MapTools.getCellIdByCoord(x, (y - 1))));
                };
                if (MapPoint.isInMap(x, (y + 1)))
                {
                    entities.push(getTacklerOnCell(MapTools.getCellIdByCoord(x, (y + 1))));
                };
                evadePercent = 1;
                for each (entity in entities)
                {
                    if (entity)
                    {
                        infos = (entitiesFrame.getEntityInfos(entity.id) as GameFightFighterInformations);
                        if (canBeTackler(infos, playerInfos))
                        {
                            tackle = infos.stats.tackleBlock;
                            if (tackle < 0)
                            {
                                tackle = 0;
                            };
                            mod = (((evade + 2) / (tackle + 2)) / 2);
                            if (mod < 1)
                            {
                                evadePercent = (evadePercent * mod);
                            };
                        };
                    };
                };
                return (evadePercent);
            };
            return (1);
        }

        public static function getTackleForFighter(tackler:GameFightFighterInformations, tackled:GameFightFighterInformations):Number
        {
            if (!Constants.DETERMINIST_TACKLE)
            {
                return (1);
            };
            if (!canBeTackled(tackled))
            {
                return (1);
            };
            if (!canBeTackler(tackler, tackled))
            {
                return (1);
            };
            var evade:int = tackled.stats.tackleEvade;
            if (evade < 0)
            {
                evade = 0;
            };
            var tackle:int = tackler.stats.tackleBlock;
            if (tackle < 0)
            {
                tackle = 0;
            };
            return (((evade + 2) / (tackle + 2)) / 2);
        }

        public static function getTacklerOnCell(cellId:int):AnimatedCharacter
        {
            var entity:AnimatedCharacter;
            var infos:GameFightFighterInformations;
            var entitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            var entities:Array = EntitiesManager.getInstance().getEntitiesOnCell(cellId, AnimatedCharacter);
            for each (entity in entities)
            {
                infos = (entitiesFrame.getEntityInfos(entity.id) as GameFightFighterInformations);
                if (((infos) && (infos.disposition is FightEntityDispositionInformations)))
                {
                    if (!FightersStateManager.getInstance().hasState(entity.id, DataEnum.SPELL_STATE_CARRIED))
                    {
                        return (entity);
                    };
                };
            };
            return (null);
        }

        public static function canBeTackled(fighter:GameFightFighterInformations, position:MapPoint=null):Boolean
        {
            var fedi:FightEntityDispositionInformations;
            if ((((((FightersStateManager.getInstance().hasState(fighter.contextualId, DataEnum.SPELL_STATE_CANT_BE_LOCKED)) || (FightersStateManager.getInstance().hasState(fighter.contextualId, DataEnum.SPELL_STATE_ROOTED))) || (fighter.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)) || (fighter.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED)) || (FightersStateManager.getInstance().getStatus(fighter.contextualId).cantBeTackled)))
            {
                return (false);
            };
            if ((fighter.disposition is FightEntityDispositionInformations))
            {
                fedi = (fighter.disposition as FightEntityDispositionInformations);
                if (((fedi.carryingCharacterId) && ((!(position)) || (fighter.disposition.cellId == position.cellId))))
                {
                    return (false);
                };
            };
            return (true);
        }

        public static function canBeTackler(fighter:GameFightFighterInformations, target:GameFightFighterInformations):Boolean
        {
            var monster:Monster;
            if (((((((FightersStateManager.getInstance().hasState(fighter.contextualId, DataEnum.SPELL_STATE_CARRIED)) || (FightersStateManager.getInstance().hasState(fighter.contextualId, DataEnum.SPELL_STATE_ROOTED))) || (FightersStateManager.getInstance().hasState(fighter.contextualId, DataEnum.SPELL_STATE_CANT_LOCK))) || (fighter.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)) || (fighter.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED)) || (FightersStateManager.getInstance().getStatus(fighter.contextualId).cantTackle)))
            {
                return (false);
            };
            var entitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            var infos:GameFightFighterInformations = (entitiesFrame.getEntityInfos(fighter.contextualId) as GameFightFighterInformations);
            if (((infos) && (infos.spawnInfo.teamId == target.spawnInfo.teamId)))
            {
                return (false);
            };
            if ((fighter is GameFightMonsterInformations))
            {
                monster = Monster.getMonsterById((fighter as GameFightMonsterInformations).creatureGenericId);
                if (!monster.canTackle)
                {
                    return (false);
                };
            };
            return (fighter.spawnInfo.alive);
        }

        public static function isTackling(pPlayer:GameFightFighterInformations, pTackler:GameFightFighterInformations, pPlayerPath:MovementPath):Boolean
        {
            var pe:PathElement;
            var x:int;
            var y:int;
            var playerEvasion:int;
            var tacklerBlock:int;
            var i:int;
            var j:int;
            var ac:AnimatedCharacter;
            var tackling:Boolean;
            if (((pPlayerPath) && (canBeTackler(pTackler, pPlayer))))
            {
                for each (pe in pPlayerPath.path)
                {
                    if (canBeTackled(pPlayer, pe.step))
                    {
                        x = pe.step.x;
                        y = pe.step.y;
                        i = (x - 1);
                        while (i <= (x + 1))
                        {
                            j = (y - 1);
                            while (j <= (y + 1))
                            {
                                ac = getTacklerOnCell(MapTools.getCellIdByCoord(i, j));
                                if (((ac) && (ac.id == pTackler.contextualId)))
                                {
                                    playerEvasion = ((pPlayer.stats.tackleEvade < 0) ? 0 : pPlayer.stats.tackleEvade);
                                    tacklerBlock = ((pTackler.stats.tackleBlock < 0) ? 0 : pTackler.stats.tackleBlock);
                                    return ((((playerEvasion + 2) / (tacklerBlock + 2)) / 2) < 1);
                                };
                                j++;
                            };
                            i++;
                        };
                    };
                };
            };
            return (tackling);
        }


    }
} com.ankamagames.dofus.logic.game.fight.miscs

