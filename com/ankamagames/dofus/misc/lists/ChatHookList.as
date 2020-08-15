package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.berilia.types.data.Hook;

    public class ChatHookList 
    {

        public static const ChatSendPreInit:Hook = new Hook("ChatSendPreInit");
        public static const ChatAppendLine:Hook = new Hook("ChatAppendLine");
        public static const ChatError:Hook = new Hook("ChatError");
        public static const ChatServer:Hook = new Hook("ChatServer");
        public static const ChatServerWithObject:Hook = new Hook("ChatServerWithObject");
        public static const ChatServerCopy:Hook = new Hook("ChatServerCopy");
        public static const ChatServerCopyWithObject:Hook = new Hook("ChatServerCopyWithObject");
        public static const ChatSmiley:Hook = new Hook("ChatSmiley");
        public static const MoodResult:Hook = new Hook("MoodResult");
        public static const SmileyListUpdated:Hook = new Hook("SmileyListUpdated");
        public static const NewMessage:Hook = new Hook("NewMessage");
        public static const ChatSpeakingItem:Hook = new Hook("ChatSpeakingItem");
        public static const TextInformation:Hook = new Hook("TextInformation");
        public static const TextActionInformation:Hook = new Hook("TextActionInformation");
        public static const ChatFocus:Hook = new Hook("ChatFocus");
        public static const ChatFocusInterGame:Hook = new Hook("ChatFocusInterGame");
        public static const ChannelEnablingChange:Hook = new Hook("ChannelEnablingChange");
        public static const EnabledChannels:Hook = new Hook("EnabledChannels");
        public static const ChatCommunityChannelCommunity:Hook = new Hook("ChatCommunityChannelCommunity");
        public static const LivingObjectMessage:Hook = new Hook("LivingObjectMessage");
        public static const InsertRecipeHyperlink:Hook = new Hook("InsertRecipeHyperlink");
        public static const Notification:Hook = new Hook("Notification");
        public static const PopupWarning:Hook = new Hook("PopupWarning");
        public static const ChatWarning:Hook = new Hook("ChatWarning");
        public static const ChatLinkRelease:Hook = new Hook("ChatLinkRelease");
        public static const AddItemHyperlink:Hook = new Hook("AddItemHyperlink");
        public static const ShowObjectLinked:Hook = new Hook("ShowObjectLinked");
        public static const ToggleChatLog:Hook = new Hook("ToggleChatLog");
        public static const ClearChat:Hook = new Hook("ClearChat");
        public static const MailStatus:Hook = new Hook("MailStatus");
        public static const NumericWhoIs:Hook = new Hook("NumericWhoIs");
        public static const SilentWhoIs:Hook = new Hook("SilentWhoIs");


    }
}

