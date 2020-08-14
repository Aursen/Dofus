package Ankama_Common.ui
{
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.SecurityApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.TextArea;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Input;
    import d2enums.ComponentHookList;

    public class SecureMode 
    {

        public static const STATE_START:uint = 0;
        public static const STATE_UNLOCK:uint = 1;
        public static const STATE_COMPUTER_NAME:uint = 2;
        public static const STATE_SEND_EMAIL:uint = 3;
        public static const STATE_EMAIL:uint = 4;
        public static const STATE_ENTER_CODE:uint = 5;
        public static const STATE_END:uint = 6;
        public static const STATE_FATAL_ERROR:uint = 7;
        public static const STATE_ERROR:uint = 8;
        public static const STATE_NEED_RESTART:uint = 9;
        public static const STATE_START_SERVICE:uint = 100;

        private var _step:uint;
        private var _nextStep:uint;
        private var _isComputerUnlock:Boolean;
        private var _computerName:String;
        private var _maxProcessStep:uint;
        private var _currentProcessStep:uint;
        private var _currentWebServiceData:Object;
        private var _onErrorStep:int = -1;
        private var _initialValues:Dictionary = new Dictionary();
        private var _secureModeNeedReboot:Boolean;
        private var _callBackOnSecured:Object;
        private var _callBackOnCancelled:Function;
        private var _initialStep:uint;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="SecurityApi")]
        public var securityApi:SecurityApi;
        public var main_window:GraphicContainer;
        public var inputCtr:GraphicContainer;
        public var ctr_more_info:GraphicContainer;
        public var lbl_moreInfo:Label;
        public var lbl_inputInfo:TextArea;
        public var tx_loading:Texture;
        public var lbl_title:Label;
        public var lbl_intro:TextArea;
        public var lbl_content:TextArea;
        public var lbl_content2:TextArea;
        public var lbl_input:Label;
        public var btn1:ButtonContainer;
        public var btn_lbl_btn1:Label;
        public var btn2:ButtonContainer;
        public var btn_lbl_btn2:Label;
        public var btn3:ButtonContainer;
        public var btn_lbl_btn3:Label;
        public var btn_close:ButtonContainer;
        public var input:Input;
        public var top_block:GraphicContainer;
        public var bot_block:GraphicContainer;
        public var top_block_deco:GraphicContainer;
        public var bot_block_deco:GraphicContainer;


        public function main(param:Object):void
        {
            var target:GraphicContainer;
            var firstStep:uint;
            var prop:Object;
            this.uiApi.addComponentHook(this.lbl_moreInfo, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.input, ComponentHookList.ON_CHANGE);
            if (param)
            {
                if (param.hasOwnProperty("reboot"))
                {
                    this._secureModeNeedReboot = param.reboot;
                };
                if (param.hasOwnProperty("callBackOnSecured"))
                {
                    this._callBackOnSecured = {"fct":param.callBackOnSecured};
                    if (((this._callBackOnSecured) && (param.hasOwnProperty("callBackOnSecuredParams"))))
                    {
                        this._callBackOnSecured.params = param.callBackOnSecuredParams;
                    };
                };
                if (param.hasOwnProperty("callBackOnCancelled"))
                {
                    this._callBackOnCancelled = param.callBackOnCancelled;
                };
                if (((param.hasOwnProperty("offset")) && (param.offset)))
                {
                    this.uiApi.me().showModalContainer = false;
                    this.main_window.x = (this.main_window.x + param.offset.x);
                    this.main_window.y = (this.main_window.y + param.offset.y);
                };
                if (param.hasOwnProperty("step"))
                {
                    firstStep = param.step;
                };
            };
            var targets:Array = [this.btn1, this.btn2, this.btn3];
            var properties:Array = [{
                "get":"anchorY",
                "set":"y"
            }];
            for each (target in targets)
            {
                this._initialValues[target] = new Dictionary();
                for each (prop in properties)
                {
                    this._initialValues[target][prop] = target[prop.get];
                };
            };
            this._computerName = this.uiApi.getText("ui.common.houseWord");
            if (this._secureModeNeedReboot)
            {
                this.step = STATE_NEED_RESTART;
            }
            else
            {
                if (firstStep)
                {
                    this.step = firstStep;
                }
                else
                {
                    this.step = STATE_START;
                };
            };
            this._initialStep = this._step;
        }

        public function set step(stepId:uint):void
        {
            var target:*;
            var prop:*;
            if (!this.btn1)
            {
                return;
            };
            for (target in this._initialValues)
            {
                for (prop in this._initialValues[target])
                {
                    target[prop.set] = this._initialValues[target][prop];
                };
            };
            this.btn1.visible = false;
            this.btn2.visible = false;
            this.btn3.visible = false;
            this.btn1.disabled = false;
            this.btn2.disabled = false;
            this.btn3.disabled = false;
            this.inputCtr.visible = false;
            this.lbl_inputInfo.visible = false;
            this.tx_loading.visible = false;
            this.tx_loading.gotoAndStop = 0;
            this.lbl_intro.visible = false;
            this.lbl_content.y = 20;
            this.lbl_content.visible = true;
            this.lbl_content2.visible = false;
            this.top_block.visible = true;
            this.bot_block.visible = false;
            switch (stepId)
            {
                case STATE_START:
                case STATE_START_SERVICE:
                    this.main_window.height = 535;
                    this.lbl_title.text = this.uiApi.getText("ui.modeSecure.title");
                    this.lbl_intro.visible = true;
                    if (stepId == STATE_START_SERVICE)
                    {
                        this.lbl_intro.text = this.uiApi.getText("ui.modeSecure.serviceDesc.title");
                        this.lbl_content.text = this.uiApi.getText("ui.modeSecure.serviceDesc");
                    }
                    else
                    {
                        this.lbl_intro.text = this.uiApi.getText("ui.modeSecure.startDesc.title");
                        this.lbl_content.text = this.uiApi.getText("ui.modeSecure.startDesc1");
                    };
                    this.lbl_content.y = 85;
                    this.lbl_content2.text = this.uiApi.getText("ui.modeSecure.startDesc2");
                    this.lbl_content2.visible = true;
                    this.lbl_content2.y = 310;
                    this.btn1.visible = true;
                    this.btn2.visible = true;
                    this.btn1.width = 220;
                    this.btn1.y = 370;
                    this.btn2.y = 245;
                    this.btn_lbl_btn1.text = this.uiApi.getText("ui.modeSecure.exit");
                    this.btn_lbl_btn2.text = this.uiApi.getText("ui.modeSecure.unlock");
                    this.top_block.height = 290;
                    this.bot_block.height = 120;
                    this.bot_block.visible = true;
                    this.bot_block.y = 300;
                    this.top_block_deco.y = 290;
                    this.bot_block_deco.y = 120;
                    this.ctr_more_info.y = 430;
                    break;
                case STATE_UNLOCK:
                    this._currentProcessStep = 0;
                    this._maxProcessStep = 5;
                    this.main_window.height = 480;
                    this.lbl_title.text = this.uiApi.getText("ui.modeSecure.title");
                    this.lbl_content.text = this.uiApi.getText("ui.modeSecure.unlockDesc1");
                    this.lbl_content2.visible = true;
                    this.lbl_content2.text = this.uiApi.getText("ui.modeSecure.unlockDesc2");
                    this.lbl_content2.y = 175;
                    this.btn1.visible = true;
                    this.btn2.visible = true;
                    this.btn3.visible = true;
                    this.btn1.y = 330;
                    this.btn2.y = 265;
                    this.btn3.y = 110;
                    this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.back");
                    this.btn_lbl_btn2.text = this.uiApi.getText("ui.modeSecure.unlockThisSession");
                    this.btn_lbl_btn3.text = this.uiApi.getText("ui.modeSecure.unlockThisComputer");
                    this.top_block.height = 155;
                    this.bot_block.visible = true;
                    this.bot_block.y = 165;
                    this.bot_block.height = 150;
                    this.top_block_deco.y = 155;
                    this.bot_block_deco.y = 150;
                    this.ctr_more_info.y = 370;
                    this._isComputerUnlock = false;
                    break;
                case STATE_COMPUTER_NAME:
                    this._currentProcessStep = 1;
                    this._maxProcessStep = 6;
                    this.main_window.height = 450;
                    this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockComputerTitle").replace("%1", this._currentProcessStep).replace("%2", this._maxProcessStep);
                    this.lbl_content.text = this.uiApi.getText("ui.modeSecure.computerNameDesc");
                    this.btn1.visible = true;
                    this.btn2.visible = true;
                    this.lbl_input.text = this.uiApi.getText("ui.modeSecure.computerName");
                    this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.back");
                    this.btn_lbl_btn2.text = this.uiApi.getText("ui.common.continue");
                    this.input.restrict = null;
                    this.input.text = this._computerName;
                    this.input.focus();
                    this.inputCtr.y = 70;
                    this.inputCtr.height = 160;
                    this.inputCtr.visible = true;
                    this.btn1.y = 305;
                    this.btn2.y = 245;
                    this.top_block.height = 290;
                    this.top_block_deco.y = 290;
                    this.ctr_more_info.y = 345;
                    this._isComputerUnlock = true;
                    break;
                case STATE_EMAIL:
                    this._currentProcessStep = (this._currentProcessStep + 1);
                    this.main_window.height = 350;
                    if (this._isComputerUnlock)
                    {
                        this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockComputerTitle").replace("%1", this._currentProcessStep).replace("%2", this._maxProcessStep);
                    }
                    else
                    {
                        this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockSessionTitle").replace("%1", this._currentProcessStep).replace("%2", this._maxProcessStep);
                    };
                    this.lbl_content.text = this.uiApi.getText("ui.modeSecure.mailDesc");
                    this.btn1.visible = true;
                    this.btn2.visible = true;
                    this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.back");
                    this.btn_lbl_btn2.text = this.uiApi.getText("ui.modeSecure.sendEmail");
                    this.btn1.y = 205;
                    this.btn2.y = 145;
                    this.top_block.height = 190;
                    this.top_block_deco.y = 190;
                    this.ctr_more_info.y = 245;
                    break;
                case STATE_SEND_EMAIL:
                    this._currentProcessStep = (this._currentProcessStep + 1);
                    this.main_window.height = 300;
                    if (this._isComputerUnlock)
                    {
                        this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockComputerTitle").replace("%1", this._currentProcessStep).replace("%2", this._maxProcessStep);
                    }
                    else
                    {
                        this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockSessionTitle").replace("%1", this._currentProcessStep).replace("%2", this._maxProcessStep);
                    };
                    this.tx_loading.visible = true;
                    this.lbl_inputInfo.visible = true;
                    this.lbl_content.visible = false;
                    this.tx_loading.gotoAndPlay = 0;
                    this.lbl_inputInfo.y = 20;
                    this.lbl_inputInfo.text = this.uiApi.getText("ui.modeSecure.sendEmailDesc");
                    this.top_block.height = 190;
                    this.top_block_deco.y = 190;
                    this.ctr_more_info.y = 195;
                    break;
                case STATE_ENTER_CODE:
                    this._currentProcessStep = (this._currentProcessStep + 1);
                    this._onErrorStep = STATE_ENTER_CODE;
                    this._nextStep = STATE_END;
                    this.main_window.height = 470;
                    if (this._isComputerUnlock)
                    {
                        this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockComputerTitle").replace("%1", this._currentProcessStep).replace("%2", this._maxProcessStep);
                        this.lbl_content.text = this.uiApi.getText("ui.modeSecure.enterCodeDesc").replace("%1", this._currentWebServiceData.domain);
                    }
                    else
                    {
                        this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockSessionTitle").replace("%1", this._currentProcessStep).replace("%2", this._maxProcessStep);
                        this.lbl_content.text = this.uiApi.getText("ui.modeSecure.enterCodeSessionDesc").replace("%1", this._currentWebServiceData.domain);
                    };
                    this.btn1.visible = true;
                    this.btn2.visible = true;
                    this.lbl_inputInfo.visible = true;
                    this.btn1.y = 325;
                    this.btn2.y = 0xFF;
                    this.lbl_inputInfo.y = 80;
                    this.lbl_inputInfo.text = this.uiApi.getText("ui.modeSecure.codeInfo");
                    this.lbl_input.text = this.uiApi.getText("ui.modeSecure.secureCode");
                    this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.back");
                    this.btn_lbl_btn2.text = this.uiApi.getText("ui.common.validation");
                    this.input.restrict = "A-Za-z0-9";
                    this.input.text = "";
                    this.input.focus();
                    this.inputCtr.y = 125;
                    this.inputCtr.height = 110;
                    this.inputCtr.visible = true;
                    this.top_block.height = 300;
                    this.top_block_deco.y = 300;
                    this.ctr_more_info.y = 365;
                    break;
                case STATE_END:
                    this._currentProcessStep = (this._currentProcessStep + 1);
                    this.main_window.height = 330;
                    if (this._isComputerUnlock)
                    {
                        this.lbl_content.text = this.uiApi.getText("ui.modeSecure.endComputerDesc").replace("%1", this._computerName);
                        this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockComputerTitle").replace("%1", this._currentProcessStep).replace("%2", this._maxProcessStep);
                    }
                    else
                    {
                        this.lbl_content.text = this.uiApi.getText("ui.modeSecure.endSessionDesc");
                        this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockSessionTitle").replace("%1", this._currentProcessStep).replace("%2", this._maxProcessStep);
                    };
                    this.btn1.visible = true;
                    this.btn1.y = 175;
                    this.top_block.height = 220;
                    this.top_block_deco.y = 220;
                    this.ctr_more_info.y = 225;
                    this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.play");
                    break;
                case STATE_NEED_RESTART:
                    this._secureModeNeedReboot = true;
                    this.main_window.height = 300;
                    this.btn1.visible = true;
                    this.btn2.visible = true;
                    this.lbl_title.text = this.uiApi.getText("ui.popup.warning");
                    this.lbl_content.text = this.uiApi.getText("ui.secureMode.error.checkCode.202");
                    this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.continue");
                    this.btn_lbl_btn2.text = this.uiApi.getText("ui.common.restartGame");
                    this.btn1.y = 155;
                    this.btn2.y = 95;
                    this.top_block.height = 140;
                    this.top_block_deco.y = 140;
                    this.ctr_more_info.y = 195;
                    break;
                case STATE_FATAL_ERROR:
                    this.main_window.height = 300;
                    this.lbl_title.text = this.uiApi.getText("ui.common.error");
                    this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.close");
                    this.btn1.visible = true;
                    this.btn1.y = 145;
                    this.top_block.height = 190;
                    this.top_block_deco.y = 190;
                    this.ctr_more_info.y = 195;
                    break;
                case STATE_ERROR:
                    this.main_window.height = 300;
                    this.lbl_title.text = this.uiApi.getText("ui.common.error");
                    this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.continue");
                    this.btn1.visible = true;
                    this.btn1.y = 145;
                    this.top_block.height = 190;
                    this.top_block_deco.y = 190;
                    this.ctr_more_info.y = 195;
                    break;
            };
            this.uiApi.me().render();
            this._step = stepId;
        }

        public function get step():uint
        {
            return (this._step);
        }

        public function onRelease(target:GraphicContainer):void
        {
            if (target == this.lbl_moreInfo)
            {
                this.sysApi.goToSupportFAQ(this.uiApi.getText("ui.link.support.faq.shield"));
                return;
            };
            if (target == this.btn_close)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                if (this._callBackOnCancelled != null)
                {
                    this._callBackOnCancelled();
                };
                return;
            };
            switch (this._step)
            {
                case STATE_START_SERVICE:
                case STATE_START:
                    switch (target)
                    {
                        case this.btn1:
                            this.uiApi.unloadUi(this.uiApi.me().name);
                            if (this._callBackOnCancelled != null)
                            {
                                this._callBackOnCancelled();
                            };
                            break;
                        case this.btn2:
                            this.step = STATE_UNLOCK;
                            break;
                    };
                    break;
                case STATE_UNLOCK:
                    switch (target)
                    {
                        case this.btn1:
                            this.step = this._initialStep;
                            break;
                        case this.btn2:
                            this.step = STATE_EMAIL;
                            break;
                        case this.btn3:
                            this.step = STATE_COMPUTER_NAME;
                            break;
                    };
                    break;
                case STATE_COMPUTER_NAME:
                    switch (target)
                    {
                        case this.btn1:
                            this.step = STATE_UNLOCK;
                            break;
                        case this.btn2:
                            this._computerName = this.input.text;
                            this.step = STATE_EMAIL;
                            break;
                    };
                    break;
                case STATE_EMAIL:
                    switch (target)
                    {
                        case this.btn1:
                            this._currentProcessStep = (this._currentProcessStep - 2);
                            if (!this._isComputerUnlock)
                            {
                                this.step = STATE_UNLOCK;
                            }
                            else
                            {
                                this.step = STATE_COMPUTER_NAME;
                            };
                            break;
                        case this.btn2:
                            this._computerName = this.input.text;
                            this._nextStep = STATE_ENTER_CODE;
                            this.step = STATE_SEND_EMAIL;
                            this.sysApi.log(2, "ON RELEASE BUTTON ASK CODE");
                            this.securityApi.askSecureModeCode(this.onServiceResponse);
                            break;
                    };
                    break;
                case STATE_ENTER_CODE:
                    switch (target)
                    {
                        case this.btn1:
                            this._currentProcessStep = (this._currentProcessStep - 3);
                            this.step = STATE_EMAIL;
                            break;
                        case this.btn2:
                            this.securityApi.sendSecureModeCode(this.input.text, this.onServiceResponse, ((this._isComputerUnlock) ? this._computerName : null));
                            this._nextStep = STATE_END;
                            this.step = STATE_SEND_EMAIL;
                            break;
                    };
                    break;
                case STATE_END:
                    switch (target)
                    {
                        case this.btn1:
                            this.uiApi.unloadUi(this.uiApi.me().name);
                            if (this._callBackOnSecured)
                            {
                                this._callBackOnSecured.fct(this._callBackOnSecured.params);
                            };
                            break;
                    };
                    break;
                case STATE_ERROR:
                    switch (target)
                    {
                        case this.btn1:
                            this.step = this._nextStep;
                            break;
                    };
                    break;
                case STATE_FATAL_ERROR:
                    switch (target)
                    {
                        case this.btn1:
                            this.uiApi.unloadUi(this.uiApi.me().name);
                            break;
                    };
                    break;
                case STATE_NEED_RESTART:
                    switch (target)
                    {
                        case this.btn1:
                            this.uiApi.unloadUi(this.uiApi.me().name);
                            if (this._callBackOnSecured)
                            {
                                this._callBackOnSecured.fct(this._callBackOnSecured.params);
                            };
                            break;
                        case this.btn2:
                            this.sysApi.reset();
                            break;
                    };
                    break;
            };
        }

        public function onChange(target:Input):void
        {
            switch (this._step)
            {
                case STATE_COMPUTER_NAME:
                    this.btn2.disabled = (this.input.text.length == 0);
                    break;
                case STATE_ENTER_CODE:
                    this.btn2.disabled = (this.input.text.length < 4);
                    break;
            };
        }

        private function onServiceResponse(result:Object):void
        {
            this.sysApi.log(2, "ON SERVICE RESPONSE");
            if (!this.lbl_content)
            {
                return;
            };
            this._currentWebServiceData = result;
            if (result.error)
            {
                this.sysApi.log(2, ((((("ON SERVICE RESPONSE :: FATAL : " + result.fatal) + ", ERROR : ") + (!(result.restart))) + ", RESTART : ") + result.restart));
                if (this._onErrorStep != -1)
                {
                    this._nextStep = this._onErrorStep;
                };
                this.lbl_content.text = result.text;
                this._currentProcessStep = (this._currentProcessStep - 2);
                if (result.fatal)
                {
                    this.step = STATE_FATAL_ERROR;
                }
                else
                {
                    if (!result.restart)
                    {
                        this.step = STATE_ERROR;
                    }
                    else
                    {
                        this.step = STATE_NEED_RESTART;
                    };
                };
                this._onErrorStep = -1;
            }
            else
            {
                this.sysApi.log(2, "ON SERVICE RESPONSE :: SUCCESS");
                this._onErrorStep = -1;
                this.step = this._nextStep;
            };
        }


    }
} Ankama_Common.ui

