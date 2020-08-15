package com.ankamagames.dofus.misc.stats.components
{
    import com.ankamagames.dofus.misc.stats.ui.IUiStats;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;

    public interface IComponentStats extends IUiStats 
    {

        function get component():GraphicContainer;

    }
}

