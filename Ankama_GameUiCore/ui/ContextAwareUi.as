package Ankama_GameUiCore.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import d2hooks.GameFightJoin;
    import d2hooks.GameFightStart;
    import d2hooks.GameFightEnd;
    import d2hooks.SpectatorWantLeave;
    import Ankama_GameUiCore.ui.enums.ContextEnum;

    public class ContextAwareUi 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        private var _currentContext:String = "roleplay";


        public function main(args:Array):void
        {
            this.sysApi.addHook(GameFightJoin, this.onGameFightJoin);
            this.sysApi.addHook(GameFightStart, this.onGameFightStart);
            this.sysApi.addHook(GameFightEnd, this.onGameFightEnd);
            this.sysApi.addHook(SpectatorWantLeave, this.onSpectatorWantLeave);
        }

        public function get currentContext():String
        {
            return (this._currentContext);
        }

        public function set currentContext(pContext:String):void
        {
            this._currentContext = pContext;
        }

        protected function changeContext(context:String):void
        {
            var contextChanged:* = (!(this._currentContext == context));
            var previousContext:String = this._currentContext;
            this._currentContext = context;
            this.onContextChanged(context, previousContext, contextChanged);
        }

        protected function onContextChanged(context:String, previousContext:String="", contextChanged:Boolean=false):void
        {
        }

        public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int, alliesPreparation:Boolean):void
        {
            if (isSpectator)
            {
                this.changeContext(ContextEnum.SPECTATOR);
            }
            else
            {
                if (!timeMaxBeforeFightStart)
                {
                    this.onGameFightStart();
                }
                else
                {
                    this.changeContext(ContextEnum.PREFIGHT);
                };
            };
        }

        public function onGameFightEnd(params:Object):void
        {
            this.changeContext(ContextEnum.ROLEPLAY);
        }

        public function onSpectatorWantLeave():void
        {
            this.changeContext(ContextEnum.ROLEPLAY);
        }

        public function onGameFightStart():void
        {
            if (this._currentContext != ContextEnum.SPECTATOR)
            {
                this.changeContext(ContextEnum.FIGHT);
            };
        }


    }
} Ankama_GameUiCore.ui

