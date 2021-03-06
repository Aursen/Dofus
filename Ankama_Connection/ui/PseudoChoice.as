package Ankama_Connection.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Texture;
    import d2hooks.NicknameRefused;
    import d2hooks.NicknameAccepted;
    import d2hooks.KeyDown;
    import com.ankamagames.dofus.network.enums.NicknameErrorEnum;
    import d2actions.NicknameChoiceRequest;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import d2hooks.*;
    import d2actions.*;

    public class PseudoChoice 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        private var validatedPseudo:Boolean = false;
        private var connecting:Boolean = false;
        private var minChars:int;
        public var input_pseudo:Input;
        public var lbl_result:Label;
        public var btn_close:ButtonContainer;
        public var btn_validate:ButtonContainer;
        public var tx_info:Texture;


        public function main(... args):void
        {
            this.minChars = parseInt(this.uiApi.me().getConstant("minChars"));
            this.sysApi.addHook(NicknameRefused, this.onNicknameRefused);
            this.sysApi.addHook(NicknameAccepted, this.onNicknameAccepted);
            this.sysApi.addHook(KeyDown, this.onKeyDown);
            this.btn_validate.disabled = true;
        }

        public function unload():void
        {
            var login:Object;
            if (!this.connecting)
            {
                login = this.uiApi.getUi("login");
                if ((((login) && (login.uiClass)) && (login.uiClass.hasOwnProperty("disableUi"))))
                {
                    login.uiClass.disableUi(false);
                };
            };
        }

        public function onNicknameAccepted():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        public function onNicknameRefused(reason:uint):void
        {
            this.connecting = false;
            switch (reason)
            {
                case NicknameErrorEnum.ALREADY_USED:
                    this.lbl_result.text = this.uiApi.getText("ui.nickname.alreadyUsed");
                    break;
                case NicknameErrorEnum.SAME_AS_LOGIN:
                    this.lbl_result.text = this.uiApi.getText("ui.nickname.equalsLogin");
                    break;
                case NicknameErrorEnum.TOO_SIMILAR_TO_LOGIN:
                    this.lbl_result.text = this.uiApi.getText("ui.nickname.similarToLogin");
                    break;
                case NicknameErrorEnum.INVALID_NICK:
                    this.lbl_result.text = this.uiApi.getText("ui.nickname.invalid");
                    break;
                case NicknameErrorEnum.UNKNOWN_NICK_ERROR:
                    this.lbl_result.text = this.uiApi.getText("ui.nickname.unknown");
                    break;
                default:
                    this.sysApi.log(8, "Pseudo refusé pour une raison non traitée");
            };
            this.btn_validate.disabled = false;
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_validate:
                    if (((this.input_pseudo.text) && (this.input_pseudo.text.length >= this.minChars)))
                    {
                        this.connecting = true;
                        this.sysApi.sendAction(new NicknameChoiceRequest(this.input_pseudo.text));
                        this.btn_validate.disabled = true;
                        this.lbl_result.text = this.uiApi.getText("ui.common.waiting");
                    }
                    else
                    {
                        this.lbl_result.text = this.uiApi.getText("ui.nickname.invalid");
                    };
                    break;
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            if (target == this.tx_info)
            {
                text = this.uiApi.getText("ui.pseudoChoice.rule");
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", 6, 1, 0, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    if (!this.validatedPseudo)
                    {
                        this.sysApi.sendAction(new NicknameChoiceRequest(this.input_pseudo.text));
                        return (true);
                    };
                    break;
                case ShortcutHookListEnum.CLOSE_UI:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (true);
        }

        public function onKeyDown(target:Object, keyCode:uint):void
        {
            if (this.input_pseudo.haveFocus)
            {
                this.btn_validate.disabled = ((!(this.input_pseudo.text)) || (this.input_pseudo.text.length < 3));
            };
        }


    }
}

