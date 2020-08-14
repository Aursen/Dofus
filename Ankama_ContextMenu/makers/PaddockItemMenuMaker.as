package Ankama_ContextMenu.makers
{
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import Ankama_ContextMenu.Api;
    import d2actions.PaddockRemoveItemRequest;
    import d2actions.PaddockMoveItemRequest;
    import com.ankamagames.dofus.internalDatacenter.guild.PaddockInstanceWrapper;
    import Ankama_ContextMenu.ContextMenu;
    import d2actions.*;

    public class PaddockItemMenuMaker implements IMenuMaker 
    {

        public static var disabled:Boolean = false;


        private function onPaddockRemoved(cellId:uint):void
        {
            Api.system.sendAction(new PaddockRemoveItemRequest(cellId));
        }

        private function onPaddockMoved(o:Object, cellId:uint):void
        {
            Api.system.sendAction(new PaddockMoveItemRequest(o));
        }

        public function createMenu(data:*, param:Object):Array
        {
            var guild:Object;
            var paddockInstance:PaddockInstanceWrapper;
            var menu:Array = new Array();
            var paddock:Object = Api.mount.getCurrentPaddock();
            if (paddock)
            {
                if (paddock.paddockInstances.length == 0)
                {
                    this.addMenuItems(menu, data, param);
                }
                else
                {
                    guild = Api.social.getGuild();
                    if (((guild) && (Api.social.hasGuildRight(Api.player.id(), "organizeFarms"))))
                    {
                        for each (paddockInstance in paddock.paddockInstances)
                        {
                            if (((paddockInstance.guildIdentity) && (paddockInstance.guildIdentity.guildId == guild.guildId)))
                            {
                                this.addMenuItems(menu, data, param);
                                break;
                            };
                        };
                    };
                };
            };
            return (menu);
        }

        private function addMenuItems(menu:Array, data:*, param:Object):void
        {
            var dead:* = (!(Api.player.isAlive()));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.remove"), this.onPaddockRemoved, [param[0].position.cellId], ((disabled) || (dead))));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.move"), this.onPaddockMoved, [data, param[0].position.cellId], ((disabled) || (dead))));
        }


    }
} Ankama_ContextMenu.makers

