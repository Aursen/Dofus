package com.ankamagames.dofus.logic.game.roleplay.types
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.types.game.house.HouseInformationsForSell;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.datacenter.houses.House;
    import com.ankamagames.dofus.datacenter.world.Area;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockInformationsForSell;
    import com.ankamagames.jerakine.data.I18n;

    public class Estate 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Estate));

        public var name:String;
        public var area:String;
        public var price:Number = 0;
        public var infos:Object;

        public function Estate(estate:Object)
        {
            var house:HouseInformationsForSell;
            var subAreah:SubArea;
            var housen:House;
            var area:Area;
            var paddock:PaddockInformationsForSell;
            var subAreap:SubArea;
            var areap:Area;
            super();
            if ((estate is HouseInformationsForSell))
            {
                house = (estate as HouseInformationsForSell);
                subAreah = SubArea.getSubAreaById(house.subAreaId);
                housen = House.getGuildHouseById(house.modelId);
                if (!housen)
                {
                    this.name = "-";
                }
                else
                {
                    this.name = housen.name;
                };
                if (subAreah)
                {
                    area = Area.getAreaById(subAreah.areaId);
                    if (!area)
                    {
                        this.area = "-";
                    }
                    else
                    {
                        this.area = area.name;
                    };
                }
                else
                {
                    this.area = "-";
                };
                this.price = house.price;
                this.infos = house;
            }
            else
            {
                if ((estate is PaddockInformationsForSell))
                {
                    paddock = (estate as PaddockInformationsForSell);
                    subAreap = SubArea.getSubAreaById(paddock.subAreaId);
                    this.name = I18n.getUiText("ui.mount.paddockWithRoom", [paddock.nbMount]);
                    if (subAreap)
                    {
                        areap = Area.getAreaById(subAreap.areaId);
                        if (!areap)
                        {
                            this.area = "-";
                        }
                        else
                        {
                            this.area = areap.name;
                        };
                    }
                    else
                    {
                        this.area = "-";
                    };
                    this.price = paddock.price;
                    this.infos = paddock;
                };
            };
        }

    }
} com.ankamagames.dofus.logic.game.roleplay.types

