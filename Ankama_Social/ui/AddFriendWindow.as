package Ankama_Social.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.ChatServiceApi;
    import com.ankamagames.dofus.uiApi.ChatApi;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.jerakine.enum.SocialCharacterCategoryEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import d2hooks.FailInvitation;
    import d2hooks.ChatServiceFriendInviteCreated;
    import d2hooks.FriendsListUpdated;
    import d2hooks.ContactsListUpdated;
    import d2hooks.EnemiesListUpdated;
    import d2hooks.IgnoredListUpdated;
    import d2enums.ComponentHookList;
    import chat.protocol.transport.Payload;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import mx.utils.StringUtil;
    import d2actions.AddFriend;
    import d2actions.AddEnemy;
    import d2actions.AddIgnored;
    import chat.protocol.friendinvite.data.FriendInvite;

    public class AddFriendWindow 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="ChatServiceApi")]
        public var chatServiceApi:ChatServiceApi;
        [Api(name="ChatApi")]
        public var chatApi:ChatApi;
        public var lbl_title:Label;
        public var lbl_account:Label;
        public var inp_account:Input;
        public var btn_close:ButtonContainer;
        public var btn_sendInvite:ButtonContainer;
        public var btn_lbl_btn_sendInvite:Label;
        public var lbl_error:Label;
        private var _category:uint;


        public function main(params:Array):void
        {
            this._category = params[0];
            switch (this._category)
            {
                case SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA:
                    this.lbl_title.text = this.uiApi.getText("ui.common.invitation");
                    break;
                case SocialCharacterCategoryEnum.CATEGORY_FRIEND:
                case SocialCharacterCategoryEnum.CATEGORY_CONTACT:
                    this.lbl_title.text = this.uiApi.getText("ui.social.addContact");
                    break;
                case SocialCharacterCategoryEnum.CATEGORY_IGNORED:
                    this.lbl_title.text = this.uiApi.getText("ui.social.ignoreContact");
                    break;
                case SocialCharacterCategoryEnum.CATEGORY_ENEMY:
                    this.lbl_title.text = this.uiApi.getText("ui.social.blockContact");
                    break;
            };
            this.btn_lbl_btn_sendInvite.text = this.uiApi.getText(((this._category == SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA) ? "ui.social.reportSend" : "ui.common.validation"));
            this.btn_sendInvite.soundId = SoundEnum.OK_BUTTON;
            this.uiApi.getUi("socialBase").strata--;
            this.lbl_account.text = this.uiApi.getText(((this._category == SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA) ? "ui.header.dofusPseudo" : "ui.common.accountOrCharName"));
            this.inp_account.focus();
            this.sysApi.addHook(FailInvitation, this.failInvitation);
            this.sysApi.addHook(ChatServiceFriendInviteCreated, this.onFriendInviteLauncherCreated);
            this.sysApi.addHook(FriendsListUpdated, this.onFriendsOrContactUpdated);
            this.sysApi.addHook(ContactsListUpdated, this.onFriendsOrContactUpdated);
            this.sysApi.addHook(EnemiesListUpdated, this.onEnemiesUpdated);
            this.sysApi.addHook(IgnoredListUpdated, this.onIgnoredUpdated);
            this.uiApi.addComponentHook(this.btn_sendInvite, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.inp_account, ComponentHookList.ON_RELEASE);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.inp_account.text = params[1];
        }

        private function failInvitation(response:String):void
        {
            this.lbl_error.text = response;
            this.inp_account.blur();
        }

        private function failChatServiceInvitation(payload:Payload, status:String):void
        {
            this.lbl_error.text = this.uiApi.getText("ui.socialError.doesNotExist");
            this.inp_account.blur();
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    this.sendInvite();
                    return (true);
                case "closeUi":
                    this.closeMe();
                    return (true);
            };
            return (false);
        }

        public function unload():void
        {
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.closeMe();
                    break;
                case this.btn_sendInvite:
                    this.sendInvite();
                    break;
                case this.inp_account:
                    this.lbl_error.text = "";
                    break;
            };
        }

        private function closeMe():void
        {
            if (this.uiApi)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }

        private function sendInvite():void
        {
            var recipient:String;
            if (this.inp_account.text)
            {
                recipient = StringUtil.trim(this.inp_account.text.toLowerCase());
                if (!this.chatServiceApi.service.authenticated)
                {
                    this.lbl_error.text = this.uiApi.getText("ui.secureMode.error.checkCode.503");
                    return;
                };
                switch (this._category)
                {
                    case SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA:
                        if (recipient == this.sysApi.getPlayerManager().nickname.toLowerCase())
                        {
                            this.lbl_error.text = this.uiApi.getText("ui.social.friend.addFailureEgocentric");
                        }
                        else
                        {
                            if (this.chatServiceApi.service.getFriend(recipient))
                            {
                                this.lbl_error.text = this.uiApi.getText("ui.socialError.alreadyInList");
                            }
                            else
                            {
                                if (recipient != "")
                                {
                                    this.chatServiceApi.service.sendFriendInvite(recipient, this.failChatServiceInvitation);
                                };
                            };
                        };
                        break;
                    case SocialCharacterCategoryEnum.CATEGORY_FRIEND:
                    case SocialCharacterCategoryEnum.CATEGORY_CONTACT:
                        this.sysApi.sendAction(new AddFriend(recipient));
                        break;
                    case SocialCharacterCategoryEnum.CATEGORY_ENEMY:
                        this.sysApi.sendAction(new AddEnemy(recipient));
                        break;
                    case SocialCharacterCategoryEnum.CATEGORY_IGNORED:
                        this.sysApi.sendAction(new AddIgnored(recipient));
                        break;
                };
                this.inp_account.text = "";
            };
        }

        private function onFriendInviteLauncherCreated(friendInvite:FriendInvite):void
        {
            if (friendInvite.inviter.userId == this.sysApi.getPlayerManager().accountId.toString())
            {
                this.chatApi.sendInfoOnChat(this.uiApi.getText("ui.social.friendInviteSent", friendInvite.recipient.name));
                this.closeMe();
            };
        }

        private function onFriendsOrContactUpdated():void
        {
            this.closeMe();
        }

        private function onEnemiesUpdated():void
        {
            this.closeMe();
        }

        private function onIgnoredUpdated():void
        {
            this.closeMe();
        }


    }
} Ankama_Social.ui

