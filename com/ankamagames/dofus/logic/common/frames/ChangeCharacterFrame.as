package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.handlers.messages.Action;
    import com.ankamagames.dofus.logic.common.actions.DirectSelectionCharacterAction;
    import com.ankamagames.dofus.logic.common.actions.ChangeCharacterAction;
    import com.ankamagames.dofus.network.messages.game.approach.ReloginTokenStatusMessage;
    import com.ankamagames.dofus.network.messages.game.context.notification.NotificationListMessage;
    import com.ankamagames.dofus.network.messages.subscription.AccountInformationsUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.approach.ReloginTokenRequestMessage;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTicketAction;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTokenAction;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
    import com.ankamagames.dofus.kernel.zaap.ZaapApi;
    import com.ankamagames.dofus.kernel.sound.SoundManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.common.actions.ChangeServerAction;
    import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.jerakine.messages.Message;

    public class ChangeCharacterFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ChangeCharacterFrame));

        private var _currentAction:Action;
        private var _token:String = "";


        public function get priority():int
        {
            return (0);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var dsca:DirectSelectionCharacterAction;
            var cca:ChangeCharacterAction;
            var rtsmsg:ReloginTokenStatusMessage;
            var nlmsg:NotificationListMessage;
            var num:int;
            var aiumsg:AccountInformationsUpdateMessage;
            var rtrdsmsg:ReloginTokenRequestMessage;
            var lvadwtNew:LoginValidationWithTicketAction;
            var lvadwta:LoginValidationWithTokenAction;
            var lvad:LoginValidationAction;
            var lvadNew:LoginValidationAction;
            var rtrccmsg:ReloginTokenRequestMessage;
            var lvawtNew:LoginValidationWithTicketAction;
            var lvawsa:LoginValidationWithTokenAction;
            var lva:LoginValidationAction;
            var lvaNew:LoginValidationAction;
            var rtrcsmsg:ReloginTokenRequestMessage;
            var lvaswtNew:LoginValidationWithTicketAction;
            var lvawta:LoginValidationWithTokenAction;
            var lvacha:LoginValidationAction;
            var lvachaNew:LoginValidationAction;
            var c:int;
            var val:int;
            var bit:int;
            var forceNoRetry:Boolean;
            switch (true)
            {
                case (msg is DirectSelectionCharacterAction):
                    dsca = (msg as DirectSelectionCharacterAction);
                    if (!this._currentAction)
                    {
                        this._currentAction = dsca;
                        rtrdsmsg = new ReloginTokenRequestMessage();
                        rtrdsmsg.initReloginTokenRequestMessage();
                        ConnectionsHandler.getConnection().send(rtrdsmsg);
                    }
                    else
                    {
                        this._currentAction = null;
                        PlayerManager.getInstance().allowAutoConnectCharacter = true;
                        PlayerManager.getInstance().autoConnectOfASpecificCharacterId = dsca.characterId;
                        if (this._token != "")
                        {
                            lvadwtNew = LoginValidationWithTicketAction.create(AuthentificationManager.getInstance().username, this._token, true, dsca.serverId);
                            AuthentificationManager.getInstance().setValidationAction(lvadwtNew);
                        }
                        else
                        {
                            if (ZaapApi.canLoginWithZaap())
                            {
                                if (((ZaapApi.canLoginWithZaap()) && (!(ZaapApi.isUsingZaap()))))
                                {
                                    forceNoRetry = true;
                                }
                                else
                                {
                                    lvadwta = LoginValidationWithTokenAction.create(true, dsca.serverId);
                                    lvadwta.username = AuthentificationManager.getInstance().username;
                                    AuthentificationManager.getInstance().setValidationAction(lvadwta);
                                };
                            }
                            else
                            {
                                lvad = AuthentificationManager.getInstance().loginValidationAction;
                                lvadNew = LoginValidationAction.create(lvad.username, lvad.password, true, dsca.serverId);
                                AuthentificationManager.getInstance().setValidationAction(lvadNew);
                            };
                        };
                        SoundManager.getInstance().manager.removeAllSounds();
                        ConnectionsHandler.closeConnection();
                        Kernel.getWorker().resume();
                        Kernel.getInstance().reset(null, ((forceNoRetry) ? false : ((AuthentificationManager.getInstance().canAutoConnectWithToken) || (!(AuthentificationManager.getInstance().tokenMode)))));
                    };
                    return (true);
                case (msg is ChangeCharacterAction):
                    cca = (msg as ChangeCharacterAction);
                    if (!this._currentAction)
                    {
                        this._currentAction = cca;
                        rtrccmsg = new ReloginTokenRequestMessage();
                        rtrccmsg.initReloginTokenRequestMessage();
                        ConnectionsHandler.getConnection().send(rtrccmsg);
                    }
                    else
                    {
                        this._currentAction = null;
                        PlayerManager.getInstance().allowAutoConnectCharacter = false;
                        PlayerManager.getInstance().autoConnectOfASpecificCharacterId = -1;
                        if (this._token != "")
                        {
                            lvawtNew = LoginValidationWithTicketAction.create(AuthentificationManager.getInstance().username, this._token, true, cca.serverId);
                            AuthentificationManager.getInstance().setValidationAction(lvawtNew);
                        }
                        else
                        {
                            if (ZaapApi.canLoginWithZaap())
                            {
                                if (((ZaapApi.canLoginWithZaap()) && (!(ZaapApi.isUsingZaap()))))
                                {
                                    forceNoRetry = true;
                                }
                                else
                                {
                                    lvawsa = LoginValidationWithTokenAction.create(true, cca.serverId);
                                    AuthentificationManager.getInstance().setValidationAction(lvawsa);
                                };
                            }
                            else
                            {
                                lva = AuthentificationManager.getInstance().loginValidationAction;
                                lvaNew = LoginValidationAction.create(lva.username, lva.password, true, cca.serverId);
                                AuthentificationManager.getInstance().setValidationAction(lvaNew);
                            };
                        };
                        SoundManager.getInstance().manager.removeAllSounds();
                        ConnectionsHandler.closeConnection();
                        Kernel.getWorker().resume();
                        Kernel.getInstance().reset(null, ((forceNoRetry) ? false : ((AuthentificationManager.getInstance().canAutoConnectWithToken) || (!(AuthentificationManager.getInstance().tokenMode)))));
                    };
                    return (true);
                case (msg is ChangeServerAction):
                    if (!this._currentAction)
                    {
                        this._currentAction = (msg as ChangeServerAction);
                        rtrcsmsg = new ReloginTokenRequestMessage();
                        rtrcsmsg.initReloginTokenRequestMessage();
                        ConnectionsHandler.getConnection().send(rtrcsmsg);
                    }
                    else
                    {
                        this._currentAction = null;
                        if (this._token != "")
                        {
                            lvaswtNew = LoginValidationWithTicketAction.create(AuthentificationManager.getInstance().username, this._token, false);
                            AuthentificationManager.getInstance().setValidationAction(lvaswtNew);
                        }
                        else
                        {
                            if (ZaapApi.canLoginWithZaap())
                            {
                                if (((ZaapApi.canLoginWithZaap()) && (!(ZaapApi.isUsingZaap()))))
                                {
                                    forceNoRetry = true;
                                }
                                else
                                {
                                    lvawta = LoginValidationWithTokenAction.create();
                                    AuthentificationManager.getInstance().setValidationAction(lvawta);
                                };
                            }
                            else
                            {
                                lvacha = AuthentificationManager.getInstance().loginValidationAction;
                                lvachaNew = LoginValidationAction.create(lvacha.username, lvacha.password, false);
                                AuthentificationManager.getInstance().setValidationAction(lvachaNew);
                            };
                        };
                        ConnectionsHandler.closeConnection();
                        Kernel.getInstance().reset(null, ((forceNoRetry) ? false : ((AuthentificationManager.getInstance().canAutoConnectWithToken) || (!(AuthentificationManager.getInstance().tokenMode)))));
                    };
                    return (true);
                case (msg is ReloginTokenStatusMessage):
                    rtsmsg = ReloginTokenStatusMessage(msg);
                    if (rtsmsg.validToken)
                    {
                        this._token = AuthentificationManager.getInstance().decodeWithAES(rtsmsg.ticket).toString();
                        AuthentificationManager.getInstance().tokenMode = true;
                        AuthentificationManager.getInstance().nextToken = this._token;
                    }
                    else
                    {
                        this._token = "";
                        AuthentificationManager.getInstance().tokenMode = false;
                        AuthentificationManager.getInstance().nextToken = null;
                    };
                    this.process(this._currentAction);
                    return (true);
                case (msg is NotificationListMessage):
                    nlmsg = (msg as NotificationListMessage);
                    QuestFrame.notificationList = new Array();
                    num = nlmsg.flags.length;
                    c = 0;
                    while (c < num)
                    {
                        val = nlmsg.flags[c];
                        bit = 0;
                        while (bit < 32)
                        {
                            QuestFrame.notificationList[(bit + (c * 32))] = Boolean((val & 0x01));
                            val = (val >> 1);
                            bit++;
                        };
                        c++;
                    };
                    return (true);
                case (msg is AccountInformationsUpdateMessage):
                    aiumsg = (msg as AccountInformationsUpdateMessage);
                    PlayerManager.getInstance().subscriptionEndDate = aiumsg.subscriptionEndDate;
                    PlayerManager.getInstance().refreshSubscriptionEndDateUpdateTime();
                    KernelEventsManager.getInstance().processCallback(HookList.SubscriptionEndDateUpdate);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }


    }
} com.ankamagames.dofus.logic.common.frames

