package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterBoosts;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.game.modificator.AreaFightModificatorUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameRefreshMonsterBoostsMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.AnomalySubareaInformationRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.AnomalySubareaInformationResponseMessage;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.QuestHookList;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.datacenter.spells.SpellPair;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.game.common.actions.roleplay.AnomalySubareaInformationRequestAction;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.datacenter.monsters.Monster;

    public class WorldFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(WorldFrame));

        private var _settings:Array = null;
        private var _currentFightModificator:int = -1;
        private var _monsterBoosts:Vector.<MonsterBoosts>;
        private var _raceBoosts:Vector.<MonsterBoosts>;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get settings():Array
        {
            return (this._settings);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var afmumsg:AreaFightModificatorUpdateMessage;
            var grmbmsg:GameRefreshMonsterBoostsMessage;
            var sireqmsg:AnomalySubareaInformationRequestMessage;
            var sirmsg:AnomalySubareaInformationResponseMessage;
            var updateModificatorText:String;
            switch (true)
            {
                case (msg is AreaFightModificatorUpdateMessage):
                    afmumsg = (msg as AreaFightModificatorUpdateMessage);
                    if (this._currentFightModificator != afmumsg.spellPairId)
                    {
                        KernelEventsManager.getInstance().processCallback(QuestHookList.AreaFightModificatorUpdate, afmumsg.spellPairId);
                        if (afmumsg.spellPairId > -1)
                        {
                            if (this._currentFightModificator > -1)
                            {
                                updateModificatorText = I18n.getUiText("ui.spell.newFightModficator", [SpellPair.getSpellPairById(afmumsg.spellPairId).name]);
                            }
                            else
                            {
                                updateModificatorText = I18n.getUiText("ui.spell.currentFightModficator", [SpellPair.getSpellPairById(afmumsg.spellPairId).name]);
                            };
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, updateModificatorText, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                        };
                        this._currentFightModificator = afmumsg.spellPairId;
                    };
                    return (true);
                case (msg is GameRefreshMonsterBoostsMessage):
                    grmbmsg = (msg as GameRefreshMonsterBoostsMessage);
                    this._monsterBoosts = grmbmsg.monsterBoosts;
                    this._raceBoosts = grmbmsg.familyBoosts;
                    return (true);
                case (msg is AnomalySubareaInformationRequestAction):
                    sireqmsg = new AnomalySubareaInformationRequestMessage();
                    sireqmsg.initAnomalySubareaInformationRequestMessage();
                    ConnectionsHandler.getConnection().send(sireqmsg);
                    return (true);
                case (msg is AnomalySubareaInformationResponseMessage):
                    sirmsg = (msg as AnomalySubareaInformationResponseMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.SubareaList, sirmsg.subareas);
                    return (true);
            };
            return (false);
        }

        public function getMonsterXpBoostMultiplier(pMonsterId:int):Number
        {
            var boost:MonsterBoosts = this.getMonsterBoost(pMonsterId);
            return (((boost) ? (boost.xpBoost / 100) : 1) * this.getRaceXpBoostMultiplier(Monster.getMonsterById(pMonsterId).race));
        }

        public function getMonsterDropBoostMultiplier(pMonsterId:int):Number
        {
            var boost:MonsterBoosts = this.getMonsterBoost(pMonsterId);
            return (((boost) ? (boost.dropBoost / 100) : 1) * this.getRaceDropBoostMultiplier(Monster.getMonsterById(pMonsterId).race));
        }

        public function getRaceXpBoostMultiplier(pRaceId:int):Number
        {
            var boost:MonsterBoosts = this.getRaceBoost(pRaceId);
            return ((boost) ? (boost.xpBoost / 100) : 1);
        }

        public function getRaceDropBoostMultiplier(pRaceId:int):Number
        {
            var boost:MonsterBoosts = this.getRaceBoost(pRaceId);
            return ((boost) ? (boost.dropBoost / 100) : 1);
        }

        private function getMonsterBoost(pId:uint):MonsterBoosts
        {
            var boost:MonsterBoosts;
            for each (boost in this._monsterBoosts)
            {
                if (boost.id == pId)
                {
                    return (boost);
                };
            };
            return (null);
        }

        private function getRaceBoost(pRaceId:int):MonsterBoosts
        {
            var boost:MonsterBoosts;
            for each (boost in this._raceBoosts)
            {
                if (boost.id == pRaceId)
                {
                    return (boost);
                };
            };
            return (null);
        }


    }
} com.ankamagames.dofus.logic.game.common.frames

