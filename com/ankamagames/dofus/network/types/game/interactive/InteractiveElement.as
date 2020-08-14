package com.ankamagames.dofus.network.types.game.interactive
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class InteractiveElement implements INetworkType 
    {

        public static const protocolId:uint = 80;

        public var elementId:uint = 0;
        public var elementTypeId:int = 0;
        public var enabledSkills:Vector.<InteractiveElementSkill> = new Vector.<InteractiveElementSkill>();
        public var disabledSkills:Vector.<InteractiveElementSkill> = new Vector.<InteractiveElementSkill>();
        public var onCurrentMap:Boolean = false;
        private var _enabledSkillstree:FuncTree;
        private var _disabledSkillstree:FuncTree;


        public function getTypeId():uint
        {
            return (80);
        }

        public function initInteractiveElement(elementId:uint=0, elementTypeId:int=0, enabledSkills:Vector.<InteractiveElementSkill>=null, disabledSkills:Vector.<InteractiveElementSkill>=null, onCurrentMap:Boolean=false):InteractiveElement
        {
            this.elementId = elementId;
            this.elementTypeId = elementTypeId;
            this.enabledSkills = enabledSkills;
            this.disabledSkills = disabledSkills;
            this.onCurrentMap = onCurrentMap;
            return (this);
        }

        public function reset():void
        {
            this.elementId = 0;
            this.elementTypeId = 0;
            this.enabledSkills = new Vector.<InteractiveElementSkill>();
            this.disabledSkills = new Vector.<InteractiveElementSkill>();
            this.onCurrentMap = false;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_InteractiveElement(output);
        }

        public function serializeAs_InteractiveElement(output:ICustomDataOutput):void
        {
            if (this.elementId < 0)
            {
                throw (new Error((("Forbidden value (" + this.elementId) + ") on element elementId.")));
            };
            output.writeInt(this.elementId);
            output.writeInt(this.elementTypeId);
            output.writeShort(this.enabledSkills.length);
            var _i3:uint;
            while (_i3 < this.enabledSkills.length)
            {
                output.writeShort((this.enabledSkills[_i3] as InteractiveElementSkill).getTypeId());
                (this.enabledSkills[_i3] as InteractiveElementSkill).serialize(output);
                _i3++;
            };
            output.writeShort(this.disabledSkills.length);
            var _i4:uint;
            while (_i4 < this.disabledSkills.length)
            {
                output.writeShort((this.disabledSkills[_i4] as InteractiveElementSkill).getTypeId());
                (this.disabledSkills[_i4] as InteractiveElementSkill).serialize(output);
                _i4++;
            };
            output.writeBoolean(this.onCurrentMap);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_InteractiveElement(input);
        }

        public function deserializeAs_InteractiveElement(input:ICustomDataInput):void
        {
            var _id3:uint;
            var _item3:InteractiveElementSkill;
            var _id4:uint;
            var _item4:InteractiveElementSkill;
            this._elementIdFunc(input);
            this._elementTypeIdFunc(input);
            var _enabledSkillsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _enabledSkillsLen)
            {
                _id3 = input.readUnsignedShort();
                _item3 = ProtocolTypeManager.getInstance(InteractiveElementSkill, _id3);
                _item3.deserialize(input);
                this.enabledSkills.push(_item3);
                _i3++;
            };
            var _disabledSkillsLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _disabledSkillsLen)
            {
                _id4 = input.readUnsignedShort();
                _item4 = ProtocolTypeManager.getInstance(InteractiveElementSkill, _id4);
                _item4.deserialize(input);
                this.disabledSkills.push(_item4);
                _i4++;
            };
            this._onCurrentMapFunc(input);
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_InteractiveElement(tree);
        }

        public function deserializeAsyncAs_InteractiveElement(tree:FuncTree):void
        {
            tree.addChild(this._elementIdFunc);
            tree.addChild(this._elementTypeIdFunc);
            this._enabledSkillstree = tree.addChild(this._enabledSkillstreeFunc);
            this._disabledSkillstree = tree.addChild(this._disabledSkillstreeFunc);
            tree.addChild(this._onCurrentMapFunc);
        }

        private function _elementIdFunc(input:ICustomDataInput):void
        {
            this.elementId = input.readInt();
            if (this.elementId < 0)
            {
                throw (new Error((("Forbidden value (" + this.elementId) + ") on element of InteractiveElement.elementId.")));
            };
        }

        private function _elementTypeIdFunc(input:ICustomDataInput):void
        {
            this.elementTypeId = input.readInt();
        }

        private function _enabledSkillstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._enabledSkillstree.addChild(this._enabledSkillsFunc);
                i++;
            };
        }

        private function _enabledSkillsFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:InteractiveElementSkill = ProtocolTypeManager.getInstance(InteractiveElementSkill, _id);
            _item.deserialize(input);
            this.enabledSkills.push(_item);
        }

        private function _disabledSkillstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._disabledSkillstree.addChild(this._disabledSkillsFunc);
                i++;
            };
        }

        private function _disabledSkillsFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:InteractiveElementSkill = ProtocolTypeManager.getInstance(InteractiveElementSkill, _id);
            _item.deserialize(input);
            this.disabledSkills.push(_item);
        }

        private function _onCurrentMapFunc(input:ICustomDataInput):void
        {
            this.onCurrentMap = input.readBoolean();
        }


    }
} com.ankamagames.dofus.network.types.game.interactive

