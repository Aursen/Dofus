package Ankama_ContextMenu.behaviors
{
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;

    public class TutorialMenuBehavior implements IMenuBehavior 
    {

        public function TutorialMenuBehavior(pParams:Object)
        {
        }

        public function canDestroyItem(item:ItemWrapper):Boolean
        {
            return (false);
        }


    }
} Ankama_ContextMenu.behaviors

