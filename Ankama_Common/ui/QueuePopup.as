package Ankama_Common.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import d2hooks.LoginQueueStatus;
    import d2hooks.QueueStatus;
    import d2enums.ComponentHookList;
    import d2actions.ResetGame;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import d2actions.ChangeServer;
    import d2hooks.*;
    import d2actions.*;

    public class QueuePopup 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        public var lbl_title:Label;
        public var lbl_wait:Label;
        public var lbl_text2:Label;
        public var btn_back:ButtonContainer;
        public var btn_backServer:ButtonContainer;
        public var btn_wait:ButtonContainer;
        private var _params:Array;


        public function main(param:Array):void
        {
            this._params = ((param) ? param : [0, 666, true]);
            this.sysApi.addHook(LoginQueueStatus, this.onLoginQueueStatus);
            this.sysApi.addHook(QueueStatus, this.onQueueStatus);
            this.uiApi.addComponentHook(this.btn_wait, ComponentHookList.ON_RELEASE);
            this.lbl_wait.fullWidth();
            if (int(this._params[1]) > 1000)
            {
                this.updateLongQueue();
            }
            else
            {
                this.updateShortQueue();
            };
        }

        public function unload():void
        {
        }

        private function updateQueue(position:uint, total:uint):void
        {
            this.btn_back.visible = true;
            this.btn_backServer.visible = false;
            this.btn_wait.visible = false;
            this.lbl_text2.text = ((this.uiApi.getText("ui.queue.number", position, total) + "\n") + this.uiApi.getText("ui.queue.server", this.sysApi.getCurrentServer().name));
            this.lbl_title.text = this.uiApi.getText("ui.queue.wait", position, total);
        }

        private function updateLoginQueue(position:uint, total:uint):void
        {
            this.btn_back.visible = true;
            this.btn_backServer.visible = false;
            this.btn_wait.visible = false;
            this.lbl_text2.text = this.uiApi.getText("ui.queue.number", position, total);
            this.lbl_title.text = this.uiApi.getText("ui.queue.wait", position, total);
        }

        private function updateLongQueue():void
        {
            this.btn_back.visible = false;
            this.btn_backServer.visible = true;
            this.btn_wait.visible = true;
            this.lbl_text2.text = this.uiApi.getText("ui.queue.long");
            this.lbl_title.text = this.uiApi.getText("ui.popup.warning");
        }

        private function updateShortQueue():void
        {
            if (this._params[2])
            {
                this.updateLoginQueue(this._params[0], this._params[1]);
            }
            else
            {
                this.updateQueue(this._params[0], this._params[1]);
            };
        }

        public function onLoginQueueStatus(nPosition:uint, nTotal:uint):void
        {
            this._params[2] = true;
            if (nPosition <= 0)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            }
            else
            {
                this.updateLoginQueue(nPosition, nTotal);
            };
        }

        public function onQueueStatus(nPosition:uint, nTotal:uint):void
        {
            this._params[2] = false;
            if (nPosition <= 0)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            }
            else
            {
                if (nPosition < 1000)
                {
                    this.updateQueue(nPosition, nTotal);
                }
                else
                {
                    this.updateLongQueue();
                };
            };
        }

        public function onGoBack():void
        {
            if (this._params[2])
            {
                this.sysApi.sendAction(new ResetGame());
            }
            else
            {
                this.sysApi.setData("forceServerListDisplay", true, DataStoreEnum.BIND_ACCOUNT);
                this.sysApi.sendAction(new ChangeServer());
            };
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_backServer:
                case this.btn_back:
                    this.onGoBack();
                    break;
                case this.btn_wait:
                    this.onWait();
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            return (false);
        }

        public function onWait():void
        {
            this.updateShortQueue();
        }


    }
}

