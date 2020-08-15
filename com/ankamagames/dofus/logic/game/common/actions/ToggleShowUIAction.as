package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import com.ankamagames.berilia.Berilia;
    import flash.utils.Dictionary;

    public class ToggleShowUIAction implements Action 
    {

        private var _beriliaInstance:Berilia;


        public static function create():ToggleShowUIAction
        {
            var a:ToggleShowUIAction = new (ToggleShowUIAction)();
            return (a);
        }


        public function toggleUIs():void
        {
            this._beriliaInstance = Berilia.getInstance();
            if (Berilia.getInstance().hidenActiveUIs.length > 0)
            {
                this.unhide();
            }
            else
            {
                this.hide();
            };
        }

        public function unhide():void
        {
            var uiList:Dictionary;
            var pop:String;
            uiList = Berilia.getInstance().uiList;
            while (Berilia.getInstance().hidenActiveUIs.length > 0)
            {
                pop = Berilia.getInstance().hidenActiveUIs.pop();
                if (uiList[pop])
                {
                    if (uiList[pop].uiClass.hasOwnProperty("visible"))
                    {
                        try
                        {
                            uiList[pop].uiClass.visible = true;
                        }
                        catch(e:ReferenceError)
                        {
                            uiList[pop].visible = true;
                        };
                    }
                    else
                    {
                        uiList[pop].visible = true;
                    };
                };
            };
        }

        private function hide():void
        {
            var name:*;
            var uiList:Dictionary = Berilia.getInstance().uiList;
            for (name in uiList)
            {
                if ((name as String).indexOf("tooltip_entity") != -1)
                {
                }
                else
                {
                    if ((name as String).indexOf("gameMenu") != -1)
                    {
                    }
                    else
                    {
                        if ((name as String).indexOf("mapInfo") != -1)
                        {
                        }
                        else
                        {
                            if ((name as String).indexOf("cartography") != -1)
                            {
                            }
                            else
                            {
                                if (uiList[name].visible)
                                {
                                    uiList[name].visible = false;
                                    Berilia.getInstance().hidenActiveUIs.push(name);
                                };
                            };
                        };
                    };
                };
            };
        }


    }
}

