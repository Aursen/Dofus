package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;

    public class DialogParamsDecoder 
    {

        public static const MAIN_TYPE_CHARACTER:String = "P";


        public static function applyParams(txt:String, params:Object):String
        {
            var paramsValues:Array = getParamsValues(params);
            return ((paramsValues) ? ParamsDecoder.applyParams(txt, paramsValues, "#") : txt);
        }

        private static function getParamsValues(params:Object):Array
        {
            var values:Array;
            var paramMainType:String;
            var paramType:String;
            var i:int;
            var numParams:int = params.length;
            i = 0;
            while (i < numParams)
            {
                if (!values)
                {
                    values = new Array();
                };
                paramMainType = params[i].charAt(0);
                paramType = params[i].charAt(1);
                switch (paramMainType)
                {
                    case MAIN_TYPE_CHARACTER:
                        switch (paramType)
                        {
                            case "N":
                                values.push(PlayedCharacterManager.getInstance().infos.name);
                                break;
                            default:
                                values.push((("[UNKNOWN_PARAM_" + params[i]) + "]"));
                        };
                        break;
                    default:
                        values.push((("[UNKNOWN_PARAM_" + params[i]) + "]"));
                };
                i++;
            };
            return (values);
        }


    }
}

