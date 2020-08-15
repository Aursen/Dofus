package damageCalculation.spellManagement
{
    public class Mark 
    {

        public var teamId:uint;
        public var markId:int;
        public var mainCell:int;
        public var cells:Array;
        public var casterId:Number;
        public var active:Boolean;

        public var associatedSpell:HaxeSpell = null;
        public var markType:int = 0;

        public function Mark():void
        {
        }

        public function stopDrag():Boolean
        {
            switch (markType)
            {
                default:
                    return (false);
                case 2:
                case 3:
                    return (true);
                    return; //dead code
            };
        }

        public function setMarkType(_arg_1:int):void
        {
            markType = _arg_1;
            if (((markType != (0)) && (!(associatedSpell == null))))
            {
                switch (markType)
                {
                    default:
                        return;
                    case 1:
                        associatedSpell.isGlyph = true;
                        associatedSpell.isTrap = false;
                        associatedSpell.isRune = false;
                        return;
                    case 2:
                        associatedSpell.isTrap = true;
                        associatedSpell.isGlyph = false;
                        associatedSpell.isRune = false;
                        return;
                    case 5:
                        associatedSpell.isRune = true;
                        associatedSpell.isTrap = false;
                        associatedSpell.isGlyph = false;
                };
            };
        }

        public function setAssociatedSpell(_arg_1:HaxeSpell):void
        {
            associatedSpell = _arg_1;
            if (((markType != (0)) && (!(associatedSpell == null))))
            {
                switch (markType)
                {
                    default:
                        return;
                    case 1:
                        associatedSpell.isGlyph = true;
                        associatedSpell.isTrap = false;
                        associatedSpell.isRune = false;
                        return;
                    case 2:
                        associatedSpell.isTrap = true;
                        associatedSpell.isGlyph = false;
                        associatedSpell.isRune = false;
                        return;
                    case 5:
                        associatedSpell.isRune = true;
                        associatedSpell.isTrap = false;
                        associatedSpell.isGlyph = false;
                };
            };
        }

        public function adaptSpellToType():void
        {
            if (((markType != (0)) && (!(associatedSpell == null))))
            {
                switch (markType)
                {
                    default:
                        return;
                    case 1:
                        associatedSpell.isGlyph = true;
                        associatedSpell.isTrap = false;
                        associatedSpell.isRune = false;
                        return;
                    case 2:
                        associatedSpell.isTrap = true;
                        associatedSpell.isGlyph = false;
                        associatedSpell.isRune = false;
                        return;
                    case 5:
                        associatedSpell.isRune = true;
                        associatedSpell.isTrap = false;
                        associatedSpell.isGlyph = false;
                };
            };
        }


    }
}

