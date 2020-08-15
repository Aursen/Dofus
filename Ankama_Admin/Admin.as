package Ankama_Admin
{
    import flash.display.Sprite;
    import Ankama_Admin.adminMenu.AdminMenu;
    import Ankama_Admin.ui.AdminSelectItem;
    import com.ankamagames.dofus.uiApi.FileApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.RoleplayApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import d2hooks.MapComplementaryInformationsData;
    import d2hooks.OpeningContextMenu;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.network.types.game.context.roleplay.HumanInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionGuild;
    import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionAlliance;
    import com.ankamagames.berilia.types.data.ContextMenuData;
    import d2hooks.*;

    public class Admin extends Sprite 
    {

        private static var _self:Admin;
        private static var _adminMenu:AdminMenu;

        private var _include_SelectItem:AdminSelectItem = null;
        [Api(name="FileApi")]
        public var fileApi:FileApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="RoleplayApi")]
        public var roleplayApi:RoleplayApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="PlayedCharacterApi")]
        public var playedCharacterApi:PlayedCharacterApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Module(name="Ankama_ContextMenu")]
        public var contextMod:Object;
        [Module(name="Ankama_Console")]
        public var consoleMod:Object;


        public static function getInstance():Admin
        {
            return (_self);
        }


        public function main(... args):void
        {
            if (!this.sysApi.hasRight())
            {
                return;
            };
            _self = this;
            Api.fileApi = this.fileApi;
            Api.uiApi = this.uiApi;
            Api.systemApi = this.sysApi;
            Api.dataApi = this.dataApi;
            Api.contextMod = this.contextMod;
            Api.consoleMod = this.consoleMod;
            _adminMenu = new AdminMenu();
            this.sysApi.addHook(MapComplementaryInformationsData, this.onGameStart);
            this.sysApi.addHook(OpeningContextMenu, this.onOpeningContextMenu);
        }

        public function reloadXml():void
        {
            _adminMenu = new AdminMenu();
        }

        private function onOpeningContextMenu(contextMenuData:ContextMenuData):void
        {
            var info:Object;
            var tempContent:Array;
            var newMenu:Array;
            var elem:Object;
            var elem2:Object;
            var elem3:Object;
            var data:Object;
            var option:*;
            var playerInfos:Dictionary;
            var entity:Object;
            var cellId:uint;
            var entities:Object;
            var subMenu:Object;
            var infos:Object;
            if (contextMenuData)
            {
                info = new Object();
                info.m = this.playedCharacterApi.currentMap().mapId;
                info.n = this.playedCharacterApi.getPlayedCharacterInfo().name;
                info.s = this.sysApi.getCurrentServer().name;
                info.v = this.sysApi.getCurrentVersion();
                info.d = new Date().date;
                if (contextMenuData.makerName == "player")
                {
                    if (contextMenuData.data)
                    {
                        data = contextMenuData.data;
                        if (data.hasOwnProperty("name"))
                        {
                            info.p = data.name;
                        };
                        if ((data is String))
                        {
                            info.p = data;
                        };
                        if ((((data.hasOwnProperty("humanoidInfo")) && (data.humanoidInfo.hasOwnProperty("options"))) && (data.humanoidInfo.options)))
                        {
                            if ((data.humanoidInfo is HumanInformations))
                            {
                                for each (option in (data.humanoidInfo as HumanInformations).options)
                                {
                                    if ((option is HumanOptionGuild))
                                    {
                                        info.g = option.guildInformations.guildName;
                                    };
                                    if ((option is HumanOptionAlliance))
                                    {
                                        info.a = option.allianceInformations.allianceName;
                                    };
                                };
                            };
                        };
                    };
                    tempContent = new Array();
                    newMenu = _adminMenu.process(info);
                    for each (elem in newMenu)
                    {
                        tempContent.push(elem);
                    };
                    for each (elem2 in contextMenuData.content)
                    {
                        tempContent.push(elem2);
                    };
                    contextMenuData.content.length = 0;
                    for each (elem3 in tempContent)
                    {
                        contextMenuData.content.push(elem3);
                    };
                }
                else
                {
                    if (contextMenuData.makerName == "multiplayer")
                    {
                        playerInfos = new Dictionary();
                        entity = this.roleplayApi.getEntityByName(contextMenuData.data.name);
                        cellId = entity.position.cellId;
                        entities = this.roleplayApi.getEntitiesOnCell(cellId);
                        for each (entity in entities)
                        {
                            if (entity.id > 0)
                            {
                                infos = this.roleplayApi.getEntityInfos(entity);
                                if (!infos.hasOwnProperty("fight"))
                                {
                                    playerInfos[infos.name] = infos;
                                };
                            };
                        };
                        for each (subMenu in contextMenuData.content)
                        {
                            info = new Object();
                            data = playerInfos[subMenu.label];
                            if (data.hasOwnProperty("name"))
                            {
                                info.p = data.name;
                            };
                            if ((data is String))
                            {
                                info.p = data;
                            };
                            if (((((data.hasOwnProperty("humanoidInfo")) && (data.humanoidInfo.hasOwnProperty("guildInformations"))) && (data.humanoidInfo.guildInformations)) && (data.humanoidInfo.guildInformations.guildName)))
                            {
                                info.g = data.humanoidInfo.guildInformations.guildName;
                            };
                            subMenu.child = _adminMenu.process(info).concat(subMenu.child);
                        };
                    };
                };
            };
        }

        private function onGameStart(... args):void
        {
            this.sysApi.removeHook(MapComplementaryInformationsData);
            _adminMenu.onStart();
        }


    }
}

