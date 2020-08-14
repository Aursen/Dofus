package com.ankamagames.dofus.logic.game.fight.frames.Preview
{
    import damageCalculation.IMapInfo;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import damageCalculation.spellManagement.HaxeSpell;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
    import tools.enumeration.GameActionMarkTypeEnum;
    import damageCalculation.spellManagement.Mark;
    import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import haxe.ds.List;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import damageCalculation.fighterManagement.HaxeFighter;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import mapTools.MapTools;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.logic.game.fight.managers.LinkedCellsManager;
    import com.ankamagames.dofus.network.enums.TeamEnum;

    public class MapTranslator implements IMapInfo 
    {

        private var _context:FightContextFrame;

        public function MapTranslator(context:FightContextFrame)
        {
            this._context = context;
        }

        public static function createHaxeMark(mark:MarkInstance):Mark
        {
            var spell:HaxeSpell;
            var spellToGet:Spell;
            var effect:EffectInstanceDice;
            switch (mark.markType)
            {
                case GameActionMarkTypeEnum.WALL:
                    spell = DamagePreview.createHaxeSpell(Spell.getSpellById(mark.associatedSpell.id).getSpellLevel(mark.associatedSpellLevel.grade));
                    break;
                case GameActionMarkTypeEnum.PORTAL:
                    spell = DamagePreview.createHaxeSpell(mark.associatedSpellLevel);
                    break;
                default:
                    for each (effect in mark.associatedSpellLevel.effects)
                    {
                        spellToGet = Spell.getSpellById((effect.parameter0 as int));
                        if (spellToGet)
                        {
                            spell = DamagePreview.createHaxeSpell(spellToGet.getSpellLevel((effect.parameter1 as int)));
                            break;
                        };
                    };
            };
            if (spell == null)
            {
                return (null);
            };
            var haxeMark:Mark = new Mark();
            haxeMark.markId = mark.markId;
            haxeMark.setMarkType(mark.markType);
            haxeMark.setAssociatedSpell(spell);
            haxeMark.mainCell = mark.markImpactCellId;
            haxeMark.cells = vectorToArray(mark.cells);
            haxeMark.teamId = mark.teamId;
            haxeMark.active = mark.active;
            haxeMark.casterId = mark.markCasterId;
            return (haxeMark);
        }

        private static function vectorToArray(vector:Vector.<uint>):Array
        {
            var value:uint;
            var array:Array = [];
            for each (value in vector)
            {
                array.push(value);
            };
            return (array);
        }


        public function getEveryFighterId():Array
        {
            var entityId:Number;
            var fightEntities:Vector.<Number> = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getEntitiesIdsList();
            var fighters:Array = [];
            for each (entityId in fightEntities)
            {
                fighters.push(entityId);
            };
            return (fighters);
        }

        public function getFightersInitialPositions():List
        {
            var infos:GameContextActorInformations;
            var positions:List = new List();
            var fightEntities:Dictionary = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getEntitiesDictionnary();
            for each (infos in fightEntities)
            {
                positions.add({
                    "id":infos.contextualId,
                    "cell":infos.disposition.cellId
                });
            };
            return (positions);
        }

        public function getCarriedFighterIdBy(carrier:HaxeFighter):Number
        {
            var entity:AnimatedCharacter;
            var carriedEntity:AnimatedCharacter;
            var entities:Array = EntitiesManager.getInstance().getEntitiesOnCell(carrier.getCurrentPositionCell(), AnimatedCharacter);
            var i:int;
            while (i < entities.length)
            {
                entity = (entities[i] as AnimatedCharacter);
                if (entity.id == carrier.id)
                {
                    if (entity.carriedEntity != null)
                    {
                        carriedEntity = (entity.carriedEntity as AnimatedCharacter);
                        if (carriedEntity != null)
                        {
                            return (carriedEntity.id);
                        };
                    };
                    break;
                };
                i++;
            };
            return (HaxeFighter.INVALID_ID);
        }

        public function getFighterById(id:Number):HaxeFighter
        {
            var infos:GameFightFighterInformations = (this._context.entitiesFrame.getEntityInfos(id) as GameFightFighterInformations);
            if (infos != null)
            {
                return (new FighterTranslator(infos, id));
            };
            return (null);
        }

        public function isCellWalkable(cell:int):Boolean
        {
            if (!MapTools.isValidCellId(cell))
            {
                return (false);
            };
            return (DataMapProvider.getInstance().pointMov(MapTools.getCellIdXCoord(cell), MapTools.getCellIdYCoord(cell)));
        }

        public function getMarkInteractingWithCell(cell:int, markType:int=0):Array
        {
            var mark:MarkInstance;
            var marks:Vector.<MarkInstance> = MarkedCellsManager.getInstance().getMarks(markType, 2, true);
            if (marks == null)
            {
                return ([]);
            };
            var returnMarks:Array = [];
            for each (mark in marks)
            {
                if (mark.cells.indexOf(cell) == -1)
                {
                }
                else
                {
                    if (((markType == GameActionMarkTypeEnum.NONE) || (markType == mark.markType)))
                    {
                        returnMarks.push(createHaxeMark(mark));
                    };
                };
            };
            return (returnMarks);
        }

        public function getMarks(markType:int=0, teamId:int=2):Array
        {
            var mark:MarkInstance;
            var marks:Vector.<MarkInstance> = MarkedCellsManager.getInstance().getMarks(markType, teamId, true);
            if (marks == null)
            {
                return ([]);
            };
            var returnMarks:Array = [];
            for each (mark in marks)
            {
                if (((markType == GameActionMarkTypeEnum.NONE) || (markType == mark.markType)))
                {
                    returnMarks.push(createHaxeMark(mark));
                };
            };
            return (returnMarks);
        }

        public function getOutputPortalCell(cell:int):int
        {
            var entryMarkPortal:MarkInstance = MarkedCellsManager.getInstance().getMarkAtCellId(cell, GameActionMarkTypeEnum.PORTAL);
            if (entryMarkPortal == null)
            {
                return (MapTools.INVALID_CELL_ID);
            };
            var teamPortals:Vector.<MapPoint> = MarkedCellsManager.getInstance().getMarksMapPoint(GameActionMarkTypeEnum.PORTAL, entryMarkPortal.teamId);
            var portalsCellIds:Vector.<uint> = LinkedCellsManager.getInstance().getLinks(MapPoint.fromCellId(cell), teamPortals);
            var tmp:int = portalsCellIds.pop();
            return (tmp);
        }

        public function getLastKilledAlly(teamId:int):HaxeFighter
        {
            var infos:GameFightFighterInformations;
            var fightEntitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            if (((teamId == TeamEnum.TEAM_CHALLENGER) && (fightEntitiesFrame.lastKilledChallengers.length > 0)))
            {
                infos = fightEntitiesFrame.lastKilledChallengers[0];
            }
            else
            {
                if (((teamId == TeamEnum.TEAM_DEFENDER) && (fightEntitiesFrame.lastKilledDefenders.length > 0)))
                {
                    infos = fightEntitiesFrame.lastKilledDefenders[0];
                }
                else
                {
                    infos = null;
                };
            };
            if (!infos)
            {
                return (null);
            };
            return (new FighterTranslator(infos, infos.contextualId));
        }

        public function dispellIllusionOnCell(cell:int):void
        {
        }


    }
} com.ankamagames.dofus.logic.game.fight.frames.Preview

