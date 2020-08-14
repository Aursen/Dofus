package com.ankamagames.jerakine.network.utils
{
    public class BooleanByteWrapper 
    {


        public static function setFlag(a:uint, pos:uint, b:Boolean):uint
        {
            switch (pos)
            {
                case 0:
                    if (b)
                    {
                        a = (a | 0x01);
                    }
                    else
                    {
                        a = (a & (0xFF - 1));
                    };
                    break;
                case 1:
                    if (b)
                    {
                        a = (a | 0x02);
                    }
                    else
                    {
                        a = (a & (0xFF - 2));
                    };
                    break;
                case 2:
                    if (b)
                    {
                        a = (a | 0x04);
                    }
                    else
                    {
                        a = (a & (0xFF - 4));
                    };
                    break;
                case 3:
                    if (b)
                    {
                        a = (a | 0x08);
                    }
                    else
                    {
                        a = (a & (0xFF - 8));
                    };
                    break;
                case 4:
                    if (b)
                    {
                        a = (a | 0x10);
                    }
                    else
                    {
                        a = (a & (0xFF - 16));
                    };
                    break;
                case 5:
                    if (b)
                    {
                        a = (a | 0x20);
                    }
                    else
                    {
                        a = (a & (0xFF - 32));
                    };
                    break;
                case 6:
                    if (b)
                    {
                        a = (a | 0x40);
                    }
                    else
                    {
                        a = (a & (0xFF - 64));
                    };
                    break;
                case 7:
                    if (b)
                    {
                        a = (a | 0x80);
                    }
                    else
                    {
                        a = (a & (0xFF - 128));
                    };
                    break;
                default:
                    throw (new Error("Bytebox overflow."));
            };
            return (a);
        }

        public static function getFlag(a:uint, pos:uint):Boolean
        {
            switch (pos)
            {
                case 0:
                    return (!((a & 0x01) == 0));
                case 1:
                    return (!((a & 0x02) == 0));
                case 2:
                    return (!((a & 0x04) == 0));
                case 3:
                    return (!((a & 0x08) == 0));
                case 4:
                    return (!((a & 0x10) == 0));
                case 5:
                    return (!((a & 0x20) == 0));
                case 6:
                    return (!((a & 0x40) == 0));
                case 7:
                    return (!((a & 0x80) == 0));
                default:
                    throw (new Error("Bytebox overflow."));
            };
        }


    }
} com.ankamagames.jerakine.network.utils

