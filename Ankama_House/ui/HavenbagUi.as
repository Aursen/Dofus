package Ankama_House.ui
{
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import d2actions.HavenbagExit;

    public class HavenbagUi 
    {

        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        public var btn_havenbag:ButtonContainer;
        public var btn_leave:ButtonContainer;


        public function main(param:Object):void
        {
        }

        public function onRelease(target:Object):void
        {
            if (target == this.btn_havenbag)
            {
                this.uiApi.getUi("havenbagManager").uiClass.onRelease("btn_havenbag");
            }
            else
            {
                if (target == this.btn_leave)
                {
                    this.sysApi.sendAction(new HavenbagExit());
                };
            };
        }


    }
}

