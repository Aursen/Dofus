package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import com.ankamagames.berilia.factories.MenusFactory;
    import com.ankamagames.berilia.utils.errors.ApiError;
    import com.ankamagames.berilia.types.data.ContextMenuData;

    [InstanciedApi]
    public class ContextMenuApi implements IApi 
    {


        public function registerMenuMaker(makerName:String, makerClass:Class):void
        {
            if (DescribeTypeCache.classImplementInterface(makerClass, IMenuMaker))
            {
                MenusFactory.registerMaker(makerName, makerClass);
            }
            else
            {
                throw (new ApiError((makerName + " maker class is not compatible with IMenuMaker")));
            };
        }

        public function create(data:*, makerName:String=null, makerParams:Array=null):ContextMenuData
        {
            var menu:ContextMenuData = MenusFactory.create(data, makerName, makerParams);
            return (menu);
        }

        [NoBoxing]
        public function getMenuMaker(makerName:String):Object
        {
            return (MenusFactory.getMenuMaker(makerName));
        }


    }
} com.ankamagames.dofus.uiApi

