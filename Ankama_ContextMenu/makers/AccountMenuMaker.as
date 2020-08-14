package Ankama_ContextMenu.makers
{
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import Ankama_ContextMenu.Api;
    import d2hooks.OpenWebPortal;
    import com.ankamagames.dofus.types.enums.WebLocationEnum;
    import d2hooks.ChatFocusInterGame;
    import d2actions.RemoveFriend;
    import com.ankamagames.jerakine.enum.SocialCharacterCategoryEnum;
    import Ankama_ContextMenu.ContextMenu;
    import d2hooks.*;

    public class AccountMenuMaker implements IMenuMaker 
    {

        public static var disabled:Boolean = false;

        protected var _accountId:String;


        protected function onAnkaboxMessage(accountId:String):void
        {
            Api.system.dispatchHook(OpenWebPortal, WebLocationEnum.WEB_LOCATION_ANKABOX_SEND_MESSAGE, false, [accountId]);
        }

        protected function onWhisperMessage(accountName:String):void
        {
            Api.system.dispatchHook(ChatFocusInterGame, accountName);
        }

        protected function onRemoveContact(accountName:String, accountId:String):void
        {
            this._accountId = accountId;
            Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"), Api.ui.getText("ui.social.doUDeleteContact", accountName), [Api.ui.getText("ui.common.yes"), Api.ui.getText("ui.common.no")], [this.onAcceptRemoveContact], this.onAcceptRemoveContact);
        }

        protected function onAcceptRemoveContact():void
        {
            Api.system.sendAction(new RemoveFriend(parseInt(this._accountId)));
        }

        protected function onRemoveFriends(accountName:String, accountId:String):void
        {
            this._accountId = accountId;
            Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"), Api.ui.getText("ui.social.doUDeleteFriend", accountName), [Api.ui.getText("ui.common.yes"), Api.ui.getText("ui.common.no")], [this.onAcceptRemoveFriends], this.onAcceptRemoveFriends);
        }

        protected function onAcceptRemoveFriends():void
        {
            Api.chatServiceApi.service.deleteUserFriend(this._accountId);
        }

        public function createMenu(data:*, param:Object):Array
        {
            var menu:Array = [];
            if (data.category == SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA)
            {
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.wisperMessage"), this.onWhisperMessage, [data.name], disabled));
            };
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.ankaboxMessage"), this.onAnkaboxMessage, [data.id], disabled));
            if (data.category)
            {
                menu.push(ContextMenu.static_createContextMenuSeparatorObject());
                if (data.category == SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA)
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.removeFromAnkamaFriends"), this.onRemoveFriends, [data.name, data.id], disabled));
                };
                if (((data.category == SocialCharacterCategoryEnum.CATEGORY_CONTACT) || (data.category == SocialCharacterCategoryEnum.CATEGORY_FRIEND)))
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.removeFromContacts"), this.onRemoveContact, [data.name, data.id], disabled));
                };
            };
            return (menu);
        }


    }
} Ankama_ContextMenu.makers

