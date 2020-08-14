package Ankama_GameUiCore
{
    import flash.display.Sprite;
    import Ankama_GameUiCore.ui.Banner;
    import Ankama_GameUiCore.ui.BannerMenu;
    import Ankama_GameUiCore.ui.ActionBar;
    import Ankama_GameUiCore.ui.ExternalActionBar;
    import Ankama_GameUiCore.ui.Chat;
    import Ankama_GameUiCore.ui.Smileys;
    import Ankama_GameUiCore.ui.MapInfo;
    import Ankama_GameUiCore.ui.MainMenu;
    import Ankama_GameUiCore.ui.PayZone;
    import Ankama_GameUiCore.ui.HardcoreDeath;
    import Ankama_GameUiCore.ui.BuffUi;
    import Ankama_GameUiCore.ui.FightModificatorUi;
    import Ankama_GameUiCore.ui.RewardsUi;
    import Ankama_GameUiCore.ui.Report;
    import Ankama_GameUiCore.ui.Zoom;
    import Ankama_GameUiCore.ui.CinematicPlayer;
    import Ankama_GameUiCore.ui.ExternalNotificationUi;
    import Ankama_GameUiCore.ui.OfflineSales;
    import Ankama_GameUiCore.ui.Proto;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.NotificationApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.ConfigApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import com.ankamagames.dofus.uiApi.ExternalNotificationApi;
    import com.ankamagames.dofus.uiApi.FightApi;
    import com.ankamagames.dofus.uiApi.ChatApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.HighlightApi;
    import Ankama_GameUiCore.managers.ExternalNotificationManager;
    import d2hooks.GameStart;
    import d2hooks.SmileysStart;
    import d2hooks.EnabledChannels;
    import d2hooks.TextInformation;
    import d2hooks.PlayerFightRequestSent;
    import d2hooks.PlayerFightFriendlyRequested;
    import d2hooks.PlayerFightFriendlyAnswered;
    import d2hooks.GameRolePlayPlayerLifeStatus;
    import d2hooks.SubscriptionZone;
    import d2hooks.NonSubscriberPopup;
    import d2hooks.GuestLimitationPopup;
    import d2hooks.GuestMode;
    import d2hooks.SlotDropedOnWorld;
    import d2hooks.RoleplayBuffViewContent;
    import d2hooks.RewardableAchievementsVisible;
    import d2hooks.AchievementRewardSuccess;
    import d2hooks.DareRewardVisible;
    import d2hooks.DareRewardSuccess;
    import d2hooks.AchievementFinished;
    import d2hooks.OpenReport;
    import d2hooks.WorldRightClick;
    import d2hooks.WorldMouseWheel;
    import d2hooks.Cinematic;
    import d2hooks.InactivityNotification;
    import d2hooks.AreaFightModificatorUpdate;
    import d2hooks.OpenOfflineSales;
    import d2hooks.OpenMainMenu;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import d2hooks.FoldAll;
    import com.ankamagames.berilia.enums.StrataEnum;
    import d2actions.PlayerFightFriendlyAnswer;
    import d2actions.AddIgnored;
    import d2hooks.CloseNotification;
    import d2actions.GameRolePlayFreeSoulRequest;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import d2actions.ObjectSetPosition;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
    import com.ankama.dofus.enums.ActionIds;
    import d2actions.ObjectDrop;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.dofus.network.types.game.achievement.AchievementAchieved;
    import d2hooks.*;
    import d2actions.*;

    public class GameUiCore extends Sprite 
    {

        private static var _self:GameUiCore;

        public const MILLISECONDS_IN_DAY:Number = 86400000;

        protected var banner:Banner;
        protected var bannerMenu:BannerMenu;
        protected var actionBar:ActionBar;
        protected var externalActionBar:ExternalActionBar;
        protected var chat:Chat;
        protected var smileys:Smileys;
        protected var mapInfo:MapInfo;
        protected var mainMenu:MainMenu;
        protected var payZone:PayZone;
        protected var hardcoreDeath:HardcoreDeath;
        protected var buffUi:BuffUi;
        protected var fightModificatorUi:FightModificatorUi;
        protected var rewardsUi:RewardsUi;
        protected var report:Report;
        protected var zoom:Zoom;
        protected var cinematic:CinematicPlayer;
        protected var externalnotification:ExternalNotificationUi;
        protected var offlineSales:OfflineSales;
        protected var proto:Proto;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="NotificationApi")]
        public var notifApi:NotificationApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="ConfigApi")]
        public var configApi:ConfigApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        [Api(name="ExternalNotificationApi")]
        public var extNotifApi:ExternalNotificationApi;
        [Api(name="FightApi")]
        public var fightApi:FightApi;
        [Api(name="ChatApi")]
        public var chatApi:ChatApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="HighlightApi")]
        public var highlight:HighlightApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Module(name="Ankama_Cartography")]
        public var modCartography:Object;
        private var _channels:Object;
        private var _currentPopupName:String;
        private var _waitingObject:Object;
        private var _waitingObjectName:String;
        private var _waitingObjectQuantity:int;
        private var _folded:Boolean = false;
        private var _ignoreName:String;
        private var _aTextInfos:Array = new Array();
        private var _inactivityPopup:String = null;
        public var areGiftsRequired:Boolean;
        public var areDareRewardRequired:Boolean;


        public static function getInstance():GameUiCore
        {
            return (_self);
        }


        public function main():void
        {
            Api.system = this.sysApi;
            Api.ui = this.uiApi;
            Api.extNotif = this.extNotifApi;
            Api.social = this.socialApi;
            Api.fight = this.fightApi;
            Api.player = this.playerApi;
            Api.data = this.dataApi;
            Api.chat = this.chatApi;
            Api.util = this.utilApi;
            Api.highlight = this.highlight;
            ExternalNotificationManager.getInstance().init();
            this.sysApi.createHook("FoldAll");
            this.sysApi.addHook(GameStart, this.onGameStart);
            this.sysApi.addHook(SmileysStart, this.onSmileysStart);
            this.sysApi.addHook(EnabledChannels, this.onEnabledChannels);
            this.sysApi.addHook(TextInformation, this.onTextInformation);
            this.sysApi.addHook(PlayerFightRequestSent, this.onPlayerFightRequestSent);
            this.sysApi.addHook(PlayerFightFriendlyRequested, this.onPlayerFightFriendlyRequested);
            this.sysApi.addHook(PlayerFightFriendlyAnswered, this.onPlayerFightFriendlyAnswered);
            this.sysApi.addHook(GameRolePlayPlayerLifeStatus, this.onGameRolePlayPlayerLifeStatus);
            this.sysApi.addHook(SubscriptionZone, this.onSubscriptionZone);
            this.sysApi.addHook(NonSubscriberPopup, this.onNonSubscriberPopup);
            this.sysApi.addHook(GuestLimitationPopup, this.onGuestLimitationPopup);
            this.sysApi.addHook(GuestMode, this.onGuestMode);
            this.sysApi.addHook(SlotDropedOnWorld, this.onSlotDropedOnWorld);
            this.sysApi.addHook(RoleplayBuffViewContent, this.onRoleplayBuffViewContent);
            this.sysApi.addHook(RewardableAchievementsVisible, this.onRewardableAchievementsVisible);
            this.sysApi.addHook(AchievementRewardSuccess, this.onAchievementRewardSuccess);
            this.sysApi.addHook(DareRewardVisible, this.onDareRewardVisible);
            this.sysApi.addHook(DareRewardSuccess, this.onDareRewardSuccess);
            this.sysApi.addHook(AchievementFinished, this.onAchievementFinished);
            this.sysApi.addHook(OpenReport, this.onReportOpen);
            this.sysApi.addHook(WorldRightClick, this.onWorldRightClick);
            this.sysApi.addHook(WorldMouseWheel, this.onWorldMouseWheel);
            this.sysApi.addHook(Cinematic, this.onCinematic);
            this.sysApi.addHook(InactivityNotification, this.onInactivityNotification);
            this.sysApi.addHook(AreaFightModificatorUpdate, this.onAreaFightModificatorUpdate);
            this.sysApi.addHook(OpenOfflineSales, this.onOpenOfflineSales);
            this.sysApi.addHook(OpenMainMenu, this.onOpenMainMenu);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addShortcutHook("transparancyMode", this.onShortcut);
            this.uiApi.addShortcutHook("showGrid", this.onShortcut);
            this.uiApi.addShortcutHook("foldAll", this.onShortcut);
            this.uiApi.addShortcutHook("cellSelectionOnly", this.onShortcut);
            this.uiApi.addShortcutHook("showCoord", this.onShortcut);
            _self = this;
        }

        public function getTooltipFightPlacer():Object
        {
            var ref:Object;
            if (this.uiApi.getUi(UIEnum.BANNER))
            {
                ref = this.uiApi.getUi(UIEnum.BANNER).getElement("tooltipFightPlacer");
            };
            return (ref);
        }

        private function onShortcut(s:String):Boolean
        {
            var val:Boolean;
            switch (s)
            {
                case "closeUi":
                    if (this.uiApi.getUi("cartographyUi"))
                    {
                        this.uiApi.unloadUi("cartographyUi");
                    }
                    else
                    {
                        this.onOpenMainMenu();
                    };
                    return (true);
                case "transparancyMode":
                    val = this.configApi.getConfigProperty("atouin", "transparentOverlayMode");
                    this.configApi.setConfigProperty("atouin", "transparentOverlayMode", (!(val)));
                    return (true);
                case "showGrid":
                    val = this.configApi.getConfigProperty("atouin", "alwaysShowGrid");
                    this.configApi.setConfigProperty("atouin", "alwaysShowGrid", (!(val)));
                    return (true);
                case "showCoord":
                    val = this.configApi.getConfigProperty("dofus", "mapCoordinates");
                    this.configApi.setConfigProperty("dofus", "mapCoordinates", (!(val)));
                    return (true);
                case "foldAll":
                    this._folded = (!(this._folded));
                    this.sysApi.dispatchHook(FoldAll, this._folded);
                    return (true);
                case "cellSelectionOnly":
                    val = this.configApi.getConfigProperty("dofus", "cellSelectionOnly");
                    this.configApi.setConfigProperty("dofus", "cellSelectionOnly", (!(val)));
                    return (true);
            };
            return (false);
        }

        private function onGameStart():void
        {
            this.uiApi.loadUi(UIEnum.MAP_INFO_UI, null, null, StrataEnum.STRATA_LOW);
            this.modCartography.openBannerMap();
            this.uiApi.loadUi(UIEnum.BANNER);
            if (!this.uiApi.getUi(UIEnum.CHAT_UI))
            {
                this.uiApi.loadUi(UIEnum.CHAT_UI, UIEnum.CHAT_UI, [this._channels, this._aTextInfos]);
                this._aTextInfos = [];
            };
            this.uiApi.loadUi("bannerMenu");
        }

        private function onSmileysStart(_arg_1:int, forceOpen:String=""):void
        {
            if (!this.uiApi.getUi(UIEnum.SMILEY_UI))
            {
                this.uiApi.loadUi(UIEnum.SMILEY_UI, UIEnum.SMILEY_UI, [_arg_1], StrataEnum.STRATA_TOP);
            };
        }

        private function onEnabledChannels(v:Object):void
        {
            if (!this.uiApi.getUi(UIEnum.CHAT_UI))
            {
                this._channels = v;
            };
        }

        private function onTextInformation(content:String="", channel:int=0, timestamp:Number=0, saveMsg:Boolean=true, forceDisplay:Boolean=false):void
        {
            if (!this.uiApi.getUi(UIEnum.CHAT_UI))
            {
                this._aTextInfos.push({
                    "content":content,
                    "channel":channel,
                    "timestamp":timestamp,
                    "saveMsg":saveMsg
                });
            };
        }

        private function onPlayerFightRequestSent(targetName:String, friendly:Boolean):void
        {
            if (friendly)
            {
                this._currentPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.fight.challenge"), this.uiApi.getText("ui.fight.youChallenge", targetName), [this.uiApi.getText("ui.charcrea.undo")], [this.onFightFriendlyRefused], null, this.onFightFriendlyRefused);
            };
        }

        private function onPlayerFightFriendlyRequested(targetName:String):void
        {
            this._ignoreName = targetName;
            this._currentPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.fight.challenge"), this.uiApi.getText("ui.fight.aChallengeYou", targetName), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no"), this.uiApi.getText("ui.common.ignore")], [this.onFightFriendlyAccepted, this.onFightFriendlyRefused, this.onFightFriendlyIgnore], this.onFightFriendlyAccepted, this.onFightFriendlyRefused);
        }

        private function onFightFriendlyAccepted():void
        {
            this.sysApi.sendAction(new PlayerFightFriendlyAnswer(true));
        }

        private function onFightFriendlyRefused():void
        {
            this.sysApi.sendAction(new PlayerFightFriendlyAnswer(false));
        }

        private function onFightFriendlyIgnore():void
        {
            this.sysApi.sendAction(new PlayerFightFriendlyAnswer(false));
            this.sysApi.sendAction(new AddIgnored(this._ignoreName));
        }

        private function onPlayerFightFriendlyAnswered(accept:Boolean):void
        {
            this.uiApi.unloadUi(this._currentPopupName);
            this._currentPopupName = null;
        }

        private function onWorldRightClick():void
        {
            var menu:Object;
            if (this.playerApi.isInFight())
            {
                menu = this.menuApi.create(null, "fightWorld");
            }
            else
            {
                menu = this.menuApi.create(null, "world");
            };
            this.modContextMenu.createContextMenu(menu);
        }

        private function onWorldMouseWheel(zoomIn:Boolean):void
        {
            if (this.sysApi.getOption("zoomOnMouseWheel", "dofus"))
            {
                Api.system.mouseZoom(zoomIn);
            };
        }

        private function onGameRolePlayPlayerLifeStatus(status:uint, hardcore:uint):void
        {
            if (hardcore == 0)
            {
                switch (status)
                {
                    case 0:
                        this.sysApi.dispatchHook(CloseNotification, "notifPhantom", false);
                        break;
                    case 1:
                        this.modCommon.openPopup(this.uiApi.getText("ui.login.news"), ((this.uiApi.getText("ui.gameuicore.playerDied") + "\n\n") + this.uiApi.getText("ui.gameuicore.freeSoul")), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onFreePlayerSoulAccepted, this.onFreePlayerSoulRefused], null, this.onFreePlayerSoulRefused, this.uiApi.createUri((this.sysApi.getConfigEntry("config.content.path") + "gfx/illusUi/gravestone.png")));
                        break;
                    case 2:
                        if (this.sysApi.getData("hasSeenPhantomPopup"))
                        {
                            this.notifApi.showNotification(this.uiApi.getText("ui.login.news"), this.uiApi.getText("ui.gameuicore.soulsWorld"), 0, "notifPhantom");
                        }
                        else
                        {
                            this.modCommon.openPopup(this.uiApi.getText("ui.login.news"), this.uiApi.getText("ui.gameuicore.soulsWorld"), [this.uiApi.getText("ui.common.ok")]);
                            this.sysApi.setData("hasSeenPhantomPopup", true);
                        };
                        break;
                };
            }
            else
            {
                if (!this.uiApi.getUi("hardcoreDeath"))
                {
                    this.uiApi.loadUi("hardcoreDeath");
                };
            };
        }

        private function onFreePlayerSoulAccepted():void
        {
            this.sysApi.sendAction(new GameRolePlayFreeSoulRequest());
        }

        private function onFreePlayerSoulRefused():void
        {
        }

        private function onSubscriptionZone(active:Boolean):void
        {
            var payZonePopupAlreadySeen:Boolean;
            if (active)
            {
                if (!this.uiApi.getUi("payZone"))
                {
                    payZonePopupAlreadySeen = this.sysApi.getData("payZonePopupAlreadySeen", DataStoreEnum.BIND_COMPUTER);
                    if (payZonePopupAlreadySeen)
                    {
                        this.uiApi.loadUi("payZone", "payZone", ["payzone", false, true]);
                    }
                    else
                    {
                        this.uiApi.loadUi("payZone", "payZone", ["payzone", true, true]);
                    };
                    this.sysApi.setData("payZonePopupAlreadySeen", true, DataStoreEnum.BIND_COMPUTER);
                };
            }
            else
            {
                if (this.uiApi.getUi("payZone"))
                {
                    this.uiApi.unloadUi("payZone");
                };
            };
        }

        private function onNonSubscriberPopup(modeKeyword:String="payzone"):void
        {
            if (!this.uiApi.getUi("payZone"))
            {
                this.uiApi.loadUi("payZone", "payZone", [modeKeyword, true, false]);
            };
        }

        public function onGuestLimitationPopup():void
        {
            if (!this.uiApi.getUi("payZone"))
            {
                this.uiApi.loadUi("payZone", "payZone", ["guest", true, false], StrataEnum.STRATA_TOP);
            };
        }

        private function onGuestMode(active:Boolean):void
        {
            if (active)
            {
                if (!this.uiApi.getUi("payZone"))
                {
                    this.uiApi.loadUi("payZone", "payZone", ["guest", false, true], StrataEnum.STRATA_TOP);
                };
            }
            else
            {
                if (this.uiApi.getUi("payZone"))
                {
                    this.uiApi.unloadUi("payZone");
                };
            };
        }

        private function onAreaFightModificatorUpdate(spellPairId:int):void
        {
            if (((!(this.uiApi.getUi("fightModificatorUi"))) && (spellPairId > -1)))
            {
                this.uiApi.loadUi("fightModificatorUi", "fightModificatorUi", {"pairId":spellPairId});
            };
        }

        private function onRoleplayBuffViewContent(buffs:Object):void
        {
            if (!this.uiApi.getUi(UIEnum.BUFF_UI))
            {
                this.uiApi.loadUi(UIEnum.BUFF_UI, UIEnum.BUFF_UI, {"buffs":buffs});
            };
        }

        public function removeFromBanner(pObject:Object):void
        {
            if (this.uiApi.keyIsDown(16))
            {
                if (pObject.hasOwnProperty("objectUID"))
                {
                    this.sysApi.sendAction(new ObjectSetPosition(pObject.objectUID, 63));
                };
            };
        }

        public function onSlotDropedOnWorld(pSlot:Object, pDropTarget:Object):void
        {
            var effect:Object;
            switch (true)
            {
                case (pSlot.data is SpellWrapper):
                case (pSlot.data is BuildWrapper):
                    break;
                case (pSlot.data is ItemWrapper):
                    if (((pSlot.data.position > 63) && (pSlot.data.position < 318)))
                    {
                        this.removeFromBanner(pSlot.data);
                    };
                    for each (effect in pSlot.data.effects)
                    {
                        if ((((effect.effectId == ActionIds.ACTION_MARK_NEVER_TRADABLE_STRONG) || (effect.effectId == ActionIds.ACTION_MARK_NEVER_TRADABLE)) || (effect.effectId == ActionIds.ACTION_MARK_NOT_TRADABLE)))
                        {
                            this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.objectError.CannotDrop"), 10, this.timeApi.getTimestamp());
                            return;
                        };
                    };
                    if (this.playerApi.isInExchange())
                    {
                        return;
                    };
                    this._waitingObject = pSlot.data;
                    this._waitingObjectName = this.dataApi.getItemName(this._waitingObject.objectGID);
                    if (this._waitingObject.quantity > 1)
                    {
                        this.modCommon.openQuantityPopup(1, this._waitingObject.quantity, this._waitingObject.quantity, this.onValidQtyDrop);
                    }
                    else
                    {
                        this.sysApi.sendAction(new ObjectDrop(this._waitingObject.objectUID, this._waitingObject.objectGID, 1));
                    };
                    break;
            };
        }

        private function onValidQtyDrop(pQuantity:int):void
        {
            this._waitingObjectQuantity = pQuantity;
            this.sysApi.sendAction(new ObjectDrop(this._waitingObject.objectUID, this._waitingObject.objectGID, this._waitingObjectQuantity));
        }

        private function onReportOpen(playerID:Number, playerName:String, context:Object=null):void
        {
            this.uiApi.unloadUi("report");
            this.uiApi.loadUi("report", "report", {
                "playerID":playerID,
                "playerName":playerName,
                "context":context
            });
        }

        public function onCinematic(cinematicId:int, checkLastPlayed:Boolean):void
        {
            var date:Date = new Date();
            var lastPlayDate:Number = this.sysApi.getData(("lastPlay_" + cinematicId), DataStoreEnum.BIND_COMPUTER);
            if ((((checkLastPlayed) && (lastPlayDate > 0)) && (date.getTime() < (lastPlayDate + (7 * this.MILLISECONDS_IN_DAY)))))
            {
                return;
            };
            this.sysApi.setData(("lastPlay_" + cinematicId), date.getTime(), DataStoreEnum.BIND_COMPUTER);
            if (!this.uiApi.getUi(UIEnum.CHAT_UI))
            {
                this.uiApi.loadUi(UIEnum.CHAT_UI, UIEnum.CHAT_UI, [this._channels, this._aTextInfos]);
                this._aTextInfos = [];
            };
            var cinematicStrId:String = ("" + cinematicId);
            if (cinematicId == 10)
            {
                cinematicStrId = ((this.sysApi.getCurrentLanguage() + "/") + cinematicStrId);
            };
            if (cinematicId > 100)
            {
                if (this.sysApi.getData("trailer1Viewed"))
                {
                    return;
                };
                this.sysApi.setData("trailer1Viewed", true);
            };
            this.uiApi.loadUi("cinematic", "cinematic", {"cinematicId":cinematicStrId}, StrataEnum.STRATA_TOP);
        }

        private function onInactivityNotification(inactive:Boolean):void
        {
            if (((inactive) && (!(this._inactivityPopup))))
            {
                this._inactivityPopup = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.common.inactivityWarning"), [this.uiApi.getText("ui.common.ok")], [this.inactivityPopupClosed], this.inactivityPopupClosed, this.inactivityPopupClosed);
            };
        }

        private function inactivityPopupClosed():void
        {
            this._inactivityPopup = null;
        }

        private function onRewardableAchievementsVisible(b:Boolean):void
        {
            var rewardUi:UiRootContainer;
            if (b)
            {
                rewardUi = this.uiApi.getUi(UIEnum.REWARDS);
                if (!rewardUi)
                {
                    this.uiApi.loadUi(UIEnum.REWARDS);
                }
                else
                {
                    rewardUi.uiClass.onRewardableAchievementsVisible();
                };
            }
            else
            {
                this.uiApi.unloadUi(UIEnum.REWARDS);
            };
        }

        private function onAchievementFinished(finishedAchievement:AchievementAchieved):void
        {
            var rewardUi:UiRootContainer = this.uiApi.getUi(UIEnum.REWARDS);
            if (((rewardUi) && (!(this.playerApi.isInFight()))))
            {
                rewardUi.uiClass.onRewardableAchievementsVisible();
            };
        }

        public function onAchievementRewardSuccess(achievementId:int):void
        {
            var rewardUi:UiRootContainer = this.uiApi.getUi(UIEnum.REWARDS);
            if (!rewardUi)
            {
                this.uiApi.loadUi(UIEnum.REWARDS);
            }
            else
            {
                rewardUi.uiClass.onAchievementRewardSuccess();
            };
        }

        private function onDareRewardVisible(b:Boolean):void
        {
            this.areDareRewardRequired = b;
            var rewardUi:UiRootContainer = this.uiApi.getUi(UIEnum.REWARDS);
            if (!rewardUi)
            {
                this.uiApi.loadUi(UIEnum.REWARDS);
            }
            else
            {
                rewardUi.uiClass.onDareRewardVisible();
            };
        }

        private function onDareRewardSuccess():void
        {
            var rewardUi:UiRootContainer = this.uiApi.getUi(UIEnum.REWARDS);
            if (!rewardUi)
            {
                this.uiApi.loadUi(UIEnum.REWARDS);
            }
            else
            {
                rewardUi.uiClass.onDareRewardSuccess();
            };
        }

        private function onOpenOfflineSales(pTab:uint, pOfflineSales:Object, pUnsoldItems:Object):void
        {
            this.uiApi.loadUi("offlineSales", null, {
                "tab":pTab,
                "sales":pOfflineSales,
                "unsoldItems":pUnsoldItems
            }, 1, null, true, false, false);
        }

        public function onOpenMainMenu():void
        {
            if (!this.uiApi.getUi("mainMenu"))
            {
                this.uiApi.loadUi("mainMenu", null, null, StrataEnum.STRATA_TOP);
            }
            else
            {
                this.uiApi.unloadUi("mainMenu");
            };
        }


    }
} Ankama_GameUiCore

