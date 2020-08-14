package Ankama_Common.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.ConfigApi;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.components.Label;
    import flash.utils.Timer;
    import d2hooks.MailStatus;
    import d2hooks.SubscriptionEndDateUpdate;
    import d2hooks.LaggingNotification;
    import d2enums.ComponentHookList;
    import flash.events.TimerEvent;
    import d2hooks.OpenWebPortal;
    import com.ankamagames.dofus.types.enums.WebLocationEnum;
    import d2actions.OpenMainMenu;
    import d2hooks.*;
    import d2actions.*;

    public class GameMenu 
    {

        private static const NEW_MAIL_POPUP_DURATION:int = (15 * 1000);//15000

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="ConfigApi")]
        public var configApi:ConfigApi;
        public var btn_abo:ButtonContainer;
        public var btn_options:ButtonContainer;
        public var btn_menu:ButtonContainer;
        public var btn_mp:ButtonContainer;
        public var btn_mpGrey:ButtonContainer;
        public var btn_newMail:ButtonContainer;
        public var btn_close:ButtonContainer;
        public var ctr_newMail:GraphicContainer;
        public var ctr_bg:GraphicContainer;
        public var tx_btnMpBg:TextureBitmap;
        public var tx_lagometer:Texture;
        public var lbl_msgNumber:Label;
        public var lbl_newMail:Label;
        private var _mailUnread:uint;
        private var _mailTotal:uint;
        private var _newMailTimer:Timer;
        private var _btnSubscribeNeeded:Boolean = true;


        public function main(... args):void
        {
            this.sysApi.addHook(MailStatus, this.onMailStatus);
            this.sysApi.addHook(SubscriptionEndDateUpdate, this.onSubscriptionEndDateUpdate);
            this.sysApi.addHook(LaggingNotification, this.onLaggingNotification);
            this.uiApi.addComponentHook(this.btn_abo, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_abo, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_abo, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_options, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_options, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_options, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_menu, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_menu, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_menu, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_mp, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_mp, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_mp, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_newMail, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_close, ComponentHookList.ON_RELEASE);
            this.uiApi.addShortcutHook("optionMenu1", this.onShortcut);
            this.onSubscriptionEndDateUpdate();
            this.ctr_newMail.visible = false;
            this._newMailTimer = new Timer(NEW_MAIL_POPUP_DURATION, 1);
            this._newMailTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerUp);
            this.tx_lagometer.visible = false;
        }

        private function onLaggingNotification(isLagging:Boolean):void
        {
            this.tx_lagometer.visible = isLagging;
        }

        private function onSubscriptionEndDateUpdate():void
        {
            var newCheckSubscribeNeeded:Boolean;
            if (((this.sysApi.getPlayerManager().subscriptionEndDate > 0) || (this.sysApi.getPlayerManager().hasRights)))
            {
                newCheckSubscribeNeeded = false;
            }
            else
            {
                newCheckSubscribeNeeded = true;
            };
            if (this._btnSubscribeNeeded == newCheckSubscribeNeeded)
            {
                return;
            };
            if (newCheckSubscribeNeeded)
            {
                this.btn_abo.visible = true;
                this.ctr_bg.width = (this.ctr_bg.width + 25);
                this.ctr_bg.x = (this.ctr_bg.x - 25);
            }
            else
            {
                this.btn_abo.visible = false;
                this.ctr_bg.width = (this.ctr_bg.width - 25);
                this.ctr_bg.x = (this.ctr_bg.x + 25);
            };
            this._btnSubscribeNeeded = newCheckSubscribeNeeded;
        }

        public function unload():void
        {
            this.hideNewMailBox();
        }

        private function showNewMailBox():void
        {
            this._newMailTimer.start();
            this.ctr_newMail.visible = true;
        }

        private function hideNewMailBox():void
        {
            this._newMailTimer.stop();
            this._newMailTimer.reset();
            this.ctr_newMail.visible = false;
        }

        private function onTimerUp(event:TimerEvent):void
        {
            this.hideNewMailBox();
        }

        public function onMailStatus(hasNewMail:Boolean, unread:uint, total:uint):void
        {
            if (!this.btn_mp.visible)
            {
                this.btn_abo.x = (this.btn_abo.x - 70);
                this.ctr_bg.x = (this.ctr_bg.x - 65);
                this.ctr_bg.width = (this.ctr_bg.width + 65);
            };
            this._mailUnread = unread;
            this._mailTotal = total;
            var suffix:String = "";
            if (this._mailUnread <= 0)
            {
                this.lbl_msgNumber.cssClass = "center";
                this.btn_mpGrey.visible = true;
                this.btn_mp.visible = false;
            }
            else
            {
                this.lbl_msgNumber.cssClass = "darkboldcenter";
                this.btn_mpGrey.visible = false;
                this.btn_mp.visible = true;
            };
            this.lbl_msgNumber.visible = true;
            if (this._mailUnread <= 99)
            {
                this.lbl_msgNumber.text = (this.utilApi.kamasToString(this._mailUnread, "") + suffix);
            }
            else
            {
                this.lbl_msgNumber.text = "99+";
            };
            if (((hasNewMail) && (this.configApi.getConfigProperty("dofus", "showNewMailBox") == true)))
            {
                this.showNewMailBox();
            };
            this.uiApi.me().render();
        }

        public function onRelease(target:Object):void
        {
            this.sysApi.log(8, ((("release sur " + target) + " : ") + target.name));
            switch (target)
            {
                case this.btn_mp:
                case this.btn_mpGrey:
                    this.sysApi.dispatchHook(OpenWebPortal, WebLocationEnum.WEB_LOCATION_ANKABOX);
                    this.btn_mp.selected = false;
                    this._mailUnread = 0;
                    break;
                case this.btn_menu:
                    this.sysApi.sendAction(new OpenMainMenu());
                    break;
                case this.btn_abo:
                    this.sysApi.goToUrl(this.uiApi.getText("ui.link.subscribe"));
                    break;
                case this.btn_options:
                    if (this.uiApi.getUi("optionContainer"))
                    {
                        this.modCommon.openOptionMenu(true, "performance");
                    }
                    else
                    {
                        this.modCommon.openOptionMenu(false, "performance");
                    };
                    break;
                case this.btn_newMail:
                    this.sysApi.dispatchHook(OpenWebPortal, WebLocationEnum.WEB_LOCATION_ANKABOX_LAST_UNREAD);
                    this.hideNewMailBox();
                    this.btn_mp.selected = false;
                    this._mailUnread = 0;
                    break;
                case this.btn_close:
                    this.hideNewMailBox();
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var data:Object;
            var point:uint = 7;
            var relPoint:uint = 1;
            var shortcutKey:String;
            switch (target)
            {
                case this.btn_abo:
                    tooltipText = this.uiApi.getText("ui.header.subscribe");
                    break;
                case this.btn_menu:
                    tooltipText = this.uiApi.getText("ui.banner.mainMenu");
                    break;
                case this.btn_options:
                    tooltipText = this.uiApi.getText("ui.common.optionsMenu");
                    break;
                case this.btn_mp:
                case this.btn_mpGrey:
                    tooltipText = this.uiApi.processText(this.uiApi.getText("ui.ankabox.unread", this._mailUnread), "m", (this._mailUnread == 1), (this._mailUnread == 0));
                    break;
            };
            data = this.uiApi.textTooltipInfo(tooltipText);
            this.uiApi.showTooltip(data, target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "optionMenu1":
                    if (this.uiApi.getUi("optionContainer"))
                    {
                        this.modCommon.openOptionMenu(true, "performance");
                    }
                    else
                    {
                        this.modCommon.openOptionMenu(false, "performance");
                    };
                    return (true);
            };
            return (false);
        }


    }
} Ankama_Common.ui

