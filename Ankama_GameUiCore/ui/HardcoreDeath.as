package Ankama_GameUiCore.ui
{
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import d2actions.ChangeCharacter;

    public class HardcoreDeath 
    {

        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        public var btn_close:ButtonContainer;
        public var btn_yes:ButtonContainer;


        public function main(args:Object):void
        {
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_yes:
                    this.sysApi.sendAction(new ChangeCharacter(this.sysApi.getCurrentServer().id));
                    break;
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            return (true);
        }


    }
}

