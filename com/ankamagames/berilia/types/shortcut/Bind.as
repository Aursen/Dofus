package com.ankamagames.berilia.types.shortcut
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.I18n;

    public class Bind implements IDataCenter 
    {

        private static const codeForLowerA:int = 97;
        private static const codeForLowerZ:int = 122;
        private static const codeForUpperA:int = 65;
        private static const codeForUpperZ:int = 90;

        public var key:String;
        public var targetedShortcut:String;
        public var alt:Boolean;
        public var ctrl:Boolean;
        public var shift:Boolean;
        public var disabled:Boolean;

        public function Bind(sKey:String=null, targetedShortcut:String="", bAlt:Boolean=false, bCtrl:Boolean=false, bShift:Boolean=false)
        {
            if (sKey)
            {
                this.targetedShortcut = targetedShortcut;
                this.key = sKey;
                this.alt = bAlt;
                this.ctrl = bCtrl;
                this.shift = bShift;
                this.disabled = false;
            };
        }

        public function toString():String
        {
            var keyStr:String;
            var textValue:String = "";
            if (this.key != null)
            {
                textValue = ((this.alt) ? "Alt+" : "");
                textValue = (textValue + ((this.ctrl) ? "Ctrl+" : ""));
                textValue = (textValue + ((this.shift) ? (I18n.getUiText("ui.keyboard.shift") + "+") : ""));
                if (((this.key.charAt(0) == "(") && (this.key.charAt((this.key.length - 1)) == ")")))
                {
                    keyStr = this.key.substr(1, (this.key.length - 2));
                }
                else
                {
                    keyStr = this.key;
                };
                if (I18n.hasUiText(("ui.keyboard." + keyStr.toLowerCase())))
                {
                    textValue = (textValue + I18n.getUiText(("ui.keyboard." + keyStr.toLowerCase())));
                }
                else
                {
                    textValue = (textValue + ((this.shift) ? keyStr.toLowerCase() : keyStr));
                };
            };
            return (textValue);
        }

        public function equals(s:Bind):Boolean
        {
            var charcode:int;
            var sCharcode:int;
            if (((((!(s)) || (!(s.alt == this.alt))) || (!(s.ctrl == this.ctrl))) || (!(s.shift == this.shift))))
            {
                return (false);
            };
            if (((s.key == null) && (this.key == null)))
            {
                return (true);
            };
            if (((s.key == null) || (this.key == null)))
            {
                return (false);
            };
            if (s.key.length != this.key.length)
            {
                return (false);
            };
            if (this.key.length == 1)
            {
                charcode = this.key.charCodeAt(0);
                sCharcode = s.key.charCodeAt(0);
                if (((charcode >= codeForLowerA) && (charcode <= codeForLowerZ)))
                {
                    charcode = (charcode - (codeForLowerA - codeForUpperA));
                };
                if (((sCharcode >= codeForLowerA) && (sCharcode <= codeForLowerZ)))
                {
                    sCharcode = (sCharcode - (codeForLowerA - codeForUpperA));
                };
                if (((charcode < 127) && (sCharcode < 127)))
                {
                    return (charcode == sCharcode);
                };
            };
            return (this.key.toLocaleUpperCase() == s.key.toLocaleUpperCase());
        }

        public function reset():void
        {
            this.key = null;
            this.alt = false;
            this.ctrl = false;
            this.shift = false;
        }

        public function copy():Bind
        {
            var b:Bind = new Bind(this.key, this.targetedShortcut, this.alt, this.ctrl, this.shift);
            b.disabled = this.disabled;
            return (b);
        }


    }
}

