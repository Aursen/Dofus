package com.ankamagames.dofus.logic.game.common.misc
{
    import com.ankamagames.jerakine.entities.interfaces.IEntity;

    public interface IEntityLocalizer 
    {

        function getEntity(_arg_1:Number):IEntity;
        function unregistered():void;

    }
}

