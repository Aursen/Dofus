package Ankama_Fight.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.StorageApi;
    import com.ankamagames.dofus.uiApi.ConfigApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.FightApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.components.Texture;
    import d2hooks.RoleplayBuffViewContent;
    import d2hooks.IdolFightPreparationUpdate;
    import d2hooks.UpdatePreFightersList;
    import d2hooks.FightIdolList;
    import d2hooks.FoldAll;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.datacenter.idols.Idol;
    import com.ankamagames.dofus.network.types.game.idol.PartyIdol;
    import com.ankamagames.dofus.network.types.game.idol.Idol;
    import d2actions.OpenIdols;

    public class FightIdols 
    {

        private static const CHALLENGER:String = "challenger";

        private var _idols:Object;
        private var _slots:Array;
        private var _hidden:Boolean = false;
        private var _rpBuffNumber:int = 0;
        private var _totalFightersNumber:uint;
        private var _challengerSide:Array = new Array();
        private var _defenderSide:Array = new Array();
        private var _playerFighterId:Number;
        private var _definitivList:Boolean = false;
        private var _deactivationReason:Array;
        private var _txBackgroundWidthmodifier:int;
        private var _backgroundPreviousWidth:int;
        private var _xAnchorWithoutBuff:int;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="StorageApi")]
        public var storageApi:StorageApi;
        [Api(name="ConfigApi")]
        public var configApi:ConfigApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="FightApi")]
        public var fightApi:FightApi;
        [Api(name="PlayedCharacterApi")]
        public var playedCharacterApi:PlayedCharacterApi;
        public var _forbiddenIdols:Array = new Array();
        public var idolCtr:GraphicContainer;
        public var btn_minimArrow:ButtonContainer;
        public var ctr_root:GraphicContainer;
        public var tx_background:TextureBitmap;
        public var idolFrames:GraphicContainer;
        public var tx_idolIcon:TextureBitmap;
        public var tx_button_minimize_bgLeft:TextureBitmap;
        public var idol_slot_1:Texture;
        public var idol_slot_2:Texture;
        public var idol_slot_3:Texture;
        public var idol_slot_4:Texture;
        public var idol_slot_5:Texture;
        public var idol_slot_6:Texture;


        public function main(params:Object):void
        {
            var slot:Texture;
            this.sysApi.addHook(RoleplayBuffViewContent, this.onInventoryUpdate);
            this.sysApi.addHook(IdolFightPreparationUpdate, this.setIdols);
            this.sysApi.addHook(UpdatePreFightersList, this.updateFightersList);
            this.sysApi.addHook(FightIdolList, this.onFinalIdolList);
            this.sysApi.addHook(FoldAll, this.onFoldAll);
            this._deactivationReason = new Array();
            this._hidden = this.configApi.getConfigProperty("dofus", "lastFightIdolUiHidden");
            this._slots = [this.idol_slot_1, this.idol_slot_2, this.idol_slot_3, this.idol_slot_4, this.idol_slot_5, this.idol_slot_6];
            this._txBackgroundWidthmodifier = this.uiApi.me().getConstant("backgroundWidthmodifier");
            this._xAnchorWithoutBuff = this.uiApi.me().getConstant("xAnchorWithoutBuff");
            for each (slot in this._slots)
            {
                this.uiApi.addComponentHook(slot, "onRollOver");
                this.uiApi.addComponentHook(slot, "onRollOut");
                this.uiApi.addComponentHook(slot, "onRelease");
            };
            this.idolFrames.visible = false;
            this.tx_background.width = this.uiApi.me().getConstant("widthBackgroundHidden");
            this.tx_background.height = this.uiApi.me().getConstant("backgroundHeight");
            this.tx_background.finalize();
            this._definitivList = params[2];
            this.setIdols(params[0], params[1]);
        }

        public function update(leader:Number):void
        {
            var slot:Object;
            var i:int;
            var linkedItem:ItemWrapper;
            if (this._idols.length == 0)
            {
                this.idolCtr.visible = false;
            }
            else
            {
                if (((!(this._hidden)) && (this._idols)))
                {
                    this.btn_minimArrow.selected = false;
                    this.idolFrames.visible = true;
                }
                else
                {
                    this.btn_minimArrow.selected = true;
                };
                if (!this._hidden)
                {
                    this.idolCtr.visible = true;
                };
                i = 0;
                while (i < this._slots.length)
                {
                    slot = this._slots[i];
                    if (i >= this._idols.length)
                    {
                        slot.visible = false;
                    }
                    else
                    {
                        slot.visible = true;
                        linkedItem = this.dataApi.getItemWrapper(com.ankamagames.dofus.datacenter.idols.Idol(this.dataApi.getIdol(this._idols[i].id)).itemId);
                        slot.uri = linkedItem.iconUri;
                        if (this._definitivList)
                        {
                            slot.softDisabled = false;
                        }
                        else
                        {
                            slot.softDisabled = (!(this.isIdolActive(this._idols[i])));
                        };
                    };
                    i++;
                };
                this._backgroundPreviousWidth = (((this._slots[0].width + 6) * this._idols.length) + this._txBackgroundWidthmodifier);
                if (this.idolFrames.visible)
                {
                    this.tx_background.width = this._backgroundPreviousWidth;
                }
                else
                {
                    this.tx_background.width = this.uiApi.me().getConstant("widthBackgroundHidden");
                };
                this.repositionUi();
            };
        }

        public function updateIdolActivation():void
        {
            var i:int;
            while (i < this._idols.length)
            {
                this._slots[i].softDisabled = (!(this.isIdolActive(this._idols[i])));
                i++;
            };
        }

        public function unload():void
        {
        }

        private function fold():void
        {
            this.idolFrames.visible = (!(this._hidden));
            this.btn_minimArrow.selected = this._hidden;
            if (this._hidden)
            {
                this.tx_background.width = this.uiApi.me().getConstant("widthBackgroundHidden");
            }
            else
            {
                this.tx_background.width = this._backgroundPreviousWidth;
            };
            this.uiApi.me().render();
        }

        private function repositionUi():void
        {
            var buffUiSize:int;
            this._rpBuffNumber = this.storageApi.getViewContent("roleplayBuff").length;
            if (this._rpBuffNumber > 0)
            {
                buffUiSize = this.getBuffUiSize();
                this.idolCtr.x = (this._xAnchorWithoutBuff - buffUiSize);
            }
            else
            {
                this.idolCtr.x = this._xAnchorWithoutBuff;
            };
            this.uiApi.me().render();
        }

        private function getBuffUiSize():Number
        {
            var size:int = ((((this._slots[0].width + 6) * this._rpBuffNumber) + 26) + this.btn_minimArrow.width);
            return (size);
        }

        private function onFoldAll(hidden:Boolean):void
        {
            this._hidden = hidden;
            this.fold();
        }

        private function setIdols(leader:Number, idols:Object):void
        {
            this._idols = idols;
            this.update(leader);
        }

        private function updateFightersList(id:Number=0):void
        {
            var fightersId:Object;
            var fighterId:Number;
            var monsterId:Number;
            var forbidenIdolId:uint;
            if (!this._definitivList)
            {
                this._challengerSide = new Array();
                this._defenderSide = new Array();
                fightersId = this.fightApi.getFighters();
                if (fightersId.length == this._totalFightersNumber)
                {
                    return;
                };
                this._totalFightersNumber = fightersId.length;
                this._playerFighterId = this.playedCharacterApi.id();
                for each (fighterId in fightersId)
                {
                    if (this.fightApi.getFighterInformations(fighterId).team == CHALLENGER)
                    {
                        this._challengerSide.push(fighterId);
                    }
                    else
                    {
                        this._defenderSide.push(fighterId);
                    };
                };
                for each (fighterId in this._defenderSide)
                {
                    monsterId = this.fightApi.getMonsterId(fighterId);
                    if (monsterId != -1)
                    {
                        for each (forbidenIdolId in this.dataApi.getMonsterFromId(monsterId).incompatibleIdols)
                        {
                            this._forbiddenIdols.push(forbidenIdolId);
                        };
                    };
                };
                this.updateIdolActivation();
            };
        }

        private function isIdolActive(idol:com.ankamagames.dofus.network.types.game.idol.Idol):Boolean
        {
            var idolOwner:Number;
            var foundOwner:Boolean;
            var idolData:com.ankamagames.dofus.datacenter.idols.Idol = this.dataApi.getIdol(idol.id);
            if (this._forbiddenIdols.indexOf(idol.id) != -1)
            {
                this._deactivationReason[this._idols.indexOf(idol)] = this.uiApi.getText("ui.idol.desactivationReason.monterIncompatibility");
                return (false);
            };
            if (((idolData.groupOnly) && ((this._challengerSide.length < 4) || (this._defenderSide.length < 4))))
            {
                this._deactivationReason[this._idols.indexOf(idol)] = this.uiApi.getText("ui.idol.desactivationReason.battlePartyTooSmall");
                return (false);
            };
            if ((idol is PartyIdol))
            {
                for each (idolOwner in PartyIdol(idol).ownersIds)
                {
                    if (((idolOwner == this._playerFighterId) || (!(this._challengerSide.indexOf(idolOwner) == -1))))
                    {
                        foundOwner = true;
                        break;
                    };
                };
                if (!foundOwner)
                {
                    this._deactivationReason[this._idols.indexOf(idol)] = this.uiApi.getText("ui.idol.desactivationReason.noOwnerInBattle");
                    return (false);
                };
            };
            return (true);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_minimArrow:
                    this._hidden = (!(this._hidden));
                    this.fold();
                    break;
                default:
                    if (target.name.indexOf("slot") != -1)
                    {
                        this.sysApi.sendAction(new OpenIdols());
                    };
            };
            this.configApi.setConfigProperty("dofus", "lastFightIdolUiHidden", this._hidden);
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var idolData:com.ankamagames.dofus.datacenter.idols.Idol;
            var idol:com.ankamagames.dofus.network.types.game.idol.Idol = this._idols[this._slots.indexOf(target)];
            if (idol)
            {
                idolData = this.dataApi.getIdol(idol.id);
                tooltipText = (("<p><b>" + idolData.item.name) + "</b></p><br>");
                tooltipText = (tooltipText + (("<p>" + idolData.spellPair.description) + "</p><br>"));
                tooltipText = (tooltipText + ((("<p>" + this.uiApi.getText("ui.idol.short.bonusLoot", idol.dropBonusPercent)) + "%") + "<br>"));
                tooltipText = (tooltipText + (this.uiApi.getText("ui.idol.short.bonusXp", idol.xpBonusPercent) + "%</p>"));
                if (target.softDisabled == true)
                {
                    tooltipText = (tooltipText + (("<br><p><b>" + this._deactivationReason[this._idols.indexOf(idol)]) + "</b></p>"));
                };
            };
            if (tooltipText)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target, false, "standard", 0, 2, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        private function onInventoryUpdate(buffs:Object):void
        {
            this.repositionUi();
        }

        private function onFinalIdolList(idols:Object):void
        {
            this._definitivList = true;
            this._idols = idols;
            this.update(0);
        }


    }
} Ankama_Fight.ui

