package com.ankamagames.dofus.kernel.net
{
    public class DisconnectionReason 
    {

        private var _expected:Boolean;
        private var _reason:uint;

        public function DisconnectionReason(expected:Boolean, reason:uint)
        {
            this._expected = expected;
            this._reason = reason;
        }

        public function get expected():Boolean
        {
            return (this._expected);
        }

        public function get reason():uint
        {
            return (this._reason);
        }


    }
} com.ankamagames.dofus.kernel.net

