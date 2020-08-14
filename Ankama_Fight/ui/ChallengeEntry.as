package Ankama_Fight.ui
{
    import Ankama_Fight.Api;

    public class ChallengeEntry 
    {

        public static const STATE_INPROGRESS:uint = 0;
        public static const STATE_COMPLETE:uint = 1;
        public static const STATE_FAILED:uint = 2;

        public var ctr_challenge:Object;
        public var tx_result_challenge:Object;
        public var tx_slot_challenge:Object;
        public var tx_picto_challenge:Object;
        private var _data:Object;
        private var _state:Object;
        private var _challengeUi:Object;

        public function ChallengeEntry(challengeUi:Object, parent:Object, data:Object, x:uint, y:uint)
        {
            this._challengeUi = challengeUi;
            this.data = data;
            this.display(parent, x, y);
        }

        public function set data(data:Object):void
        {
            this._data = data;
            if (this.tx_picto_challenge)
            {
                this.tx_picto_challenge.uri = data.iconUri;
            };
            this.state = data.result;
        }

        public function get data():Object
        {
            return (this._data);
        }

        public function set state(st:uint):void
        {
            this._state = st;
            this.refresh_state();
        }

        private function display(parent:Object, x:uint, y:uint):void
        {
            this.ctr_challenge = Api.uiApi.createContainer("GraphicContainer");
            this.ctr_challenge.x = x;
            this.ctr_challenge.y = y;
            this.ctr_challenge.finalize();
            this.ctr_challenge.width = 40;
            this.ctr_challenge.height = 40;
            this.tx_picto_challenge = Api.uiApi.createComponent("Texture");
            this.tx_picto_challenge.x = 9;
            this.tx_picto_challenge.y = 4;
            this.tx_picto_challenge.width = 40;
            this.tx_picto_challenge.height = 40;
            this.tx_picto_challenge.name = "tx_picto_challenge";
            this.tx_picto_challenge.uri = this._data.iconUri;
            this.tx_picto_challenge.autoGrid = false;
            this.tx_picto_challenge.dispatchMessages = true;
            this.tx_picto_challenge.finalize();
            this.ctr_challenge.addChild(this.tx_picto_challenge);
            this.tx_result_challenge = Api.uiApi.createComponent("Texture");
            this.tx_result_challenge.x = 9;
            this.tx_result_challenge.y = 4;
            this.tx_result_challenge.width = 40;
            this.tx_result_challenge.height = 40;
            this.tx_result_challenge.autoGrid = false;
            this.tx_result_challenge.dispatchMessages = true;
            this.tx_result_challenge.finalize();
            this.ctr_challenge.addChild(this.tx_result_challenge);
            parent.addChild(this.ctr_challenge);
            this.refresh_state();
        }

        private function refresh_state():void
        {
            if (this.tx_result_challenge)
            {
                switch (this._state)
                {
                    case STATE_INPROGRESS:
                        this.tx_result_challenge.visible = false;
                        break;
                    case STATE_COMPLETE:
                        this.tx_result_challenge.visible = true;
                        this.tx_result_challenge.uri = Api.uiApi.createUri((this._challengeUi.getConstant("texture") + "hud/filter_iconChallenge_check.png"));
                        break;
                    case STATE_FAILED:
                        this.tx_result_challenge.visible = true;
                        this.tx_result_challenge.uri = Api.uiApi.createUri((this._challengeUi.getConstant("texture") + "hud/filter_iconChallenge_cross.png"));
                };
            };
        }


    }
} Ankama_Fight.ui

