package Ankama_Grimoire.ui.items
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;

    public class GiftXmlItem 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        public var lbl_giftName:Label;
        public var lbl_giftEffect:Label;
        public var tx_icon:Texture;
        private var _data:*;
        private var _selected:Boolean;


        public function main(oParam:Object=null):void
        {
            this._data = oParam.data;
            this.update(this._data, this._selected);
        }

        public function get data():*
        {
            return (this._data);
        }

        public function get selected():Boolean
        {
            return (this._selected);
        }

        public function update(data:*, selected:Boolean):void
        {
            this._data = data;
            if (data)
            {
                this.lbl_giftName.text = ((((data.giftName + " - ") + this.uiApi.getText("ui.common.level")) + " ") + data.giftLevel);
                if (data.giftEffect)
                {
                    if (data.param)
                    {
                        this.lbl_giftEffect.text = data.giftEffect.split("#1").join(data.param);
                    }
                    else
                    {
                        this.lbl_giftEffect.text = data.giftEffect;
                    };
                }
                else
                {
                    this.lbl_giftEffect.text = "";
                };
                this.tx_icon.uri = data.giftUri;
            }
            else
            {
                this.lbl_giftName.text = "";
                this.lbl_giftEffect.text = "";
                this.tx_icon.uri = null;
            };
        }

        public function select(b:Boolean):void
        {
        }

        public function onRollOver(target:Object):void
        {
        }

        public function onRollOut(target:Object):void
        {
        }


    }
}

