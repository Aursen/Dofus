package Ankama_Grimoire.ui.temporis
{
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;

    public class TemporisIntroPopUp 
    {

        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        private var _validationCallback:Function;
        public var mainCtr:GraphicContainer;
        public var btn_close:ButtonContainer;
        public var btn_ok:ButtonContainer;


        public function main(params:Array):void
        {
            if (params.length <= 0)
            {
                throw (new Error("You should provide at least the validation callback"));
            };
            this._validationCallback = params[0];
            this.btn_ok.soundId = SoundEnum.OK_BUTTON;
            this.uiApi.addComponentHook(this.btn_ok, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.mainCtr, ComponentHookList.ON_RELEASE);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortcut);
            this.uiApi.me().setOnTop();
        }

        public function unload():void
        {
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
        }

        private function closeMe():void
        {
            if (this.uiApi !== null)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }

        private function validate():void
        {
            this._validationCallback();
            this.closeMe();
        }

        public function onShortcut(shortcutLabel:String):Boolean
        {
            switch (shortcutLabel)
            {
                case ShortcutHookListEnum.VALID_UI:
                    this.validate();
                    return (true);
                case ShortcutHookListEnum.CLOSE_UI:
                    this.closeMe();
                    return (true);
            };
            return (false);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.mainCtr:
                    this.uiApi.me().setOnTop();
                    break;
                case this.btn_close:
                case this.btn_ok:
                    this.validate();
                    break;
            };
        }


    }
}

