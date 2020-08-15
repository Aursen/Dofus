package com.ankamagames.dofus.logic.common.managers
{
    import flash.utils.Dictionary;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import flash.geom.Rectangle;
    import com.ankamagames.atouin.types.GraphicCell;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.tiphon.types.ScriptedAnimation;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import flash.display.MovieClip;

    public class HyperlinkShowNpcManager 
    {


        public static function showNpc(npcId:int, loop:int=0):MovieClip
        {
            var list:Dictionary;
            var entitieInfo:Object;
            var sprite:TiphonSprite;
            var rect:Rectangle;
            var i:uint;
            var c:*;
            var graphicCell:GraphicCell;
            var abstractEntitiesFrame:RoleplayEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
            if (abstractEntitiesFrame)
            {
                list = abstractEntitiesFrame.getEntitiesDictionnary();
                for each (entitieInfo in list)
                {
                    if (((entitieInfo is GameRolePlayNpcInformations) && ((entitieInfo.npcId == npcId) || (npcId == -1))))
                    {
                        sprite = (EntitiesManager.getInstance().getEntity(GameRolePlayNpcInformations(entitieInfo).contextualId) as TiphonSprite);
                        if (sprite)
                        {
                            i = 0;
                            while (i < sprite.numChildren)
                            {
                                c = sprite.getChildAt(i);
                                if ((c is ScriptedAnimation))
                                {
                                    rect = c.getBounds(StageShareManager.stage);
                                    break;
                                };
                                i++;
                            };
                            if (!rect)
                            {
                                rect = sprite.getBounds(StageShareManager.stage);
                            };
                        }
                        else
                        {
                            graphicCell = InteractiveCellManager.getInstance().getCell(entitieInfo.disposition.cellId);
                            rect = new Rectangle(graphicCell.x, graphicCell.y, graphicCell.width, graphicCell.height);
                            rect.y = (rect.y - 80);
                        };
                        return (HyperlinkDisplayArrowManager.showAbsoluteArrow(rect, 0, 0, 1, loop));
                    };
                };
            };
            return (null);
        }


    }
}

