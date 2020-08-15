package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.ISequencable;
    import __AS3__.vec.Vector;

    public interface IFightStep extends ISequencable 
    {

        function get stepType():String;
        function get castingSpellId():int;
        function set castingSpellId(_arg_1:int):void;
        function get targets():Vector.<Number>;

    }
}

