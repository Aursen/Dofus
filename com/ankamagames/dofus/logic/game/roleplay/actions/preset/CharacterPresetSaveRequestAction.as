package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class CharacterPresetSaveRequestAction implements Action 
    {

        public var presetId:uint;
        public var symbolId:uint;
        public var name:String;
        public var fullSave:Boolean;
        public var presetType:uint;


        public static function create(presetId:uint, symbolId:uint, name:String, fullSave:Boolean, presetType:uint):CharacterPresetSaveRequestAction
        {
            var a:CharacterPresetSaveRequestAction = new (CharacterPresetSaveRequestAction)();
            a.presetId = presetId;
            a.symbolId = symbolId;
            a.name = name;
            a.fullSave = fullSave;
            a.presetType = presetType;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.roleplay.actions.preset

