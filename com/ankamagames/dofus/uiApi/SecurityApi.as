package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.dofus.logic.shield.SecureModeManager;

    public class SecurityApi implements IApi 
    {


        public function askSecureModeCode(callback:Function):void
        {
            SecureModeManager.getInstance().askCode(callback);
        }

        public function sendSecureModeCode(code:String, callback:Function, computerName:String=null):void
        {
            SecureModeManager.getInstance().computerName = computerName;
            SecureModeManager.getInstance().sendCode(code, callback);
        }

        public function SecureModeisActive():Boolean
        {
            return (SecureModeManager.getInstance().active);
        }

        public function setShieldLevel(level:uint):void
        {
            SecureModeManager.getInstance().shieldLevel = level;
        }

        public function getShieldLevel():uint
        {
            return (SecureModeManager.getInstance().shieldLevel);
        }


    }
}

