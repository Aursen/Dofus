package Ankama_Console
{
    import flash.display.Sprite;
    import Ankama_Console.ui.ConsoleUi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import d2hooks.ToggleConsole;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import com.ankamagames.berilia.enums.StrataEnum;
    import d2hooks.UiLoaded;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import d2hooks.*;

    public class Console extends Sprite 
    {

        private static var _self:Console;

        protected var console:ConsoleUi = null;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        private var _consoleState:Boolean;
        private var _waitingCmd:Array = [];


        public static function getInstance():Console
        {
            return (_self);
        }


        public function main():void
        {
            _self = this;
            this.uiApi.addShortcutHook("toggleConsole", this.onConsoleToggle);
            this.sysApi.addHook(ToggleConsole, this.onHookConsoleToggle);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SHRINK_CHAT, this.onShortcut, int.MAX_VALUE);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.EXTEND_CHAT, this.onShortcut, int.MAX_VALUE);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.EXTEND_CHAT2, this.onShortcut, int.MAX_VALUE);
        }

        public function showConsole(show:Boolean):void
        {
            var consoleUi:Object = this.uiApi.getUi("console");
            if (consoleUi)
            {
                this._consoleState = (consoleUi.visible = show);
                if (consoleUi.windowOwner)
                {
                    consoleUi.windowOwner.visible = show;
                };
                if (show)
                {
                    ConsoleUi(consoleUi.uiClass).updateInfo();
                    this.uiApi.getUi("console").uiClass.setFocus();
                }
                else
                {
                    this.sysApi.removeFocus();
                };
            }
            else
            {
                this.uiApi.loadUi("console", "console", [show], StrataEnum.STRATA_TOP);
                this._consoleState = show;
            };
        }

        public function loadConsole():void
        {
            if (!this.uiApi.getUi("console").windowOwner)
            {
                this.uiApi.unloadUi("console");
                this.uiApi.loadUi("console", "console", [true], StrataEnum.STRATA_TOP, null, false, true);
            }
            else
            {
                this.uiApi.unloadUi("console");
                this.uiApi.loadUi("console", "console", [true], StrataEnum.STRATA_TOP);
            };
        }

        public function addCommande(cmd:String, send:Boolean, openConsole:Boolean):void
        {
            var consoleUi:Object = this.uiApi.getUi("console");
            if (consoleUi)
            {
                if (openConsole)
                {
                    this.showConsole(true);
                };
                ConsoleUi(consoleUi.uiClass).addCmd(cmd, send, openConsole);
            }
            else
            {
                this._waitingCmd.push({
                    "cmd":cmd,
                    "send":send,
                    "openConsole":openConsole
                });
                this.sysApi.addHook(UiLoaded, this.onUiLoaded);
                this.showConsole(false);
            };
        }

        private function onAuthentificationStart(mustDisplaySteamLogin:Boolean):void
        {
            this.showConsole(false);
        }

        private function onConsoleToggle(shortcut:String):Boolean
        {
            var hasDevMode:Boolean = ((this.sysApi.getBuildType() == BuildTypeEnum.BETA) && (this.sysApi.isDevMode()));
            if ((((!(this.sysApi.hasRight())) && (!(hasDevMode))) || (!(this.sysApi.hasConsoleRight()))))
            {
                return (false);
            };
            if (shortcut != "toggleConsole")
            {
                return (true);
            };
            if (this._consoleState)
            {
                this.showConsole(false);
            }
            else
            {
                this.showConsole(true);
            };
            return (false);
        }

        private function onHookConsoleToggle():void
        {
            var hasDevMode:Boolean = ((this.sysApi.getBuildType() == BuildTypeEnum.BETA) && (this.sysApi.isDevMode()));
            if ((((!(this.sysApi.hasRight())) && (!(hasDevMode))) || (!(this.sysApi.hasConsoleRight()))))
            {
                return;
            };
            if (this._consoleState)
            {
                this.showConsole(false);
            }
            else
            {
                this.showConsole(true);
            };
        }

        private function onUiLoaded(uiName:String):void
        {
            var i:uint;
            var console:ConsoleUi;
            if (uiName == "console")
            {
                this.sysApi.removeHook(UiLoaded);
                i = 0;
                while (i < this._waitingCmd.length)
                {
                    this.addCommande(this._waitingCmd[i].cmd, this._waitingCmd[i].send, this._waitingCmd[i].openConsole);
                    i++;
                };
                console = this.uiApi.getUi("console").uiClass;
                this.uiApi.getUi("console").visible = this._consoleState;
                this._waitingCmd = [];
            };
        }

        public function onShortcut(s:String):Boolean
        {
            if (!this._consoleState)
            {
                return (false);
            };
            switch (s)
            {
                case ShortcutHookListEnum.EXTEND_CHAT:
                case ShortcutHookListEnum.EXTEND_CHAT2:
                case ShortcutHookListEnum.SHRINK_CHAT:
                    return (true);
            };
            return (false);
        }


    }
} Ankama_Console

