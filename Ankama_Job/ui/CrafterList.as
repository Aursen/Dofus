package Ankama_Job.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.JobsApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.components.ComboBox;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import d2hooks.CrafterDirectoryListUpdate;
    import d2enums.ComponentHookList;
    import d2actions.JobCrafterDirectoryListRequest;
    import d2actions.LeaveDialogRequest;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.network.enums.PlayerStatusEnum;
    import com.ankamagames.dofusModuleLibrary.enum.AlignementSideEnum;
    import d2hooks.ChatFocus;
    import d2hooks.*;
    import d2actions.*;

    public class CrafterList 
    {

        public var output:Object;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="JobsApi")]
        public var jobsApi:JobsApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        private var _bDescendingSort:Boolean = false;
        private var _sortCriteria:String;
        private var _crafters:Array;
        private var _jobs:Array;
        private var _sCraftersText:String;
        private var _sChooseJobText:String;
        private var _iconsPath:String;
        private var _gridComponentsList:Dictionary = new Dictionary(true);
        public var combo_job:ComboBox;
        public var gd_crafters:Grid;
        public var lbl_nbCrafter:Label;
        public var lbl_job:Label;
        public var btn_tabAli:ButtonContainer;
        public var btn_tabBreed:ButtonContainer;
        public var btn_tabName:ButtonContainer;
        public var btn_tabLevel:ButtonContainer;
        public var btn_tabCoord:ButtonContainer;
        public var btn_tabCost:ButtonContainer;
        public var btn_tabMinLevel:ButtonContainer;
        public var btn_search:Object;
        public var btn_close:ButtonContainer;
        public var bgcombo_job:TextureBitmap;


        public function main(jobs:Array):void
        {
            var job:*;
            this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_OPEN);
            this.sysApi.addHook(CrafterDirectoryListUpdate, this.onCrafterDirectoryListUpdate);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addComponentHook(this.btn_tabCoord, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_tabCoord, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_tabCost, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_tabCost, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_tabMinLevel, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_tabMinLevel, ComponentHookList.ON_ROLL_OUT);
            this._sChooseJobText = this.uiApi.getText("ui.craft.chooseJob");
            this._sCraftersText = this.uiApi.getText("ui.craft.crafters");
            this._iconsPath = this.uiApi.me().getConstant("icons_uri");
            this.gd_crafters.dataProvider = new Array();
            this._sortCriteria = "jobLevel";
            this._jobs = new Array();
            var labels:Array = new Array();
            if (jobs.length > 1)
            {
                labels.push(this._sChooseJobText);
                for each (job in jobs)
                {
                    labels.push(this.jobsApi.getJobName(job));
                    this._jobs.push(job);
                };
                this.combo_job.dataProvider = labels;
                this.combo_job.value = labels[0];
                this.lbl_job.visible = false;
                this.bgcombo_job.visible = true;
            }
            else
            {
                this.sysApi.sendAction(new JobCrafterDirectoryListRequest(jobs[0]));
                this.lbl_job.text = this.jobsApi.getJobName(jobs[0]);
                this.combo_job.visible = (this.bgcombo_job.visible = false);
            };
        }

        public function unload():void
        {
            this.sysApi.sendAction(new LeaveDialogRequest());
            this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_CLOSE);
        }

        public function updateCrafterLine(data:*, componentsRef:*, selected:Boolean):void
        {
            var sa:SubArea;
            var txt:String;
            if (data)
            {
                if (!this._gridComponentsList[componentsRef.tx_loc.name])
                {
                    this.uiApi.addComponentHook(componentsRef.tx_loc, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(componentsRef.tx_loc, ComponentHookList.ON_ROLL_OUT);
                    this.uiApi.addComponentHook(componentsRef.tx_loc, ComponentHookList.ON_RIGHT_CLICK);
                };
                this._gridComponentsList[componentsRef.tx_loc.name] = data;
                if (!this._gridComponentsList[componentsRef.tx_status.name])
                {
                    this.uiApi.addComponentHook(componentsRef.tx_status, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(componentsRef.tx_status, ComponentHookList.ON_ROLL_OUT);
                };
                this._gridComponentsList[componentsRef.tx_status.name] = data;
                if (!this._gridComponentsList[componentsRef.btn_more.name])
                {
                    this.uiApi.addComponentHook(componentsRef.btn_more, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(componentsRef.btn_more, ComponentHookList.ON_ROLL_OUT);
                    this.uiApi.addComponentHook(componentsRef.btn_more, ComponentHookList.ON_RELEASE);
                };
                this._gridComponentsList[componentsRef.btn_more.name] = data;
                componentsRef.lbl_name.text = (((((("{player," + data.playerName) + ",") + data.playerId) + "::") + data.playerName) + "}");
                componentsRef.lbl_job.text = this.jobsApi.getJobName(data.jobId);
                componentsRef.lbl_level.text = data.jobLevel;
                componentsRef.tx_status.visible = true;
                switch (data.statusId)
                {
                    case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                        componentsRef.tx_status.uri = this.uiApi.createUri((this._iconsPath + "green.png"));
                        break;
                    case PlayerStatusEnum.PLAYER_STATUS_AFK:
                    case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                        componentsRef.tx_status.uri = this.uiApi.createUri((this._iconsPath + "yellow.png"));
                        break;
                    case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                        componentsRef.tx_status.uri = this.uiApi.createUri((this._iconsPath + "blue.png"));
                        break;
                    case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                        componentsRef.tx_status.uri = this.uiApi.createUri((this._iconsPath + "red.png"));
                        break;
                };
                componentsRef.tx_head.uri = this.uiApi.createUri(((((this.uiApi.me().getConstant("heads") + data.breed) + "") + ((data.sex) ? "0" : "1")) + ".png"));
                switch (data.alignmentSide)
                {
                    case AlignementSideEnum.ALIGNMENT_ANGEL:
                        componentsRef.tx_alignment.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "tx_alignement_bonta.png"));
                        break;
                    case AlignementSideEnum.ALIGNMENT_EVIL:
                        componentsRef.tx_alignment.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "tx_alignement_brakmar.png"));
                        break;
                    default:
                        componentsRef.tx_alignment.uri = null;
                };
                componentsRef.btn_more.visible = true;
                if (!data.isInWorkshop)
                {
                    componentsRef.lbl_loc.text = "-";
                }
                else
                {
                    sa = this.dataApi.getSubArea(data.subAreaId);
                    txt = ((this.dataApi.getArea(sa.areaId).name + " ") + data.worldPos);
                    componentsRef.lbl_loc.text = txt;
                };
                if (data.freeCraft)
                {
                    componentsRef.tx_notFree.visible = false;
                }
                else
                {
                    componentsRef.tx_notFree.visible = true;
                };
                componentsRef.lbl_lvlMin.text = data.minLevelCraft;
            }
            else
            {
                componentsRef.lbl_name.text = "";
                componentsRef.lbl_level.text = "";
                componentsRef.lbl_loc.text = "";
                componentsRef.lbl_lvlMin.text = "";
                componentsRef.tx_notFree.visible = false;
                componentsRef.tx_alignment.uri = null;
                componentsRef.tx_head.uri = null;
                componentsRef.btn_more.visible = false;
                componentsRef.tx_status.visible = false;
                componentsRef.lbl_job.text = "";
            };
        }

        private function sortCrafters():void
        {
            if (((!(this._crafters)) || (this._crafters.length < 1)))
            {
                return;
            };
            if (this._crafters.length == 1)
            {
                this.gd_crafters.dataProvider = this._crafters;
                return;
            };
            switch (this._sortCriteria)
            {
                case "alignmentSide":
                case "breed":
                case "jobLevel":
                case "minLevelCraft":
                    if (this._bDescendingSort)
                    {
                        this._crafters.sortOn([this._sortCriteria, "playerName"], [Array.NUMERIC, Array.CASEINSENSITIVE]);
                    }
                    else
                    {
                        this._crafters.sortOn([this._sortCriteria, "playerName"], [(Array.NUMERIC | Array.DESCENDING)]);
                    };
                    break;
                case "playerName":
                    if (this._bDescendingSort)
                    {
                        this._crafters.sortOn("playerName", Array.CASEINSENSITIVE);
                    }
                    else
                    {
                        this._crafters.sortOn("playerName", (Array.CASEINSENSITIVE | Array.DESCENDING));
                    };
                    break;
                case "freeCraft":
                case "worldPos":
                    if (this._bDescendingSort)
                    {
                        this._crafters.sortOn([this._sortCriteria, "playerName"], [0, Array.CASEINSENSITIVE]);
                    }
                    else
                    {
                        this._crafters.sortOn([this._sortCriteria, "playerName"], [Array.DESCENDING, Array.CASEINSENSITIVE]);
                    };
                    break;
            };
            this.gd_crafters.dataProvider = this._crafters;
        }

        public function onCrafterDirectoryListUpdate(list:Object):void
        {
            var crafter:*;
            this._crafters = new Array();
            for each (crafter in list)
            {
                this._crafters.push(crafter);
            };
            if (this._crafters.length == 0)
            {
                this.gd_crafters.dataProvider = this._crafters;
            }
            else
            {
                this.sortCrafters();
            };
            this.lbl_nbCrafter.text = ((this._crafters.length + " ") + this._sCraftersText);
        }

        public function onRelease(target:Object):void
        {
            var data:Object;
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_search:
                    break;
                case this.btn_tabAli:
                    if (this._sortCriteria == "alignmentSide")
                    {
                        this._bDescendingSort = (!(this._bDescendingSort));
                    };
                    this._sortCriteria = "alignmentSide";
                    this.sortCrafters();
                    break;
                case this.btn_tabBreed:
                    if (this._sortCriteria == "breed")
                    {
                        this._bDescendingSort = (!(this._bDescendingSort));
                    };
                    this._sortCriteria = "breed";
                    this.sortCrafters();
                    break;
                case this.btn_tabName:
                    if (this._sortCriteria == "playerName")
                    {
                        this._bDescendingSort = (!(this._bDescendingSort));
                    };
                    this._sortCriteria = "playerName";
                    this.sortCrafters();
                    break;
                case this.btn_tabLevel:
                    if (this._sortCriteria == "jobLevel")
                    {
                        this._bDescendingSort = (!(this._bDescendingSort));
                    };
                    this._sortCriteria = "jobLevel";
                    this.sortCrafters();
                    break;
                case this.btn_tabCost:
                    if (this._sortCriteria == "freeCraft")
                    {
                        this._bDescendingSort = (!(this._bDescendingSort));
                    };
                    this._sortCriteria = "freeCraft";
                    this.sortCrafters();
                    break;
                case this.btn_tabCoord:
                    if (this._sortCriteria == "worldPos")
                    {
                        this._bDescendingSort = (!(this._bDescendingSort));
                    };
                    this._sortCriteria = "worldPos";
                    this.sortCrafters();
                    break;
                case this.btn_tabMinLevel:
                    if (this._sortCriteria == "minLevelCraft")
                    {
                        this._bDescendingSort = (!(this._bDescendingSort));
                    };
                    this._sortCriteria = "minLevelCraft";
                    this.sortCrafters();
                    break;
            };
            if (target.name.indexOf("btn_more") == 0)
            {
                data = this._gridComponentsList[target.name];
                this.sysApi.dispatchHook(ChatFocus, data.playerName);
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var data:Object;
            var sa:SubArea;
            var area:String;
            if (target == this.btn_tabCoord)
            {
                tooltipText = this.uiApi.getText("ui.craft.crafterWorkshopPosition");
            }
            else
            {
                if (target == this.btn_tabMinLevel)
                {
                    tooltipText = this.uiApi.getText("ui.craft.minLevelCraft");
                }
                else
                {
                    if (target == this.btn_tabCost)
                    {
                        tooltipText = this.uiApi.getText("ui.craft.notFree");
                    };
                };
            };
            if (target.name.indexOf("btn_more") == 0)
            {
                tooltipText = this.uiApi.getText("ui.common.wisperMessage");
            }
            else
            {
                if (target.name.indexOf("tx_status") == 0)
                {
                    data = this._gridComponentsList[target.name];
                    switch (data.statusId)
                    {
                        case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                            tooltipText = this.uiApi.getText("ui.chat.status.availiable");
                            break;
                        case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                            tooltipText = this.uiApi.getText("ui.chat.status.idle");
                            break;
                        case PlayerStatusEnum.PLAYER_STATUS_AFK:
                            tooltipText = this.uiApi.getText("ui.chat.status.away");
                            if (data.awayMessage != null)
                            {
                                tooltipText = (tooltipText + (this.uiApi.getText("ui.common.colon") + data.awayMessage));
                            };
                            break;
                        case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                            tooltipText = this.uiApi.getText("ui.chat.status.private");
                            break;
                        case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                            tooltipText = this.uiApi.getText("ui.chat.status.solo");
                            break;
                    };
                }
                else
                {
                    if (target.name.indexOf("tx_loc") == 0)
                    {
                        data = this._gridComponentsList[target.name];
                        if (data.isInWorkshop)
                        {
                            sa = this.dataApi.getSubArea(data.subAreaId);
                            area = (((((this.uiApi.getText("ui.craft.nearCraftTable") + " : ") + this.dataApi.getArea(sa.areaId).name) + " ( ") + sa.name) + " )");
                            tooltipText = area;
                        };
                    };
                };
            };
            if (tooltipText)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var jobId:uint;
            switch (target)
            {
                case this.combo_job:
                    if (this.combo_job.selectedIndex > 0)
                    {
                        jobId = this._jobs[(this.combo_job.selectedIndex - 1)];
                        this.sysApi.sendAction(new JobCrafterDirectoryListRequest(jobId));
                    }
                    else
                    {
                        this.gd_crafters.dataProvider = new Array();
                        this.lbl_nbCrafter.text = "";
                    };
                    break;
            };
        }

        public function onRightClick(target:Object):void
        {
            var contextMenu:Object;
            var data:Object = this._gridComponentsList[target.name];
            if (data)
            {
                contextMenu = this.menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "closeUi":
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }


    }
}

