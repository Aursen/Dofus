package com.ankamagames.dofus.kernel.zaap.messages.impl
{
    import com.ankamagames.dofus.kernel.zaap.messages.IZaapInputMessage;

    public class ZaapNeedUpdateMessage implements IZaapInputMessage 
    {

        private var _needUpdate:Boolean;

        public function ZaapNeedUpdateMessage(needUpdate:Boolean)
        {
            this._needUpdate = needUpdate;
        }

        public function get needUpdate():Boolean
        {
            return (this._needUpdate);
        }


    }
} com.ankamagames.dofus.kernel.zaap.messages.impl

