package com.ankamagames.atouin.renderers
{
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.atouin.Atouin;

    public class MovementZoneRenderer extends ZoneDARenderer 
    {

        private var _showText:Boolean;
        private var _startAt:int;

        public function MovementZoneRenderer(showText:Boolean, startAt:int=1)
        {
            this._showText = showText;
            this._startAt = startAt;
            _strata = PlacementStrataEnums.STRATA_AREA;
            currentStrata = ((Atouin.getInstance().options.getOption("transparentOverlayMode")) ? PlacementStrataEnums.STRATA_NO_Z_ORDER : _strata);
        }

        public function get startAt():int
        {
            return (this._startAt);
        }

        public function set startAt(pStartAt:int):void
        {
            this._startAt = pStartAt;
        }

        override protected function getText(count:int):String
        {
            if (this._showText)
            {
                return (String((count + this._startAt)));
            };
            return (null);
        }


    }
} com.ankamagames.atouin.renderers

