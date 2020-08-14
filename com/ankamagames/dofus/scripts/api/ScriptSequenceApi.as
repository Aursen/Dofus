package com.ankamagames.dofus.scripts.api
{
    import com.ankamagames.jerakine.lua.LuaPackage;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.sequencer.SerialSequencer;
    import com.ankamagames.jerakine.types.events.SequencerEvent;
    import __AS3__.vec.*;

    public class ScriptSequenceApi implements LuaPackage 
    {

        private var _sequencers:Vector.<SerialSequencer> = new Vector.<SerialSequencer>(0);
        private var _callbacks:Vector.<Function> = new Vector.<Function>(0);


        public function hasSequences():Boolean
        {
            return (this._sequencers.length > 0);
        }

        public function create():SerialSequencer
        {
            var seq:SerialSequencer = new SerialSequencer("ScriptSequencer");
            this._sequencers.push(seq);
            seq.addEventListener(SequencerEvent.SEQUENCE_END, this.onSequenceEnd);
            return (seq);
        }

        public function addCompleteCallback(pCallBack:Function):void
        {
            this._callbacks.push(pCallBack);
        }

        public function clear():void
        {
            var seq:SerialSequencer;
            for each (seq in this._sequencers)
            {
                seq.clear();
            };
            this._sequencers.length = 0;
            this._callbacks.length = 0;
        }

        private function onSequenceEnd(pEvent:SequencerEvent):void
        {
            var c:Function;
            pEvent.currentTarget.removeEventListener(SequencerEvent.SEQUENCE_END, this.onSequenceEnd);
            this._sequencers.splice(this._sequencers.indexOf(pEvent.currentTarget), 1);
            if (this._sequencers.length == 0)
            {
                for each (c in this._callbacks)
                {
                    c.apply();
                };
                this._callbacks.length = 0;
            };
        }


    }
} com.ankamagames.dofus.scripts.api

