package chat.protocol.transport
{
    import chat.protocol.common.JsonifiedMessage;
    import flash.utils.Dictionary;
    import pools.PoolsManager;
    import pools.PoolablePayload;
    import chat.protocol.user.events.UserPresenceUpdatedEvt;
    import chat.protocol.common.PayloadType;
    import chat.protocol.user.events.UserStatusUpdatedEvt;
    import chat.protocol.user.data.EndpointProperties;
    import chat.protocol.user.events.UserEndpointPropertiesUpdatedEvt;
    import chat.protocol.user.data.User;
    import chat.protocol.friendinvite.data.FriendInvite;
    import chat.protocol.friendinvite.data.FriendInviteList;
    import chat.protocol.channel.events.ChannelMessageCreatedEvt;
    import chat.protocol.channel.data.ChannelMessage;
    import chat.protocol.friendinvite.events.FriendInviteCreatedEvt;
    import chat.protocol.friendinvite.events.FriendInviteDeletedEvt;
    import chat.protocol.user.events.UserFriendCreatedEvt;
    import chat.protocol.user.data.Friend;
    import chat.protocol.user.events.UserFriendUpdatedEvt;
    import chat.protocol.user.data.FriendGroup;
    import chat.protocol.user.events.UserFriendDeletedEvt;
    import chat.protocol.user.events.UserFriendGroupCreatedEvt;
    import chat.protocol.user.events.UserFriendGroupDeletedEvt;
    import chat.protocol.user.data.FriendList;
    import chat.protocol.user.data.FriendGroupList;
    import chat.protocol.user.events.UserBlockedUserCreatedEvt;
    import chat.protocol.user.events.UserBlockedUserDeletedEvt;
    import chat.protocol.user.data.UserList;
    import __AS3__.vec.*;

    public class Payload extends JsonifiedMessage 
    {

        public var id:int;
        public var data:JsonifiedMessage;

        public function Payload(payloadType:int, payload:JsonifiedMessage)
        {
            this.init(payloadType, payload);
        }

        public static function createFromReceivedJsonObject(payloadType:int, _data:Object):Payload
        {
            var userActivities:Array;
            var friendInvites:Array;
            var friends:Array;
            var groups:Array;
            var property:Object;
            var map:Dictionary;
            var key:String;
            var fi:Object;
            var friend:Object;
            var group:Object;
            var processedContent:PoolablePayload = (PoolsManager.getInstance().getPayloadPool().checkOut() as PoolablePayload);
            switch (payloadType)
            {
                case PayloadType.USER_EVT_UserPresenceUpdated:
                    processedContent = processedContent.renew(payloadType, new UserPresenceUpdatedEvt(_data.userId, _data.presence));
                    break;
                case PayloadType.USER_EVT_UserStatusUpdated:
                    processedContent = processedContent.renew(payloadType, new UserStatusUpdatedEvt(_data.userId, _data.status));
                    break;
                case PayloadType.USER_EVT_UserEndpointPropertiesUpdatedEvt:
                    userActivities = [];
                    for each (property in _data.properties)
                    {
                        map = new Dictionary();
                        for (key in property.metadata)
                        {
                            map[key] = property.metadata[key];
                        };
                        userActivities.push(new EndpointProperties(property.applicationId, Vector.<String>(property.activities), map));
                    };
                    processedContent = processedContent.renew(payloadType, new UserEndpointPropertiesUpdatedEvt(_data.userId, userActivities));
                    break;
                case PayloadType.USER_User:
                    processedContent = processedContent.renew(payloadType, new User(_data.userId, _data.name));
                    break;
                case PayloadType.FRIEND_INVITE_FriendInviteList:
                    friendInvites = [];
                    for each (fi in _data.values)
                    {
                        friendInvites.push(new FriendInvite(new User(fi.inviter.userId, fi.inviter.name), new User(fi.recipient.userId, fi.recipient.name)));
                    };
                    processedContent = processedContent.renew(payloadType, new FriendInviteList(friendInvites));
                    break;
                case PayloadType.CHANNEL_EVT_ChannelMessageCreatedEvt:
                    processedContent = processedContent.renew(payloadType, new ChannelMessageCreatedEvt(new ChannelMessage(_data.message.messageId, _data.message.channelId, _data.message.createdTimestamp, _data.message.content, new User(_data.message.author.userId, _data.message.author.name))));
                    break;
                case PayloadType.FRIEND_INVITE_EVT_FriendInviteCreated:
                    processedContent = processedContent.renew(payloadType, new FriendInviteCreatedEvt(new FriendInvite(new User(_data.invite.inviter.userId, _data.invite.inviter.name), new User(_data.invite.recipient.userId, _data.invite.recipient.name))));
                    break;
                case PayloadType.FRIEND_INVITE_EVT_FriendInviteDeleted:
                    processedContent = processedContent.renew(payloadType, new FriendInviteDeletedEvt(new FriendInvite(new User(_data.invite.inviter.userId, _data.invite.inviter.name), new User(_data.invite.recipient.userId, _data.invite.recipient.name)), _data.reason));
                    break;
                case PayloadType.USER_EVT_UserFriendCreated:
                    processedContent = processedContent.renew(payloadType, new UserFriendCreatedEvt(_data.userId, new Friend(new User(_data.friend.user.userId, _data.friend.user.name), null)));
                    break;
                case PayloadType.USER_EVT_UserFriendUpdated:
                    processedContent = processedContent.renew(payloadType, new UserFriendUpdatedEvt(_data.userId, new Friend(new User(_data.friend.user.userId, _data.friend.user.name), new FriendGroup(_data.friend.group.name))));
                    break;
                case PayloadType.USER_EVT_UserFriendDeleted:
                    processedContent = processedContent.renew(payloadType, new UserFriendDeletedEvt(_data.userId, _data.friendUserId));
                    break;
                case PayloadType.USER_EVT_UserFriendGroupCreated:
                    processedContent = processedContent.renew(payloadType, new UserFriendGroupCreatedEvt(_data.userId, new FriendGroup(_data.group.name)));
                    break;
                case PayloadType.USER_EVT_UserFriendGroupDeleted:
                    processedContent = processedContent.renew(payloadType, new UserFriendGroupDeletedEvt(_data.userId, _data.name));
                    break;
                case PayloadType.USER_FriendList:
                    friends = [];
                    for each (friend in _data.values)
                    {
                        friends.push(new Friend(new User(friend.user.userId, friend.user.name), ((friend.group != null) ? new FriendGroup(friend.group.name) : null)));
                    };
                    processedContent = processedContent.renew(payloadType, new FriendList(friends));
                    break;
                case PayloadType.USER_FriendGroupList:
                    groups = [];
                    for each (group in _data.values)
                    {
                        groups.push(new FriendGroup(group.name));
                    };
                    processedContent = processedContent.renew(payloadType, new FriendGroupList(groups));
                    break;
                case PayloadType.USER_EVT_UserBlockedUserCreatedEvt:
                    processedContent = processedContent.renew(payloadType, new UserBlockedUserCreatedEvt(_data.userId, _data.blockedUserId));
                    break;
                case PayloadType.USER_EVT_UserBlockedUserDeletedEvt:
                    processedContent = processedContent.renew(payloadType, new UserBlockedUserDeletedEvt(_data.userId, _data.blockedUserId));
                    break;
                case PayloadType.USER_UserList:
                    processedContent = processedContent.renew(payloadType, new UserList(_data.values));
                    break;
            };
            return (processedContent);
        }


        protected function init(payloadType:int, payload:JsonifiedMessage):void
        {
            this.id = payloadType;
            this.data = payload;
        }


    }
}

