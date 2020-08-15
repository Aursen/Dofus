package Ankama_GameUiCore.ui
{
    import com.ankamagames.dofus.network.enums.PlayerStatusEnum;
    import com.ankamagames.dofus.uiApi.BindsApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.ChatApi;
    import com.ankamagames.dofus.uiApi.ChatServiceApi;
    import com.ankamagames.dofus.uiApi.ConfigApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import com.ankamagames.dofus.datacenter.servers.ServerLang;
    import com.ankamagames.dofus.logic.game.spin2.chat.ChatService;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.TextFieldScrollBar;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import d2hooks.ChatServer;
    import d2hooks.NewMessage;
    import d2hooks.ChatSendPreInit;
    import d2hooks.ChatServerWithObject;
    import d2hooks.ChatServerCopy;
    import d2hooks.ChatServerCopyWithObject;
    import d2hooks.ChatSpeakingItem;
    import d2hooks.TextActionInformation;
    import d2hooks.TextInformation;
    import d2hooks.EnabledChannels;
    import d2hooks.UpdateChatOptions;
    import d2hooks.ChatSmiley;
    import d2hooks.ChatFocus;
    import d2hooks.ChatFocusInterGame;
    import d2hooks.MouseShiftClick;
    import d2hooks.InsertHyperlink;
    import d2hooks.InsertRecipeHyperlink;
    import d2hooks.ChatHyperlink;
    import d2hooks.AddItemHyperlink;
    import d2hooks.LivingObjectMessage;
    import d2hooks.ChatWarning;
    import d2hooks.PopupWarning;
    import d2hooks.ChatLinkRelease;
    import d2hooks.EmoteEnabledListUpdated;
    import d2hooks.GameFightLeave;
    import d2hooks.GameFightJoin;
    import d2hooks.ClearChat;
    import d2hooks.ChatRollOverLink;
    import d2hooks.PlayerStatusUpdate;
    import d2hooks.InactivityNotification;
    import d2hooks.NewAwayMessage;
    import d2hooks.ChatCommunityChannelCommunity;
    import d2hooks.WindowResize;
    import d2hooks.ChatServiceChannelMessage;
    import d2hooks.ChatServiceUserUpdatedStatus;
    import d2hooks.ChatServiceUserFriendInviteResponse;
    import com.ankamagames.berilia.enums.EventEnums;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import flash.text.AntiAliasType;
    import flash.events.KeyboardEvent;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import d2actions.TabsUpdate;
    import d2actions.ChatLoaded;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.events.Event;
    import __AS3__.vec.Vector;
    import flash.text.StyleSheet;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.jerakine.enum.SocialCharacterCategoryEnum;
    import flash.geom.ColorTransform;
    import Ankama_GameUiCore.Api;
    import d2actions.ChannelEnabling;
    import d2actions.ChatCommunityChannelSetCommunity;
    import d2actions.OpenSmileys;
    import d2hooks.OpenStatusMenu;
    import d2actions.ChatTextOutput;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import flash.text.TextField;
    import flash.ui.Keyboard;
    import com.ankamagames.dofus.datacenter.communication.ChatChannel;
    import d2actions.ChatCommand;
    import d2actions.SaveMessage;
    import com.ankamagames.berilia.components.TextureBase;
    import d2actions.ClearChat;
    import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.MountWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.IdolsPresetWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
    import com.ankamagames.dofus.internalDatacenter.appearance.OrnamentWrapper;
    import com.ankamagames.berilia.components.MapViewer;
    import com.ankamagames.dofus.internalDatacenter.house.HavenbagFurnitureWrapper;
    import com.ankamagames.dofus.internalDatacenter.userInterface.ButtonWrapper;
    import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
    import com.ankamagames.dofus.internalDatacenter.communication.SmileyWrapper;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.dofus.datacenter.quest.Achievement;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.GuildFactSheetWrapper;
    import com.ankamagames.dofus.internalDatacenter.appearance.TitleWrapper;
    import com.ankamagames.dofus.internalDatacenter.dare.DareWrapper;
    import d2actions.PlayerStatusUpdateRequest;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import __AS3__.vec.*;
    import d2hooks.*;
    import d2actions.*;

    public class Chat 
    {

        private static var _shortcutColor:String;
        private static const SMALL_SIZE:uint = 14;
        private static const MEDIUM_SIZE:uint = 16;
        private static const LARGE_SIZE:uint = 18;
        private static const CHAT_MAXIMUM_HEIGHT:uint = 980;
        private static const CHAT_MEDIUM_HEIGHT:uint = 400;
        private static const CHAT_MINIMUM_HEIGHT:uint = 115;
        private static const CHAT_TOLERATED_DIFFERENCE_HEIGHT:uint = 30;
        private static const ITEM_INDEX_CODE:String = String.fromCharCode(65532);
        private static const SPLIT_CODE:String = String.fromCharCode(65533);
        private static const MAX_CHAT_ITEMS:int = 16;
        private static const LINK_CONTENT_REGEXP:RegExp = /<a.*?>\s*(.*?)\s*<\/a>/g;
        private static var _currentStatus:int = PlayerStatusEnum.PLAYER_STATUS_AVAILABLE;//10
        private static const USER_STATUS_AWAY:String = "Away";
        private static const USER_STATUS_BUSY:String = "Busy";
        private static const USER_STATUS_AVAILABLE:String = "Available";

        public var output:Object;
        [Api(name="BindsApi")]
        public var bindsApi:BindsApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="ChatApi")]
        public var chatApi:ChatApi;
        [Api(name="ChatServiceApi")]
        public var chatServiceApi:ChatServiceApi;
        [Api(name="ConfigApi")]
        public var configApi:ConfigApi;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        private var _aChannels:Array;
        private var _aTabs:Object;
        private var _aTabsPicto:Array;
        private var _aMiscReplacement:Array = [];
        private var _aItemReplacement:Array = [];
        private var _dItemIndex:Dictionary = new Dictionary();
        private var _dGenericItemIndex:Dictionary = new Dictionary();
        private var _maxCmdHistoryIndex:uint = 100;
        private var _aHistory:Array;
        private var _nHistoryIndex:int = 0;
        private var _privateHistory:PrivateHistory;
        private var _nCurrentTab:uint = 0;
        private var _tabsCache:Dictionary = new Dictionary();
        private var _refreshingTab:int = -1;
        private var _sFrom:String;
        private var _sTo:String;
        private var _sChan:String = "/s";
        private var _sChanLocked:String = "/s";
        private var _sChanLockedBeforeSpec:String = "/s";
        private var _sLastChan:String;
        private var _sDest:String;
        private var _sText:String;
        private var _sCssClass:String = "p0";
        private var _focusTimer:Timer = new Timer(1, 1);
        private var _currentChatHeightMode:uint = 0;
        private var _smileyOpened:Boolean = false;
        private var _emoteOpened:Boolean = false;
        private var _bCurrentChannelSelected:Boolean = false;
        private var _aTxHighlights:Array;
        private var _aBtnTabs:Array;
        private var _nFontSize:uint;
        private var _iconsPath:String;
        private var _autocompletionCount:int = 0;
        private var _autocompletionLastCompletion:String = null;
        private var _autocompletionSubString:String = null;
        private var _unreadMessagesCount:int;
        private var _communityChannelLangs:Array;
        private var _currentCommunityLang:ServerLang;
        private var _init:Boolean;
        private var _mainDone:Boolean = false;
        private var _splittedContent:String = "";
        private var _tabIconsPath:String;
        public var _awayMessage:String = "";
        public var _idle:Boolean = false;
        private var _currentMainCtrHeight:Number;
        private var _currentMainCtrWidth:Number;
        private var _msgQueueTimer:Timer = new Timer(50, 1);
        private var _commonStrings:Dictionary;
        private var _chatService:ChatService;
        public var tx_background:GraphicContainer;
        public var mainCtr:GraphicContainer;
        public var inp_tchatinput:Input;
        public var tx_newMessages:Texture;
        private var lbl_chat:Label;
        public var tfsb_scrollBar:TextFieldScrollBar;
        public var btn_menu:ButtonContainer;
        public var btn_plus:ButtonContainer;
        public var btn_minus:ButtonContainer;
        public var btn_smiley:ButtonContainer;
        public var btn_tab0:ButtonContainer;
        public var btn_tab1:ButtonContainer;
        public var btn_tab2:ButtonContainer;
        public var btn_tab3:ButtonContainer;
        public var tx_tab0:Texture;
        public var tx_tab1:Texture;
        public var tx_tab2:Texture;
        public var tx_tab3:Texture;
        public var tx_arrow_btn_menu:Texture;
        public var iconTexturebtn_status:TextureBitmap;
        public var btn_status:ButtonContainer;


        public function main(args:Array):void
        {
            var c:*;
            var iPicto:uint;
            var modifiedNames:Boolean;
            var tabNames:Object;
            var name:*;
            var canal:*;
            var langId:int;
            var lang:ServerLang;
            var obj:*;
            this._chatService = this.chatServiceApi.service;
            this.btn_plus.soundId = SoundEnum.WINDOW_OPEN;
            this.btn_minus.soundId = SoundEnum.WINDOW_OPEN;
            this.btn_menu.soundId = SoundEnum.WINDOW_OPEN;
            this.btn_smiley.soundId = SoundEnum.WINDOW_OPEN;
            this.sysApi.createHook("InsertHyperlink");
            this.sysApi.addHook(ChatServer, this.onChatServer);
            this.sysApi.addHook(NewMessage, this.onNewMessage);
            this.sysApi.addHook(ChatSendPreInit, this.onChatSendPreInit);
            this.sysApi.addHook(ChatServerWithObject, this.onChatServerWithObject);
            this.sysApi.addHook(ChatServerCopy, this.onChatServerCopy);
            this.sysApi.addHook(ChatServerCopyWithObject, this.onChatServerCopyWithObject);
            this.sysApi.addHook(ChatSpeakingItem, this.onChatSpeakingItem);
            this.sysApi.addHook(TextActionInformation, this.onTextActionInformation);
            this.sysApi.addHook(TextInformation, this.onTextInformation);
            this.sysApi.addHook(EnabledChannels, this.onEnabledChannels);
            this.sysApi.addHook(UpdateChatOptions, this.onUpdateChatOptions);
            this.sysApi.addHook(ChatSmiley, this.onChatSmiley);
            this.sysApi.addHook(ChatFocus, this.onChatFocus);
            this.sysApi.addHook(ChatFocusInterGame, this.onChatFocusInterGame);
            this.sysApi.addHook(MouseShiftClick, this.onMouseShiftClick);
            this.sysApi.addHook(InsertHyperlink, this.onInsertHyperlink);
            this.sysApi.addHook(InsertRecipeHyperlink, this.onInsertRecipeHyperlink);
            this.sysApi.addHook(ChatHyperlink, this.onChatHyperlink);
            this.sysApi.addHook(AddItemHyperlink, this.onInsertHyperlink);
            this.sysApi.addHook(LivingObjectMessage, this.onLivingObjectMessage);
            this.sysApi.addHook(ChatWarning, this.onChatWarning);
            this.sysApi.addHook(PopupWarning, this.onPopupWarning);
            this.sysApi.addHook(ChatLinkRelease, this.onChatLinkRelease);
            this.sysApi.addHook(EmoteEnabledListUpdated, this.onEmoteEnabledListUpdated);
            this.sysApi.addHook(GameFightLeave, this.onGameFightLeave);
            this.sysApi.addHook(GameFightJoin, this.onGameFightJoin);
            this.sysApi.addHook(d2hooks.ClearChat, this.onClearChat);
            this.sysApi.addHook(ChatRollOverLink, this.onChatRollOverLink);
            this.sysApi.addHook(PlayerStatusUpdate, this.onPlayerStatusUpdate);
            this.sysApi.addHook(InactivityNotification, this.onInactivityNotification);
            this.sysApi.addHook(NewAwayMessage, this.onNewAwayMessage);
            this.sysApi.addHook(ChatCommunityChannelCommunity, this.onChatCommunityChannelCommunity);
            this.sysApi.addHook(WindowResize, this.onWindowResize);
            this.sysApi.addHook(ChatServiceChannelMessage, this.onUserMessage);
            this.sysApi.addHook(ChatServiceUserUpdatedStatus, this.onLauncherStatusChange);
            this.sysApi.addHook(ChatServiceUserFriendInviteResponse, this._chatService.processUserFriendInvite);
            this.uiApi.addComponentHook(this.btn_tab0, EventEnums.EVENT_ONROLLOVER);
            this.uiApi.addComponentHook(this.btn_tab0, EventEnums.EVENT_ONROLLOUT);
            this.uiApi.addComponentHook(this.btn_tab0, EventEnums.EVENT_ONRIGHTCLICK);
            this.uiApi.addComponentHook(this.btn_tab1, EventEnums.EVENT_ONROLLOVER);
            this.uiApi.addComponentHook(this.btn_tab1, EventEnums.EVENT_ONROLLOUT);
            this.uiApi.addComponentHook(this.btn_tab1, EventEnums.EVENT_ONRIGHTCLICK);
            this.uiApi.addComponentHook(this.btn_tab2, EventEnums.EVENT_ONROLLOVER);
            this.uiApi.addComponentHook(this.btn_tab2, EventEnums.EVENT_ONROLLOUT);
            this.uiApi.addComponentHook(this.btn_tab2, EventEnums.EVENT_ONRIGHTCLICK);
            this.uiApi.addComponentHook(this.btn_tab3, EventEnums.EVENT_ONROLLOVER);
            this.uiApi.addComponentHook(this.btn_tab3, EventEnums.EVENT_ONROLLOUT);
            this.uiApi.addComponentHook(this.btn_tab3, EventEnums.EVENT_ONRIGHTCLICK);
            this.uiApi.addComponentHook(this.btn_status, EventEnums.EVENT_ONROLLOVER);
            this.uiApi.addComponentHook(this.btn_status, EventEnums.EVENT_ONROLLOUT);
            this.uiApi.addComponentHook(this.btn_status, EventEnums.EVENT_ONRELEASE);
            this.uiApi.addComponentHook(this.tx_newMessages, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_newMessages, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_newMessages, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_smiley, EventEnums.EVENT_ONROLLOVER);
            this.uiApi.addComponentHook(this.btn_smiley, EventEnums.EVENT_ONROLLOUT);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.HISTORY_UP, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.HISTORY_DOWN, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SHIFT_UP, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SHIFT_DOWN, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SHIFT_VALID, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.ALT_VALID, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CTRL_VALID, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.EXTEND_CHAT, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.EXTEND_CHAT2, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SHRINK_CHAT, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_EMOTES, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_ATTITUDES, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_TAB_0, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_TAB_1, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_TAB_2, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_TAB_3, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.NEXT_CHAT_TAB, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PREVIOUS_CHAT_TAB, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_AUTOCOMPLETE, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_GLOBAL, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_TEAM, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_GUILD, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_ALLIANCE, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_PARTY, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_ARENA, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_SALES, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_SEEK, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_FIGHT, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SWITCH_TEXT_SIZE, this.onShortcut, true);
            this.uiApi.addShortcutHook("focusChat", this.onShortcut);
            this._commonStrings = new Dictionary();
            this._commonStrings["ui.chat.channel.information"] = (("(" + this.uiApi.getText("ui.chat.channel.information")) + ") ");
            this._commonStrings["ui.common.fight"] = (("(" + this.uiApi.getText("ui.common.fight")) + ") ");
            this._commonStrings["ui.chat.channel.important"] = (("(" + this.uiApi.getText("ui.chat.channel.important")) + ") ");
            this._commonStrings["ui.common.colon"] = this.uiApi.getText("ui.common.colon");
            this._commonStrings["ui.chat.think"] = this.uiApi.getText("ui.chat.think");
            if (this.sysApi.getCurrentLanguage() == "ja")
            {
                this.inp_tchatinput.useEmbedFonts = false;
            };
            this._focusTimer.addEventListener(TimerEvent.TIMER, this.onFocusTimer);
            this._communityChannelLangs = [];
            var serverLangs:Object = this.sysApi.getCurrentServer().community.supportedLangIds;
            if (serverLangs.length > 1)
            {
                for each (langId in serverLangs)
                {
                    lang = this.dataApi.getServerLang(langId);
                    this._communityChannelLangs.push(lang);
                };
            };
            this._currentCommunityLang = this.dataApi.getServerLang(this.chatApi.getLangIdForCommunityChannel());
            var uiRootContainer:* = this.uiApi.me();
            this._tabIconsPath = uiRootContainer.getConstant("tab_uri");
            this._sFrom = this.uiApi.getText("ui.chat.from");
            this._sTo = this.uiApi.getText("ui.chat.to");
            this._aHistory = this.sysApi.getData("aTchatHistory");
            if (this._aHistory == null)
            {
                this._aHistory = [];
            };
            this._nHistoryIndex = this._aHistory.length;
            this._privateHistory = new PrivateHistory(this._maxCmdHistoryIndex);
            this.inp_tchatinput.html = false;
            this.inp_tchatinput.maxChars = ProtocolConstantsEnum.USER_MAX_CHAT_LEN;
            this.inp_tchatinput.antialias = AntiAliasType.ADVANCED;
            this.inp_tchatinput.textfield.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            this._aTxHighlights = [this.tx_tab0, this.tx_tab1, this.tx_tab2, this.tx_tab3];
            this._aBtnTabs = [this.btn_tab0, this.btn_tab1, this.btn_tab2, this.btn_tab3];
            var tmpChanel:Object = this.chatApi.getChannelsId();
            this._aChannels = [];
            for each (c in tmpChanel)
            {
                if (((c == ChatActivableChannelsEnum.CHANNEL_COMMUNITY) && (this._communityChannelLangs.length <= 1)))
                {
                }
                else
                {
                    this._aChannels.push(c);
                };
            };
            this.setTabsChannels();
            this._aTabsPicto = [];
            iPicto = 0;
            modifiedNames = false;
            tabNames = this.sysApi.getOption("tabsNames", "chat");
            for each (name in tabNames)
            {
                if (!Number(name))
                {
                    name = iPicto;
                    modifiedNames = true;
                };
                this._aTabsPicto.push(name);
                uiRootContainer.getElement(("iconTexture" + this._aBtnTabs[iPicto].name)).uri = this.uiApi.createUri(((this._tabIconsPath + name) + ".png"));
                this[("tx_tab" + iPicto)].uri = this.uiApi.createUri((((this._tabIconsPath + "hl_") + name) + ".png"));
                iPicto++;
            };
            if (modifiedNames)
            {
                this.sysApi.sendAction(new TabsUpdate(null, this._aTabsPicto));
            };
            this.uiApi.setRadioGroupSelectedItem("tabChatGroup", this.btn_tab0, this.uiApi.me());
            this._init = true;
            this.init();
            this.initChatUi();
            this._msgQueueTimer.addEventListener(TimerEvent.TIMER, this.resizeAndScroll);
            this.onUpdateChatOptions();
            this.sysApi.sendAction(new ChatLoaded());
            for each (canal in this._aChannels)
            {
                if (canal != ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG)
                {
                    this.lbl_chat.setCssColor(("#" + this.sysApi.getOption(("channelColor" + canal), "chat").toString(16)), ("p" + canal));
                };
            };
            if (args)
            {
                this.onEnabledChannels(args[0]);
                if (((args[1]) && (!(args[1].length == 0))))
                {
                    for each (obj in args[1])
                    {
                        this.onTextInformation(obj.content, obj.channel, obj.timestamp, obj.saveMsg);
                    };
                };
            };
            this._iconsPath = uiRootContainer.getConstant("icons_uri");
            this.chatApi.setExternalChatChannels(this._aTabs[this._nCurrentTab]);
            this._init = false;
            this._currentMainCtrHeight = this.sysApi.getSetData("currentMainCtrHeight", this.mainCtr.height, DataStoreEnum.BIND_COMPUTER);
            this._currentChatHeightMode = this.sysApi.getData("currentChatHeightMode", DataStoreEnum.BIND_COMPUTER);
            this.resizeToPos(this._currentChatHeightMode);
            this._mainDone = true;
        }

        public function unload():void
        {
            if (this._focusTimer)
            {
                this._focusTimer.removeEventListener(TimerEvent.TIMER, this.onFocusTimer);
            };
            if (((this.inp_tchatinput) && (this.inp_tchatinput.textfield)))
            {
                this.inp_tchatinput.textfield.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            };
        }

        public function renderUpdate():void
        {
            if (!this._mainDone)
            {
                return;
            };
            if (this._currentMainCtrWidth != this.mainCtr.width)
            {
                this._currentMainCtrWidth = this.mainCtr.width;
            };
            this.resizeAndScroll();
            if ((((this._currentMainCtrHeight == this.mainCtr.height) || (this.mainCtr.height <= (CHAT_MINIMUM_HEIGHT + CHAT_TOLERATED_DIFFERENCE_HEIGHT))) || (this.mainCtr.height >= (CHAT_MAXIMUM_HEIGHT - CHAT_TOLERATED_DIFFERENCE_HEIGHT))))
            {
                return;
            };
            this._currentMainCtrHeight = this.mainCtr.height;
            this.sysApi.setData("currentMainCtrHeight", this._currentMainCtrHeight, DataStoreEnum.BIND_COMPUTER);
            this._currentChatHeightMode = 1;
            this.sysApi.setData("currentChatHeightMode", this._currentChatHeightMode, DataStoreEnum.BIND_COMPUTER);
            this.mainCtr.setSavedDimension(this.mainCtr.width, this.mainCtr.height);
            this.mainCtr.setSavedPosition(this.mainCtr.x, this.mainCtr.y);
        }

        public function resize(way:int=1):void
        {
            if (((way == -1) && (this._currentChatHeightMode == 0)))
            {
                this.resizeToPos(2);
            }
            else
            {
                this.resizeToPos(((this._currentChatHeightMode + way) % 3));
            };
        }

        public function resizeToPos(pos:int=-1):void
        {
            var xChat:Number;
            var oldMainCtrHeight:int = this.mainCtr.height;
            if (pos < 0)
            {
                pos = ((this._currentChatHeightMode + 1) % 3);
            };
            var visibleStageBounds:Rectangle = this.uiApi.getVisibleStageBounds();
            if (pos == 1)
            {
                if (this._currentMainCtrHeight == CHAT_MINIMUM_HEIGHT)
                {
                    this._currentMainCtrHeight = CHAT_MEDIUM_HEIGHT;
                };
                this.mainCtr.height = this._currentMainCtrHeight;
                this._currentChatHeightMode = 1;
                this.btn_plus.selected = false;
            }
            else
            {
                if (pos == 2)
                {
                    this.mainCtr.height = CHAT_MAXIMUM_HEIGHT;
                    this._currentChatHeightMode = 2;
                    this.btn_plus.selected = true;
                }
                else
                {
                    this.mainCtr.height = CHAT_MINIMUM_HEIGHT;
                    this._currentChatHeightMode = 0;
                    this.btn_plus.selected = false;
                };
            };
            var oldMainCtrPosition:Point = this.mainCtr.getSavedPosition();
            if (oldMainCtrPosition)
            {
                this.mainCtr.yNoCache = ((oldMainCtrPosition.y - this.mainCtr.height) + oldMainCtrHeight);
                xChat = oldMainCtrPosition.x;
            }
            else
            {
                this.mainCtr.yNoCache = (visibleStageBounds.height - this.mainCtr.height);
                xChat = this.mainCtr.x;
            };
            this.sysApi.setData("currentChatHeightMode", this._currentChatHeightMode, DataStoreEnum.BIND_COMPUTER);
            this.mainCtr.setSavedDimension(this.mainCtr.width, this.mainCtr.height);
            this.mainCtr.setSavedPosition(xChat, this.mainCtr.y);
            var uiRootContainer:* = this.uiApi.me();
            uiRootContainer.render();
            this.tx_newMessages.visible = false;
            this.tx_newMessages.handCursor = true;
            this._unreadMessagesCount = 0;
        }

        public function sendMessage(txt:String):void
        {
            this.inp_tchatinput.text = txt;
            this.chanSearch(txt);
            this.inp_tchatinput.focus();
            this.validUiShortcut();
        }

        private function resizeAndScroll(e:Event=null, forceResize:Boolean=false):void
        {
            if (this.lbl_chat.text == "")
            {
                this.tfsb_scrollBar.updateScrolling();
            };
            if (forceResize)
            {
                this.tfsb_scrollBar.lines = this._tabsCache[this._nCurrentTab].texts;
            };
            this.tfsb_scrollBar.resize((this.tx_background.width - 38), (this.tx_background.height - 30));
            this.tfsb_scrollBar.updateScrolling();
            if (this._msgQueueTimer.running)
            {
                this._msgQueueTimer.reset();
            };
        }

        private function appendLines(newTexts:Array, channel:uint):void
        {
            var tab:uint;
            var text:String;
            for each (text in newTexts)
            {
                for each (tab in this.getChannelTabs(channel))
                {
                    if (((this._refreshingTab == -1) || (tab == this._refreshingTab)))
                    {
                        if (!this._tabsCache[tab])
                        {
                            this._tabsCache[tab] = new TabCache();
                        };
                        this._tabsCache[tab].texts.push(text);
                        if (this._tabsCache[tab].texts.length > this.chatApi.getMaxMessagesStored())
                        {
                            if (tab == this._nCurrentTab)
                            {
                                this.tfsb_scrollBar.removeLastText();
                            }
                            else
                            {
                                this._tabsCache[tab].texts.shift();
                            };
                        };
                        if (tab == this._nCurrentTab)
                        {
                            this.tfsb_scrollBar.addTextLength(text);
                            if (!this.tfsb_scrollBar.isAtEnd())
                            {
                                this.tx_newMessages.visible = true;
                                this._unreadMessagesCount++;
                            }
                            else
                            {
                                this.tx_newMessages.visible = false;
                                this._unreadMessagesCount = 0;
                            };
                        };
                    };
                };
            };
            if (!this._msgQueueTimer.running)
            {
                this._msgQueueTimer.start();
            };
        }

        private function displayMessage(channel:uint=0, content:String="", timestamp:Number=0, fingerprint:String="", senderId:Number=0, senderPrefix:String="", senderName:String="", objects:Object=null, receiverName:String="", receiverId:Number=0, livingObject:Boolean=false, admin:Boolean=false, forceDisplay:Boolean=false, account:Boolean=false):void
        {
            var msg:Dictionary = new Dictionary();
            msg["channel"] = channel;
            msg["content"] = content;
            msg["timestamp"] = timestamp;
            msg["fingerprint"] = fingerprint;
            msg["senderId"] = senderId;
            msg["senderPrefix"] = senderPrefix;
            msg["senderName"] = senderName;
            msg["objects"] = objects;
            msg["receiverName"] = receiverName;
            msg["receiverId"] = receiverId;
            msg["livingObject"] = livingObject;
            msg["admin"] = admin;
            msg["forceDisplay"] = forceDisplay;
            msg["account"] = account;
            this.addTextToChats(msg);
        }

        private function getChannelTabs(pChannelId:uint):Vector.<uint>
        {
            var tab:*;
            var chan:*;
            var tabs:Vector.<uint> = new Vector.<uint>(0);
            if (pChannelId == this.chatApi.getRedChannelId())
            {
                for (tab in this._aTabs)
                {
                    tabs.push(tab);
                };
            }
            else
            {
                for (tab in this._aTabs)
                {
                    for each (chan in this._aTabs[tab])
                    {
                        if (chan == pChannelId)
                        {
                            tabs.push(tab);
                        };
                    };
                };
            };
            return (tabs);
        }

        private function setTabsChannels():void
        {
            var iTab:int;
            var tabs:*;
            var temp:Array;
            var chan:*;
            this._aTabs = [];
            iTab = 0;
            while (iTab < 4)
            {
                tabs = this.sysApi.getOption("channelTabs", "chat")[iTab];
                temp = [];
                if (tabs)
                {
                    for each (chan in tabs)
                    {
                        if (((this.chatApi.getDisallowedChannelsId()) && (this.chatApi.getDisallowedChannelsId().indexOf(chan) == -1)))
                        {
                            temp.push(chan);
                        };
                    };
                };
                this._aTabs.push(temp);
                iTab++;
            };
        }

        private function textOutput():void
        {
            var dest:String = "";
            if (this._sDest.length > 0)
            {
                dest = (this._sDest + " ");
            };
            var textToSave:String = (((this._sChan + " ") + dest) + this._sText);
            this.addToHistory(textToSave);
            if (this._sDest.length > 0)
            {
                this._privateHistory.addName(this._sDest);
            };
        }

        private function addToHistory(msg:String):void
        {
            msg = this.trim(msg);
            var hisLength:uint = this._aHistory.length;
            if (((!(hisLength)) || (!(msg == this._aHistory[(hisLength - 1)]))))
            {
                this._aHistory.push(msg);
                if ((hisLength + 1) > this._maxCmdHistoryIndex)
                {
                    this._aHistory = this._aHistory.slice(((hisLength + 10) - this._maxCmdHistoryIndex), (hisLength + 1));
                };
                this._nHistoryIndex = (this._aHistory.length - 1);
                this.sysApi.setData("_nHistoryIndex ", this._nHistoryIndex);
                this.sysApi.setData("aTchatHistory", this._aHistory);
            };
            this._nHistoryIndex++;
        }

        private function chanSearch(input:String):void
        {
            var chan:String;
            if (input.toLocaleLowerCase().indexOf(this._sChan) != 0)
            {
                if (input.charAt(0) == "/")
                {
                    chan = input.toLocaleLowerCase().substring(0, input.indexOf(" "));
                }
                else
                {
                    chan = this._sChanLocked;
                };
                if (this.sysApi.getOption("channelLocked", "chat"))
                {
                    this.changeDefaultChannel(chan);
                }
                else
                {
                    this.changeCurrentChannel(chan);
                };
            };
        }

        private function init():void
        {
            this._sDest = "";
            this._sText = "";
            this.changeCurrentChannel(this._sChanLocked);
        }

        private function initChatUi():void
        {
            this.lbl_chat = (this.uiApi.createComponent("Label") as Label);
            this.lbl_chat.multiline = true;
            this.lbl_chat.wordWrap = true;
            this.lbl_chat.textfield.mouseWheelEnabled = false;
            this.lbl_chat.useEmbedFonts = false;
            this.lbl_chat.x = 18;
            this.lbl_chat.y = 26;
            this.lbl_chat.hyperlinkEnabled = true;
            this.lbl_chat.dropValidator = this.dropValidator;
            this.lbl_chat.processDrop = this.processDrop;
            this.lbl_chat.selectable = true;
            this.lbl_chat.cacheAsBitmap = true;
            this.lbl_chat.setStyleSheet((this.chatApi.getChatStyle() as StyleSheet));
            this._tabsCache[this._nCurrentTab] = new TabCache();
            this.tfsb_scrollBar.initProperties(this.lbl_chat, this._tabsCache[this._nCurrentTab].texts, 2, this.sysApi.getConfigEntry("colors.scrollbar.bg"), this.sysApi.getConfigEntry("colors.scrollbar.bar"), true);
            this.lbl_chat.addEventListener(Event.CHANGE, this.onTextFieldChange);
            var initSize:uint = this.configApi.getConfigProperty("chat", "chatFontSize");
            if ((((initSize == MEDIUM_SIZE) || (initSize == SMALL_SIZE)) || (initSize == LARGE_SIZE)))
            {
                this.textResize(initSize);
            }
            else
            {
                this.textResize(MEDIUM_SIZE);
            };
            this.uiApi.addChild(this.mainCtr, this.tfsb_scrollBar);
            this.uiApi.addChildAt(this.mainCtr, this.lbl_chat, (this.mainCtr.getChildIndex(this.tfsb_scrollBar) + 1));
            this.resizeAndScroll();
            this.tfsb_scrollBar.updateScrolling();
        }

        private function onTextFieldChange(e:Event):void
        {
            this.tx_newMessages.visible = (!((this.tfsb_scrollBar.isAtEnd()) && (this.tx_newMessages.visible)));
            this._unreadMessagesCount = 0;
        }

        private function addTimeToText(inValue:String, inTime:Number):String
        {
            if (this.sysApi.getOption("showTime", "chat"))
            {
                inValue = ((("[" + this.timeApi.getClock(inTime, true)) + "] ") + inValue);
            };
            return (inValue);
        }

        private function textResize(size:uint):void
        {
            if (this._nFontSize != size)
            {
                this._nFontSize = size;
                this.configApi.setConfigProperty("chat", "chatFontSize", size);
                this.tfsb_scrollBar.setFontSize(size);
            };
            this.resizeAndScroll();
        }

        private function formatLine(channel:uint=0, content:String="", timestamp:Number=0, fingerprint:String="", senderId:Number=0, senderPrefix:String="", senderName:String="", objects:Object=null, receiverName:String="", receiverId:Number=0, livingObject:Boolean=false, admin:Boolean=false, account:Boolean=false):Dictionary
        {
            var numItem:int;
            var i:int;
            var item:ItemWrapper;
            var index:int;
            var prefix:String;
            var channelLang:String;
            var channelClass:String;
            var channelName:String;
            var shortcut:String;
            var senderBaseName:String = (((account) ? "*" : "") + senderName);
            if (((content) && (content.length > 1)))
            {
                content = this.chatApi.unEscapeChatString(content);
            };
            if (content.indexOf(SPLIT_CODE) != -1)
            {
                if (content.length > 1)
                {
                    this._splittedContent = (this._splittedContent + content.substr(0, (content.length - 1)));
                    return (null);
                };
                content = this._splittedContent;
                this._splittedContent = "";
            }
            else
            {
                this._splittedContent = "";
            };
            if (objects)
            {
                numItem = objects.length;
                i = 0;
                while (i < numItem)
                {
                    item = objects[i];
                    index = content.indexOf(ITEM_INDEX_CODE);
                    if (index == -1)
                    {
                        break;
                    };
                    content = ((content.substr(0, index) + this.chatApi.newChatItem(item)) + content.substr((index + 1)));
                    i++;
                };
            };
            var textToShow:String = "";
            var classCss:String = ("p" + channel);
            if (receiverName == "")
            {
                if (senderName == "")
                {
                    prefix = "";
                    if (channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO)
                    {
                        prefix = this._commonStrings["ui.chat.channel.information"];
                    }
                    else
                    {
                        if (channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG)
                        {
                            prefix = this._commonStrings["ui.common.fight"];
                            channel = ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO;
                        };
                    };
                    if (channel == this.chatApi.getRedChannelId())
                    {
                        prefix = this._commonStrings["ui.chat.channel.important"];
                        classCss = "p";
                    }
                    else
                    {
                        classCss = ("p" + channel);
                    };
                    if (this.sysApi.getOption("showInfoPrefix", "chat"))
                    {
                        textToShow = (prefix + content);
                    }
                    else
                    {
                        textToShow = content;
                    };
                }
                else
                {
                    if (((!(livingObject)) && (!(senderId == 0))))
                    {
                        senderName = ((((((account) ? ((((("{account," + senderName) + ",") + senderId) + ",") + SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA) : ((((((((("{player," + escape(senderName)) + ",") + senderId) + ",") + timestamp) + ",") + fingerprint) + ",") + channel)) + "::<b>") + ((senderPrefix != "") ? (senderPrefix + " ") : "")) + senderName) + "</b>}");
                    };
                    if (((!(this.dataApi.getChatChannel(channel).isPrivate)) && (!(channel == ChatActivableChannelsEnum.CHANNEL_GLOBAL))))
                    {
                        channelLang = "";
                        if (channel == ChatActivableChannelsEnum.CHANNEL_COMMUNITY)
                        {
                            if (!this._currentCommunityLang)
                            {
                                this._currentCommunityLang = this.dataApi.getServerLang(this.chatApi.getLangIdForCommunityChannel());
                            };
                            if (!this._currentCommunityLang)
                            {
                                this.sysApi.log(16, "Probleme récupération canal communautaire");
                                channelLang = (channelLang + this.sysApi.getConfigEntry("config.lang.current"));
                            }
                            else
                            {
                                channelLang = (channelLang + this._currentCommunityLang.langCode.toLocaleUpperCase());
                            };
                        };
                        channelClass = ((admin) ? "p" : ("p" + channel));
                        if (!this.sysApi.getOption("showShortcut", "chat"))
                        {
                            channelName = this.dataApi.getChatChannel(channel).name;
                            if (channel == ChatActivableChannelsEnum.CHANNEL_COMMUNITY)
                            {
                                channelName = (channelName + (" " + channelLang));
                            };
                            textToShow = ((((("(" + channelName) + ") ") + senderName) + this._commonStrings["ui.common.colon"]) + content);
                            classCss = channelClass;
                        }
                        else
                        {
                            shortcut = this.dataApi.getChatChannel(channel).shortcut;
                            if (channel == ChatActivableChannelsEnum.CHANNEL_COMMUNITY)
                            {
                                shortcut = (shortcut + (" " + channelLang));
                            };
                            textToShow = ((((("(" + shortcut) + ") ") + senderName) + this._commonStrings["ui.common.colon"]) + content);
                            classCss = channelClass;
                        };
                    }
                    else
                    {
                        if (channel == ChatActivableChannelsEnum.CHANNEL_GLOBAL)
                        {
                            if (content.substr(0, 4).toLowerCase() == "/me")
                            {
                                content = content.substr(3);
                                textToShow = ((((senderName + this._commonStrings["ui.common.colon"]) + " <i>") + content) + "</i>");
                                classCss = ("p" + channel);
                            }
                            else
                            {
                                if (content.substr(0, 6).toLowerCase() == "/think")
                                {
                                    content = content.substr(7);
                                    textToShow = ((((((senderName + " ") + this._commonStrings["ui.chat.think"]) + this._commonStrings["ui.common.colon"]) + "<i>") + content) + "</i>");
                                    classCss = ("p" + channel);
                                }
                                else
                                {
                                    if ((((content.length > 1) && (content.charAt(0) == "*")) && (content.charAt((content.length - 1)) == "*")))
                                    {
                                        content = content.substr(1, (content.length - 2));
                                        textToShow = (((("<i>" + senderName) + " ") + content) + "</i>");
                                        classCss = ("p" + channel);
                                    }
                                    else
                                    {
                                        if (content.substr(0, 3).toLowerCase() == "/me")
                                        {
                                            content = content.substr(4);
                                            textToShow = (((("<i>" + senderName) + " ") + content) + "</i>");
                                            classCss = ("p" + channel);
                                        }
                                        else
                                        {
                                            textToShow = ((senderName + this._commonStrings["ui.common.colon"]) + content);
                                            classCss = ("p" + channel);
                                        };
                                    };
                                };
                            };
                        }
                        else
                        {
                            if (senderName != "")
                            {
                                if (!livingObject)
                                {
                                    this._privateHistory.addName(senderBaseName);
                                };
                                textToShow = ((((this._sFrom + " ") + senderName) + this._commonStrings["ui.common.colon"]) + content);
                            };
                        };
                    };
                };
            }
            else
            {
                textToShow = ((((((this._sTo + ((account) ? (((((" {account," + receiverName) + ",") + receiverId) + ",") + SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA) : (((" {player," + receiverName) + ",") + receiverId))) + "::<b>") + receiverName) + "</b>}") + this._commonStrings["ui.common.colon"]) + content);
            };
            var messageDetails:Dictionary = new Dictionary();
            messageDetails["textToShow"] = textToShow;
            messageDetails["classCss"] = classCss;
            return (messageDetails);
        }

        private function addTextToChats(message:Dictionary):void
        {
            var newTexts:Array;
            var i:int;
            var externalChatChannels:Object;
            var result:Object;
            var noLinksText:String;
            var messageDetails:Dictionary = this.formatLine(message["channel"], message["content"], message["timestamp"], message["fingerprint"], message["senderId"], message["senderPrefix"], message["senderName"], message["objects"], message["receiverName"], message["receiverId"], message["livingObject"], message["admin"], message["account"]);
            if (!messageDetails)
            {
                return;
            };
            if (messageDetails["textToShow"] != "")
            {
                newTexts = messageDetails["textToShow"].split("\n");
                i = 0;
                while (i < newTexts.length)
                {
                    newTexts[i] = (((("<span class='" + messageDetails["classCss"]) + "'>") + this.addTimeToText(newTexts[i], message["timestamp"])) + "</span>");
                    i++;
                };
                this.appendLines(newTexts, message["channel"]);
                if (this._refreshingTab == -1)
                {
                    externalChatChannels = this.sysApi.getOption("externalChatEnabledChannels", "chat");
                    if (((!(externalChatChannels.indexOf(message["channel"]) == -1)) || (message["channel"] == this.chatApi.getRedChannelId())))
                    {
                        result = LINK_CONTENT_REGEXP.exec(messageDetails["textToShow"]);
                        noLinksText = messageDetails["textToShow"];
                        while (result)
                        {
                            noLinksText = noLinksText.replace(result[0], result[1]);
                            result = LINK_CONTENT_REGEXP.exec(messageDetails["textToShow"]);
                        };
                        this.chatApi.logChat(this.chatApi.getStaticHyperlink(noLinksText), messageDetails["classCss"]);
                    };
                };
            };
        }

        private function updateChanColor(channelId:int):void
        {
            var chanColor:int = this.sysApi.getOption(("channelColor" + channelId), "chat");
            var colorisation:ColorTransform = new ColorTransform();
            colorisation.color = chanColor;
            this.tx_arrow_btn_menu.transform.colorTransform = colorisation;
            this.inp_tchatinput.setCssColor(("#" + chanColor.toString(16)), ("p" + channelId));
        }

        private function changeCurrentChannel(chan:String, auto:Boolean=true):void
        {
            var channelId:int;
            if (this._sChan != chan)
            {
                channelId = this.chatApi.searchChannel(chan);
                if (channelId != -1)
                {
                    this._sCssClass = ("p" + channelId);
                    this._sLastChan = this._sChan;
                    this._sChan = chan;
                    if (!auto)
                    {
                        this._bCurrentChannelSelected = true;
                    };
                    this.updateChanColor(channelId);
                };
            };
        }

        private function changeDefaultChannel(chan:String):void
        {
            var channelId:int = this.chatApi.searchChannel(chan);
            if (channelId != -1)
            {
                this._sChanLocked = chan;
            };
            this.changeCurrentChannel(chan, false);
        }

        private function refreshTabCache(tab:uint):void
        {
            var channelToShow:*;
            var messageRed:*;
            var msg:*;
            var messageForThisChannel:*;
            if (tab == this._nCurrentTab)
            {
                this.tfsb_scrollBar.clear();
            }
            else
            {
                this._tabsCache[tab].texts.length = 0;
            };
            var messagesBuffer:Array = [];
            for each (channelToShow in this._aTabs[tab])
            {
                for each (messageForThisChannel in this.chatApi.getMessagesByChannel(channelToShow))
                {
                    messagesBuffer.push(messageForThisChannel);
                };
            };
            for each (messageRed in this.chatApi.getMessagesByChannel(this.chatApi.getRedChannelId()))
            {
                messagesBuffer.push(messageRed);
            };
            messagesBuffer.sortOn("id", Array.NUMERIC);
            if (messagesBuffer.length > this.chatApi.getMaxMessagesStored())
            {
                messagesBuffer.splice(0, (messagesBuffer.length - this.chatApi.getMaxMessagesStored()));
            };
            this._refreshingTab = tab;
            for each (msg in messagesBuffer)
            {
                switch (Api.chat.getTypeOfChatSentence(msg))
                {
                    case "basicSentence":
                        this.displayMessage(msg.channel, msg.msg, msg.timestamp, msg.fingerprint);
                        break;
                    case "sourceSentence":
                        this.displayMessage(msg.channel, msg.msg, msg.timestamp, msg.fingerprint, msg.senderId, msg.prefix, msg.senderName, msg.objects, "", 0, false, msg.admin);
                        break;
                    case "recipientSentence":
                        this.displayMessage(msg.channel, msg.msg, msg.timestamp, msg.fingerprint, msg.senderId, msg.prefix, msg.senderName, msg.objects, msg.receiverName, msg.receiverId);
                        break;
                    case "informationSentence":
                        this.displayMessage(msg.channel, msg.msg, msg.timestamp, msg.fingerprint);
                        break;
                };
            };
            this._refreshingTab = -1;
            if (tab == this._nCurrentTab)
            {
                this.tfsb_scrollBar.updateScrolling();
            };
        }

        private function changeDisplayChannel(channel:Object, tab:int):void
        {
            if (this._aTabs[tab].indexOf(channel.id) == -1)
            {
                if (this.howManyTimesIsThisChannelUsed(channel.id) == 0)
                {
                    this.sysApi.sendAction(new ChannelEnabling(channel.id, true));
                };
                this._aTabs[tab].push(channel.id);
            }
            else
            {
                if (this.howManyTimesIsThisChannelUsed(channel.id) == 1)
                {
                    this.sysApi.sendAction(new ChannelEnabling(channel.id, false));
                };
                this._aTabs[tab].splice(this._aTabs[tab].indexOf(channel.id), 1);
            };
            this.refreshTabCache(tab);
            this.sysApi.sendAction(new TabsUpdate(this._aTabs));
        }

        private function displayHelp(typeToDisplay:String):void
        {
            var shortcuts:Array;
            var helpShortcutsText:String;
            var shortcutId:String;
            if (typeToDisplay == "shortcuts")
            {
                shortcuts = ["focusChat", "shiftUp", "altValid", "shiftValid", "autoComplete"];
                helpShortcutsText = (("\n" + this.uiApi.getText("ui.chat.mainShortcuts.details")) + "\n");
                for each (shortcutId in shortcuts)
                {
                    helpShortcutsText = (helpShortcutsText + ((((" - " + this.uiApi.getText(("ui.shortcuts." + shortcutId))) + this.uiApi.getText("ui.common.colon")) + this.bindsApi.getShortcutBind(shortcutId).toString()) + "\n"));
                };
                this.sysApi.dispatchHook(TextInformation, helpShortcutsText, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, this.timeApi.getTimestamp());
            }
            else
            {
                if (typeToDisplay == "commands")
                {
                    this.sendMessage("/help");
                };
            };
        }

        private function howManyTimesIsThisChannelUsed(channelId:uint):uint
        {
            var tab:*;
            var chanId:*;
            var timesUsed:uint;
            for each (tab in this._aTabs)
            {
                for each (chanId in tab)
                {
                    if (chanId == channelId)
                    {
                        timesUsed++;
                    };
                };
            };
            return (timesUsed);
        }

        private function tabpicChange(pictoId:uint, tab:int):void
        {
            this.onTabPictoChange((tab + 1), pictoId.toString());
        }

        private function selectLangForCommunityChannel(langId:int):void
        {
            if (langId != this.chatApi.getLangIdForCommunityChannel())
            {
                this.sysApi.sendAction(new ChatCommunityChannelSetCommunity(langId));
            };
        }

        private function openOptions():void
        {
            this.modCommon.openOptionMenu(false, "ui");
        }

        private function openExternalChat():void
        {
            this.chatApi.launchExternalChat();
        }

        private function setCurrentTab(tab:uint):void
        {
            this._nCurrentTab = tab;
            if (!this._tabsCache[this._nCurrentTab])
            {
                this._tabsCache[this._nCurrentTab] = new TabCache();
            };
            this.tfsb_scrollBar.lines = this._tabsCache[this._nCurrentTab].texts;
            this.tfsb_scrollBar.updateScrolling();
            this.tfsb_scrollBar.scrollAtEnd();
        }

        public function onWindowResize(width:Number, height:Number, scale:Number):void
        {
            this.resizeAndScroll(null, true);
        }

        public function onRelease(target:Object):void
        {
            var contextMenu:Array;
            var sizeMenu:Array;
            var communityMenu:Array;
            var picMenu:Array;
            var displayedChannelsMenu:Array;
            var helpMenu:Array;
            var iconUri:String;
            var channelLang:String;
            var name:String;
            var current:Boolean;
            var nbActivableChannels:uint;
            var statusMenu:Array;
            var lang:ServerLang;
            var iPic:uint;
            var chanAvailable:*;
            var selected:Boolean;
            var chanDisp:*;
            var chatChannel:Object;
            var shortcutKey:String;
            var chan:*;
            var chatChannelTab:Object;
            switch (target)
            {
                case this.btn_menu:
                    contextMenu = [];
                    sizeMenu = [];
                    communityMenu = [];
                    picMenu = [];
                    displayedChannelsMenu = [];
                    helpMenu = [];
                    sizeMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.small"), this.textResize, [SMALL_SIZE], false, null, (this._nFontSize == SMALL_SIZE)));
                    sizeMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.medium"), this.textResize, [MEDIUM_SIZE], false, null, (this._nFontSize == MEDIUM_SIZE)));
                    sizeMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.large"), this.textResize, [LARGE_SIZE], false, null, (this._nFontSize == LARGE_SIZE)));
                    if (this._communityChannelLangs.length > 1)
                    {
                        for each (lang in this._communityChannelLangs)
                        {
                            communityMenu.push(this.modContextMenu.createContextMenuItemObject(lang.name, this.selectLangForCommunityChannel, [lang.id], false, null, (this.chatApi.getLangIdForCommunityChannel() == lang.id)));
                        };
                    };
                    iconUri = this.uiApi.me().getConstant("tabIcon_uri");
                    iPic = 0;
                    while (iPic < 12)
                    {
                        picMenu.push(this.modContextMenu.createContextMenuPictureItemObject((((iconUri + "hl_") + iPic) + ".png"), this.tabpicChange, [iPic, this._nCurrentTab], false, null, (iPic.toString() == this._aTabsPicto[this._nCurrentTab]), true));
                        iPic++;
                    };
                    channelLang = "";
                    for each (chanAvailable in this._aChannels)
                    {
                        selected = false;
                        for each (chanDisp in this._aTabs[this._nCurrentTab])
                        {
                            if (chanDisp == chanAvailable)
                            {
                                selected = true;
                            };
                        };
                        chatChannel = this.dataApi.getChatChannel(chanAvailable);
                        shortcutKey = null;
                        if (chatChannel.shortcutKey)
                        {
                            shortcutKey = this.bindsApi.getShortcutBindStr(chatChannel.shortcutKey).toString();
                        };
                        channelLang = "";
                        if (chanAvailable == ChatActivableChannelsEnum.CHANNEL_COMMUNITY)
                        {
                            if (!this._currentCommunityLang)
                            {
                                this._currentCommunityLang = this.dataApi.getServerLang(this.chatApi.getLangIdForCommunityChannel());
                            };
                            if (!this._currentCommunityLang)
                            {
                                this.sysApi.log(16, "Probleme récupération canal communautaire");
                                channelLang = (channelLang + this.sysApi.getConfigEntry("config.lang.current"));
                            }
                            else
                            {
                                channelLang = (channelLang + this._currentCommunityLang.langCode.toLocaleUpperCase());
                            };
                        };
                        if (shortcutKey)
                        {
                            name = ((((chatChannel.name + channelLang) + " (") + shortcutKey) + ")");
                        }
                        else
                        {
                            name = (chatChannel.name + channelLang);
                        };
                        displayedChannelsMenu.push(this.modContextMenu.createContextMenuItemObject(name, this.changeDisplayChannel, [chatChannel, this._nCurrentTab], false, null, selected, false));
                    };
                    helpMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.chat.mainShortcuts"), this.displayHelp, ["shortcuts"], false, null, false));
                    helpMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.chat.commands"), this.displayHelp, ["commands"], false, null, false));
                    contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.option.chat")));
                    contextMenu.push(this.modContextMenu.createContextMenuItemObject((this.uiApi.getText("ui.option.title.chat") + "..."), this.openOptions, null, false, null, false, true));
                    contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.help"), null, null, false, helpMenu));
                    contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.externalChat.open"), this.openExternalChat, null, false, null, false, true));
                    contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.fontSize"), null, null, false, sizeMenu));
                    if (this._communityChannelLangs.length > 1)
                    {
                        contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.chat.channel.communityLang"), null, null, false, communityMenu));
                    };
                    contextMenu.push(this.modContextMenu.createContextMenuSeparatorObject());
                    contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.option.chatTab")));
                    contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.tabPic"), null, null, false, picMenu));
                    contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.displayedChannels"), null, null, false, displayedChannelsMenu));
                    contextMenu.push(this.modContextMenu.createContextMenuSeparatorObject());
                    contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.option.currentChannel")));
                    nbActivableChannels = 0;
                    if (!_shortcutColor)
                    {
                        _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                        _shortcutColor = _shortcutColor.replace("0x", "#");
                    };
                    for each (chan in this._aTabs[this._nCurrentTab])
                    {
                        if (((chan == ChatActivableChannelsEnum.CHANNEL_COMMUNITY) && (this._communityChannelLangs.length <= 1)))
                        {
                        }
                        else
                        {
                            chatChannelTab = this.dataApi.getChatChannel(chan);
                            if (((chatChannelTab.shortcut) && (!(chatChannelTab.shortcut == "null"))))
                            {
                                nbActivableChannels++;
                                current = (this._sChanLocked == chatChannelTab.shortcut);
                                contextMenu.push(this.modContextMenu.createContextMenuItemObject((((((chatChannelTab.name + " <font color='") + _shortcutColor) + "'>(") + chatChannelTab.shortcut) + ")</font>"), this.changeDefaultChannel, [chatChannelTab.shortcut], false, null, current, true));
                            };
                        };
                    };
                    if (nbActivableChannels == 0)
                    {
                        contextMenu.pop();
                        contextMenu.pop();
                    };
                    this.modContextMenu.createContextMenu(contextMenu);
                    break;
                case this.btn_plus:
                    this.resize(1);
                    break;
                case this.btn_minus:
                    this.resize(-1);
                    break;
                case this.btn_smiley:
                    this.sysApi.sendAction(new OpenSmileys(-1));
                    if (this._smileyOpened)
                    {
                        this.btn_smiley.soundId = SoundEnum.WINDOW_OPEN;
                    }
                    else
                    {
                        this.btn_smiley.soundId = SoundEnum.WINDOW_CLOSE;
                    };
                    this._smileyOpened = (!(this._smileyOpened));
                    break;
                case this.tx_newMessages:
                    this.tfsb_scrollBar.scrollAtEnd();
                    this.tx_newMessages.visible = false;
                    this._unreadMessagesCount = 0;
                    break;
                case this.btn_tab0:
                    this.setCurrentTab(0);
                    this._aTxHighlights[this._nCurrentTab].visible = false;
                    break;
                case this.btn_tab1:
                    this.setCurrentTab(1);
                    this._aTxHighlights[this._nCurrentTab].visible = false;
                    break;
                case this.btn_tab2:
                    this.setCurrentTab(2);
                    this._aTxHighlights[this._nCurrentTab].visible = false;
                    break;
                case this.btn_tab3:
                    this.setCurrentTab(3);
                    this._aTxHighlights[this._nCurrentTab].visible = false;
                    break;
                case this.btn_status:
                    this.sysApi.dispatchHook(OpenStatusMenu);
                    statusMenu = [];
                    statusMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.chat.status.title")));
                    statusMenu.push(this.modContextMenu.createContextMenuPictureLabelItemObject(this.uiApi.createUri((this._iconsPath + "green.png")), this.uiApi.getText("ui.chat.status.availiable"), 13, false, this.onStatusChange, [PlayerStatusEnum.PLAYER_STATUS_AVAILABLE], false, null, (_currentStatus == -1), true, this.uiApi.getText("ui.chat.status.availiabletooltip")));
                    statusMenu.push(this.modContextMenu.createContextMenuPictureLabelItemObject(this.uiApi.createUri((this._iconsPath + "yellow.png")), this.uiApi.getText("ui.chat.status.away"), 13, false, this.onStatusChange, [PlayerStatusEnum.PLAYER_STATUS_AFK], false, null, (_currentStatus == 0), true, this.uiApi.getText("ui.chat.status.awaytooltip")));
                    statusMenu.push(this.modContextMenu.createContextMenuPictureLabelItemObject(this.uiApi.createUri((this._iconsPath + "yellow.png")), (this.uiApi.getText("ui.chat.status.away") + "..."), 13, false, this.onStatusChangeWithMessage, [PlayerStatusEnum.PLAYER_STATUS_AFK], false, null, (_currentStatus == 0), true, this.uiApi.getText("ui.chat.status.awaymessagetooltip")));
                    statusMenu.push(this.modContextMenu.createContextMenuPictureLabelItemObject(this.uiApi.createUri((this._iconsPath + "blue.png")), this.uiApi.getText("ui.chat.status.private"), 13, false, this.onStatusChange, [PlayerStatusEnum.PLAYER_STATUS_PRIVATE], false, null, (_currentStatus == 1), true, this.uiApi.getText("ui.chat.status.privatetooltip")));
                    statusMenu.push(this.modContextMenu.createContextMenuPictureLabelItemObject(this.uiApi.createUri((this._iconsPath + "red.png")), this.uiApi.getText("ui.chat.status.solo"), 13, false, this.onStatusChange, [PlayerStatusEnum.PLAYER_STATUS_SOLO], false, null, (_currentStatus == 1), true, this.uiApi.getText("ui.chat.status.solotooltip")));
                    this.modContextMenu.createContextMenu(statusMenu);
                    break;
            };
        }

        private function getHyperlinkFormatedText(text:String):String
        {
            var item:Object;
            var num:int;
            var k:int;
            var currentItem:Object;
            var itemName:String;
            var index:int;
            text = this.chatApi.escapeChatString(text);
            var numItem:int = this._aItemReplacement.length;
            var itemsToRemove:Array = [];
            var m:int = (numItem - 1);
            while (m >= 0)
            {
                currentItem = this._aItemReplacement[m];
                itemName = (("[" + currentItem.realName) + "]");
                index = text.indexOf(itemName);
                if (index == -1)
                {
                    itemsToRemove.push(this._aItemReplacement[m]);
                }
                else
                {
                    text = ((text.substr(0, index) + ITEM_INDEX_CODE) + text.substr((index + itemName.length)));
                };
                m--;
            };
            for each (item in itemsToRemove)
            {
                this._aItemReplacement.splice(this._aItemReplacement.indexOf(item), 1);
            };
            num = this._aMiscReplacement.length;
            k = (num - 1);
            while (k >= 0)
            {
                index = text.lastIndexOf(this._aMiscReplacement[(k - 1)]);
                if (index != -1)
                {
                    text = ((text.substr(0, index) + this._aMiscReplacement[k]) + text.substr((index + this._aMiscReplacement[(k - 1)].length)));
                };
                k = (k - 2);
            };
            return (text);
        }

        private function processLinkedItem(text:String):String
        {
            var currentItem:Object;
            var itemName:String;
            var index:int;
            var numItem:int = this._aItemReplacement.length;
            var m:int;
            while (m < numItem)
            {
                currentItem = this._aItemReplacement[m];
                itemName = (("[" + currentItem.realName) + "]");
                index = text.indexOf(itemName);
                if (index == -1)
                {
                    this._aItemReplacement.splice(m, 1);
                    m--;
                    numItem--;
                }
                else
                {
                    text = ((((((text.substr(0, index) + ITEM_INDEX_CODE) + currentItem.objectGID) + ",") + currentItem.objectUID) + ITEM_INDEX_CODE) + text.substr((index + itemName.length)));
                };
                m++;
            };
            return (text);
        }

        private function addChannelsContextMenu(nTab:int):void
        {
            var channelLang:String;
            var help:String;
            var chanAvailable:*;
            var selected:Boolean;
            var chanDisp:*;
            var chatChannel:Object;
            var shortcutKey:String;
            var name:String;
            var contextMenu:Array = [];
            var picMenu:Array = [];
            var iconUri:String = this.uiApi.me().getConstant("tabIcon_uri");
            var iPic:uint;
            while (iPic < 12)
            {
                picMenu.push(this.modContextMenu.createContextMenuPictureItemObject((((iconUri + "hl_") + iPic) + ".png"), this.tabpicChange, [iPic, nTab], false, null, (iPic.toString() == this._aTabsPicto[nTab]), true));
                iPic++;
            };
            for each (chanAvailable in this._aChannels)
            {
                selected = false;
                for each (chanDisp in this._aTabs[nTab])
                {
                    if (chanDisp == chanAvailable)
                    {
                        selected = true;
                    };
                };
                chatChannel = this.dataApi.getChatChannel(chanAvailable);
                shortcutKey = null;
                if (chatChannel.shortcutKey)
                {
                    shortcutKey = this.bindsApi.getShortcutBindStr(chatChannel.shortcutKey).toString();
                };
                help = "";
                channelLang = "";
                if (chanAvailable == ChatActivableChannelsEnum.CHANNEL_COMMUNITY)
                {
                    if (!this._currentCommunityLang)
                    {
                        this.sysApi.log(16, "Probleme récupération canal communautaire");
                        channelLang = (channelLang + this.sysApi.getConfigEntry("config.lang.current"));
                    }
                    else
                    {
                        channelLang = (channelLang + this._currentCommunityLang.langCode.toLocaleUpperCase());
                    };
                    help = ((((((this.uiApi.getText("ui.chat.channel.communityLang") + " : ") + this._currentCommunityLang.name) + " (") + channelLang) + ")\n") + this.uiApi.getText("ui.chat.channel.communityLang.help"));
                };
                if (shortcutKey)
                {
                    name = ((((chatChannel.name + channelLang) + " (") + shortcutKey) + ")");
                }
                else
                {
                    name = (chatChannel.name + channelLang);
                };
                contextMenu.push(this.modContextMenu.createContextMenuItemObject(name, this.changeDisplayChannel, [chatChannel, nTab], false, null, selected, false, help, false, 0));
            };
            contextMenu.push(this.modContextMenu.createContextMenuSeparatorObject());
            contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.tabPic"), null, null, false, picMenu));
            this.modContextMenu.createContextMenu(contextMenu);
        }

        private function validUiShortcut():Boolean
        {
            var controler:Object;
            if (!this.inp_tchatinput.haveFocus)
            {
                return (false);
            };
            if (this.canSendMsg(this.inp_tchatinput.text))
            {
                controler = this.sysApi.getNewDynamicSecureObject();
                controler.cancel = false;
                this.sysApi.dispatchHook(ChatSendPreInit, this.inp_tchatinput.text, controler);
                return (true);
            };
            return (false);
        }

        private function canSendMsg(msg:String):Boolean
        {
            if (msg.charAt(0) != " ")
            {
                return (true);
            };
            if (msg.length == 0)
            {
                return (false);
            };
            while (msg.indexOf(" ") != -1)
            {
                msg = msg.replace(" ", "");
            };
            return (msg.length > 0);
        }

        public function onShortcut(s:String):Boolean
        {
            var i:int;
            var historyString:String;
            var name:String;
            var command:String;
            var historyText2:String;
            var text:String;
            var chan:uint;
            var shortcutChan:String;
            var sShortcut:String;
            var finalText:String;
            var textInfos:Array;
            var numInfos:int;
            var idsInfo:Array;
            var objectGID:uint;
            var objectUID:uint;
            var item:Object;
            var c2:*;
            switch (s)
            {
                case "focusChat":
                    if (!this.inp_tchatinput.haveFocus)
                    {
                        this._focusTimer.stop();
                        this._focusTimer.reset();
                        this._focusTimer.start();
                    };
                    return (true);
                case ShortcutHookListEnum.CLOSE_UI:
                    if (this.inp_tchatinput.haveFocus)
                    {
                        this.inp_tchatinput.blur();
                        return (true);
                    };
                    return (false);
                case "upArrow":
                case "downArrow":
                    if (!this.inp_tchatinput.haveFocus)
                    {
                        break;
                    };
                    if (((!(this._aHistory[(this._aHistory.length - 1)])) && (!(this._aHistory[0]))))
                    {
                        break;
                    };
                    this._bCurrentChannelSelected = false;
                    if (((s == "upArrow") && (this._nHistoryIndex >= 0)))
                    {
                        this._nHistoryIndex--;
                    };
                    if (((s == "downArrow") && (this._nHistoryIndex < this._aHistory.length)))
                    {
                        this._nHistoryIndex++;
                    };
                    historyString = this._aHistory[this._nHistoryIndex];
                    if (((!(historyString == null)) && (!(historyString == ""))))
                    {
                        this.chanSearch(historyString);
                        sShortcut = this.dataApi.getChatChannel(0).shortcut;
                        if (historyString.indexOf((sShortcut + " ")) == 0)
                        {
                            finalText = historyString.slice((sShortcut.length + 1));
                        }
                        else
                        {
                            finalText = historyString;
                        };
                        this._aItemReplacement = [];
                        textInfos = finalText.split(ITEM_INDEX_CODE);
                        numInfos = textInfos.length;
                        i = 1;
                        while (i < numInfos)
                        {
                            idsInfo = textInfos[i].split(",");
                            objectGID = (idsInfo[0] as uint);
                            objectUID = (idsInfo[1] as uint);
                            item = ((objectUID) ? this._dItemIndex[objectUID] : this._dGenericItemIndex[objectGID]);
                            if (item)
                            {
                                textInfos[i] = (("[" + item.name) + "]");
                                this._aItemReplacement.push(item);
                            }
                            else
                            {
                                textInfos[i] = "";
                            };
                            i = (i + 2);
                        };
                        finalText = textInfos.join("");
                        this.inp_tchatinput.text = finalText;
                    }
                    else
                    {
                        this.inp_tchatinput.text = "";
                        this.init();
                    };
                    this.inp_tchatinput.setSelection(this.inp_tchatinput.length, this.inp_tchatinput.length);
                    return (true);
                case "shiftDown":
                case "shiftUp":
                    if (!this.inp_tchatinput.haveFocus)
                    {
                        break;
                    };
                    if (this._privateHistory.length == 0)
                    {
                        break;
                    };
                    this._bCurrentChannelSelected = false;
                    if (s == "shiftUp")
                    {
                        name = this._privateHistory.previous();
                    }
                    else
                    {
                        if (s == "shiftDown")
                        {
                            name = this._privateHistory.next();
                        };
                    };
                    command = (("/w " + name) + " ");
                    this.inp_tchatinput.text = command;
                    this.chanSearch(command);
                    this.inp_tchatinput.setSelection(this.inp_tchatinput.length, this.inp_tchatinput.length);
                    return (true);
                case "shiftValid":
                case "altValid":
                case "ctrlValid":
                    if (!this.inp_tchatinput.haveFocus)
                    {
                        this._focusTimer.stop();
                        this._focusTimer.reset();
                        this._focusTimer.start();
                        return (false);
                    };
                    if (((this.inp_tchatinput.text.charAt(0) == "/") && (this.inp_tchatinput.text.indexOf(this._sChan) == 0)))
                    {
                        this._sText = this.inp_tchatinput.text.substring((this.inp_tchatinput.text.indexOf(" ") + 1), this.inp_tchatinput.text.length);
                    }
                    else
                    {
                        this._sText = this.inp_tchatinput.text;
                    };
                    if (this._sText.length == 0)
                    {
                        return (true);
                    };
                    this._bCurrentChannelSelected = false;
                    historyText2 = this._sText;
                    this._sText = this.getHyperlinkFormatedText(this._sText);
                    text = "";
                    if (this._sDest)
                    {
                        text = (text + (this._sDest + " "));
                    }
                    else
                    {
                        text = (text + this._sDest);
                    };
                    text = (text + this._sText);
                    if (s == "altValid")
                    {
                        chan = ChatActivableChannelsEnum.CHANNEL_GUILD;
                        if (this._aItemReplacement.length)
                        {
                            this.sysApi.sendAction(new ChatTextOutput(text, chan, "", this._aItemReplacement));
                        }
                        else
                        {
                            this.sysApi.sendAction(new ChatTextOutput(text, chan));
                        };
                    }
                    else
                    {
                        if (s == "shiftValid")
                        {
                            chan = ChatActivableChannelsEnum.CHANNEL_PARTY;
                            this.sysApi.sendAction(new ChatTextOutput(text, chan, "", ((this._aItemReplacement.length) ? this._aItemReplacement : null)));
                        }
                        else
                        {
                            if (s == "ctrlValid")
                            {
                                chan = ChatActivableChannelsEnum.CHANNEL_TEAM;
                                this.sysApi.sendAction(new ChatTextOutput(text, chan, "", ((this._aItemReplacement.length) ? this._aItemReplacement : null)));
                            };
                        };
                    };
                    shortcutChan = this.dataApi.getChatChannel(chan).shortcut;
                    if (this.sysApi.getOption("channelLocked", "chat"))
                    {
                        this.changeDefaultChannel(shortcutChan);
                    }
                    else
                    {
                        this.changeCurrentChannel(shortcutChan);
                    };
                    historyText2 = this.processLinkedItem(historyText2);
                    this._sText = historyText2;
                    this.textOutput();
                    this.inp_tchatinput.text = "";
                    if (!this.sysApi.getOption("channelLocked", "chat"))
                    {
                        this.init();
                    }
                    else
                    {
                        for each (c2 in this._aChannels)
                        {
                            if (((!(c2 == ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG)) && (this.dataApi.getChatChannel(c2).shortcut == this._sChan)))
                            {
                                if (this.dataApi.getChatChannel(c2).isPrivate)
                                {
                                    this.init();
                                };
                            };
                        };
                    };
                    return (true);
                case ShortcutHookListEnum.EXTEND_CHAT:
                    if (!this.inp_tchatinput.haveFocus)
                    {
                        this.resize(1);
                    };
                    return (true);
                case ShortcutHookListEnum.EXTEND_CHAT2:
                    if (this.inp_tchatinput.haveFocus)
                    {
                        this.resize(1);
                    };
                    return (true);
                case ShortcutHookListEnum.SHRINK_CHAT:
                    if (!this.inp_tchatinput.haveFocus)
                    {
                        this.resize(-1);
                    };
                    return (true);
                case ShortcutHookListEnum.TOGGLE_EMOTES:
                    this.sysApi.sendAction(new OpenSmileys(2));
                    if (this._smileyOpened)
                    {
                        this.btn_smiley.soundId = SoundEnum.WINDOW_OPEN;
                    }
                    else
                    {
                        this.btn_smiley.soundId = SoundEnum.WINDOW_CLOSE;
                    };
                    this._smileyOpened = (!(this._smileyOpened));
                    return (true);
                case ShortcutHookListEnum.TOGGLE_ATTITUDES:
                    this.openEmoteUi();
                    return (true);
                case ShortcutHookListEnum.CHAT_TAB_0:
                    if (this._aTabs.length > 0)
                    {
                        this.setCurrentTab(0);
                        this._aTxHighlights[this._nCurrentTab].visible = false;
                        this._aBtnTabs[this._nCurrentTab].selected = true;
                    };
                    return (true);
                case ShortcutHookListEnum.CHAT_TAB_1:
                    if (this._aTabs.length > 1)
                    {
                        this.setCurrentTab(1);
                        this._aTxHighlights[this._nCurrentTab].visible = false;
                        this._aBtnTabs[this._nCurrentTab].selected = true;
                    };
                    return (true);
                case ShortcutHookListEnum.CHAT_TAB_2:
                    if (this._aTabs.length > 2)
                    {
                        this.setCurrentTab(2);
                        this._aTxHighlights[this._nCurrentTab].visible = false;
                        this._aBtnTabs[this._nCurrentTab].selected = true;
                    };
                    return (true);
                case ShortcutHookListEnum.CHAT_TAB_3:
                    if (this._aTabs.length > 3)
                    {
                        this.setCurrentTab(3);
                        this._aTxHighlights[this._nCurrentTab].visible = false;
                        this._aBtnTabs[this._nCurrentTab].selected = true;
                    };
                    return (true);
                case ShortcutHookListEnum.NEXT_CHAT_TAB:
                    this.setCurrentTab((this._nCurrentTab % this._aTabs.length));
                    this._aTxHighlights[this._nCurrentTab].visible = false;
                    this._aBtnTabs[this._nCurrentTab].selected = true;
                    return (true);
                case ShortcutHookListEnum.PREVIOUS_CHAT_TAB:
                    if (this._nCurrentTab > 0)
                    {
                        this.setCurrentTab((this._nCurrentTab - 1));
                    }
                    else
                    {
                        this.setCurrentTab((this._aTabs.length - 1));
                    };
                    this._aTxHighlights[this._nCurrentTab].visible = false;
                    this._aBtnTabs[this._nCurrentTab].selected = true;
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_GLOBAL:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(DataEnum.CHAT_CHANNEL_GENERAL), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_TEAM:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(DataEnum.CHAT_CHANNEL_TEAM), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_GUILD:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(DataEnum.CHAT_CHANNEL_GUILD), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_ALLIANCE:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(DataEnum.CHAT_CHANNEL_ALLIANCE), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_PARTY:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(DataEnum.CHAT_CHANNEL_GROUP), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_ARENA:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(DataEnum.CHAT_CHANNEL_ARENA), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_SALES:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(DataEnum.CHAT_CHANNEL_TRADE), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_SEEK:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(DataEnum.CHAT_CHANNEL_RECRUITMENT), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_FIGHT:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(DataEnum.CHAT_CHANNEL_FIGHT), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.SWITCH_TEXT_SIZE:
                    switch (this._nFontSize)
                    {
                        case SMALL_SIZE:
                            this.textResize(MEDIUM_SIZE);
                            break;
                        case MEDIUM_SIZE:
                            this.textResize(LARGE_SIZE);
                            break;
                        case LARGE_SIZE:
                            this.textResize(SMALL_SIZE);
                            break;
                    };
                    return (true);
                case ShortcutHookListEnum.CHAT_AUTOCOMPLETE:
                    if (this.inp_tchatinput.haveFocus)
                    {
                        this.autocompleteChat();
                        return (true);
                    };
                    return (false);
            };
            return (false);
        }

        public function onKeyUp(event:KeyboardEvent):void
        {
            var lastWarning:Number;
            var now:Number;
            var input:String;
            if (((!(event.target == this.inp_tchatinput)) && (!(event.target.parent == this.inp_tchatinput))))
            {
                if ((((((((event.hasOwnProperty("controlKey")) && (Object(event).controlKey)) || (event.ctrlKey)) || ((event.hasOwnProperty("commandKey")) && (Object(event).commandKey))) && ((event.keyCode == Keyboard.C) || (event.keyCode == Keyboard.X))) && (event.currentTarget as TextField)) && (!((event.currentTarget as TextField).selectedText == ""))))
                {
                    lastWarning = this.sysApi.getData("lastWarningChatCopy");
                    if (!lastWarning)
                    {
                        lastWarning = 0;
                    };
                    now = new Date().getTime();
                    if (((lastWarning == 0) || ((now - lastWarning) > 4838400000)))
                    {
                        this.modCommon.openIllustratedWithLinkPopup(this.uiApi.getText("ui.popup.warning.copy"), this.uiApi.getText("ui.popup.copy.text"), this.uiApi.getText("ui.link.copyLink"), "tx_illu_secure.jpg");
                        this.sysApi.setData("lastWarningChatCopy", now);
                    };
                };
            }
            else
            {
                if (((!(((((event.altKey) || (event.shiftKey)) || ((event.hasOwnProperty("controlKey")) && (Object(event).controlKey))) || (event.ctrlKey)) || ((event.hasOwnProperty("commandKey")) && (Object(event).commandKey)))) && (event.keyCode == Keyboard.ENTER)))
                {
                    this.validUiShortcut();
                }
                else
                {
                    input = this.inp_tchatinput.text;
                    this.inp_tchatinput.text = input;
                    if (this.inp_tchatinput.text == "")
                    {
                        this.updateChanColor(parseInt(this._sCssClass.substr(1), 10));
                    };
                    this.chanSearch(input);
                };
            };
        }

        public function onUserMessage(msg:*):void
        {
            var otherId:String;
            var elem:String;
            var friend:*;
            var friendName:String;
            var me:String = this.sysApi.getPlayerManager().accountId.toString();
            var actors:* = msg.channelId.substr(3).split("_");
            for each (elem in actors)
            {
                if (elem != me)
                {
                    otherId = elem;
                    break;
                };
            };
            if (msg.author.userId == me)
            {
                friend = this._chatService.friendList.getFriendById(otherId);
                friendName = ((friend) ? friend.user.name : otherId);
                this.displayMessage(ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE, msg.content, 0, "", 0, "", "", null, friendName, parseInt(otherId), false, false, false, true);
            }
            else
            {
                this.displayMessage(ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE, msg.content, 0, "", msg.author.userId, "", msg.author.name, "", "", 0, false, false, false, true);
            };
        }

        public function onChatSendPreInit(content:String, controler:Object):void
        {
            var japString:String;
            var ijc:uint;
            var japchar:Number;
            var l:int;
            var objectGid:uint;
            var objectUid:uint;
            var a:Array;
            var item:Object;
            var spaceIndex:int;
            var dest:String;
            if (controler.cancel)
            {
                this.inp_tchatinput.text = "";
                return;
            };
            var chanId:int = this.chatApi.searchChannel(this._sChan);
            var chanData:ChatChannel = this.dataApi.getChatChannel(chanId);
            var textInp:String = content;
            if (((textInp.charAt(0) == "/") && (textInp.toLowerCase().indexOf((this._sChan + " ")) == 0)))
            {
                this._sText = textInp.substring((textInp.indexOf(" ") + 1), textInp.length);
            }
            else
            {
                this._sText = textInp;
            };
            if (this._sText.length == 0)
            {
                return;
            };
            this._bCurrentChannelSelected = false;
            if (this._sText.charAt(0) == String.fromCharCode(65295))
            {
                japString = "";
                ijc = 0;
                while (ijc < this._sText.length)
                {
                    japchar = this._sText.charCodeAt(ijc);
                    if (((japchar >= 65281) && (japchar <= 65374)))
                    {
                        japchar = (japchar - 65248);
                    };
                    japString = (japString + String.fromCharCode(japchar));
                    ijc++;
                };
                this._sText = japString;
            };
            if ((((((this._sText.charAt(0) == "/") && (this._sText.length == textInp.length)) && (!(this._sText.substr(0, 3).toLowerCase() == "/me"))) && (!(this._sText.substr(0, 6).toLowerCase() == "/think"))) && (!((this._sText.charAt(0) == "*") && (this._sText.charAt((this._sText.length - 1)) == "*")))))
            {
                this.sysApi.sendAction(new ChatCommand(this.chatApi.escapeChatString(this._sText.substr(1))));
                this.inp_tchatinput.text = "";
                this.addToHistory(this._sText);
                return;
            };
            var adminWithServerSender:Boolean;
            if (this._sText.indexOf(")[") != -1)
            {
                adminWithServerSender = true;
            };
            this._sText = this._sText.replace("][", "] [");
            var destTmp:String = this._sText.substring(0, this._sText.indexOf(" "));
            if (destTmp == "")
            {
                destTmp = this._sText;
            };
            if ((((((!(destTmp.charAt(0) == "[")) && (!((destTmp.charAt(0) == "*") && (destTmp.charAt(1) == "[")))) && (!(destTmp.indexOf("]") == -1))) && (destTmp.indexOf("-[") == -1)) || (((!(destTmp.indexOf("[") == -1)) && (destTmp.indexOf("]") == -1)) && (!(this._sText.indexOf("]") == -1)))))
            {
                this._sText = ((this._sText.substring(0, this._sText.indexOf("[")) + " ") + this._sText.substring(this._sText.indexOf("["), this._sText.length));
                this._sText = this.trim(this._sText);
            }
            else
            {
                if (((destTmp.charAt(0) == "[") && (!(destTmp.indexOf("]") == destTmp.lastIndexOf("]")))))
                {
                    this._sText = ((this._sText.substring(0, this._sText.lastIndexOf("[")) + " ") + this._sText.substring(this._sText.lastIndexOf("["), this._sText.length));
                    this._sText = this.trim(this._sText);
                };
            };
            if (((adminWithServerSender) && (!(this._sText.indexOf(") [") == -1))))
            {
                this._sText = this._sText.replace(") [", ")[");
            };
            var links:Object = this.inp_tchatinput.getHyperLinkCodes();
            var numLinks:uint = ((links) ? links.length : 0);
            if (numLinks > 0)
            {
                this._aItemReplacement = [];
                l = 0;
                while (l < numLinks)
                {
                    a = links[l].split(",");
                    objectGid = (a[1] as uint);
                    objectUid = (a[2].substring(0, a[2].indexOf("}")) as uint);
                    item = ((objectUid) ? this._dItemIndex[objectUid] : this._dGenericItemIndex[objectGid]);
                    if (item)
                    {
                        this._aItemReplacement.push(item);
                    };
                    l++;
                };
            };
            var historyText:String = this._sText;
            this._sText = this.getHyperlinkFormatedText(this._sText);
            if (!chanData.isPrivate)
            {
                if (this._aItemReplacement.length)
                {
                    this.sysApi.sendAction(new ChatTextOutput(this._sText, chanData.id, this._sDest, this._aItemReplacement));
                }
                else
                {
                    this.sysApi.sendAction(new ChatTextOutput(this._sText, chanData.id, this._sDest));
                };
            }
            else
            {
                spaceIndex = this._sText.indexOf(" ");
                this._sDest = this._sText.substring(0, spaceIndex);
                this._sText = this._sText.substring((spaceIndex + 1), this._sText.length);
                historyText = historyText.substring((historyText.indexOf(" ") + 1), historyText.length);
                if (this._sDest.length != 0)
                {
                    if (this._aItemReplacement.length)
                    {
                        this.sysApi.sendAction(new ChatTextOutput(this._sText, chanData.id, this._sDest, this._aItemReplacement));
                    }
                    else
                    {
                        if (this._sDest.charAt(0) == "*")
                        {
                            dest = this._sDest.substr(1);
                            this._chatService.sendMessage(dest, this._sText);
                        }
                        else
                        {
                            this.sysApi.sendAction(new ChatTextOutput(this._sText, chanData.id, this._sDest));
                        };
                    };
                };
            };
            this._privateHistory.resetCursor();
            historyText = this.processLinkedItem(historyText);
            this._sText = historyText;
            this._aItemReplacement = [];
            this.textOutput();
            this.inp_tchatinput.text = "";
            if (((!(this.sysApi.getOption("channelLocked", "chat"))) || (chanData.isPrivate)))
            {
                this.init();
            };
        }

        public function onChatServer(channel:uint=0, senderId:Number=0, prefix:String="", senderName:String="", content:String="", timestamp:Number=0, fingerprint:String="", admin:Boolean=false):void
        {
            this.displayMessage(channel, content, timestamp, fingerprint, senderId, prefix, senderName, null, "", 0, false, admin);
        }

        public function onChatServerWithObject(channel:uint=0, senderId:Number=0, prefix:String="", senderName:String="", content:String="", timestamp:Number=0, fingerprint:String="", objects:Object=null):void
        {
            this.displayMessage(channel, content, timestamp, fingerprint, senderId, prefix, senderName, objects);
        }

        public function onChatServerCopy(channel:uint=0, receiverName:String="", content:String="", timestamp:Number=0, fingerprint:String="", receiverId:Number=0):void
        {
            this.displayMessage(channel, content, timestamp, fingerprint, 0, "", "", null, receiverName, receiverId);
        }

        public function onChatServerCopyWithObject(channel:uint=0, receiverName:String="", content:String="", timestamp:Number=0, fingerprint:String="", receiverId:Number=0, objects:Object=null):void
        {
            this.displayMessage(channel, content, timestamp, fingerprint, 0, "", "", objects, receiverName, receiverId);
        }

        public function onChatSpeakingItem(channel:uint=0, item:Object=null, content:String="", timestamp:Number=0, fingerprint:String=""):void
        {
            this.sysApi.sendAction(new SaveMessage(((item.name + this.uiApi.getText("ui.common.colon")) + content), channel, timestamp));
            this.displayMessage(channel, content, timestamp, fingerprint, 0, "", item.name, null, "", 0, true);
        }

        public function onLivingObjectMessage(owner:String="", text:String="", timestamp:Number=0):void
        {
            this.sysApi.sendAction(new SaveMessage(((owner + this.uiApi.getText("ui.common.colon")) + text), 0, timestamp));
            this.displayMessage(0, text, timestamp, "", 0, "", owner, null, "", 0, true);
        }

        public function onTextInformation(content:String="", channel:int=0, timestamp:Number=0, saveMsg:Boolean=true, forceDisplay:Boolean=false):void
        {
            if (content == "")
            {
                this.sysApi.log(16, "Le message d'information est vide, il ne sera pas affiché.");
            }
            else
            {
                if (channel == DataEnum.CHAT_CHANNEL_GUILD)
                {
                    this.soundApi.playSoundById("16109");
                };
                if (saveMsg)
                {
                    this.sysApi.sendAction(new SaveMessage(content, channel, timestamp));
                };
                this.displayMessage(channel, content, timestamp, "", 0, "", "", null, "", 0, false, false, forceDisplay);
            };
        }

        public function onTextActionInformation(textKey:uint=0, params:Array=null, channel:int=0, timestamp:Number=0):void
        {
            var content:String = this.uiApi.getTextFromKey(textKey, null, params);
            content = this.uiApi.processText(content, "n", false);
            this.displayMessage(channel, content, timestamp);
        }

        public function onTabPictoChange(tab:uint, name:String=null):void
        {
            this._aTabsPicto[(tab - 1)] = name;
            (this.uiApi.me().getElement(("iconTexture" + this._aBtnTabs[(tab - 1)].name)) as TextureBase).uri = this.uiApi.createUri(((this._tabIconsPath + name) + ".png"));
            this[("tx_tab" + (tab - 1))].uri = this.uiApi.createUri((((this._tabIconsPath + "hl_") + name) + ".png"));
            this.sysApi.sendAction(new TabsUpdate(null, this._aTabsPicto));
        }

        public function onEnabledChannels(channels:Object):void
        {
            var tab:*;
            var channelsFromData:Object;
            var cc:*;
            var chans:Array;
            var c:*;
            var newChannelsByTab:Array;
            var chan:*;
            var defaultChan:Object;
            var currentChannels:Array;
            var i:*;
            var j:*;
            var chan2:*;
            var newTabs:Array = [];
            for each (tab in this._aTabs)
            {
                newChannelsByTab = [];
                for each (chan in tab)
                {
                    if (this.chatApi.getDisallowedChannelsId().indexOf(chan) == -1)
                    {
                        newChannelsByTab.push(chan);
                    };
                };
                newTabs.push(newChannelsByTab);
            };
            this._aTabs = newTabs;
            channelsFromData = this.chatApi.getChannelsId();
            this._aChannels = [];
            for each (cc in channelsFromData)
            {
                if (((cc == ChatActivableChannelsEnum.CHANNEL_COMMUNITY) && (this._communityChannelLangs.length <= 1)))
                {
                }
                else
                {
                    this._aChannels.push(cc);
                };
            };
            chans = [];
            for each (c in channels)
            {
                chans.push(c);
            };
            if (chans.length)
            {
                currentChannels = [];
                if (this._aTabs.length == 0)
                {
                    this._aTabs = this.sysApi.getOption("channelTabs", "chat");
                };
                for each (tab in this._aTabs)
                {
                    for each (chan2 in tab)
                    {
                        if (currentChannels[chan2] == undefined)
                        {
                            currentChannels[chan2] = 1;
                        };
                    };
                };
                for each (i in chans)
                {
                    if (currentChannels[i] == undefined)
                    {
                        this.sysApi.sendAction(new ChannelEnabling(i, false));
                    }
                    else
                    {
                        currentChannels[i] = null;
                    };
                };
                for (j in currentChannels)
                {
                    if (((!(currentChannels[j] == null)) && (!(j == ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG))))
                    {
                        if (chans.indexOf(j) == -1)
                        {
                            this.sysApi.sendAction(new ChannelEnabling(j, true));
                        };
                    };
                };
            };
        }

        public function onUpdateChatOptions():void
        {
            var cssColor:String;
            var cssClass:String;
            var canal:*;
            var tabId:*;
            var serverLangs:Object = this.sysApi.getCurrentServer().community.supportedLangIds;
            for each (canal in this._aChannels)
            {
                if (((!(canal == ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG)) && ((!(canal == ChatActivableChannelsEnum.CHANNEL_COMMUNITY)) || (serverLangs.length > 1))))
                {
                    cssColor = ("#" + this.configApi.getConfigProperty("chat", ("channelColor" + canal)).toString(16));
                    cssClass = ("p" + canal);
                    this.lbl_chat.setCssColor(cssColor, cssClass);
                };
                if (this.dataApi.getChatChannel(canal).shortcut == this._sChan)
                {
                    this.updateChanColor(canal);
                };
            };
            this.setTabsChannels();
            if (!this._init)
            {
                for (tabId in this._aTabs)
                {
                    this.refreshTabCache(tabId);
                };
            };
        }

        public function onChatSmiley(smileyId:uint, entityId:Number):void
        {
            if (((this.sysApi.getOption("smileysAutoclosed", "chat")) && (entityId == this.playerApi.id())))
            {
                this.btn_smiley.selected = false;
            };
        }

        private function openEmoteUi():void
        {
            this.sysApi.sendAction(new OpenSmileys(0));
            if (this._emoteOpened)
            {
                this.btn_smiley.soundId = SoundEnum.WINDOW_OPEN;
            }
            else
            {
                this.btn_smiley.soundId = SoundEnum.WINDOW_CLOSE;
            };
            this._emoteOpened = (!(this._emoteOpened));
        }

        private function onClearChat():void
        {
            if (!this._tabsCache[this._nCurrentTab])
            {
                this._tabsCache[this._nCurrentTab] = new TabCache();
            };
            this.tfsb_scrollBar.clear();
            this.resizeAndScroll();
            this.sysApi.sendAction(new d2actions.ClearChat(this._aTabs[this._nCurrentTab]));
        }

        private function onChatRollOverLink(target:*, pHref:String):void
        {
            var data:Object = this.uiApi.textTooltipInfo(pHref, null, null, 400);
            this.uiApi.showTooltip(data, target, false, "standard", 0, 0, 3, null, null, null, "TextInfo");
        }

        public function onNewMessage(chanId:int, removedSentence:uint=0):void
        {
            var tab:*;
            for (tab in this._aTabs)
            {
                if ((((!(this._aTabs[tab].indexOf(chanId) == -1)) && (!(tab == this._nCurrentTab))) && (this._aTabs[this._nCurrentTab].indexOf(chanId) == -1)))
                {
                    this._aTxHighlights[tab].visible = true;
                };
            };
        }

        public function onChatFocus(name:String=""):void
        {
            var position:int;
            if (name)
            {
                this.inp_tchatinput.text = (("/w " + name) + " ");
                position = this.inp_tchatinput.text.length;
                this.inp_tchatinput.setSelection(position, position);
                this.chanSearch("/w ");
            };
            this.inp_tchatinput.focus();
            this.inp_tchatinput.caretIndex = -1;
        }

        public function onChatFocusInterGame(name:String=""):void
        {
            var position:int;
            if (name)
            {
                this.inp_tchatinput.text = (("/w *" + name) + " ");
                position = this.inp_tchatinput.text.length;
                this.inp_tchatinput.setSelection(position, position);
                this.chanSearch("/w ");
            };
            this.inp_tchatinput.focus();
            this.inp_tchatinput.caretIndex = -1;
        }

        public function onRightClick(target:Object):void
        {
            switch (target)
            {
                case this.btn_tab0:
                case this.btn_tab1:
                case this.btn_tab2:
                case this.btn_tab3:
                    this.uiApi.hideTooltip();
                    this.addChannelsContextMenu(int(target.name.substr(7, 1)));
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var point:uint;
            var relPoint:uint;
            var chatChannel:Object;
            var chan0:*;
            var chan1:*;
            var chan2:*;
            var chan3:*;
            var data:Object;
            var tooltipText:String = "";
            var shortcutKey:String;
            var maxWidth:int;
            var channelLang:String = "";
            point = 7;
            relPoint = 1;
            switch (target)
            {
                case this.btn_smiley:
                    tooltipText = this.uiApi.getText("ui.smiley.title");
                    shortcutKey = this.bindsApi.getShortcutBindStr("toggleEmotes").toString();
                    break;
                case this.btn_plus:
                    tooltipText = this.uiApi.getText("ui.chat.resize.plus");
                    shortcutKey = this.bindsApi.getShortcutBindStr("extendChat").toString();
                    maxWidth = 240;
                    break;
                case this.btn_minus:
                    tooltipText = this.uiApi.getText("ui.chat.resize.minus");
                    shortcutKey = this.bindsApi.getShortcutBindStr("shrinkChat").toString();
                    maxWidth = 240;
                    break;
                case this.btn_menu:
                    tooltipText = this.uiApi.getText("ui.option.chat");
                    break;
                case this.tx_newMessages:
                    tooltipText = this.uiApi.processText(this.uiApi.getText("ui.ankabox.unread", this._unreadMessagesCount), "", (this._unreadMessagesCount <= 1), (this._unreadMessagesCount == 0));
                    break;
                case this.btn_tab0:
                    for each (chan0 in this._aTabs[0])
                    {
                        channelLang = "";
                        if (chan0 == ChatActivableChannelsEnum.CHANNEL_COMMUNITY)
                        {
                            if (((!(this._currentCommunityLang)) || (this._communityChannelLangs.length <= 1)))
                            {
                                continue;
                            };
                            channelLang = (" " + this._currentCommunityLang.langCode.toLocaleUpperCase());
                        };
                        chatChannel = this.dataApi.getChatChannel(chan0);
                        tooltipText = (tooltipText + ((chatChannel.name + channelLang) + "\n"));
                    };
                    tooltipText = (tooltipText + ("\n" + this.uiApi.getText("ui.common.rightclick.filter")));
                    break;
                case this.btn_tab1:
                    for each (chan1 in this._aTabs[1])
                    {
                        channelLang = "";
                        if (chan1 == ChatActivableChannelsEnum.CHANNEL_COMMUNITY)
                        {
                            if (((!(this._currentCommunityLang)) || (this._communityChannelLangs.length <= 1)))
                            {
                                continue;
                            };
                            channelLang = (" " + this._currentCommunityLang.langCode.toLocaleUpperCase());
                        };
                        chatChannel = this.dataApi.getChatChannel(chan1);
                        tooltipText = (tooltipText + ((chatChannel.name + channelLang) + "\n"));
                    };
                    tooltipText = (tooltipText + ("\n" + this.uiApi.getText("ui.common.rightclick.filter")));
                    break;
                case this.btn_tab2:
                    for each (chan2 in this._aTabs[2])
                    {
                        channelLang = "";
                        if (chan2 == ChatActivableChannelsEnum.CHANNEL_COMMUNITY)
                        {
                            if (((!(this._currentCommunityLang)) || (this._communityChannelLangs.length <= 1)))
                            {
                                continue;
                            };
                            channelLang = (" " + this._currentCommunityLang.langCode.toLocaleUpperCase());
                        };
                        chatChannel = this.dataApi.getChatChannel(chan2);
                        tooltipText = (tooltipText + ((chatChannel.name + channelLang) + "\n"));
                    };
                    tooltipText = (tooltipText + ("\n" + this.uiApi.getText("ui.common.rightclick.filter")));
                    break;
                case this.btn_tab3:
                    for each (chan3 in this._aTabs[3])
                    {
                        channelLang = "";
                        if (chan3 == ChatActivableChannelsEnum.CHANNEL_COMMUNITY)
                        {
                            if (((!(this._currentCommunityLang)) || (this._communityChannelLangs.length <= 1)))
                            {
                                continue;
                            };
                            channelLang = (" " + this._currentCommunityLang.langCode.toLocaleUpperCase());
                        };
                        chatChannel = this.dataApi.getChatChannel(chan3);
                        tooltipText = (tooltipText + ((chatChannel.name + channelLang) + "\n"));
                    };
                    tooltipText = (tooltipText + ("\n" + this.uiApi.getText("ui.common.rightclick.filter")));
                    break;
                case this.btn_status:
                    switch (_currentStatus)
                    {
                        case PlayerStatusEnum.PLAYER_STATUS_AFK:
                            if (this._awayMessage != "")
                            {
                                tooltipText = ((this.uiApi.getText("ui.chat.status.away") + this.uiApi.getText("ui.common.colon")) + this._awayMessage);
                            }
                            else
                            {
                                tooltipText = this.uiApi.getText("ui.chat.status.away");
                            };
                            break;
                        case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                            tooltipText = this.uiApi.getText("ui.chat.status.idle");
                            break;
                        case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                            tooltipText = this.uiApi.getText("ui.chat.status.private");
                            break;
                        case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                            tooltipText = this.uiApi.getText("ui.chat.status.solo");
                            break;
                        case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                            tooltipText = this.uiApi.getText("ui.chat.status.availiable");
                            break;
                    };
                    maxWidth = 400;
                    break;
            };
            if (tooltipText != "")
            {
                if (shortcutKey)
                {
                    if (!_shortcutColor)
                    {
                        _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                        _shortcutColor = _shortcutColor.replace("0x", "#");
                    };
                    data = this.uiApi.textTooltipInfo((((((tooltipText + " <font color='") + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"), null, null, maxWidth);
                }
                else
                {
                    data = this.uiApi.textTooltipInfo(tooltipText, null, null, maxWidth);
                };
                this.uiApi.showTooltip(data, target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        private function onFocusTimer(e:Event):void
        {
            this.inp_tchatinput.focus();
            this._focusTimer.stop();
            this._focusTimer.reset();
        }

        private function onChatHyperlink(hyperLinkCode:String):void
        {
            var hyperlinkInfo:Array = hyperLinkCode.split(",");
            var staticHyperlink:String = this.chatApi.getStaticHyperlink(hyperLinkCode);
            if (((staticHyperlink) && (staticHyperlink.length > 0)))
            {
                if ((((((((hyperlinkInfo[0] == "{spell") || (hyperlinkInfo[0] == "{recipe")) || (hyperlinkInfo[0] == "{chatachievement")) || (hyperlinkInfo[0] == "{chatmonster")) || (hyperlinkInfo[0] == "{guild")) || (hyperlinkInfo[0] == "{alliance")) || (hyperlinkInfo[0] == "{chatdare")))
                {
                    this._aMiscReplacement.push(staticHyperlink, hyperLinkCode);
                };
                this.inp_tchatinput.appendText((staticHyperlink + " "));
                this.inp_tchatinput.focus();
                this.inp_tchatinput.caretIndex = -1;
            };
        }

        private function onChatWarning():void
        {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.popup.warningForbiddenLink"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, true, true);
        }

        private function onChatLinkRelease(link:String, sender:Number, senderName:String):void
        {
            this.sysApi.goToCheckLink(link, sender, senderName);
        }

        private function onPopupWarning(author:String, content:String, duration:uint):void
        {
            var msg:String = ((author + this.uiApi.getText("ui.common.colon")) + content);
            this.modCommon.openLockedPopup(this.uiApi.getText("ui.popup.warning"), msg, null, false, [duration.toString()], false, true);
        }

        private function onMouseShiftClick(target:Object):void
        {
            var data:Object = target.data;
            if (data)
            {
                if ((data is ShortcutWrapper))
                {
                    data = (data as ShortcutWrapper).realItem;
                };
                if (((data.hasOwnProperty("isPresetObject")) && (data.isPresetObject)))
                {
                    return;
                };
                if (((((((((((data is SmileyWrapper) || (data is EmoteWrapper)) || (data is ButtonWrapper)) || (data is HavenbagFurnitureWrapper)) || (data is MapViewer)) || (data is OrnamentWrapper)) || (data is EmblemWrapper)) || (data is BuildWrapper)) || (data is IdolsPresetWrapper)) || (data is MountWrapper)))
                {
                    return;
                };
                this.onInsertHyperlink(data, ((target.hasOwnProperty("params")) ? target.params : null));
            };
        }

        public function onEmoteEnabledListUpdated(emotesOk:Object):void
        {
            if (emotesOk.length == 0)
            {
                if (this.uiApi.getUi(UIEnum.SMILEY_UI))
                {
                    this.uiApi.unloadUi(UIEnum.SMILEY_UI);
                };
            };
        }

        public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int, alliesPreparation:Boolean):void
        {
            if (isSpectator)
            {
                if (this._sChanLocked == this._sChanLockedBeforeSpec)
                {
                    if (this.sysApi.getOption("channelLocked", "chat"))
                    {
                        this.changeDefaultChannel(this.dataApi.getChatChannel(1).shortcut);
                    };
                };
            };
        }

        public function onGameFightLeave(id:Number):void
        {
            if (((id == this.playerApi.id()) && (this._sChanLocked == this.dataApi.getChatChannel(1).shortcut)))
            {
                if (this.sysApi.getOption("channelLocked", "chat"))
                {
                    this.changeDefaultChannel(this.dataApi.getChatChannel(0).shortcut);
                };
            };
        }

        private function onInsertRecipeHyperlink(id:uint):void
        {
            this.onInsertHyperlink(id, {"isRecipe":true});
        }

        private function onInsertHyperlink(data:Object, params:Object=null):void
        {
            var staticHyperlink:String;
            var hyperLinkCode:String;
            var isGeneric:Boolean;
            if (data.hasOwnProperty("objectUID"))
            {
                if (this._aItemReplacement.length >= MAX_CHAT_ITEMS)
                {
                    return;
                };
                hyperLinkCode = (("{item," + data.objectGID) + "}");
                staticHyperlink = this.chatApi.getStaticHyperlink(hyperLinkCode);
                if ((this.inp_tchatinput.length + (staticHyperlink + " ").length) > this.inp_tchatinput.maxChars)
                {
                    return;
                };
                this._aItemReplacement.push(data);
                isGeneric = (data.objectUID == 0);
                if (isGeneric)
                {
                    this._dGenericItemIndex[data.objectGID] = data;
                }
                else
                {
                    this._dItemIndex[data.objectUID] = data;
                };
                this.inp_tchatinput.addHyperLinkCode((((("{item," + data.objectGID) + ",") + data.objectUID) + "}"));
            }
            else
            {
                if (((params) && (params.isRecipe)))
                {
                    hyperLinkCode = (("{recipe," + data) + "}");
                }
                else
                {
                    if ((data is Achievement))
                    {
                        hyperLinkCode = (("{chatachievement," + data.id) + "}");
                    }
                    else
                    {
                        if ((data is Monster))
                        {
                            hyperLinkCode = (("{chatmonster," + data.id) + "}");
                        }
                        else
                        {
                            if ((data is AllianceWrapper))
                            {
                                hyperLinkCode = this.chatApi.getAllianceLink(data);
                            }
                            else
                            {
                                if ((data is GuildFactSheetWrapper))
                                {
                                    hyperLinkCode = this.chatApi.getGuildLink(data);
                                }
                                else
                                {
                                    if (data.hasOwnProperty("spellLevel"))
                                    {
                                        hyperLinkCode = (((("{spell," + data.id) + ",") + data.spellLevel) + "}");
                                    }
                                    else
                                    {
                                        if ((data is TitleWrapper))
                                        {
                                            return;
                                        };
                                        if (data == "Map")
                                        {
                                            hyperLinkCode = (((((((("{map," + params.x) + ",") + params.y) + ",") + params.worldMapId) + ",") + escape(params.elementName)) + "}");
                                        }
                                        else
                                        {
                                            if (data == "MonsterGroup")
                                            {
                                                hyperLinkCode = (((((((((("{monsterGroup," + params.x) + ",") + params.y) + ",") + params.worldMapId) + ",") + escape(params.monsterName)) + ",") + params.infos) + "}");
                                            }
                                            else
                                            {
                                                if (data == "MonsterGroupScale")
                                                {
                                                    hyperLinkCode = (((((((((((("{monsterGroup," + params.x) + ",") + params.y) + ",") + params.worldMapId) + ",") + escape(params.monsterName)) + ",") + params.infos) + ",") + ((this.playerApi.isInBreach()) ? 1 : 2)) + "}");
                                                }
                                                else
                                                {
                                                    if ((data is DareWrapper))
                                                    {
                                                        hyperLinkCode = (("{chatdare," + data.dareId) + "}");
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                staticHyperlink = this.chatApi.getStaticHyperlink(hyperLinkCode);
                if (((!(staticHyperlink)) || ((this.inp_tchatinput.length + (staticHyperlink + " ").length) > this.inp_tchatinput.maxChars)))
                {
                    return;
                };
                this._aMiscReplacement.push(staticHyperlink, hyperLinkCode);
            };
            this.inp_tchatinput.appendText((staticHyperlink + " "));
            this.inp_tchatinput.focus();
            this.inp_tchatinput.caretIndex = -1;
        }

        private function autocompleteChat():void
        {
            var subString:String;
            var text:String = this.inp_tchatinput.text;
            var i:int = (text.length - 1);
            while (i >= 0)
            {
                if (text.charAt(i) == " ")
                {
                    text = text.substr(0, i);
                }
                else
                {
                    break;
                };
                i--;
            };
            var lidx:int = text.lastIndexOf(" ");
            if ((((lidx == -1) || (!(text.substr(0, lidx).indexOf(" ") == -1))) || (!(text.charAt(0) == "/"))))
            {
                return;
            };
            subString = text.substr((lidx + 1));
            if (subString.length == 0)
            {
                return;
            };
            if (((!(this._autocompletionLastCompletion)) || (!(this._autocompletionLastCompletion == subString))))
            {
                this._autocompletionCount = 0;
                this._autocompletionSubString = subString;
            };
            var autocompletion:String = this.chatApi.getAutocompletion(this._autocompletionSubString, this._autocompletionCount);
            if (((autocompletion == null) && (this._autocompletionCount > 0)))
            {
                this._autocompletionCount = 0;
                autocompletion = this.chatApi.getAutocompletion(this._autocompletionSubString, this._autocompletionCount);
            };
            if (autocompletion == null)
            {
                return;
            };
            this._autocompletionLastCompletion = autocompletion;
            this._autocompletionCount++;
            this.inp_tchatinput.text = ((text.substring(0, (lidx + 1)) + autocompletion) + " ");
            this.inp_tchatinput.caretIndex = -1;
        }

        public function onLauncherStatusChange(userId:String, status:String):void
        {
            if (userId == this.sysApi.getPlayerManager().accountId.toString())
            {
                if (((status == USER_STATUS_AWAY) && (!(_currentStatus == PlayerStatusEnum.PLAYER_STATUS_AFK))))
                {
                    Api.system.sendAction(new PlayerStatusUpdateRequest(PlayerStatusEnum.PLAYER_STATUS_AFK));
                }
                else
                {
                    if (((status == USER_STATUS_BUSY) && (!(_currentStatus == PlayerStatusEnum.PLAYER_STATUS_SOLO))))
                    {
                        Api.system.sendAction(new PlayerStatusUpdateRequest(PlayerStatusEnum.PLAYER_STATUS_SOLO));
                    }
                    else
                    {
                        if ((((status == USER_STATUS_AVAILABLE) && (!(_currentStatus == PlayerStatusEnum.PLAYER_STATUS_AVAILABLE))) && (!(_currentStatus == PlayerStatusEnum.PLAYER_STATUS_PRIVATE))))
                        {
                            Api.system.sendAction(new PlayerStatusUpdateRequest(PlayerStatusEnum.PLAYER_STATUS_AVAILABLE));
                        };
                    };
                };
                this._awayMessage = "";
            };
        }

        private function onStatusChange(status:uint, message:String=""):void
        {
            if (message == "")
            {
                Api.system.sendAction(new PlayerStatusUpdateRequest(status));
                this._awayMessage = "";
            }
            else
            {
                Api.system.sendAction(new PlayerStatusUpdateRequest(status, message));
                this.onNewAwayMessage(message);
            };
        }

        private function updateLauncherStatus(status:uint):void
        {
            if (((status == PlayerStatusEnum.PLAYER_STATUS_AFK) && (!(this._chatService.myStatus == USER_STATUS_AWAY))))
            {
                this._chatService.updateUserStatus(USER_STATUS_AWAY);
            }
            else
            {
                if (((status == PlayerStatusEnum.PLAYER_STATUS_SOLO) && (!(this._chatService.myStatus == USER_STATUS_BUSY))))
                {
                    this._chatService.updateUserStatus(USER_STATUS_BUSY);
                }
                else
                {
                    if ((((status == PlayerStatusEnum.PLAYER_STATUS_AVAILABLE) || (status == PlayerStatusEnum.PLAYER_STATUS_PRIVATE)) && (!(this._chatService.myStatus == USER_STATUS_AVAILABLE))))
                    {
                        this._chatService.updateUserStatus(USER_STATUS_AVAILABLE);
                    };
                };
            };
        }

        private function onStatusChangeWithMessage(status:uint):void
        {
            var oldMsg:Array = this.sysApi.getData("oldAwayMessage");
            this.modCommon.openInputComboBoxPopup(this.uiApi.getText("ui.popup.status.awaytitle"), this.uiApi.getText("ui.popup.status.awaymessage"), this.uiApi.getText("ui.popup.status.wipeAwayMessageHistory"), this.onSubmitAwayMessage, null, this.onResetAwayMessage, "", null, ProtocolConstantsEnum.USER_MAX_CHAT_LEN, oldMsg);
        }

        private function onSubmitAwayMessage(value:String):void
        {
            this.onStatusChange(PlayerStatusEnum.PLAYER_STATUS_AFK, value);
        }

        private function onResetAwayMessage():void
        {
            this.sysApi.setData("oldAwayMessage", []);
        }

        private function onPlayerStatusUpdate(accountId:uint, playerId:Number, status:uint, message:String):void
        {
            var statusName:String;
            if (playerId == this.playerApi.id())
            {
                switch (status)
                {
                    case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                        this.iconTexturebtn_status.uri = this.uiApi.createUri((this._iconsPath + "green.png"));
                        statusName = this.uiApi.getText("ui.chat.status.availiable");
                        break;
                    case PlayerStatusEnum.PLAYER_STATUS_AFK:
                        if (message != "")
                        {
                            this._awayMessage = message;
                        };
                        this.iconTexturebtn_status.uri = this.uiApi.createUri((this._iconsPath + "yellow.png"));
                        statusName = this.uiApi.getText("ui.chat.status.away");
                        break;
                    case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                        this.iconTexturebtn_status.uri = this.uiApi.createUri((this._iconsPath + "yellow.png"));
                        statusName = this.uiApi.getText("ui.chat.status.away");
                        break;
                    case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                        this.iconTexturebtn_status.uri = this.uiApi.createUri((this._iconsPath + "blue.png"));
                        statusName = this.uiApi.getText("ui.chat.status.private");
                        break;
                    case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                        this.iconTexturebtn_status.uri = this.uiApi.createUri((this._iconsPath + "red.png"));
                        statusName = this.uiApi.getText("ui.chat.status.solo");
                        break;
                };
                if (status != PlayerStatusEnum.PLAYER_STATUS_IDLE)
                {
                    _currentStatus = status;
                    this.updateLauncherStatus(status);
                };
                this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.chat.status.statuschange", [statusName]), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, this.timeApi.getTimestamp());
            };
        }

        private function onNewAwayMessage(message:String):void
        {
            var oldMsg:Array;
            var i:int;
            if (message != "")
            {
                oldMsg = this.sysApi.getData("oldAwayMessage");
                if (!oldMsg)
                {
                    oldMsg = [];
                }
                else
                {
                    if (oldMsg.length > 10)
                    {
                        oldMsg.pop();
                    };
                };
                i = 0;
                while (i < oldMsg.length)
                {
                    if (oldMsg[i] == message)
                    {
                        oldMsg.splice(i, 1);
                        break;
                    };
                    i++;
                };
                oldMsg.unshift(message);
            };
            this.sysApi.setData("oldAwayMessage", oldMsg);
        }

        private function onChatCommunityChannelCommunity(communityId:int):void
        {
            this._currentCommunityLang = this.dataApi.getServerLang(communityId);
        }

        private function onInactivityNotification(inactive:Boolean):void
        {
            if ((((inactive) && (!(_currentStatus == PlayerStatusEnum.PLAYER_STATUS_AFK))) && (!(this._idle))))
            {
                this._idle = true;
                this.onStatusChange(PlayerStatusEnum.PLAYER_STATUS_IDLE);
            }
            else
            {
                if (((!(inactive)) && (this._idle)))
                {
                    this._idle = false;
                    this.onStatusChange(_currentStatus, this._awayMessage);
                };
            };
        }

        private function trim(s:String):String
        {
            var start:int;
            while (((start < s.length) && ((((s.charAt(start) == " ") || (s.charAt(start) == "\n")) || (s.charAt(start) == "\t")) || (s.charAt(start) == "\r"))))
            {
                start++;
            };
            var end:int = (s.length - 1);
            while (((end >= 0) && ((((s.charAt(end) == " ") || (s.charAt(end) == "\n")) || (s.charAt(end) == "\t")) || (s.charAt(end) == "\r"))))
            {
                end--;
            };
            if ((end - start) == 0)
            {
                return ("");
            };
            return (s.substring(start, (end + 1)));
        }

        private function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            if (!data)
            {
                return (false);
            };
            return (((data is SpellWrapper) || (data is ShortcutWrapper)) || (data is ItemWrapper));
        }

        private function processDrop(target:Object, data:Object, source:Object):void
        {
            if (this.dropValidator(target, data, source))
            {
                this.onMouseShiftClick(target);
            };
        }


    }
}

import __AS3__.vec.Vector;
import __AS3__.vec.*;

class TabCache 
{

    public var texts:Vector.<String> = new Vector.<String>();


}


