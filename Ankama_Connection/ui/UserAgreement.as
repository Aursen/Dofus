package Ankama_Connection.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.TextArea;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import d2actions.AgreementAgreed;
    import d2actions.QuitGame;
    import d2actions.*;

    public class UserAgreement 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        private var _currentAgreement:uint;
        private var _agreementsList:Array;
        public var lbl_title:Label;
        public var lbl_content:TextArea;
        public var btn_refuse:ButtonContainer;
        public var btn_accept:ButtonContainer;
        public var mainCtr:GraphicContainer;


        public function main(params:Object):void
        {
            var text:Object;
            this.mainCtr.mouseEnabled = true;
            this.mainCtr.mouseChildren = true;
            this._agreementsList = new Array();
            for each (text in params)
            {
                this._agreementsList.push(text);
            };
            this.lbl_content.mouseChildren = true;
            this.lbl_content.mouseEnabled = true;
            this.lbl_content.selectable = true;
            this.displayAgreement();
        }

        public function unload():void
        {
        }

        private function displayAgreement():void
        {
            if (this._agreementsList[this._currentAgreement] == "tou")
            {
                this.lbl_content.text = (this.uiApi.getText("ui.legal.tou1") + this.uiApi.getText("ui.legal.tou2"));
            }
            else
            {
                this.lbl_content.text = this.uiApi.getText(("ui.legal." + this._agreementsList[this._currentAgreement]));
            };
            this.lbl_title.text = this.uiApi.getText(("ui.legal.title." + this._agreementsList[this._currentAgreement]));
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_accept:
                    this.sysApi.sendAction(new AgreementAgreed(this._agreementsList[this._currentAgreement]));
                    if (this._currentAgreement >= (this._agreementsList.length - 1))
                    {
                        this.uiApi.unloadUi(this.uiApi.me().name);
                    }
                    else
                    {
                        this._currentAgreement++;
                        this.displayAgreement();
                    };
                    break;
                case this.btn_refuse:
                    this.sysApi.sendAction(new QuitGame());
                    break;
            };
        }


    }
}

