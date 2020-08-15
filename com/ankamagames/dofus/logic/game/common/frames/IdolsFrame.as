package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.messages.game.idol.IdolPartyRegisterRequestMessage;
    import com.ankamagames.dofus.datacenter.idols.Idol;
    import com.ankamagames.dofus.internalDatacenter.items.IdolsPresetWrapper;
    import com.ankamagames.dofus.logic.game.common.actions.IdolSelectRequestAction;
    import com.ankamagames.dofus.network.messages.game.idol.IdolSelectRequestMessage;
    import com.ankamagames.dofus.network.messages.game.idol.IdolListMessage;
    import com.ankamagames.dofus.network.messages.game.idol.IdolSelectErrorMessage;
    import com.ankamagames.dofus.network.messages.game.idol.IdolSelectedMessage;
    import com.ankamagames.dofus.network.messages.game.idol.IdolPartyRefreshMessage;
    import com.ankamagames.dofus.network.messages.game.idol.IdolPartyLostMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectAddedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectDeletedMessage;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.game.common.actions.OpenIdolsAction;
    import com.ankamagames.dofus.logic.game.common.actions.CloseIdolsAction;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.types.enums.Priority;

    public class IdolsFrame implements Frame 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(IdolsFrame));
        private static const TYPE_IDOLS_PRESET_WRAPPER:int = 5;

        private var _openIdols:Boolean;
        private var _shortcutReplaced:Boolean;


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
            var iprrmsg:IdolPartyRegisterRequestMessage;
            var idol:Idol;
            var idolIndex:int;
            var preset:IdolsPresetWrapper;
            var isra:IdolSelectRequestAction;
            var isrmsg:IdolSelectRequestMessage;
            var ilmsg:IdolListMessage;
            var i:int;
            var numSoloIdols:uint;
            var numPartyIdols:uint;
            var uiParams:Object;
            var isemsg:IdolSelectErrorMessage;
            var iselmsg:IdolSelectedMessage;
            var iprmsg:IdolPartyRefreshMessage;
            var iplmsg:IdolPartyLostMessage;
            var oamsg:ObjectAddedMessage;
            var odmsg:ObjectDeletedMessage;
            var itemW:ItemWrapper;
            var inventoryMgr:InventoryManager = InventoryManager.getInstance();
            switch (true)
            {
                case (msg is OpenIdolsAction):
                    this._openIdols = true;
                    iprrmsg = new IdolPartyRegisterRequestMessage();
                    iprrmsg.initIdolPartyRegisterRequestMessage(true);
                    ConnectionsHandler.getConnection().send(iprrmsg);
                    return (true);
                case (msg is CloseIdolsAction):
                    iprrmsg = new IdolPartyRegisterRequestMessage();
                    iprrmsg.initIdolPartyRegisterRequestMessage(false);
                    ConnectionsHandler.getConnection().send(iprrmsg);
                    return (true);
                case (msg is IdolSelectRequestAction):
                    isra = (msg as IdolSelectRequestAction);
                    isrmsg = new IdolSelectRequestMessage();
                    isrmsg.initIdolSelectRequestMessage(isra.idolId, isra.activate, isra.party);
                    ConnectionsHandler.getConnection().send(isrmsg);
                    return (true);
                case (msg is IdolListMessage):
                    ilmsg = (msg as IdolListMessage);
                    PlayedCharacterManager.getInstance().soloIdols.length = 0;
                    numSoloIdols = ilmsg.chosenIdols.length;
                    i = 0;
                    while (i < numSoloIdols)
                    {
                        PlayedCharacterManager.getInstance().soloIdols.push(ilmsg.chosenIdols[i]);
                        i++;
                    };
                    PlayedCharacterManager.getInstance().partyIdols.length = 0;
                    numPartyIdols = ilmsg.partyChosenIdols.length;
                    i = 0;
                    while (i < numPartyIdols)
                    {
                        PlayedCharacterManager.getInstance().partyIdols.push(ilmsg.partyChosenIdols[i]);
                        i++;
                    };
                    uiParams = new Object();
                    uiParams.chosenIdols = ilmsg.chosenIdols;
                    uiParams.partyChosenIdols = ilmsg.partyChosenIdols;
                    uiParams.partyIdols = ilmsg.partyIdols;
                    uiParams.presets = PlayedCharacterManager.getInstance().idolsPresets;
                    if (((this._openIdols) && (!(Berilia.getInstance().getUi("idolsTab")))))
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.OpenBook, "idolsTab", uiParams);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.IdolsList, uiParams.chosenIdols, uiParams.partyChosenIdols, uiParams.partyIdols);
                    };
                    this._openIdols = false;
                    return (true);
                case (msg is IdolSelectErrorMessage):
                    isemsg = (msg as IdolSelectErrorMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.IdolSelectError, isemsg.reason, isemsg.idolId, isemsg.activate, isemsg.party);
                    return (true);
                case (msg is IdolSelectedMessage):
                    iselmsg = (msg as IdolSelectedMessage);
                    if (!iselmsg.party)
                    {
                        if (!iselmsg.activate)
                        {
                            idolIndex = PlayedCharacterManager.getInstance().soloIdols.indexOf(iselmsg.idolId);
                            if (idolIndex != -1)
                            {
                                PlayedCharacterManager.getInstance().soloIdols.splice(idolIndex, 1);
                            };
                        }
                        else
                        {
                            PlayedCharacterManager.getInstance().soloIdols.push(iselmsg.idolId);
                        };
                    }
                    else
                    {
                        if (!iselmsg.activate)
                        {
                            idolIndex = PlayedCharacterManager.getInstance().partyIdols.indexOf(iselmsg.idolId);
                            if (idolIndex != -1)
                            {
                                PlayedCharacterManager.getInstance().partyIdols.splice(idolIndex, 1);
                            };
                        }
                        else
                        {
                            PlayedCharacterManager.getInstance().partyIdols.push(iselmsg.idolId);
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.IdolSelected, iselmsg.idolId, iselmsg.activate, iselmsg.party);
                    return (true);
                case (msg is IdolPartyRefreshMessage):
                    iprmsg = (msg as IdolPartyRefreshMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.IdolPartyRefresh, iprmsg.partyIdol);
                    return (true);
                case (msg is IdolPartyLostMessage):
                    iplmsg = (msg as IdolPartyLostMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.IdolPartyLost, iplmsg.idolId);
                    return (true);
                case (msg is ObjectAddedMessage):
                    oamsg = (msg as ObjectAddedMessage);
                    idol = Idol.getIdolByItemId(oamsg.object.objectGID);
                    if (idol)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.IdolAdded, idol.id);
                    };
                    return (false);
                case (msg is ObjectDeletedMessage):
                    odmsg = (msg as ObjectDeletedMessage);
                    itemW = InventoryManager.getInstance().inventory.getItem(odmsg.objectUID);
                    if (itemW)
                    {
                        idol = Idol.getIdolByItemId(itemW.objectGID);
                    };
                    if (idol)
                    {
                        idolIndex = PlayedCharacterManager.getInstance().soloIdols.indexOf(idol.id);
                        if (idolIndex != -1)
                        {
                            PlayedCharacterManager.getInstance().soloIdols.splice(idolIndex, 1);
                        };
                        KernelEventsManager.getInstance().processCallback(HookList.IdolRemoved, idol.id);
                    };
                    return (false);
            };
            return (false);
        }

        public function get priority():int
        {
            return (Priority.HIGH);
        }


    }
}

