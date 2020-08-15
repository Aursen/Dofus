package Ankama_ContextMenu.contextMenu
{
    import Ankama_ContextMenu.Api;
    import d2hooks.MouseClick;
    import d2hooks.CloseContextMenu;
    import flash.utils.setTimeout;
    import flash.utils.getTimer;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import flash.geom.Point;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import d2hooks.*;

    public class ContextMenuManager 
    {

        private static var _self:ContextMenuManager;

        private var _contextMenuTree:Array = new Array();
        private var _currentFocus:Object;
        private var _cancelNextClick:Boolean = false;
        private var _openDate:uint;
        private var _closeCallback:Function;
        public var mainUiLoaded:Boolean;

        public function ContextMenuManager()
        {
            if (_self)
            {
                new Error("Singleton Error");
            };
            Api.system.addHook(MouseClick, this.onGenericMouseClick);
            Api.system.addHook(CloseContextMenu, this.closeAll);
        }

        public static function getInstance():ContextMenuManager
        {
            if (!_self)
            {
                _self = new (ContextMenuManager)();
            };
            return (_self);
        }

        public static function unload():void
        {
            _self = null;
        }


        public function openNew(menu:Array, positionReference:Object=null, closeCallback:Function=null, directOpen:Boolean=false, instanceName:String=null, pContainer:UiRootContainer=null):void
        {
            var container:Object;
            var ui:Object;
            if (menu == null)
            {
                return;
            };
            if (!directOpen)
            {
                setTimeout(this.openNew, 1, menu, positionReference, closeCallback, true, instanceName, pContainer);
                return;
            };
            if (menu.length > 0)
            {
                if (this._contextMenuTree.length)
                {
                    for each (ui in this._contextMenuTree)
                    {
                        Api.ui.unloadUi(ui.name);
                    };
                    if (this._closeCallback != null)
                    {
                        this._closeCallback();
                    };
                };
                this._openDate = getTimer();
                this._closeCallback = closeCallback;
                this._contextMenuTree = new Array();
                this.mainUiLoaded = false;
                if (pContainer)
                {
                    container = Api.ui.loadUiInside("contextMenu", pContainer, ((instanceName) ? instanceName : "Ankama_ContextMenu"), [menu, positionReference]);
                }
                else
                {
                    container = Api.ui.loadUi("contextMenu", ((instanceName) ? instanceName : "Ankama_ContextMenu"), [menu, positionReference], 3);
                };
                this._contextMenuTree.push(container);
            };
        }

        public function openChild(args:Object):void
        {
            var container:UiRootContainer = this._contextMenuTree[0];
            if (((container.parentUiRoot) && (container.parentUiRoot.windowOwner)))
            {
                this._contextMenuTree.push(Api.ui.loadUiInside("contextMenu", container.parentUiRoot, ("Ankama_SubContextMenu" + this._contextMenuTree.length), args));
            }
            else
            {
                this._contextMenuTree.push(Api.ui.loadUi("contextMenu", ("Ankama_SubContextMenu" + this._contextMenuTree.length), args, 3));
            };
        }

        public function closeChild(contextMenuChild:Object):void
        {
            if (this._contextMenuTree.indexOf(contextMenuChild) == -1)
            {
                return;
            };
            while (((this._contextMenuTree.length) && (!(this._contextMenuTree[(this._contextMenuTree.length - 1)] == contextMenuChild))))
            {
                Api.ui.unloadUi(this._contextMenuTree.pop().name);
            };
        }

        public function closeAll():void
        {
            if (!this._contextMenuTree.length)
            {
                return;
            };
            while (this._contextMenuTree.length)
            {
                Api.ui.unloadUi(this._contextMenuTree.pop().name);
            };
            if (this._closeCallback != null)
            {
                this._closeCallback();
            };
        }

        public function childHasFocus(contextMenu:Object):Boolean
        {
            var i:uint = (this._contextMenuTree.length - 1);
            while (i >= 0)
            {
                if (this._contextMenuTree[i] == contextMenu)
                {
                    return (false);
                };
                if (this._contextMenuTree[i] == this._currentFocus)
                {
                    return (true);
                };
                i--;
            };
            return (false);
        }

        public function setCurrentFocus(contextMenu:Object):void
        {
            this._currentFocus = contextMenu;
        }

        public function placeMe(pContextMenu:Object, mainCtr:Object, startPoint:Point, targetHeight:Number=0):void
        {
            var p:Object;
            var p2:Object;
            var visibleStageBounds:* = Api.ui.getVisibleStageBounds();
            var newX:int = startPoint.x;
            var newY:int = startPoint.y;
            if ((newX + mainCtr.width) > visibleStageBounds.right)
            {
                p = this.getParent(pContextMenu);
                if (p)
                {
                    newX = (p.getElement("mainCtr").x - mainCtr.width);
                }
                else
                {
                    newX = (startPoint.x - mainCtr.width);
                };
            };
            if ((newY + mainCtr.height) > visibleStageBounds.bottom)
            {
                p2 = this.getParent(pContextMenu);
                if (p2)
                {
                    newY = ((newY - mainCtr.height) + targetHeight);
                }
                else
                {
                    newY = (startPoint.y - mainCtr.height);
                };
            };
            if (newX < visibleStageBounds.left)
            {
                newX = visibleStageBounds.left;
            };
            if (newY < visibleStageBounds.top)
            {
                newY = visibleStageBounds.top;
            };
            mainCtr.x = newX;
            mainCtr.y = newY;
            if (((pContextMenu.parentUiRoot) && (pContextMenu.parentUiRoot.windowOwner)))
            {
                if ((mainCtr.y + mainCtr.height) > pContextMenu.parentUiRoot.windowOwner.bounds.height)
                {
                    pContextMenu.parentUiRoot.windowOwner.height = (pContextMenu.parentUiRoot.windowOwner.height + ((mainCtr.y + mainCtr.height) - pContextMenu.parentUiRoot.windowOwner.bounds.height));
                };
            };
        }

        public function getTopParent():Object
        {
            return (this._contextMenuTree[0]);
        }

        public function getParent(contextMenu:Object):Object
        {
            var i:uint;
            while (i < this._contextMenuTree.length)
            {
                if (this._contextMenuTree[i] == contextMenu)
                {
                    return (this._contextMenuTree[(i - 1)]);
                };
                i++;
            };
            return (this._contextMenuTree[(this._contextMenuTree.length - 1)]);
        }

        private function onGenericMouseClick(target:Object):void
        {
            var ui:Object;
            try
            {
                ui = ((target is GraphicContainer) ? target.getUi() : null);
            }
            catch(e:Error)
            {
            };
            if (((!(ui)) || (this._contextMenuTree.indexOf(ui) == -1)))
            {
                this.closeAll();
            };
        }


    }
}

