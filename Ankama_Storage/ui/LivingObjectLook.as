package Ankama_Storage.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import d2hooks.LivingObjectFeed;
    import d2actions.LivingObjectChangeSkinRequest;
    import d2hooks.*;
    import d2actions.*;

    public class LivingObjectLook 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        private var _item:ItemWrapper;
        public var btn_closeLook:ButtonContainer;
        public var btn_help:ButtonContainer;
        public var btn_lookOk:ButtonContainer;
        public var grid_look:Grid;


        public function main(param:Object):void
        {
            this.uiApi.addComponentHook(this.btn_lookOk, "onRelease");
            this.uiApi.addComponentHook(this.btn_closeLook, "onRelease");
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortCut);
            this.sysApi.addHook(LivingObjectFeed, this.onLivingObjectFeed);
            this._item = param.item;
            if (this._item)
            {
                this.initLook(this._item);
            }
            else
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }

        public function initLook(item:ItemWrapper=null):void
        {
            var provider:Object;
            if (item)
            {
                provider = this.dataApi.getLivingObjectSkins(item);
                this.grid_look.dataProvider = provider;
                this.grid_look.selectedIndex = (item.livingObjectSkin - 1);
            };
        }

        private function onLivingObjectFeed(item:ItemWrapper=null):void
        {
            this.initLook(item);
        }

        public function onRelease(target:Object):void
        {
            if (target == this.btn_lookOk)
            {
                this.sysApi.sendAction(new LivingObjectChangeSkinRequest(this._item.objectUID, this._item.position, (this.grid_look.selectedIndex + 1)));
                this.uiApi.unloadUi(this.uiApi.me().name);
            }
            else
            {
                if (target == this.btn_closeLook)
                {
                    this.uiApi.unloadUi(this.uiApi.me().name);
                };
            };
        }

        private function onShortCut(s:String):Boolean
        {
            if (s == ShortcutHookListEnum.CLOSE_UI)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                return (true);
            };
            return (false);
        }


    }
} Ankama_Storage.ui

