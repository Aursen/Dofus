package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PresetDeleteRequestAction implements Action 
    {

        public var presetId:uint;


        public static function create(presetId:uint):PresetDeleteRequestAction
        {
            var a:PresetDeleteRequestAction = new (PresetDeleteRequestAction)();
            a.presetId = presetId;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.roleplay.actions.preset

