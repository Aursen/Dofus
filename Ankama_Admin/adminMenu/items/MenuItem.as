package Ankama_Admin.adminMenu.items
{
    import Ankama_Admin.Api;

    public class MenuItem extends BasicItem 
    {

        public var children:Array = [];


        override public function getContextMenuItem(replaceParam:Object):Object
        {
            var child:BasicItem;
            var processedChildren:Array = [];
            for each (child in this.children)
            {
                processedChildren.push(child.getContextMenuItem(replaceParam), null, null, false, null, false, true, help);
            };
            return (Api.contextMod.createContextMenuItemObject(label, null, null, false, processedChildren, false, true, help));
        }


    }
} Ankama_Admin.adminMenu.items

