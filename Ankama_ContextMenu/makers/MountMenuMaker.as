package Ankama_ContextMenu.makers
{
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import Ankama_ContextMenu.Api;
    import d2actions.MountInformationInPaddockRequest;
    import d2actions.OpenMount;
    import d2actions.MountToggleRidingRequest;
    import d2actions.MountHarnessDissociateRequest;
    import d2actions.MountHarnessColorsUpdateRequest;
    import Ankama_ContextMenu.ContextMenu;
    import d2actions.*;

    public class MountMenuMaker implements IMenuMaker 
    {

        public static var disabled:Boolean = false;


        private function onDetails(data:Object):void
        {
            Api.system.sendAction(new MountInformationInPaddockRequest(data.id));
        }

        private function onOpenMountOptions():void
        {
            Api.system.sendAction(new OpenMount());
        }

        private function onEquipMount():void
        {
            Api.system.sendAction(new MountToggleRidingRequest());
        }

        private function onHarnessDissociate():void
        {
            Api.system.sendAction(new MountHarnessDissociateRequest());
        }

        private function onUseHarnessColors(useHarnessColors:Boolean):void
        {
            Api.system.sendAction(new MountHarnessColorsUpdateRequest(useHarnessColors));
        }

        public function createMenu(data:*, param:Object):Array
        {
            var myMount:Object;
            var harnessOptionsDisabled:Boolean;
            Api.ui.hideTooltip();
            var menu:Array = [];
            if (data.hasOwnProperty("ownerName"))
            {
                menu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.mount.mountOf", data.ownerName)));
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.viewMountDetails"), this.onDetails, [param[0]], disabled));
            }
            else
            {
                myMount = Api.player.getMount();
                harnessOptionsDisabled = (myMount.harnessGID == 0);
                menu.push(ContextMenu.static_createContextMenuTitleObject(myMount.name, false));
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.options"), this.onOpenMountOptions, null, disabled));
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.equip"), this.onEquipMount, null, disabled));
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.harness.dissociate"), this.onHarnessDissociate, null, ((disabled) || (harnessOptionsDisabled))));
                if (myMount.useHarnessColors)
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.harness.useMountColors"), this.onUseHarnessColors, [false], ((disabled) || (harnessOptionsDisabled))));
                }
                else
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.harness.useHarnessColors"), this.onUseHarnessColors, [true], ((disabled) || (harnessOptionsDisabled))));
                };
            };
            return (menu);
        }


    }
}

