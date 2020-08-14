package com.ankamagames.atouin.types.miscs
{
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class HavenbagPackedInfos 
    {

        public var furnitureTypeIds:Vector.<int> = new Vector.<int>();
        public var furnitureCellIds:Vector.<uint> = new Vector.<uint>();
        public var furnitureOrientations:Vector.<uint> = new Vector.<uint>();


        public static function createFromSharedObject(soData:Object):HavenbagPackedInfos
        {
            var infos:HavenbagPackedInfos = new (HavenbagPackedInfos)();
            infos.furnitureTypeIds = soData.furnitureTypeIds;
            infos.furnitureCellIds = soData.furnitureCellIds;
            infos.furnitureOrientations = soData.furnitureOrientations;
            return (infos);
        }


    }
} com.ankamagames.atouin.types.miscs

