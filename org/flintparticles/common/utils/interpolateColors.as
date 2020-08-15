package org.flintparticles.common.utils
{
    public function interpolateColors(color1:uint, color2:uint, ratio:Number):uint
    {
        var inv:Number = (1 - ratio);
        var red:uint = Math.round(((((color1 >>> 16) & 0xFF) * ratio) + (((color2 >>> 16) & 0xFF) * inv)));
        var green:uint = Math.round(((((color1 >>> 8) & 0xFF) * ratio) + (((color2 >>> 8) & 0xFF) * inv)));
        var blue:uint = Math.round((((color1 & 0xFF) * ratio) + ((color2 & 0xFF) * inv)));
        var alpha:uint = Math.round(((((color1 >>> 24) & 0xFF) * ratio) + (((color2 >>> 24) & 0xFF) * inv)));
        return ((((alpha << 24) | (red << 16)) | (green << 8)) | blue);
    }

}

