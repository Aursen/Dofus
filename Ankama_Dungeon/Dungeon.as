package Ankama_Dungeon
{
    import flash.display.Sprite;
    import Ankama_Dungeon.ui.BreachBossSelection;
    import Ankama_Dungeon.ui.BreachTracking;
    import Ankama_Dungeon.ui.BreachShop;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.PartyApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import d2hooks.BreachBranchesList;
    import d2hooks.OpenBreachShop;
    import d2hooks.CurrentMap;
    import d2hooks.BreachState;
    import d2hooks.BreachExit;
    import d2hooks.BreachInvitGroupMembers;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
    import d2actions.BreachExitRequest;
    import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
    import d2actions.BreachInvitationRequest;
    import __AS3__.vec.*;

    public class Dungeon extends Sprite 
    {

        protected var breachBossSelection:BreachBossSelection = null;
        protected var breachTracking:BreachTracking = null;
        protected var breachShop:BreachShop = null;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="PartyApi")]
        public var partyApi:PartyApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;


        public function main():void
        {
            this.sysApi.addHook(BreachBranchesList, this.onBreachBranchesList);
            this.sysApi.addHook(OpenBreachShop, this.onOpenBreachShop);
            this.sysApi.addHook(CurrentMap, this.onCurrentMap);
            this.sysApi.addHook(BreachState, this.onBreachState);
            this.sysApi.addHook(BreachExit, this.onBreachExit);
            this.sysApi.addHook(BreachInvitGroupMembers, this.onInvitGroupMembersInBreach);
        }

        private function onBreachBranchesList(branches:Array):void
        {
            if (!this.uiApi.getUi("breachBossSelection"))
            {
                this.uiApi.loadUi("breachBossSelection", "breachBossSelection", {"branches":branches});
            };
        }

        private function onOpenBreachShop(rewards:Array):void
        {
            if (!this.uiApi.getUi("breachShop"))
            {
                this.uiApi.loadUi("breachShop", "breachShop", {"rewards":rewards});
            };
        }

        private function onCurrentMap(pMapId:Number):void
        {
            if (this.uiApi.getUi("breachBossSelection"))
            {
                this.uiApi.unloadUi("breachBossSelection");
            };
            if (this.uiApi.getUi("breachShop"))
            {
                this.uiApi.unloadUi("breachShop");
            };
        }

        private function onBreachState(owner:String, bonuses:Vector.<EffectInstanceInteger>, saved:Boolean):void
        {
            if (!this.uiApi.getUi(UIEnum.BREACH_TRACKING))
            {
                this.uiApi.loadUi(UIEnum.BREACH_TRACKING, UIEnum.BREACH_TRACKING, {
                    "owner":owner,
                    "bonuses":bonuses,
                    "saved":saved
                });
            };
        }

        private function onBreachExit():void
        {
            this.sysApi.sendAction(new BreachExitRequest());
        }

        private function onInvitGroupMembersInBreach():void
        {
            var member:PartyMemberWrapper;
            var allGroupMembers:Object = this.partyApi.getPartyMembers();
            var breachParty:Vector.<Number> = new Vector.<Number>();
            for each (member in allGroupMembers)
            {
                if (member.id != this.playerApi.id())
                {
                    breachParty.push(member.id);
                };
                if (breachParty.length == 3)
                {
                    break;
                };
            };
            this.sysApi.sendAction(new BreachInvitationRequest(breachParty));
        }


    }
} Ankama_Dungeon

