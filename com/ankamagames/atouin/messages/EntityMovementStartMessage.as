package com.ankamagames.atouin.messages
{
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.messages.ILogableMessage;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;

    public class EntityMovementStartMessage implements Message, ILogableMessage 
    {

        private var _entity:IEntity;
        public var id:Number;

        public function EntityMovementStartMessage(entity:IEntity=null)
        {
            this._entity = entity;
            if (this._entity)
            {
                this.id = entity.id;
            };
        }

        public function get entity():IEntity
        {
            return (this._entity);
        }


    }
} com.ankamagames.atouin.messages

