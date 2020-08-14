package com.ankamagames.dofus.logic.game.spin2.chat
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.spin2.chat.data.AvailableGameInfo;
    import com.ankamagames.dofus.logic.game.spin2.chat.data.GameActivities;
    import flash.net.URLLoader;
    import flash.utils.Dictionary;
    import chat.protocol.user.data.EndpointProperties;
    import chat.protocol.friendinvite.data.FriendInviteList;
    import chat.protocol.user.data.FriendList;
    import chat.protocol.user.data.FriendGroupList;
    import chat.protocol.user.data.UserList;
    import com.ankamagames.jerakine.data.XmlConfig;
    import flash.events.Event;
    import flash.events.SecurityErrorEvent;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import com.ankamagames.jerakine.utils.misc.JsonUtil;
    import com.ankamagames.jerakine.logger.LogLevel;
    import com.ankamagames.dofus.misc.utils.GameID;
    import flash.events.ErrorEvent;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
    import com.ankamagames.dofus.misc.utils.events.TokenReadyEvent;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ChatServiceHookList;
    import chat.protocol.transport.Payload;
    import chat.protocol.common.PayloadType;
    import chat.protocol.user.commands.ListUserFriendInvitesCmd;
    import chat.protocol.user.commands.ListUserFriendGroupsCmd;
    import chat.protocol.user.data.UserPresence;
    import chat.protocol.common.CorrelatedRequest;
    import chat.protocol.transport.Frame;
    import chat.protocol.user.events.UserPresenceUpdatedEvt;
    import chat.protocol.user.events.UserStatusUpdatedEvt;
    import chat.protocol.user.events.UserEndpointPropertiesUpdatedEvt;
    import chat.protocol.channel.events.ChannelMessageCreatedEvt;
    import chat.protocol.friendinvite.events.FriendInviteDeletedEvt;
    import chat.protocol.friendinvite.events.FriendInviteCreatedEvt;
    import chat.protocol.user.events.UserFriendCreatedEvt;
    import chat.protocol.user.events.UserFriendDeletedEvt;
    import chat.protocol.user.events.UserFriendGroupCreatedEvt;
    import chat.protocol.user.events.UserFriendGroupDeletedEvt;
    import chat.protocol.user.events.UserFriendUpdatedEvt;
    import chat.protocol.user.events.UserBlockedUserCreatedEvt;
    import chat.protocol.user.events.UserBlockedUserDeletedEvt;
    import chat.protocol.common.ResponseStatus;
    import chat.protocol.channel.data.ChannelMessageList;
    import chat.protocol.user.data.Friend;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import chat.protocol.channel.data.ChannelMessage;
    import com.ankamagames.dofus.logic.common.managers.NotificationManager;
    import chat.protocol.user.data.FriendGroup;
    import chat.protocol.user.commands.ListUserFriendsCmd;
    import chat.protocol.channel.commands.CreateChannelMessageCmd;
    import chat.protocol.user.commands.UpdateUserStatusCmd;
    import chat.protocol.user.commands.UpdateUserEndpointPropertiesCmd;
    import chat.protocol.friendinvite.data.FriendInvite;
    import chat.protocol.friendinvite.commands.DeleteFriendInviteCmd;
    import chat.protocol.friendinvite.commands.CreateFriendInviteCmd;
    import chat.protocol.user.commands.DeleteUserFriendCmd;
    import chat.protocol.user.commands.UpdateUserFriendCmd;
    import chat.protocol.user.commands.CreateUserFriendGroupCmd;
    import chat.protocol.user.commands.DeleteUserFriendGroupCmd;
    import chat.protocol.user.commands.ListUserBlockedUsersCmd;
    import chat.protocol.user.commands.CreateUserBlockedUserCmd;
    import chat.protocol.user.commands.DeleteUserBlockedUserCmd;
    import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
    import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
    import chat.protocol.friendinvite.data.DeleteFriendInviteReason;
    import __AS3__.vec.*;

    public class ChatService extends Spin2ServiceConnection 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        private var _userActivitiesFileExt:String;
        private var _userActivitiesIndexFileUrl:String;
        private var _availableGame:Vector.<AvailableGameInfo>;
        private var _currentLang:String;
        private var _gamesActivities:Vector.<GameActivities>;
        private var _loader:URLLoader;
        protected var userActivitiesMap:Dictionary;
        public var myPresence:String;
        public var myStatus:String;
        public var myActivities:Vector.<EndpointProperties>;
        public var pendingFriendInvitesList:FriendInviteList;
        public var friendList:FriendList;
        public var friendGroupList:FriendGroupList;
        public var friendMap:Dictionary;
        public var blockedUserList:UserList;
        private var friendsInfos:Dictionary = new Dictionary(true);

        public function ChatService()
        {
            super(XmlConfig.getInstance().getEntry("config.spin2.chat.host"), XmlConfig.getInstance().getEntry("config.spin2.chat.port"));
            this._userActivitiesFileExt = XmlConfig.getInstance().getEntry("config.spin2.chat.userActivities.fileExtension");
            this._userActivitiesIndexFileUrl = XmlConfig.getInstance().getEntry("config.spin2.chat.userActivities.availableGamesUrl");
            this._currentLang = XmlConfig.getInstance().getEntry("config.lang.current");
            this._loader = new URLLoader();
            this._loader.addEventListener(Event.COMPLETE, this.onIndexFileRequestComplete);
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onIndexFileError);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onIndexFileError);
            if (this._userActivitiesIndexFileUrl)
            {
                this._loader.load(new URLRequest(this._userActivitiesIndexFileUrl));
            };
        }

        private function onIndexFileRequestComplete(e:Event):void
        {
            var conf:Object;
            var game:AvailableGameInfo;
            var value:Object;
            var loaderComplete:URLLoader = URLLoader(e.currentTarget);
            try
            {
                conf = JsonUtil.fromJson(loaderComplete.data);
                if (conf)
                {
                    this._availableGame = new Vector.<AvailableGameInfo>();
                    for each (value in conf.games)
                    {
                        this._availableGame.push(new AvailableGameInfo(value.name, value.id, value.languages, value.fallback, value.basePath));
                    };
                };
            }
            catch(e:Error)
            {
                log(LogLevel.ERROR, "Can't decode string, JSON required !!");
            };
            for each (game in this._availableGame)
            {
                if (game.basePath != "")
                {
                    this.loadActivities(game, ((game.hasLang(this._currentLang)) ? this._currentLang : game.fallback));
                };
            };
        }

        public function getGameActivities():Vector.<GameActivities>
        {
            return (this._gamesActivities);
        }

        public function getGameActivitiesByGame(gameId:int):Dictionary
        {
            var i:int;
            if (this._gamesActivities != null)
            {
                i = 0;
                while (i < this._gamesActivities.length)
                {
                    if (((!(this._gamesActivities[i] == null)) && (this._gamesActivities[i].getGameId() == gameId)))
                    {
                        return (this._gamesActivities[i].getGameActivities());
                    };
                    i++;
                };
            };
            return (null);
        }

        public function getMyGameActivity(key:String):String
        {
            var gameActivity:GameActivities;
            if (this._gamesActivities != null)
            {
                for each (gameActivity in this._gamesActivities)
                {
                    if (((!(gameActivity == null)) && (gameActivity.getGameId() == GameID.current)))
                    {
                        return (gameActivity.getGameActivities()[key]);
                    };
                };
            };
            return (null);
        }

        public function get CurrentGameName():String
        {
            return (GameID.getName(GameID.current));
        }

        private function loadActivities(game:AvailableGameInfo, lang:String):void
        {
            var loader:URLLoader;
            this._gamesActivities = new Vector.<GameActivities>();
            loader = new URLLoader();
            var url:URLRequest = new URLRequest(((game.basePath + lang) + this._userActivitiesFileExt));
            loader.addEventListener(Event.COMPLETE, function onActivitiesLoaded (e:Event):void
            {
                var activities:Object;
                var map:Dictionary;
                var key:String;
                try
                {
                    activities = JsonUtil.fromJson(loader.data);
                    if (activities)
                    {
                        map = new Dictionary();
                        for (key in activities)
                        {
                            map[key] = activities[key];
                        };
                        _gamesActivities.push(new GameActivities(game.id, map));
                    };
                }
                catch(e:Error)
                {
                    log(LogLevel.ERROR, "Can't decode activities, JSON required !!");
                };
            });
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
            loader.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            loader.load(url);
        }

        private function onError(pEvt:Event):void
        {
            var errorText:* = (("Error caught while loading activities (type : " + pEvt.type) + ") ");
            if ((pEvt is ErrorEvent))
            {
                errorText = (errorText + (((", " + ErrorEvent(pEvt).text) + " ") + pEvt.target.data));
            };
            log(LogLevel.ERROR, errorText);
        }

        private function onIndexFileError(pEvt:Event):void
        {
            var errorText:* = (("We caught an Error (type : " + pEvt.type) + ") ");
            if ((pEvt is ErrorEvent))
            {
                errorText = (errorText + (((", " + ErrorEvent(pEvt).text) + " ") + pEvt.target.data));
            };
            log(LogLevel.ERROR, errorText);
        }

        override public function connect():void
        {
            connectSocket();
        }

        override public function disconnect():void
        {
            super.disconnect();
        }

        override protected function requestAuthDetails():void
        {
            var accountId:uint = PlayerManager.getInstance().accountId;
            if (((_currentHaapiToken == "") || (!(ChatServiceManager.getInstance().isServiceInitializedWithAccount(accountId)))))
            {
                HaapiKeyManager.getInstance().addEventListener(TokenReadyEvent.READY, this.onTokenReady);
                HaapiKeyManager.getInstance().askToken(GameID.CHAT);
            }
            else
            {
                authenticate(_currentHaapiToken);
            };
        }

        private function onTokenReady(event:TokenReadyEvent):void
        {
            if (event.gameId == GameID.CHAT)
            {
                HaapiKeyManager.getInstance().removeEventListener(TokenReadyEvent.READY, this.onTokenReady);
                _currentHaapiToken = HaapiKeyManager.getInstance().pullToken(GameID.CHAT);
                authenticate(_currentHaapiToken);
            };
        }

        override protected function onAuthenticated():void
        {
            super.onAuthenticated();
            accountId = PlayerManager.getInstance().accountId.toString();
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceUserConnected);
            log(LogLevel.INFO, ("On Authenticated to Chat Service !" + accountId));
            sendChatServiceCmd(new Payload(PayloadType.USER_CMD_ListUserFriendInvites, new ListUserFriendInvitesCmd(accountId)));
            sendChatServiceCmd(new Payload(PayloadType.USER_CMD_ListUserFriendGroups, new ListUserFriendGroupsCmd(accountId)));
            this.updatePlayerDofusActivity();
            this.listBlockedUsers();
        }

        override protected function onDisconnected():void
        {
            this.myPresence = UserPresence.OFFLINE;
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceUserUpdatedPresence, accountId, this.myPresence);
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceUserDisconnected);
        }

        override protected function onMessage(msg:Frame):void
        {
            var found:Boolean;
            var correlatedRequest:CorrelatedRequest;
            var requestedFrame:Frame;
            var success:Boolean;
            var payloadType:int;
            super.onMessage(msg);
            var isEvent:* = (!(msg.event == null));
            var isResponse:* = (!(msg.response == null));
            if (isEvent)
            {
                if (msg.event.data == null)
                {
                    log(LogLevel.ERROR, (("Received event " + PayloadType.getPayloadType(msg.event.id)) + " data is null..."));
                    return;
                };
                switch (msg.event.id)
                {
                    case PayloadType.USER_EVT_UserPresenceUpdated:
                        this.dispatchUserPresence((msg.event.data as UserPresenceUpdatedEvt));
                        break;
                    case PayloadType.USER_EVT_UserStatusUpdated:
                        this.dispatchUserStatus((msg.event.data as UserStatusUpdatedEvt));
                        break;
                    case PayloadType.USER_EVT_UserEndpointPropertiesUpdatedEvt:
                        this.dispatchUserActivities((msg.event.data as UserEndpointPropertiesUpdatedEvt));
                        break;
                    case PayloadType.CHANNEL_EVT_ChannelMessageCreatedEvt:
                        this.dispatchChannelMessageCreated((msg.event.data as ChannelMessageCreatedEvt).message);
                        break;
                    case PayloadType.FRIEND_INVITE_EVT_FriendInviteDeleted:
                        this.dispatchFriendInviteDeleted((msg.event.data as FriendInviteDeletedEvt));
                        break;
                    case PayloadType.FRIEND_INVITE_EVT_FriendInviteCreated:
                        this.dispatchFriendInviteCreated((msg.event.data as FriendInviteCreatedEvt));
                        break;
                    case PayloadType.USER_EVT_UserFriendCreated:
                        this.dispatchNewUserFriend((msg.event.data as UserFriendCreatedEvt));
                        break;
                    case PayloadType.USER_EVT_UserFriendDeleted:
                        this.dispatchDeleteUserFriend((msg.event.data as UserFriendDeletedEvt));
                        break;
                    case PayloadType.USER_EVT_UserFriendGroupCreated:
                        this.dispatchNewFriendGroupCreated((msg.event.data as UserFriendGroupCreatedEvt));
                        break;
                    case PayloadType.USER_EVT_UserFriendGroupDeleted:
                        this.dispatchFriendGroupDeleted((msg.event.data as UserFriendGroupDeletedEvt));
                        break;
                    case PayloadType.USER_EVT_UserFriendUpdated:
                        this.dispatchFriendUpdated((msg.event.data as UserFriendUpdatedEvt));
                        break;
                    case PayloadType.USER_EVT_UserBlockedUserCreatedEvt:
                        this.dispatchUserBlocked((msg.event.data as UserBlockedUserCreatedEvt));
                        break;
                    case PayloadType.USER_EVT_UserBlockedUserDeletedEvt:
                        this.dispatchUserBlockedDeleted((msg.event.data as UserBlockedUserDeletedEvt));
                        break;
                };
            }
            else
            {
                if (isResponse)
                {
                    if (((!(msg.response.payload == null)) && (msg.response.payload.data == null)))
                    {
                        log(LogLevel.ERROR, (("Received response payload data " + PayloadType.getPayloadType(msg.response.payload.id)) + " data is null..."));
                        return;
                    };
                    found = false;
                    if (statusRequestMap[msg.response.correlationId])
                    {
                        correlatedRequest = (statusRequestMap[msg.response.correlationId] as CorrelatedRequest);
                        if (correlatedRequest)
                        {
                            requestedFrame = correlatedRequest.requestedFrame;
                            if (requestedFrame)
                            {
                                found = true;
                                success = (msg.response.status == ResponseStatus.SUCCESS);
                                payloadType = (requestedFrame.request.payload as Payload).id;
                                if (!success)
                                {
                                    if (correlatedRequest.callbackOnFailure != null)
                                    {
                                        correlatedRequest.callbackOnFailure((requestedFrame.request.payload as Payload), msg.response.status);
                                    }
                                    else
                                    {
                                        this.onFailCommand(payloadType, msg.response.status);
                                    };
                                }
                                else
                                {
                                    switch (payloadType)
                                    {
                                        case PayloadType.USER_CMD_ListUserFriendInvites:
                                            this.dispatchUserFriendInvitesReceived((msg.response.payload.data as FriendInviteList));
                                            break;
                                        case PayloadType.USER_CMD_ListUserFriends:
                                            this.dispatchUserFriendsReceived((msg.response.payload.data as FriendList));
                                            break;
                                        case PayloadType.USER_CMD_ListUserFriendGroups:
                                            this.dispatchUserFriendGroupsReceived((msg.response.payload.data as FriendGroupList));
                                            break;
                                        case PayloadType.CHANNEL_CMD_ListChannelMessagesCmd:
                                            this.dispatchChannelMessageListReceived((msg.response.payload.data as ChannelMessageList));
                                            break;
                                        case PayloadType.USER_CMD_ListUserBlockedUsersCmd:
                                            this.dispatchBlockedUserListReceived((msg.response.payload.data as UserList));
                                            break;
                                    };
                                };
                            };
                            delete statusRequestMap[msg.response.correlationId];
                        };
                    };
                    if (!found)
                    {
                        log(LogLevel.WARN, (("Can't find the correlationId " + currentCorrelationId) + " inside response map..."));
                    };
                };
            };
        }

        private function onFailCommand(payloadType:int, responseStatus:String):void
        {
            log(LogLevel.WARN, ((("Failed cmd " + PayloadType.getPayloadType(payloadType)) + " : ") + responseStatus));
        }

        private function dispatchUserPresence(data:UserPresenceUpdatedEvt):void
        {
            log(LogLevel.INFO, ((("UserPresence updated for user - " + data.userId) + " - ") + data.presence));
            if (((this.isMe(data.userId)) && (!(this.myPresence == data.presence))))
            {
                this.myPresence = data.presence;
                if (((connected) && (this.myPresence == UserPresence.OFFLINE)))
                {
                    this.disconnect();
                }
                else
                {
                    if (((!(connected)) || (!(authenticated))))
                    {
                        this.connect();
                    };
                };
            }
            else
            {
                if (this.friendList)
                {
                    this.friendList.setFriendPresence(data.userId, data.presence);
                }
                else
                {
                    if (!this.friendsInfos[data.userId])
                    {
                        this.friendsInfos[data.userId] = new Friend(null, null);
                    };
                    this.friendsInfos[data.userId].presence = data.presence;
                };
            };
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceUserUpdatedPresence, data.userId, data.presence);
        }

        private function dispatchUserStatus(data:UserStatusUpdatedEvt):void
        {
            log(LogLevel.INFO, ((("UserStatus updated for user - " + data.userId) + " - ") + data.status));
            if (this.isMe(data.userId))
            {
                this.myStatus = data.status;
            }
            else
            {
                if (this.friendList)
                {
                    this.friendList.setFriendStatus(data.userId, data.status);
                }
                else
                {
                    if (!this.friendsInfos[data.userId])
                    {
                        this.friendsInfos[data.userId] = new Friend(null, null);
                    };
                    this.friendsInfos[data.userId].status = data.status;
                };
            };
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceUserUpdatedStatus, data.userId, data.status);
        }

        private function dispatchUserActivities(data:UserEndpointPropertiesUpdatedEvt):void
        {
            log(LogLevel.INFO, ((("UserActivities updated for user - " + data.userId) + " - ") + data.properties));
            if (this.isMe(data.userId))
            {
                this.myActivities = data.properties;
            }
            else
            {
                if (this.friendList)
                {
                    this.friendList.setFriendActivities(data.userId, data.properties);
                }
                else
                {
                    if (!this.friendsInfos[data.userId])
                    {
                        this.friendsInfos[data.userId] = new Friend(null, null);
                    };
                    this.friendsInfos[data.userId].activities = data.properties;
                };
            };
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceUserUpdatedActivities, data.userId, data.properties);
        }

        private function dispatchChannelMessageCreated(chanMsgCreated:ChannelMessage):void
        {
            if (chanMsgCreated == null)
            {
                return;
            };
            chanMsgCreated.content = StringUtils.escapeHTMLText(chanMsgCreated.content);
            log(LogLevel.INFO, chanMsgCreated.toString());
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceChannelMessage, chanMsgCreated);
        }

        private function dispatchChannelMessageListReceived(chanMsgList:ChannelMessageList):void
        {
            if (((chanMsgList == null) || (chanMsgList.values == null)))
            {
                return;
            };
            log(LogLevel.INFO, chanMsgList.values.toString());
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceChannelMessageListUpdated, chanMsgList);
        }

        private function dispatchUserFriendInvitesReceived(friendInviteList:FriendInviteList):void
        {
            this.pendingFriendInvitesList = friendInviteList;
            log(LogLevel.INFO, ("FriendInvite list received - " + this.pendingFriendInvitesList.values.toString()));
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceFriendInviteListUpdated, friendInviteList);
        }

        private function dispatchFriendInviteCreated(friendInviteCreated:FriendInviteCreatedEvt):void
        {
            log(LogLevel.INFO, ("FriendInvite created - " + friendInviteCreated.invite.toString()));
            this.pendingFriendInvitesList.values.push(friendInviteCreated.invite);
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceFriendInviteCreated, friendInviteCreated.invite);
            this.onFriendInviteLauncherCreated(friendInviteCreated.invite);
        }

        private function dispatchFriendInviteDeleted(evt:FriendInviteDeletedEvt):void
        {
            log(LogLevel.INFO, ((("FriendInvite processed - " + evt.reason) + " - ") + evt.invite.toString()));
            if (this.isMe(evt.invite.recipient.userId))
            {
                NotificationManager.getInstance().closeNotification(("socialInvit_" + evt.invite.inviter.name));
            };
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceFriendInviteProcessed, evt.invite, evt.reason);
            var removeAtIndex:int = -1;
            var i:int;
            while (i < this.pendingFriendInvitesList.values.length)
            {
                if (((evt.invite.inviter.userId == this.pendingFriendInvitesList.values[i].inviter.userId) && (evt.invite.recipient.userId == this.pendingFriendInvitesList.values[i].recipient.userId)))
                {
                    removeAtIndex = i;
                    break;
                };
                i++;
            };
            if (removeAtIndex >= 0)
            {
                delete this.pendingFriendInvitesList.values[removeAtIndex];
            };
            sendChatServiceCmd(new Payload(PayloadType.USER_CMD_ListUserFriendInvites, new ListUserFriendInvitesCmd(accountId)));
        }

        private function dispatchBlockedUserListReceived(userList:UserList):void
        {
            this.blockedUserList = userList;
            log(LogLevel.INFO, ("Blocked Users List - " + userList.toString()));
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceUserBlockedList, userList);
        }

        private function dispatchUserBlocked(evt:UserBlockedUserCreatedEvt):void
        {
            this.blockedUserList.values.push(evt.blockedUser);
            log(LogLevel.INFO, ("User Blocked Added - " + evt.blockedUser.toString()));
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceUserBlockedDeleted, evt.blockedUser);
        }

        private function dispatchUserBlockedDeleted(evt:UserBlockedUserDeletedEvt):void
        {
            log(LogLevel.INFO, ("User Blocked Deleted - " + evt.blockedUserId));
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceUserBlockedDeleted, evt.blockedUserId);
        }

        private function dispatchNewUserFriend(friendEvt:UserFriendCreatedEvt):void
        {
            this.friendList.values.push(friendEvt.friend);
            log(LogLevel.INFO, ("New Friend - " + friendEvt.friend.toString()));
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceUserFriendCreated, friendEvt.friend);
        }

        private function dispatchFriendUpdated(updateEvt:UserFriendUpdatedEvt):void
        {
            var oldGroup:FriendGroup;
            var newGroup:FriendGroup;
            var oldIndex:int;
            log(LogLevel.INFO, ("Friend Updated - " + updateEvt.friend.toString()));
            var friend:Friend = this.getFriend(updateEvt.friend.user.userId);
            if (friend)
            {
                oldGroup = this.getFriendGroup(friend.group.name);
                newGroup = this.getFriendGroup(updateEvt.friend.group.name);
                if (((oldGroup) && (this.friendMap[oldGroup.name])))
                {
                    oldIndex = this.friendMap[oldGroup.name].indexOf(friend);
                    if (oldIndex >= 0)
                    {
                        this.friendMap[oldGroup.name].removeAt(oldIndex);
                    };
                };
                if (this.friendMap[updateEvt.friend.group.name])
                {
                    friend.group = newGroup;
                    this.friendMap[updateEvt.friend.group.name].push(friend);
                };
                KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceUserFriendUpdated, updateEvt.friend);
            };
        }

        private function dispatchDeleteUserFriend(deleteEvt:UserFriendDeletedEvt):void
        {
            var index:int;
            var friendToRemove:Friend = this.getFriend(deleteEvt.friendUserId);
            if (friendToRemove != null)
            {
                index = this.friendList.values.indexOf(friendToRemove);
                if (index >= 0)
                {
                    this.friendList.values.removeAt(index);
                    log(LogLevel.INFO, ("Friend Deleted - " + deleteEvt.friendUserId));
                    KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceUserFriendDeleted, deleteEvt.friendUserId);
                };
            };
        }

        private function dispatchUserFriendsReceived(friendList:FriendList):void
        {
            var group:FriendGroup;
            var friend:Friend;
            var friendInfo:Object;
            log(LogLevel.INFO, ("Friend list received - " + friendList.values.toString()));
            this.friendList = friendList;
            this.friendMap = new Dictionary();
            for each (group in this.friendGroupList.values)
            {
                this.friendMap[group.name] = new Vector.<Friend>();
            };
            for each (friend in this.friendList.values)
            {
                friendInfo = this.friendsInfos[friend.user.userId];
                if (friendInfo)
                {
                    friend.presence = friendInfo.presence;
                    friend.status = friendInfo.status;
                    friend.activities = friendInfo.activities;
                };
                if (friend.group)
                {
                    friend.group = this.getFriendGroup(friend.group.name);
                    this.friendMap[friend.group.name].push(friend);
                };
            };
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceFriendListUpdated, this.friendList);
        }

        private function dispatchUserFriendGroupsReceived(friendGroupList:FriendGroupList):void
        {
            log(LogLevel.INFO, ("Friend groups received - " + friendGroupList.values.toString()));
            this.friendGroupList = friendGroupList;
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceFriendGroupsUpdated, this.friendGroupList);
            sendChatServiceCmd(new Payload(PayloadType.USER_CMD_ListUserFriends, new ListUserFriendsCmd(accountId)));
        }

        private function dispatchNewFriendGroupCreated(createGrpEvt:UserFriendGroupCreatedEvt):void
        {
            log(LogLevel.INFO, ("New friend group - " + createGrpEvt.group.toString()));
            this.friendGroupList.values.push(createGrpEvt.group);
            this.friendMap[createGrpEvt.group.name] = new Vector.<Friend>();
            KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceFriendGroupCreated, createGrpEvt.group);
        }

        private function dispatchFriendGroupDeleted(deleteGrpEvt:UserFriendGroupDeletedEvt):void
        {
            var index:int;
            log(LogLevel.INFO, ("Friend group deleted - " + deleteGrpEvt.name));
            var friendGroupToDelete:FriendGroup = this.getFriendGroup(deleteGrpEvt.name);
            if (friendGroupToDelete != null)
            {
                if (this.friendMap[friendGroupToDelete.name])
                {
                    delete this.friendMap[friendGroupToDelete.name];
                };
                index = this.friendGroupList.values.indexOf(friendGroupToDelete);
                if (index >= 0)
                {
                    this.friendGroupList.values.removeAt(index);
                };
                KernelEventsManager.getInstance().processCallback(ChatServiceHookList.ChatServiceFriendGroupDeleted, deleteGrpEvt.name);
            };
        }

        private function isMe(userId:String):Boolean
        {
            return (userId == accountId);
        }

        public function getFriend(target:String):Friend
        {
            var friend:Friend;
            var userIdIsNan:Boolean = isNaN(Number(target));
            if (this.friendList)
            {
                for each (friend in this.friendList.values)
                {
                    if ((((userIdIsNan) && (friend.user.name.toLowerCase() == target.toLowerCase())) || ((!(userIdIsNan)) && (friend.user.userId == target))))
                    {
                        return (friend);
                    };
                };
            };
            return (null);
        }

        public function getFriendGroup(groupName:String):FriendGroup
        {
            var group:FriendGroup;
            for each (group in this.friendGroupList.values)
            {
                if (group.name == groupName)
                {
                    return (group);
                };
            };
            return (null);
        }

        public function sendMessage(target:String, msg:String, callbackOnFailure:Function=null):void
        {
            var authorId:Number;
            var targetId:Number;
            var friend:Friend = this.getFriend(target);
            if (friend)
            {
                authorId = parseInt(accountId);
                targetId = parseInt(friend.user.userId);
                sendChatServiceCmd(new Payload(PayloadType.CHANNEL_CMD_CreateChannelMessageCmd, new CreateChannelMessageCmd(((("DM_" + Math.min(authorId, targetId)) + "_") + Math.max(authorId, targetId)), accountId, msg)), callbackOnFailure);
            }
            else
            {
                log(LogLevel.WARN, (("Can't send message to user " + target) + ", impossible to find this friend in player list..."));
            };
        }

        public function updateUserStatus(newStatus:String, callbackOnFailure:Function=null):void
        {
            sendChatServiceCmd(new Payload(PayloadType.USER_CMD_UpdateUserStatus, new UpdateUserStatusCmd(accountId, newStatus)), callbackOnFailure);
        }

        public function updatePlayerDofusActivity(activity:String=null):void
        {
            var activities:Vector.<String> = ((activity != null) ? new <String>[activity] : new Vector.<String>(0));
            var dictionary:Dictionary = new Dictionary();
            var serverName:String = PlayerManager.getInstance().server.name;
            dictionary["SERVER_NAME"] = serverName;
            if (((this._gamesActivities) && (this._gamesActivities.length > 0)))
            {
                serverName = this._gamesActivities[0].getActivityKey(serverName);
            };
            if (serverName)
            {
                dictionary["SERVER_NAME"] = serverName;
            };
            this.updateUserActivity(activities, dictionary);
        }

        public function updateUserActivity(activities:Vector.<String>, metadata:Dictionary, callbackOnFailure:Function=null):void
        {
            sendChatServiceCmd(new Payload(PayloadType.USER_CMD_UpdateUserEndpointPropertiesCmd, new UpdateUserEndpointPropertiesCmd(accountId, new EndpointProperties(GameID.DOFUS, activities, metadata))), callbackOnFailure);
        }

        public function processAllUserFriendInvites(reason:String, callbackOnFailure:Function=null):void
        {
            var invite:FriendInvite;
            for each (invite in this.pendingFriendInvitesList.values)
            {
                this.processUserFriendInvite(invite.inviter.userId, invite.recipient.userId, reason, callbackOnFailure);
            };
        }

        public function processUserFriendInvite(inviterId:String, recipientId:String, reason:String, callbackOnFailure:Function=null):void
        {
            var invite:FriendInvite;
            if ((((this.pendingFriendInvitesList == null) || (this.pendingFriendInvitesList.values == null)) || (this.pendingFriendInvitesList.values.length == 0)))
            {
                return;
            };
            for each (invite in this.pendingFriendInvitesList.values)
            {
                if (((invite.inviter.userId == inviterId) && (invite.recipient.userId == recipientId)))
                {
                    sendChatServiceCmd(new Payload(PayloadType.FRIEND_INVITE_CMD_DeleteFriendInvite, new DeleteFriendInviteCmd(inviterId, recipientId, reason)), callbackOnFailure);
                };
            };
        }

        public function sendFriendInvite(target:String, callbackOnFailure:Function=null):void
        {
            var targetIsUserId:* = (!(isNaN(Number(target))));
            sendChatServiceCmd(new Payload(PayloadType.FRIEND_INVITE_CMD_CreateFriendInvite, new CreateFriendInviteCmd(accountId, ((targetIsUserId) ? target : null), ((targetIsUserId) ? null : target))), callbackOnFailure);
        }

        public function deleteUserFriend(friendUserId:String, callbackOnFailure:Function=null):void
        {
            var friendToDelete:Friend = this.getFriend(friendUserId);
            if (((friendToDelete) && (friendToDelete.user)))
            {
                sendChatServiceCmd(new Payload(PayloadType.USER_CMD_DeleteUserFriend, new DeleteUserFriendCmd(accountId, friendToDelete.user.userId)), callbackOnFailure);
            }
            else
            {
                log(LogLevel.WARN, (("Can't delete user " + friendUserId) + ", impossible to find this friend in player list..."));
            };
        }

        public function deleteAllUserFriend(callbackOnFailure:Function=null):void
        {
            var friend:Friend;
            for each (friend in this.friendList)
            {
                sendChatServiceCmd(new Payload(PayloadType.USER_CMD_DeleteUserFriend, new DeleteUserFriendCmd(accountId, friend.user.userId)), callbackOnFailure);
            };
        }

        public function updateUserFriend(target:String, groupName:String, callbackOnFailure:Function=null):void
        {
            var friend:Friend = this.getFriend(target);
            if (friend == null)
            {
                log(LogLevel.WARN, (("Can't find friend with userId or userName = " + target) + " in player friendList."));
                return;
            };
            var newGroup:FriendGroup = this.getFriendGroup(groupName);
            if (newGroup == null)
            {
                log(LogLevel.WARN, (("Can't find group with name=" + newGroup) + " in player groupList."));
                return;
            };
            if (friend.group != newGroup)
            {
                sendChatServiceCmd(new Payload(PayloadType.USER_CMD_UpdateUserFriend, new UpdateUserFriendCmd(accountId, new Friend(friend.user, newGroup))), callbackOnFailure);
            };
        }

        public function createFriendGroup(groupName:String, callbackOnFailure:Function=null):void
        {
            sendChatServiceCmd(new Payload(PayloadType.USER_CMD_CreateUserFriendGroup, new CreateUserFriendGroupCmd(accountId, new FriendGroup(groupName))), callbackOnFailure);
        }

        public function deleteFriendGroup(groupName:String, callbackOnFailure:Function=null):void
        {
            sendChatServiceCmd(new Payload(PayloadType.USER_CMD_DeleteUserFriendGroup, new DeleteUserFriendGroupCmd(accountId, groupName)), callbackOnFailure);
        }

        public function listBlockedUsers(callbackOnFailure:Function=null):void
        {
            sendChatServiceCmd(new Payload(PayloadType.USER_CMD_ListUserBlockedUsersCmd, new ListUserBlockedUsersCmd(accountId)), callbackOnFailure);
        }

        public function blockUser(userId:String, callbackOnFailure:Function=null):void
        {
            sendChatServiceCmd(new Payload(PayloadType.USER_CMD_CreateUserBlockedUserCmd, new CreateUserBlockedUserCmd(accountId, userId)), callbackOnFailure);
        }

        public function deleteBlockedUser(userId:String, callbackOnFailure:Function=null):void
        {
            sendChatServiceCmd(new Payload(PayloadType.USER_CMD_DeleteUserBlockedUserCmd, new DeleteUserBlockedUserCmd(accountId, userId)), callbackOnFailure);
        }

        private function onFriendInviteLauncherCreated(friendInvite:FriendInvite):void
        {
            var externalNotificationManager:ExternalNotificationManager;
            if (friendInvite.inviter.userId != accountId)
            {
                externalNotificationManager = ExternalNotificationManager.getInstance();
                if (externalNotificationManager.canAddExternalNotification(ExternalNotificationTypeEnum.FRIEND_INVITE))
                {
                    KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification, ExternalNotificationTypeEnum.FRIEND_INVITE, [friendInvite.inviter.name]);
                };
                this.sendInviteNotification(friendInvite);
            };
        }

        public function sendInviteNotification(friendInvite:FriendInvite):void
        {
            var notifManager:NotificationManager = NotificationManager.getInstance();
            var pidmsgNid:uint = notifManager.prepareNotification(I18n.getUiText("ui.common.invitation"), I18n.getUiText("ui.social.wantToBeAnkamaFriend", [friendInvite.inviter.name]), NotificationTypeEnum.INVITATION, ("socialInvit_" + friendInvite.inviter.name));
            notifManager.addButtonToNotification(pidmsgNid, I18n.getUiText("ui.common.refuse"), "ChatServiceUserFriendInviteResponse", [friendInvite.inviter.userId, friendInvite.recipient.userId, DeleteFriendInviteReason.REJECTED], true, 130, 0, "hook");
            notifManager.addButtonToNotification(pidmsgNid, I18n.getUiText("ui.common.accept"), "ChatServiceUserFriendInviteResponse", [friendInvite.inviter.userId, friendInvite.recipient.userId, DeleteFriendInviteReason.ACCEPTED], true, 130, 0, "hook");
            notifManager.sendNotification(pidmsgNid);
        }

        public function getGameId(property:String):uint
        {
            return (GameID[property]);
        }

        public function getGameName(applicationId:uint):String
        {
            return (GameID.getName(applicationId));
        }


    }
} com.ankamagames.dofus.logic.game.spin2.chat

