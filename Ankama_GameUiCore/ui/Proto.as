package Ankama_GameUiCore.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import d2hooks.WindowResize;

    public class Proto 
    {

        public var output:Object;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        public var ctr_ui:GraphicContainer;


        public function main(... args):void
        {
            this.sysApi.addHook(WindowResize, this.onWindowResize);
            this.onWindowResize(this.uiApi.getWindowWidth(), this.uiApi.getWindowHeight(), this.uiApi.getWindowScale());
        }

        public function onWindowResize(width:uint, height:uint, windowScale:Number):void
        {
            var gameWindowWidth:int;
            var gameWindowHeight:int;
            var normalRatio:Number = (0x0500 / 0x0400);
            if ((((width / height) < (normalRatio + 0.01)) && ((width / height) > (normalRatio - 0.01))))
            {
                return;
            };
            var widthReal:uint = uint(((width * 1) / windowScale));
            var heightReal:uint = uint(((height * 1) / windowScale));
            this.ctr_ui.width = widthReal;
            this.ctr_ui.height = heightReal;
            if (widthReal > (heightReal * normalRatio))
            {
                gameWindowHeight = heightReal;
                gameWindowWidth = (heightReal * normalRatio);
            }
            else
            {
                gameWindowHeight = int(((widthReal * 1) / normalRatio));
                gameWindowWidth = widthReal;
            };
            this.ctr_ui.x = (-(widthReal - gameWindowWidth) / 2);
            this.ctr_ui.y = (-(heightReal - gameWindowHeight) / 2);
            this.uiApi.me().render();
        }


    }
} Ankama_GameUiCore.ui

