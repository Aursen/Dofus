package com.ankamagames.dofus.logic.game.common.misc
{
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;

    public class PlayerInventory extends Inventory 
    {


        override public function set kamas(value:Number):void
        {
            if (PlayedCharacterManager.getInstance().characteristics)
            {
                PlayedCharacterManager.getInstance().characteristics.kamas = value;
            };
            super.kamas = value;
        }


    }
} com.ankamagames.dofus.logic.game.common.misc

