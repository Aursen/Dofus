package com.ankamagames.dofus.misc
{
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;

    public class BuildTypeParser 
    {


        public static function getTypeName(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case BuildTypeEnum.RELEASE:
                    return ("Release");
                case BuildTypeEnum.BETA:
                    return ("Beta");
                case BuildTypeEnum.ALPHA:
                    return ("Alpha");
                case BuildTypeEnum.TESTING:
                    return ("Testing");
                case BuildTypeEnum.INTERNAL:
                    return ("Local");
                case BuildTypeEnum.DEBUG:
                    return ("Debug");
                case BuildTypeEnum.DRAFT:
                    return ("Draft");
            };
            return ("UNKNOWN");
        }

        public static function getTypeColor(_arg_1:uint):uint
        {
            switch (_arg_1)
            {
                case BuildTypeEnum.RELEASE:
                    return (0x99CC00);
                case BuildTypeEnum.BETA:
                    return (0xFFCC00);
                case BuildTypeEnum.ALPHA:
                    return (0xFF9900);
                case BuildTypeEnum.TESTING:
                    return (0xFF6600);
                case BuildTypeEnum.INTERNAL:
                    return (6724095);
                case BuildTypeEnum.DEBUG:
                    return (10053375);
                case BuildTypeEnum.DRAFT:
                    return (10053375);
            };
            return (0xFFFFFF);
        }


    }
}

