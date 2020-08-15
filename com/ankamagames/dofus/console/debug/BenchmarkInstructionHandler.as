package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.entities.interfaces.IAnimated;
    import com.ankamagames.dofus.misc.utils.frames.LuaScriptRecorderFrame;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
    import com.ankamagames.jerakine.utils.prng.PRNG;
    import com.ankamagames.dofus.types.entities.BenchmarkCharacter;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.datacenter.communication.Emoticon;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.dofus.logic.common.frames.DebugBotFrame;
    import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.dofus.misc.BenchmarkMovementBehavior;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.tiphon.engine.TiphonDebugManager;
    import com.ankamagames.dofus.logic.common.frames.FightBotFrame;
    import com.ankamagames.dofus.console.moduleLogger.ModuleDebugManager;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
    import com.ankamagames.dofus.logic.common.frames.BenchmarkFrame;
    import com.ankamagames.jerakine.console.ConsoleHandler;
    import com.ankamagames.dofus.datacenter.monsters.Monster;

    public class BenchmarkInstructionHandler implements ConsoleInstructionHandler 
    {

        private static var id:uint = 50000;

        protected var _log:Logger = Log.getLogger(getQualifiedClassName(BenchmarkInstructionHandler));


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var emotes:Array;
            var emoticonFounded:Boolean;
            var animName:String;
            var animEntity:IAnimated;
            var lsrf:LuaScriptRecorderFrame;
            var fef:FightEntitiesFrame;
            var dic:Dictionary;
            var dirEntity:IAnimated;
            var fps:FpsManager;
            var txt:String;
            var useCache:Boolean;
            var typeZone:int;
            var showFightZone:Boolean;
            var showInteractiveCells:Boolean;
            var showTacticMode:Boolean;
            var showScalezone:Boolean;
            var flattenCells:Boolean;
            var showBlockMvt:Boolean;
            var rnd:PRNG;
            var i:uint;
            var rpCharEntity:BenchmarkCharacter;
            var cell:MapPoint;
            var emote:Emoticon;
            var name:String;
            var param:String;
            var fightEntity:GameContextActorInformations;
            var gfmi:GameFightMonsterInformations;
            var fr:DebugBotFrame;
            var chatind:int;
            var time:int;
            var arg:String;
            var valueTab:Array;
            var cmdValue:String;
            switch (cmd)
            {
                case "addmovingcharacter":
                    if (args.length > 0)
                    {
                        rnd = new ParkMillerCarta(4538651);
                        i = 0;
                        while (i < parseInt(args[1]))
                        {
                            rpCharEntity = new BenchmarkCharacter(id++, TiphonEntityLook.fromString(args[0]));
                            while (true)
                            {
                                cell = MapPoint.fromCellId(rnd.nextIntR(0, AtouinConstants.MAP_CELLS_COUNT));
                                if (DataMapProvider.getInstance().pointMov(cell.x, cell.y))
                                {
                                    break;
                                };
                            };
                            rpCharEntity.position = MapPoint.fromCellId(cell.cellId);
                            rpCharEntity.display();
                            rpCharEntity.move(BenchmarkMovementBehavior.getRandomPath(rpCharEntity));
                            i++;
                        };
                    };
                    break;
                case "playemote":
                    emotes = Emoticon.getEmoticons();
                    emoticonFounded = false;
                    animName = StringUtils.noAccent(args.join(" ").toLowerCase());
                    for each (emote in emotes)
                    {
                        name = I18n.getUnDiacriticalText(emote.nameId);
                        if (animName.indexOf(name) != -1)
                        {
                            args[0] = emote.getAnimName(TiphonSprite(DofusEntities.getEntity(PlayedCharacterManager.getInstance().id)).look);
                            emoticonFounded = true;
                        };
                    };
                    if (!emoticonFounded)
                    {
                        console.output(("Aucune correspondance trouvée pour : " + animName));
                        return;
                    };
                    for each (param in args)
                    {
                        if (parseInt(param).toString() == param)
                        {
                            args[1] = param;
                            break;
                        };
                    };
                case "setanimation":
                    animEntity = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IAnimated);
                    lsrf = (Kernel.getWorker().getFrame(LuaScriptRecorderFrame) as LuaScriptRecorderFrame);
                    if (Kernel.getWorker().getFrame(LuaScriptRecorderFrame))
                    {
                        lsrf.createLine("player", "setAnimation", args[0], true);
                    };
                    animEntity.setAnimation(args[0]);
                    if (((animEntity is TiphonSprite) && (args.length > 1)))
                    {
                        TiphonSprite(animEntity).stopAnimation(parseInt(args[1]));
                    };
                    break;
                case "setdirection":
                    fef = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
                    dic = fef.getEntitiesDictionnary();
                    dirEntity = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IAnimated);
                    for each (fightEntity in dic)
                    {
                        if ((fightEntity is GameFightMonsterInformations))
                        {
                            gfmi = (fightEntity as GameFightMonsterInformations);
                            if (gfmi.creatureGenericId == parseInt(args[1]))
                            {
                                dirEntity = (DofusEntities.getEntity(gfmi.contextualId) as IAnimated);
                                dirEntity.setDirection(args[0]);
                            };
                        };
                    };
                    dirEntity.setDirection(args[0]);
                    break;
                case "tiphon-error":
                    TiphonDebugManager.disable();
                    break;
                case "bot-spectator":
                    if (Kernel.getWorker().contains(DebugBotFrame))
                    {
                        Kernel.getWorker().removeFrame(DebugBotFrame.getInstance());
                        console.output((("Arret du bot-spectator, " + DebugBotFrame.getInstance().fightCount) + " combat(s) vu"));
                    }
                    else
                    {
                        fr = DebugBotFrame.getInstance();
                        chatind = args.indexOf("debugchat");
                        if (chatind != -1)
                        {
                            time = 500;
                            if (args.length > (chatind + 1))
                            {
                                time = args[(chatind + 1)];
                            };
                            fr.enableChatMessagesBot(true, time);
                        };
                        Kernel.getWorker().addFrame(fr);
                        console.output("Démarrage du bot-spectator ");
                    };
                    break;
                case "bot-fight":
                    if (Kernel.getWorker().contains(FightBotFrame))
                    {
                        Kernel.getWorker().removeFrame(FightBotFrame.getInstance());
                        console.output((("Arret du bot-fight, " + FightBotFrame.getInstance().fightCount) + " combat(s) effectué"));
                    }
                    else
                    {
                        Kernel.getWorker().addFrame(FightBotFrame.getInstance());
                        console.output("Démarrage du bot-fight ");
                    };
                    break;
                case "fps":
                    ModuleDebugManager.display((!(ModuleDebugManager.isDisplayed)), false);
                    break;
                case "fpsmanager":
                    fps = FpsManager.getInstance();
                    if (StageShareManager.stage.contains(fps))
                    {
                        fps.hide();
                    }
                    else
                    {
                        fps.display();
                    };
                    break;
                case "tacticmode":
                    TacticModeManager.getInstance().hide();
                    useCache = false;
                    typeZone = 0;
                    showFightZone = false;
                    showInteractiveCells = false;
                    showTacticMode = false;
                    showScalezone = false;
                    flattenCells = true;
                    showBlockMvt = true;
                    for each (arg in args)
                    {
                        valueTab = arg.split("=");
                        if (valueTab == null)
                        {
                        }
                        else
                        {
                            cmdValue = valueTab[1];
                            if (((!(arg.search("fightzone") == -1)) && (valueTab.length > 1)))
                            {
                                showFightZone = (cmdValue.toLowerCase() == "true");
                            }
                            else
                            {
                                if (((!(arg.search("clearcache") == -1)) && (valueTab.length > 1)))
                                {
                                    useCache = (!(cmdValue.toLowerCase() == "true"));
                                }
                                else
                                {
                                    if (((!(arg.search("mode") == -1)) && (valueTab.length > 1)))
                                    {
                                        typeZone = ((cmdValue.toLowerCase() == "rp") ? 1 : 0);
                                    }
                                    else
                                    {
                                        if (((!(arg.search("interactivecells") == -1)) && (valueTab.length > 1)))
                                        {
                                            showInteractiveCells = (cmdValue.toLowerCase() == "true");
                                        }
                                        else
                                        {
                                            if (((!(arg.search("scalezone") == -1)) && (valueTab.length > 1)))
                                            {
                                                showScalezone = (cmdValue.toLowerCase() == "true");
                                            }
                                            else
                                            {
                                                if (((!(arg.search("show") == -1)) && (valueTab.length > 1)))
                                                {
                                                    showTacticMode = (cmdValue.toLowerCase() == "true");
                                                }
                                                else
                                                {
                                                    if (((!(arg.search("flattencells") == -1)) && (valueTab.length > 1)))
                                                    {
                                                        flattenCells = (cmdValue.toLowerCase() == "true");
                                                    }
                                                    else
                                                    {
                                                        if (((!(arg.search("blocLDV") == -1)) && (valueTab.length > 1)))
                                                        {
                                                            showBlockMvt = (cmdValue.toLowerCase() == "true");
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                    if (showTacticMode)
                    {
                        TacticModeManager.getInstance().setDebugMode(showFightZone, useCache, typeZone, showInteractiveCells, showScalezone, flattenCells, showBlockMvt);
                        TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap, true);
                        txt = "Activation";
                    }
                    else
                    {
                        txt = "Désactivation";
                    };
                    txt = (txt + " du mode tactique.");
                    console.output(txt);
                    break;
                case "chainteleport":
                    if (Kernel.getWorker().contains(BenchmarkFrame))
                    {
                        Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(BenchmarkFrame));
                    }
                    else
                    {
                        Kernel.getWorker().addFrame(new BenchmarkFrame());
                    };
                    break;
                case "memorylog":
                    console.output(FpsManager.getInstance().dumpData());
                    break;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "setdirection":
                    return ("Set direction of the player if only one arg is used. You can specifie a second arg that will be the generic ID of a monster (use tab to list them)");
                case "playemote":
                    return ("Set the animation of the current player. Param 1: Name of the emoticon, param 2 (opt): Frame of the animation");
                case "setanimation":
                    return ("Set the animation of the current player. Param 1: Name of the animation, param 2 (opt): Frame of the animation");
                case "addmovingcharacter":
                    return ("Add a new mobile character on scene.");
                case "fps":
                    return ("Displays the performance of the client.");
                case "fpsmanager":
                    return ("Displays the performance of the client." + "\n    external");
                case "bot-spectator":
                    return ("Start/Stop the auto join fight spectator bot" + "\n    debugchat");
                case "tiphon-error":
                    return ("Désactive l'affichage des erreurs du moteur d'animation.");
                case "tacticmode":
                    return ((((((("Active/Désactive le mode tactique" + "\n    show=[true|false]") + "\n    clearcache=[true|false]") + "\n    mode=[fight|RP]") + "\n    interactivecells=[true|false] ") + "\n    fightzone=[true|false]") + "\n    scalezone=[true|false]") + "\n    flattencells=[true|false]");
                case "chainteleport":
                    return ("Chain teleport in all game area");
            };
            return ("Unknow command");
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            var animEntity:TiphonSprite;
            var list:Array;
            var animList:Array;
            var anim:String;
            var fef:FightEntitiesFrame;
            var dic:Dictionary;
            var monsterList:Array;
            var fightEntity:GameContextActorInformations;
            var gfmi:GameFightMonsterInformations;
            var emotes:Array;
            var emoteNames:Array;
            var emote:Emoticon;
            switch (cmd)
            {
                case "tacticmode":
                    return (["show", "clearcache", "mode", "interactivecells", "fightzone", "scalezone", "flattencells"]);
                case "setanimation":
                    animEntity = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as TiphonSprite);
                    list = animEntity.animationList;
                    animList = [];
                    for each (anim in list)
                    {
                        if (anim.indexOf("Anim") != -1)
                        {
                            animList.push(anim);
                        };
                    };
                    animList.sort();
                    return (animList);
                case "setdirection":
                    if (paramIndex == 0)
                    {
                        return ([0, 1, 2, 3, 4, 5, 6, 7]);
                    };
                    if (paramIndex == 1)
                    {
                        fef = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
                        dic = fef.getEntitiesDictionnary();
                        monsterList = [];
                        for each (fightEntity in dic)
                        {
                            if ((fightEntity is GameFightMonsterInformations))
                            {
                                gfmi = (fightEntity as GameFightMonsterInformations);
                                monsterList.push(((Monster.getMonsterById(gfmi.creatureGenericId).id + " ") + Monster.getMonsterById(gfmi.creatureGenericId).name));
                            };
                        };
                        monsterList.sort();
                        return (monsterList);
                    };
                    break;
                case "playemote":
                    if (paramIndex == 0)
                    {
                        emotes = Emoticon.getEmoticons();
                        emoteNames = [];
                        for each (emote in emotes)
                        {
                            emoteNames.push(emote.name);
                        };
                        return (emoteNames);
                    };
            };
            return ([]);
        }


    }
}

