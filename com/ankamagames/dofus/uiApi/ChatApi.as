package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
    import com.ankamagames.dofus.datacenter.communication.ChatChannel;
    import com.ankamagames.dofus.internalDatacenter.communication.ChatSentenceWithRecipient;
    import com.ankamagames.dofus.internalDatacenter.communication.ChatSentenceWithSource;
    import com.ankamagames.dofus.internalDatacenter.communication.ChatInformationSentence;
    import com.ankamagames.berilia.factories.HyperlinkFactory;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkItemManager;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.ChatAutocompleteNameManager;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkShowGuildManager;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkShowAllianceManager;
    import com.ankamagames.berilia.managers.HtmlManager;
    import com.ankamagames.jerakine.logger.ModuleLogger;
    import com.ankamagames.dofus.console.moduleLogger.TypeMessage;
    import com.ankamagames.dofus.console.moduleLogger.Console;
    import flash.text.StyleSheet;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;

    [InstanciedApi]
    public class ChatApi implements IApi 
    {

        protected var _log:Logger = Log.getLogger(getQualifiedClassName(ChatApi));
        private var _module:UiModule;


        private function get chatFrame():ChatFrame
        {
            return (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame);
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        public function destroy():void
        {
            this._module = null;
        }

        public function getChannelsId():Array
        {
            var chan:*;
            var disallowed:Array = this.chatFrame.disallowedChannels;
            var list:Array = new Array();
            for each (chan in ChatChannel.getChannels())
            {
                if (disallowed.indexOf(chan.id) == -1)
                {
                    list.push(chan.id);
                };
            };
            return (list);
        }

        public function getDisallowedChannelsId():Array
        {
            return (this.chatFrame.disallowedChannels);
        }

        public function getLangIdForCommunityChannel():int
        {
            return (this.chatFrame.communityIdForCommunityChannel);
        }

        public function getChatColors():Array
        {
            return (this.chatFrame.chatColors);
        }

        public function getSmileyMood():int
        {
            return (this.chatFrame.smileyMood);
        }

        public function getMessagesByChannel(channel:uint):Array
        {
            var list:Array = this.chatFrame.getMessages();
            return (list[channel]);
        }

        [NoBoxing]
        public function getParagraphByChannel(channel:uint):Array
        {
            var list:Array = this.chatFrame.getParagraphes();
            return (list[channel]);
        }

        public function setMaxMessagesStored(val:int):void
        {
            this.chatFrame.maxMessagesStored = val;
        }

        public function getMaxMessagesStored():int
        {
            return (this.chatFrame.maxMessagesStored);
        }

        public function getTypeOfChatSentence(msg:Object):String
        {
            if ((msg is ChatSentenceWithRecipient))
            {
                return ("recipientSentence");
            };
            if ((msg is ChatSentenceWithSource))
            {
                return ("sourceSentence");
            };
            if ((msg is ChatInformationSentence))
            {
                return ("informationSentence");
            };
            return ("basicSentence");
        }

        public function searchChannel(chan:String):int
        {
            var i:*;
            var channels:Array = ChatChannel.getChannels();
            for (i in channels)
            {
                if (chan == channels[i].shortcut)
                {
                    return (channels[i].id);
                };
            };
            return (-1);
        }

        public function getRedChannelId():uint
        {
            return (this.chatFrame.getRedId());
        }

        public function getStaticHyperlink(string:String):String
        {
            return (HyperlinkFactory.decode(string, false));
        }

        public function newChatItem(item:ItemWrapper):String
        {
            return (HyperlinkItemManager.newChatItem(item));
        }

        public function getAutocompletion(subString:String, count:int):String
        {
            return (ChatAutocompleteNameManager.getInstance().autocomplete(subString, count));
        }

        public function getGuildLink(pGuild:*, pText:String=null):String
        {
            return (HyperlinkShowGuildManager.getLink(pGuild, pText));
        }

        public function getAllianceLink(pAlliance:*, pText:String=null, pLinkColor:String=null, pHoverColor:String=null):String
        {
            return (HyperlinkShowAllianceManager.getLink(pAlliance, pText, pLinkColor, pHoverColor));
        }

        public function changeCssHandler(val:String):void
        {
            HtmlManager.changeCssHandler(val);
        }

        public function logChat(text:String, cssClass:String):void
        {
            ModuleLogger.log(text, TypeMessage.LOG_CHAT, cssClass);
        }

        public function launchExternalChat():void
        {
            Console.getInstance().display();
        }

        public function getChatStyle():StyleSheet
        {
            return (Console.getInstance().consoleStyle);
        }

        public function setExternalChatChannels(pChannels:Array):void
        {
            var chanId:uint;
            var externalChatChannels:Array = OptionManager.getOptionManager("chat").getOption("externalChatEnabledChannels");
            externalChatChannels.length = 0;
            for each (chanId in pChannels)
            {
                if (externalChatChannels.indexOf(chanId) == -1)
                {
                    externalChatChannels.push(chanId);
                };
            };
            if (Console.getInstance().opened)
            {
                Console.getInstance().updateEnabledChatChannels();
            };
        }

        public function addHtmlLink(pText:String, pHref:String):String
        {
            return (HtmlManager.addLink(pText, pHref));
        }

        public function escapeChatString(inStr:String):String
        {
            var pattern:RegExp = /&/g;
            inStr = inStr.replace(pattern, "&amp;");
            pattern = /{/g;
            inStr = inStr.replace(pattern, "&#123;");
            pattern = /}/g;
            inStr = inStr.replace(pattern, "&#125;");
            return (inStr);
        }

        public function unEscapeChatString(inStr:String):String
        {
            inStr = inStr.split("&amp;#123;").join("&#123;");
            inStr = inStr.split("&amp;#125;").join("&#125;");
            inStr = inStr.split("&amp;amp;").join("&amp;");
            return (inStr);
        }

        public function sendInfoOnChat(text:String):void
        {
            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, text, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp(), false);
        }


    }
} com.ankamagames.dofus.uiApi

