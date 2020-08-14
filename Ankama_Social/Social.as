package Ankama_Social
{
    import flash.display.Sprite;
    import Ankama_Social.ui.SocialBase;
    import Ankama_Social.ui.Friends;
    import Ankama_Social.ui.AddFriendWindow;
    import Ankama_Social.ui.Spouse;
    import Ankama_Social.ui.Guild;
    import Ankama_Social.ui.Alliance;
    import Ankama_Social.ui.Directory;
    import Ankama_Social.ui.HousesList;
    import Ankama_Social.ui.GuildCard;
    import Ankama_Social.ui.AllianceCard;
    import Ankama_Social.ui.GuildHouses;
    import Ankama_Social.ui.GuildMembers;
    import Ankama_Social.ui.GuildMemberRights;
    import Ankama_Social.ui.GuildPaddock;
    import Ankama_Social.ui.GuildPersonalization;
    import Ankama_Social.ui.GuildTaxCollector;
    import Ankama_Social.ui.GuildCreator;
    import Ankama_Social.ui.AllianceMembers;
    import Ankama_Social.ui.AllianceAreas;
    import Ankama_Social.ui.AllianceFights;
    import Ankama_Social.ui.AllianceCreator;
    import Ankama_Social.ui.CollectedTaxCollector;
    import Ankama_Social.ui.TopTaxCollectors;
    import Ankama_Social.ui.SocialBulletin;
    import Ankama_Social.ui.Dare;
    import Ankama_Social.ui.DareList;
    import Ankama_Social.ui.DareCreation;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import d2hooks.OpenSocial;
    import d2hooks.OpenHouses;
    import d2hooks.ClientUIOpened;
    import d2hooks.ContextChanged;
    import d2hooks.GuildCreationStarted;
    import d2hooks.GuildInvited;
    import d2hooks.GuildInvitationStateRecruter;
    import d2hooks.GuildInvitationStateRecruted;
    import d2hooks.AllianceCreationStarted;
    import d2hooks.AllianceInvited;
    import d2hooks.AllianceInvitationStateRecruter;
    import d2hooks.AllianceInvitationStateRecruted;
    import d2hooks.AttackPlayer;
    import d2hooks.DishonourChanged;
    import d2hooks.OpenOneAlliance;
    import d2hooks.OpenOneGuild;
    import d2hooks.OpenDareSearch;
    import d2hooks.ShowCollectedTaxCollector;
    import d2hooks.ShowTopTaxCollectors;
    import d2actions.SpouseRequest;
    import d2actions.PlayerFightRequest;
    import d2actions.GuildInvitationAnswer;
    import d2actions.AllianceInvitationAnswer;
    import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
    import d2hooks.*;
    import d2actions.*;

    public class Social extends Sprite 
    {

        private static var _self:Social;

        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        protected var socialBase:SocialBase;
        protected var friends:Friends;
        protected var addFriendWindow:AddFriendWindow;
        protected var spouse:Spouse;
        protected var guild:Guild;
        protected var alliance:Alliance;
        protected var directory:Directory;
        protected var housesList:HousesList;
        protected var guildCard:GuildCard;
        protected var allianceCard:AllianceCard;
        protected var guildHouses:GuildHouses;
        protected var guildMembers:GuildMembers;
        protected var guildMemberRights:GuildMemberRights;
        protected var guildPaddock:GuildPaddock;
        protected var guildPersonalization:GuildPersonalization;
        protected var guildTaxCollector:GuildTaxCollector;
        protected var guildCreator:GuildCreator;
        protected var allianceMembers:AllianceMembers;
        protected var allianceAreas:AllianceAreas;
        protected var allianceFights:AllianceFights;
        protected var allianceCreator:AllianceCreator;
        protected var collectedTaxCollector:CollectedTaxCollector;
        protected var topTaxCollectors:TopTaxCollectors;
        protected var socialBulletin:SocialBulletin;
        protected var dare:Dare;
        protected var dareList:DareList;
        protected var dareCreation:DareCreation;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        private var _firstTime:Boolean = true;
        private var _ava:Boolean;
        private var _targetId:Number;
        private var _cellId:int;
        private var _popupName:String = null;
        private var _popupAllianceName:String = null;
        private var _dareCreationStatus:Object;


        public static function getInstance():Social
        {
            return (_self);
        }


        public function main():void
        {
            Api.system = this.sysApi;
            Api.social = this.socialApi;
            Api.ui = this.uiApi;
            Api.player = this.playerApi;
            Api.modCommon = this.modCommon;
            Api.data = this.dataApi;
            Api.util = this.utilApi;
            Api.time = this.timeApi;
            _self = this;
            this.sysApi.addHook(OpenSocial, this.onOpenSocial);
            this.sysApi.addHook(OpenHouses, this.onOpenHouses);
            this.sysApi.addHook(ClientUIOpened, this.onClientUIOpened);
            this.sysApi.addHook(ContextChanged, this.onContextChanged);
            this.sysApi.addHook(GuildCreationStarted, this.onCreateGuild);
            this.sysApi.addHook(GuildInvited, this.onGuildInvited);
            this.sysApi.addHook(GuildInvitationStateRecruter, this.onGuildInvitationStateRecruter);
            this.sysApi.addHook(GuildInvitationStateRecruted, this.onGuildInvitationStateRecruted);
            this.sysApi.addHook(AllianceCreationStarted, this.onCreateAlliance);
            this.sysApi.addHook(AllianceInvited, this.onAllianceInvited);
            this.sysApi.addHook(AllianceInvitationStateRecruter, this.onAllianceInvitationStateRecruter);
            this.sysApi.addHook(AllianceInvitationStateRecruted, this.onAllianceInvitationStateRecruted);
            this.sysApi.addHook(AttackPlayer, this.onAttackPlayer);
            this.sysApi.addHook(DishonourChanged, this.onDishonourChanged);
            this.sysApi.addHook(OpenOneAlliance, this.onOpenOneAlliance);
            this.sysApi.addHook(OpenOneGuild, this.onOpenOneGuild);
            this.sysApi.addHook(OpenDareSearch, this.onOpenDareSearch);
            this.sysApi.addHook(ShowCollectedTaxCollector, this.onShowCollectedTaxCollector);
            this.sysApi.addHook(ShowTopTaxCollectors, this.onShowTopTaxCollectors);
            if (!this.sysApi.getData("guildBulletinLastVisitTimestamp"))
            {
                this.sysApi.setData("guildBulletinLastVisitTimestamp", 0);
            };
            if (!this.sysApi.getData("allianceBulletinLastVisitTimestamp"))
            {
                this.sysApi.setData("allianceBulletinLastVisitTimestamp", 0);
            };
        }

        public function get dareCreationStatus():Object
        {
            return (this._dareCreationStatus);
        }

        public function set dareCreationStatus(status:Object):void
        {
            this._dareCreationStatus = status;
        }

        private function onCreateGuild(modifyName:Boolean, modifyEmblem:Boolean):void
        {
            this.uiApi.loadUi("guildCreator", "guildCreator", [modifyName, modifyEmblem]);
        }

        private function onCreateAlliance(modifyName:Boolean, modifyEmblem:Boolean):void
        {
            this.uiApi.loadUi("allianceCreator", "allianceCreator", [modifyName, modifyEmblem]);
        }

        private function onOpenOneGuild(guild:Object):void
        {
            this.uiApi.unloadUi("allianceCard");
            if (!this.uiApi.getUi("guildCard"))
            {
                this.uiApi.loadUi("guildCard", "guildCard", {"guild":guild});
            };
        }

        private function onOpenOneAlliance(alliance:Object):void
        {
            this.uiApi.unloadUi("guildCard");
            if (!this.uiApi.getUi("allianceCard"))
            {
                this.uiApi.loadUi("allianceCard", "allianceCard", {"alliance":alliance});
            };
        }

        private function onOpenDareSearch(search:String, filter:String=null, forceRefresh:Boolean=true):void
        {
            var args:Object;
            if (!this.uiApi.getUi("socialBase"))
            {
                args = new Object();
                args.tab = 5;
                args.subTab = 0;
                args.params = ((filter) ? [search, filter] : [search]);
                args.restoreSnapshotAfterLoading = false;
                this.uiApi.loadUi("socialBase", "socialBase", args);
            }
            else
            {
                this.uiApi.getUi("socialBase").uiClass.openTab(5, 0, ((filter) ? [search, filter] : [search]));
            };
        }

        private function onOpenSocial(tab:int=-1, subTab:int=-1, params:Object=null):void
        {
            var args:Object;
            this.sysApi.log(8, ((((("onOpenSocial " + tab) + ", ") + subTab) + ", ") + params));
            if (((tab == 2) && (!(this.playerApi.characteristics()))))
            {
                return;
            };
            if (tab == 3)
            {
                if (!this.uiApi.getUi("spouse"))
                {
                    this.sysApi.sendAction(new SpouseRequest());
                    this.uiApi.loadUi("spouse");
                }
                else
                {
                    this.uiApi.unloadUi("spouse");
                };
                return;
            };
            if (!this.uiApi.getUi("socialBase"))
            {
                if (((tab == 3) && (this.socialApi.getSpouse() == null)))
                {
                    return;
                };
                args = new Object();
                if (tab != -1)
                {
                    args.tab = tab;
                };
                if (subTab != -1)
                {
                    args.subTab = subTab;
                };
                if (((!(params == null)) && (params.length > 0)))
                {
                    args.params = params;
                };
                if (subTab == -1)
                {
                    this.uiApi.loadUi("socialBase", "socialBase", args);
                }
                else
                {
                    this.uiApi.loadUi("socialBase", "socialBase", args, 1, null, false, false, false);
                };
            }
            else
            {
                if (tab != -1)
                {
                    if (((!(this.uiApi.getUi("socialBase").uiClass.getTab() == tab)) || ((!(subTab == -1)) && (!(this.uiApi.getUi("socialBase").uiClass.getSubTab() == subTab)))))
                    {
                        if (subTab == -1)
                        {
                            this.uiApi.getUi("socialBase").uiClass.openTab(tab);
                        }
                        else
                        {
                            if (params == null)
                            {
                                this.uiApi.getUi("socialBase").uiClass.openTab(tab, subTab, null, false);
                            }
                            else
                            {
                                this.uiApi.getUi("socialBase").uiClass.openTab(tab, subTab, params, false);
                            };
                        };
                    }
                    else
                    {
                        this.uiApi.unloadUi("socialBase");
                    };
                }
                else
                {
                    this.uiApi.unloadUi("socialBase");
                };
            };
        }

        private function onOpenHouses():void
        {
            if (!this.uiApi.getUi("housesList"))
            {
                this.uiApi.loadUi("housesList");
            };
        }

        private function onContextChanged(context:uint):void
        {
            if (context == 2)
            {
                this.uiApi.unloadUi("socialBase");
            };
        }

        private function onClientUIOpened(_arg_1:uint, uid:uint):void
        {
            if (this.socialApi.hasGuild())
            {
                if (!this.uiApi.getUi("socialBase"))
                {
                    switch (_arg_1)
                    {
                        case 0:
                            this.sysApi.log(16, "Error : wrong UI type to open.");
                            break;
                        case 1:
                            this.uiApi.loadUi("socialBase", "socialBase", {
                                "tab":1,
                                "subTab":4
                            }, 1, null, false, false, false);
                            break;
                        case 2:
                            this.uiApi.loadUi("socialBase", "socialBase", {
                                "tab":1,
                                "subTab":3
                            }, 1, null, false, false, false);
                            break;
                        case 4:
                            this.uiApi.loadUi("socialBase", "socialBase", {
                                "tab":1,
                                "subTab":2
                            }, 1, null, false, false, false);
                            break;
                    };
                }
                else
                {
                    if (this.uiApi.getUi("socialBase").uiClass.getTab() != 1)
                    {
                        switch (_arg_1)
                        {
                            case 1:
                                this.uiApi.getUi("socialBase").uiClass.openTab(1, 4, null, false);
                                break;
                            case 2:
                                this.uiApi.getUi("socialBase").uiClass.openTab(1, 3, null, false);
                                break;
                            case 4:
                                this.uiApi.getUi("socialBase").uiClass.openTab(1, 2, null, false);
                                break;
                        };
                    }
                    else
                    {
                        this.sysApi.log(16, "Error : Social UI is already open.");
                    };
                };
            };
            if (_arg_1 == 5)
            {
                if (!this.uiApi.getUi("housesList"))
                {
                    this.uiApi.loadUi("housesList");
                };
            };
        }

        private function onDishonourChanged(dishonour:int):void
        {
            var maxDishonour:int = dishonour;
            if (maxDishonour > 9)
            {
                maxDishonour = 9;
            };
            var text:String = this.uiApi.processText(this.uiApi.getText("ui.social.disgraceSanction", dishonour), "n", (dishonour < 2), (dishonour == 0));
            text = (text + ("\n\n" + this.uiApi.getText("ui.disgrace.sanction.1")));
            this.modCommon.openPopup(this.uiApi.getText("ui.common.informations"), text, [this.uiApi.getText("ui.common.ok")]);
        }

        private function onAttackPlayer(targetId:Number, ava:Boolean, targetName:String, _arg_4:int, cellId:int):void
        {
            var text:String;
            this._targetId = targetId;
            this._cellId = cellId;
            this._ava = ava;
            if (((ava) || (_arg_4 == 0)))
            {
                text = this.uiApi.getText("ui.pvp.doUAttack", targetName);
            }
            else
            {
                if (_arg_4 == 2)
                {
                    text = this.uiApi.getText("ui.pvp.doUAttackNeutral");
                }
                else
                {
                    if (_arg_4 == -1)
                    {
                        text = this.uiApi.getText("ui.pvp.doUAttackNoGain", targetName);
                    }
                    else
                    {
                        if (_arg_4 == 1)
                        {
                            text = this.uiApi.getText("ui.pvp.doUAttackBonusGain", targetName);
                        };
                    };
                };
            };
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), text, [this.uiApi.getText("ui.common.attack"), this.uiApi.getText("ui.common.cancel")], [this.onConfirmAttack, null], this.onConfirmAttack);
        }

        private function onConfirmAttack():void
        {
            this.sysApi.sendAction(new PlayerFightRequest(this._targetId, this._ava, false, true));
        }

        private function onGuildInvited(guildName:String, recruterId:Number, recruterName:String):void
        {
            this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.invitation"), this.uiApi.getText("ui.social.aInvitYouInGuild", recruterName, guildName), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmJoinGuild, this.onCancelJoinGuild], this.onConfirmJoinGuild, this.onCancelJoinGuild);
        }

        private function onConfirmJoinGuild():void
        {
            this.sysApi.sendAction(new GuildInvitationAnswer(true));
        }

        private function onCancelJoinGuild():void
        {
            this.sysApi.sendAction(new GuildInvitationAnswer(false));
        }

        private function onGuildInvitationStateRecruter(state:uint, recrutedName:String):void
        {
            switch (state)
            {
                case 1:
                    this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.invitation"), this.uiApi.getText("ui.craft.waitForCraftClient", recrutedName), [this.uiApi.getText("ui.common.cancel")], [this.onCancelJoinGuild], null, this.onCancelJoinGuild);
                    break;
                case 2:
                case 3:
                    if (((this._popupName) && (this.uiApi.getUi(this._popupName))))
                    {
                        this.uiApi.unloadUi(this._popupName);
                        this._popupName = null;
                    };
                    break;
            };
        }

        private function onGuildInvitationStateRecruted(state:uint):void
        {
            switch (state)
            {
                case 1:
                    break;
                case 2:
                case 3:
                    if (((this._popupName) && (this.uiApi.getUi(this._popupName))))
                    {
                        this.uiApi.unloadUi(this._popupName);
                        this._popupName = null;
                    };
                    break;
            };
        }

        private function onAllianceInvited(allianceName:String, recruterId:Number, recruterName:String):void
        {
            this._popupAllianceName = this.modCommon.openPopup(this.uiApi.getText("ui.common.invitation"), this.uiApi.getText("ui.alliance.youAreInvited", recruterName, allianceName), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmJoinAlliance, this.onCancelJoinAlliance], this.onConfirmJoinAlliance, this.onCancelJoinAlliance);
        }

        private function onConfirmJoinAlliance():void
        {
            this.sysApi.sendAction(new AllianceInvitationAnswer(true));
        }

        private function onCancelJoinAlliance():void
        {
            this.sysApi.sendAction(new AllianceInvitationAnswer(false));
        }

        private function onAllianceInvitationStateRecruter(state:uint, recrutedName:String):void
        {
            switch (state)
            {
                case 1:
                    this._popupAllianceName = this.modCommon.openPopup(this.uiApi.getText("ui.common.invitation"), this.uiApi.getText("ui.craft.waitForCraftClient", recrutedName), [this.uiApi.getText("ui.common.cancel")], [this.onCancelJoinAlliance], null, this.onCancelJoinAlliance);
                    break;
                case 2:
                case 3:
                    if (((this._popupAllianceName) && (this.uiApi.getUi(this._popupAllianceName))))
                    {
                        this.uiApi.unloadUi(this._popupAllianceName);
                        this._popupAllianceName = null;
                    };
                    break;
            };
        }

        private function onAllianceInvitationStateRecruted(state:uint):void
        {
            switch (state)
            {
                case 1:
                    break;
                case 2:
                case 3:
                    if (((this._popupAllianceName) && (this.uiApi.getUi(this._popupAllianceName))))
                    {
                        this.uiApi.unloadUi(this._popupAllianceName);
                        this._popupAllianceName = null;
                    };
                    break;
            };
        }

        private function onShowCollectedTaxCollector(pTaxCollector:TaxCollectorWrapper):void
        {
            this.uiApi.loadUi("collectedTaxCollector", null, pTaxCollector, 1, null, true);
        }

        private function onShowTopTaxCollectors(pDungeonTopTaxCollectors:Object, pTopTaxCollectors:Object):void
        {
            this.uiApi.loadUi("topTaxCollectors", null, {
                "dungeonTopTaxCollectors":pDungeonTopTaxCollectors,
                "topTaxCollectors":pTopTaxCollectors
            }, 1, null, true);
        }


    }
} Ankama_Social

