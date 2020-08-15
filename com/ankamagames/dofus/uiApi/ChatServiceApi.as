package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.dofus.logic.game.spin2.chat.ChatServiceManager;
    import com.ankamagames.dofus.logic.game.spin2.chat.ChatService;
    import chat.protocol.user.data.Friend;
    import __AS3__.vec.Vector;
    import chat.protocol.friendinvite.data.FriendInvite;
    import chat.protocol.friendinvite.data.DeleteFriendInviteReason;
    import __AS3__.vec.*;

    [InstanciedApi]
    public class ChatServiceApi implements IApi 
    {


        public function get service():ChatService
        {
            return (ChatServiceManager.getInstance().chatService);
        }

        public function getFriendsList():Vector.<Friend>
        {
            return ((this.service.friendList == null) ? new Vector.<Friend>() : this.service.friendList.values);
        }

        public function getWaitingList():Vector.<FriendInvite>
        {
            return ((this.service.pendingFriendInvitesList == null) ? new Vector.<FriendInvite>() : this.service.pendingFriendInvitesList.values);
        }

        public function acceptInvite(invite:FriendInvite):void
        {
            this.service.processUserFriendInvite(invite.inviter.userId, invite.recipient.userId, DeleteFriendInviteReason.ACCEPTED);
        }

        public function rejectInvite(invite:FriendInvite):void
        {
            this.service.processUserFriendInvite(invite.inviter.userId, invite.recipient.userId, DeleteFriendInviteReason.REJECTED);
        }

        public function cancelInvite(invite:FriendInvite):void
        {
            this.service.processUserFriendInvite(invite.inviter.userId, invite.recipient.userId, DeleteFriendInviteReason.CANCELED);
        }


    }
}

