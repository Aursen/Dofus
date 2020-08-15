package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.types.positions.WorldPoint;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.atouin.types.Selection;
    import flash.filesystem.File;
    import flash.geom.Matrix;
    import flash.display.BitmapData;
    import flash.filesystem.FileStream;
    import com.hurlant.util.Hex;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.atouin.utils.map.getWorldPointFromMapId;
    import com.ankamagames.atouin.utils.map.getMapIdFromCoord;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.network.enums.ConsoleMessageTypeEnum;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.atouin.types.DebugToolTip;
    import com.ankamagames.atouin.managers.SelectionManager;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.tiphon.events.TiphonEvent;
    import flash.events.Event;
    import com.ankamagames.atouin.managers.EntitiesDisplayManager;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.atouin.types.Frustum;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.display.Screen;
    import com.ankamagames.berilia.Berilia;
    import flash.display.StageDisplayState;
    import com.ankamagames.atouin.AtouinConstants;
    import flash.filesystem.FileMode;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class DisplayMapInstructionHandler implements ConsoleInstructionHandler 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DisplayMapInstructionHandler));

        private var _wCtrRect:Rectangle;


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var decryptionKey:ByteArray;
            var worldPoint:WorldPoint;
            var outputStr:String;
            var mapGenericId:Number;
            var mapId:Number;
            var formattedMapId:String;
            var subarea:SubArea;
            var finalString:String;
            var cacheMode:int;
            var scale:int;
            var ts:AnimatedCharacter;
            var uisVisible:Boolean;
            var wCtr:DisplayObjectContainer;
            var fullscreen:Boolean;
            var crop:Boolean;
            var exportElements:Boolean;
            var arg:String;
            var index:int;
            var mapid:int;
            var selection:Selection;
            var currentMapId:Number;
            var f:File;
            var world:DisplayObjectContainer;
            var s:int;
            var r:Rectangle;
            var m:Matrix;
            var bd:BitmapData;
            var ba:ByteArray;
            var fs:FileStream;
            var elementDir:File;
            var gfxList:Array;
            var gfxId:String;
            switch (cmd)
            {
                case "displaymapdebug":
                case "displaymap":
                    if (!args[0])
                    {
                        console.output("Error : need mapId or map location as first parameter");
                        return;
                    };
                    decryptionKey = ((args.length > 1) ? Hex.toArray(Hex.fromString(args[1])) : null);
                    if (decryptionKey)
                    {
                        decryptionKey.position = 0;
                    };
                    if (args[0].indexOf(",") == -1)
                    {
                        MapDisplayManager.getInstance().display(getWorldPointFromMapId(args[0]), false, decryptionKey);
                    }
                    else
                    {
                        MapDisplayManager.getInstance().display(WorldPoint.fromCoords(0, args[0].split(",")[0], args[0].split(",")[1]), false, decryptionKey);
                    };
                    break;
                case "getmapcoord":
                    console.output((((((((("Map world point for " + args[0]) + " : ") + getWorldPointFromMapId(int(args[0])).x) + "/") + getWorldPointFromMapId(int(args[0])).y) + " (world : ") + WorldPoint.fromMapId(int(args[0])).worldId) + ")"));
                    break;
                case "getmapid":
                    console.output(("Map id : " + getMapIdFromCoord(int(args[0]), parseInt(args[1]), parseInt(args[2]))));
                    break;
                case "testatouin":
                    Atouin.getInstance().display(new WorldPoint());
                    break;
                case "mapid":
                    worldPoint = MapDisplayManager.getInstance().currentMapPoint;
                    mapGenericId = worldPoint.mapId;
                    mapId = MapDisplayManager.getInstance().mapInstanceId;
                    if (mapId > 0)
                    {
                        formattedMapId = (((mapId + " (model ") + mapGenericId) + ")");
                    }
                    else
                    {
                        formattedMapId = mapGenericId.toString();
                    };
                    if ((worldPoint is WorldPointWrapper))
                    {
                        outputStr = ((((((((("Current map : " + worldPoint.x) + "/") + worldPoint.y) + " (relative : ") + WorldPointWrapper(worldPoint).outdoorX) + "/") + WorldPointWrapper(worldPoint).outdoorY) + "), map id : ") + formattedMapId);
                    }
                    else
                    {
                        outputStr = ((((("Current map : " + worldPoint.x) + "/") + worldPoint.y) + ", map id : ") + formattedMapId);
                    };
                    console.output(outputStr);
                    break;
                case "subareainfos":
                    subarea = PlayedCharacterManager.getInstance().currentSubArea;
                    if (!isNaN(parseInt(args[0])))
                    {
                        subarea = SubArea.getSubAreaById(parseInt(args[0]));
                        args.shift();
                    };
                    if (!subarea)
                    {
                        console.output("La sous-zone demandée n'existe pas", ConsoleMessageTypeEnum.CONSOLE_ERR_MESSAGE);
                        break;
                    };
                    finalString = ((I18n.getUiText("ui.tooltip.beInSubarea", [subarea.name]) + " -- ID de la sous-zone : ") + subarea.id);
                    if (args.length > 0)
                    {
                        for each (arg in args)
                        {
                            switch (arg)
                            {
                                case "area":
                                    finalString = (finalString + ("\nID de la zone : " + subarea.areaId));
                                    break;
                                case "maps":
                                    finalString = (finalString + "\nIDs des maps de la sous-zone :\n");
                                    for each (mapid in subarea.mapIds)
                                    {
                                        finalString = (finalString + ("   - " + mapid));
                                    };
                                    break;
                                case "zaap":
                                    finalString = (finalString + ((((("\nID de map du zaap associé : " + subarea.associatedZaapMapId) + ", coordonnées : ") + subarea.zaapMapPosition.posX) + "/") + subarea.zaapMapPosition.posY));
                                    break;
                                case "conquest":
                                    finalString = (finalString + "\nEst un village de conquête ? ");
                                    finalString = (finalString + ((subarea.isConquestVillage) ? "Oui" : "Non"));
                                    break;
                                case "autotrip":
                                    finalString = (finalString + "\nAutopilotage autorisé ? ");
                                    finalString = (finalString + ((subarea.mountAutoTripAllowed) ? "Oui" : "Non"));
                                    break;
                                default:
                                    index = (args.indexOf(arg) + 1);
                                    finalString = (finalString + (("\nParamètre " + index) + " erroné"));
                            };
                        };
                    };
                    console.output(finalString);
                    break;
                case "showcellid":
                    Atouin.getInstance().options.setOption("showCellIdOnOver", (!(Atouin.getInstance().options.getOption("showCellIdOnOver"))));
                    console.output(("showCellIdOnOver : " + Atouin.getInstance().options.getOption("showCellIdOnOver")));
                    InteractiveCellManager.getInstance().setInteraction(true, Atouin.getInstance().options.getOption("showCellIdOnOver"), Atouin.getInstance().options.getOption("showCellIdOnOver"));
                    if (!Atouin.getInstance().options.getOption("showCellIdOnOver"))
                    {
                        if (DebugToolTip.getInstance().parent)
                        {
                            DebugToolTip.getInstance().parent.removeChild(DebugToolTip.getInstance());
                        };
                        selection = SelectionManager.getInstance().getSelection("infoOverCell");
                        if (selection != null)
                        {
                            selection.remove();
                        };
                    };
                    break;
                case "showeverycellid":
                    Atouin.getInstance().options.setOption("showEveryCellId", (!(Atouin.getInstance().options.getOption("showEveryCellId"))));
                    console.output(("showEveryCellId : " + Atouin.getInstance().options.getOption("showEveryCellId")));
                    InteractiveCellManager.getInstance().showEveryCellId(Atouin.getInstance().options.getOption("showEveryCellId"));
                    break;
                case "playerjump":
                    Atouin.getInstance().options.setOption("virtualPlayerJump", (!(Atouin.getInstance().options.getOption("virtualPlayerJump"))));
                    console.output(("playerJump : " + Atouin.getInstance().options.getOption("virtualPlayerJump")));
                    break;
                case "showtransitions":
                    Atouin.getInstance().options.setOption("showTransitions", (!(Atouin.getInstance().options.getOption("showTransitions"))));
                    break;
                case "groundcache":
                    if (args.length)
                    {
                        cacheMode = int(args[0]);
                        Atouin.getInstance().options.setOption("groundCacheMode", cacheMode);
                    }
                    else
                    {
                        cacheMode = Atouin.getInstance().options.getOption("groundCacheMode");
                    };
                    if (cacheMode == 0)
                    {
                        console.output("Ground cache : disabled");
                    }
                    else
                    {
                        if (cacheMode == 1)
                        {
                            console.output("Ground cache : High");
                        }
                        else
                        {
                            if (cacheMode == 2)
                            {
                                console.output("Ground cache : Medium");
                            }
                            else
                            {
                                if (cacheMode == 3)
                                {
                                    console.output("Ground cache : Low");
                                };
                            };
                        };
                    };
                    break;
                case "removeblackbars":
                    Atouin.getInstance().toggleWorldMask();
                    break;
                case "setmaprenderscale":
                    scale = 1;
                    if (args.length)
                    {
                        scale = parseInt(args[0]);
                    };
                    if (MapDisplayManager.getInstance().renderer.setRenderScale(scale))
                    {
                        console.output((("Map render scale set to : " + scale) + " (will take effect from the next renderer)"));
                    }
                    else
                    {
                        console.output("Failed to set scale for the map rendering, your config.xml has no gfx.path.world.swf key defined!");
                    };
                    break;
                case "tutofx":
                    ts = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(), TiphonEntityLook.fromString("{3440}"));
                    ts.addEventListener(TiphonEvent.RENDER_SUCCEED, function (e:Event):void
                    {
                        ts.stopAnimation(1);
                    });
                    if (ts.hasAnimation("FX", 0))
                    {
                        ts.setAnimationAndDirection("FX", 0);
                        EntitiesDisplayManager.getInstance().displayEntity(ts, MapPoint.fromCellId(342), PlacementStrataEnums.STRATA_FOREGROUND);
                    };
                    break;
                case "setfrustum":
                    if (((args) && (args.length == 4)))
                    {
                        Atouin.getInstance().setFrustrum(new Frustum(parseInt(args[0]), parseInt(args[1]), parseInt(args[2]), parseInt(args[3])));
                    }
                    else
                    {
                        console.output("Needs 4 margins as arguments to create a frustum (right, top, left, bottom)");
                    };
                    break;
                case "setclientwindowsize":
                    if (((args) && (args.length == 2)))
                    {
                        StageShareManager.stage.nativeWindow.restore();
                        StageShareManager.stage.nativeWindow.width = (parseFloat(args[0]) + StageShareManager.chrome.x);
                        StageShareManager.stage.nativeWindow.height = (parseFloat(args[1]) + StageShareManager.chrome.y);
                        StageShareManager.stage.nativeWindow.x = ((Screen.mainScreen.bounds.width - StageShareManager.stage.nativeWindow.width) / 2);
                        StageShareManager.stage.nativeWindow.y = ((Screen.mainScreen.bounds.height - StageShareManager.stage.nativeWindow.height) / 2);
                    }
                    else
                    {
                        console.output("Needs a width and height as arguments to resize the client window");
                    };
                    break;
                case "togglebottomuis":
                    uisVisible = Berilia.getInstance().getUi("banner").visible;
                    Berilia.getInstance().getUi("banner").visible = (!(uisVisible));
                    Berilia.getInstance().getUi("chat").visible = (!(uisVisible));
                    break;
                case "debugmapwide":
                    wCtr = Atouin.getInstance().worldContainer;
                    if (((args.length == 1) && (this._wCtrRect)))
                    {
                        wCtr.x = this._wCtrRect.x;
                        wCtr.y = this._wCtrRect.y;
                        wCtr.scaleX = this._wCtrRect.width;
                        wCtr.scaleY = this._wCtrRect.height;
                        return;
                    };
                    if (args.length == 3)
                    {
                        wCtr.scaleX = (wCtr.scaleY = parseFloat(args[0]));
                        wCtr.x = parseFloat(args[1]);
                        wCtr.y = parseFloat(args[2]);
                        return;
                    };
                    fullscreen = (wCtr.stage.displayState == StageDisplayState["FULL_SCREEN_INTERACTIVE"]);
                    if (!this._wCtrRect)
                    {
                        this._wCtrRect = new Rectangle(wCtr.x, wCtr.y, wCtr.scaleX, wCtr.scaleY);
                    };
                    if (!fullscreen)
                    {
                        wCtr.scaleX = (wCtr.scaleY = 1.55);
                        wCtr.x = -325;
                        wCtr.y = -196;
                    }
                    else
                    {
                        wCtr.scaleX = (wCtr.scaleY = 1.46);
                        wCtr.x = -270;
                        wCtr.y = -220;
                    };
                    break;
                case "capturemap":
                    crop = true;
                    exportElements = true;
                    if (args.length)
                    {
                        crop = Boolean((String(args[0]).toLowerCase() == "true"));
                        if (args.length > 1)
                        {
                            exportElements = Boolean((String(args[1]).toLowerCase() == "true"));
                        };
                    };
                    try
                    {
                        currentMapId = MapDisplayManager.getInstance().currentMapPoint.mapId;
                        f = File.desktopDirectory.resolvePath((((("maps/" + currentMapId) + "/") + currentMapId) + ".png"));
                        world = Atouin.getInstance().worldContainer;
                        EntitiesManager.getInstance().setEntitiesVisibility(false);
                        s = MapDisplayManager.getInstance().renderer.renderScale;
                        r = world.getBounds(world);
                        m = new Matrix();
                        if (!crop)
                        {
                            m.translate(-(r.x), -(r.y));
                        };
                        m.scale(s, s);
                        if (!crop)
                        {
                            bd = new BitmapData((r.width * s), (r.height * s));
                        }
                        else
                        {
                            bd = new BitmapData(((StageShareManager.startWidth - (Atouin.getInstance().worldContainer.x * 2)) * s), (((AtouinConstants.CELL_HEIGHT * AtouinConstants.MAP_HEIGHT) + 15) * s));
                        };
                        bd.draw(world, m);
                        EntitiesManager.getInstance().setEntitiesVisibility(true);
                        PNGEncoder2.level = CompressionLevel.UNCOMPRESSED;
                        ba = PNGEncoder2.encode(bd);
                        fs = new FileStream();
                        fs.open(f, FileMode.WRITE);
                        fs.writeBytes(ba);
                        fs.close();
                        PNGEncoder2.freeCachedMemory();
                        if (exportElements)
                        {
                            elementDir = f.parent.resolvePath("elements");
                            elementDir.createDirectory();
                            gfxList = MapDisplayManager.getInstance().renderer.getAllGfx();
                            for (gfxId in gfxList)
                            {
                                f = elementDir.resolvePath((gfxId + ".png"));
                                fs.open(f, FileMode.WRITE);
                                ba = PNGEncoder2.encode(gfxList[gfxId]);
                                fs.writeBytes(ba);
                                fs.close();
                                PNGEncoder2.freeCachedMemory();
                            };
                        };
                        console.output(("Generated files are available in " + ((elementDir) ? elementDir.parent.nativePath : f.parent.nativePath)));
                    }
                    catch(error:Error)
                    {
                        console.output(("Failed to capture map! " + error.message));
                    };
                    break;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "displaymapdebug":
                    return ("Display a given map with debug filters activated. These filters apply a different color on every map layers.");
                case "displaymap":
                    return ("Display a given map.");
                case "getmapcoord":
                    return ("Get the world point for a given map id.");
                case "getmapid":
                    return ("Get the map id for a given world point.");
                case "showeverycellid":
                    return ("Display on each cell its id.");
                case "showtransitions":
                    return ("Toggle map transitions highlighting");
                case "groundcache":
                    return ("Set ground cache.\n<li>0 --> Disabled</li><li>1 --> High</li><li>2 --> Medium</li><li>3 --> Low</li>");
                case "mapid":
                    return ("Get the current map id.");
                case "removeblackbars":
                    return ("Remove the black mask around the current game map. Execute the command a second time to put it back.");
                case "setmaprenderscale":
                    return ("Specify a scale to render maps. If it's different than 1, the game will need to load it all assets as SWF in order to rescale them properly. Insure that your config.xml has the key gfx.path.world.swf defined!. Will deactivate temporarily caching of floor bitmap.");
                case "capturemap":
                    return ("Save a PNG of the current map on the user's desktop. It will be scaled per the value defined by the command setmaprenderscale. Optional parameters : true/false if you want a cropped render as it is ingame, true/false will export all scaled elements of the maps in a separate folder as PNG as well.");
                case "subareainfos":
                    return ("Get infos about the subarea.\nOptions : id (id de la sous-zone souhaitée. A placer en premier argument), area (id de la zone), maps (ids des maps de la sous-zone), zaap (id de la map du zaap associé), conquest (est-ce un village de conquête), autotrip (peut-on utiliser l'autopilotage dans cette sous-zone)");
            };
            return (("No help for command '" + cmd) + "'");
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}

