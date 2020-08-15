package com.ankamagames.dofus.scripts.api
{
    import com.ankamagames.jerakine.sequencer.SerialSequencer;
    import com.ankamagames.jerakine.sequencer.ISequencer;
    import com.ankamagames.jerakine.sequencer.ParallelStartSequenceStep;
    import com.ankamagames.jerakine.sequencer.ISequencable;
    import com.ankamagames.jerakine.sequencer.StartSequenceStep;
    import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
    import flash.display.DisplayObject;
    import com.ankamagames.dofus.scripts.FxRunner;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
    import com.ankamagames.dofus.scripts.SpellFxRunner;
    import com.ankamagames.tiphon.sequence.PlayAnimationStep;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.tiphon.sequence.SetDirectionStep;
    import com.ankamagames.tiphon.types.CarriedSprite;
    import com.ankamagames.atouin.types.sequences.ParableGfxMovementStep;
    import com.ankamagames.jerakine.entities.interfaces.IMovable;
    import com.ankamagames.dofus.types.sequences.AddGfxInLineStep;
    import com.ankamagames.atouin.types.sequences.AddWorldEntityStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightDestroyEntityStep;
    import com.ankamagames.atouin.types.sequences.DestroyEntityStep;
    import com.ankamagames.jerakine.sequencer.DebugStep;

    public class SequenceApi 
    {


        public static function CreateSerialSequencer():ISequencer
        {
            return (new SerialSequencer());
        }

        public static function CreateParallelStartSequenceStep(aSequence:Array, waitAllSequenceEnd:Boolean=true, waitFirstEndSequence:Boolean=false):ISequencable
        {
            return (new ParallelStartSequenceStep(aSequence, waitAllSequenceEnd, waitFirstEndSequence));
        }

        public static function CreateStartSequenceStep(sequence:ISequencer):ISequencable
        {
            return (new StartSequenceStep(sequence));
        }

        public static function CreateAddGfxEntityStep(runner:FxRunner, gfxId:uint, cell:MapPoint, angle:Number=0, yOffset:int=0, mode:uint=0, startCell:MapPoint=null, endCell:MapPoint=null, popUnderPlayer:Boolean=false, startEntity:IEntity=null):ISequencable
        {
            return (new AddGfxEntityStep(gfxId, cell.cellId, angle, ((-(DisplayObject(runner.caster).height) * yOffset) / 10), mode, startCell, endCell, popUnderPlayer, null, startEntity));
        }

        public static function CreateAddGlyphGfxStep(runner:SpellFxRunner, gfxId:uint, cell:MapPoint, markId:int):ISequencable
        {
            return (new AddGlyphGfxStep(gfxId, cell.cellId, markId, runner.castingSpell.markType));
        }

        public static function CreatePlayAnimationStep(target:TiphonSprite, animationName:String, backToLastAnimationAtEnd:Boolean, waitForEvent:Boolean, eventEnd:String="animation_event_end", loop:int=1):ISequencable
        {
            return (new PlayAnimationStep(target, animationName, backToLastAnimationAtEnd, waitForEvent, eventEnd, loop));
        }

        public static function CreateSetDirectionStep(target:TiphonSprite, nDirection:uint):ISequencable
        {
            return (new SetDirectionStep(target, nDirection));
        }

        public static function CreateParableGfxMovementStep(runner:FxRunner, gfxEntity:IMovable, targetPoint:MapPoint, speed:Number=100, curvePrc:Number=0.5, yOffset:int=0, waitEnd:Boolean=true):ParableGfxMovementStep
        {
            var subEntityOffset:int;
            var p:DisplayObject = TiphonSprite(runner.caster).parent;
            while (p)
            {
                if ((p is CarriedSprite))
                {
                    subEntityOffset = (subEntityOffset + p.y);
                };
                p = p.parent;
            };
            return (new ParableGfxMovementStep(gfxEntity, targetPoint, speed, curvePrc, (((-(DisplayObject(runner.caster).height) * yOffset) / 10) + subEntityOffset), waitEnd));
        }

        public static function CreateAddGfxInLineStep(runner:SpellFxRunner, gfxId:uint, startCell:MapPoint, endCell:MapPoint, yOffset:Number=0, mode:uint=0, minScale:Number=0, maxScale:Number=0, addOnStartCell:Boolean=false, addOnEndCell:Boolean=false, showUnder:Boolean=false, useSpellZone:Boolean=false, useOnlySpellZone:Boolean=false, startEntity:IEntity=null):AddGfxInLineStep
        {
            return (new AddGfxInLineStep(gfxId, runner.castingSpell, startCell, endCell, ((-(DisplayObject(runner.caster).height) * yOffset) / 10), mode, minScale, maxScale, addOnStartCell, addOnEndCell, useSpellZone, useOnlySpellZone, showUnder, startEntity));
        }

        public static function CreateAddWorldEntityStep(entity:IEntity, strata:int=200):AddWorldEntityStep
        {
            return (new AddWorldEntityStep(entity, strata));
        }

        public static function CreateDestroyEntityStep(entity:IEntity):DestroyEntityStep
        {
            return (new FightDestroyEntityStep(entity));
        }

        public static function CreateDebugStep(text:String):DebugStep
        {
            return (new DebugStep(text));
        }


    }
}

