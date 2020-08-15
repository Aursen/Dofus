package Ankama_ContextMenu.makers
{
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import Ankama_ContextMenu.Api;
    import d2actions.InteractiveElementActivation;
    import Ankama_ContextMenu.contextMenu.ContextMenuItem;
    import com.ankamagames.dofus.internalDatacenter.guild.PaddockWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.PaddockInstanceWrapper;
    import com.ankamagames.dofus.internalDatacenter.house.HouseInstanceWrapper;
    import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
    import Ankama_ContextMenu.ContextMenu;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import d2actions.*;

    public class SkillMenuMaker implements IMenuMaker 
    {

        public static var disabled:Boolean = false;


        private function onSkillClicked(ie:Object, skillInstanceId:uint, additionalParam:int=0):void
        {
            Api.system.sendAction(new InteractiveElementActivation(ie.element, ie.position, skillInstanceId, additionalParam));
        }

        private function onDisabledSkillClicked(ie:Object, skillInstanceId:uint):void
        {
            Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"), Api.ui.getText("ui.skill.disabled"), [Api.ui.getText("ui.common.ok")], null);
        }

        public function createMenu(data:*, param:Object):Array
        {
            var cm:ContextMenuItem;
            var params:Array;
            var isDisabled:Boolean;
            var currentPaddockInstances:Array;
            var currentHouseInstances:Array;
            var skill:Object;
            var title:String;
            var currentPaddock:PaddockWrapper;
            var pricesMenu:Array;
            var lastGuildId:int;
            var paddockInst:PaddockInstanceWrapper;
            var priceText:String;
            var guildId:int;
            var ownersMenu:Array;
            var instanceId:int;
            var text:String;
            var houseInst:HouseInstanceWrapper;
            var menu:Array = new Array();
            var dead:* = (!(Api.player.isAlive()));
            var houseInformation:HouseWrapper = Api.data.getHouseInformations(param[0].element.elementId);
            if (houseInformation)
            {
                title = houseInformation.name;
                menu.push(ContextMenu.static_createContextMenuTitleObject(title));
                if (((houseInformation.houseInstances) && (houseInformation.houseInstances.length > 0)))
                {
                    currentHouseInstances = houseInformation.houseInstances;
                };
            }
            else
            {
                if (param[1])
                {
                    menu.push(ContextMenu.static_createContextMenuTitleObject(param[1].name));
                };
            };
            if (((param[1]) && (param[1].id == 120)))
            {
                currentPaddock = (Api.mount.getCurrentPaddock() as PaddockWrapper);
                if (((currentPaddock.paddockInstances) && (currentPaddock.paddockInstances.length > 0)))
                {
                    currentPaddockInstances = currentPaddock.paddockInstances;
                };
            };
            for each (skill in data)
            {
                isDisabled = (((disabled) || (!(skill.enabled))) || (dead));
                params = [param[0], skill.instanceId];
                Api.system.log(2, ("skill.id " + skill.id));
                if (((skill.id == DataEnum.SKILL_BUY_PADDOCK) && (currentPaddockInstances)))
                {
                    pricesMenu = new Array();
                    lastGuildId = 0;
                    for each (paddockInst in currentPaddockInstances)
                    {
                        if (((paddockInst.price > 0) && (!(paddockInst.isSaleLocked))))
                        {
                            priceText = paddockInst.priceString;
                            guildId = 0;
                            if (paddockInst.guildIdentity)
                            {
                                guildId = paddockInst.guildIdentity.guildId;
                                priceText = (((priceText + " (") + paddockInst.guildIdentity.guildName) + ")");
                            };
                            pricesMenu.push(ContextMenu.static_createContextMenuItemObject(priceText, this.onSkillClicked, [param[0], skill.instanceId, guildId], false, null));
                            if (guildId > 0)
                            {
                                lastGuildId = guildId;
                            };
                        };
                    };
                    if (pricesMenu.length > 1)
                    {
                        cm = ContextMenu.static_createContextMenuItemObject(skill.name, null, null, isDisabled, pricesMenu);
                    }
                    else
                    {
                        cm = ContextMenu.static_createContextMenuItemObject(skill.name, this.onSkillClicked, [param[0], skill.instanceId, lastGuildId], isDisabled);
                    };
                }
                else
                {
                    if (currentHouseInstances)
                    {
                        ownersMenu = new Array();
                        instanceId = 0;
                        for each (houseInst in currentHouseInstances)
                        {
                            if ((((skill.id == DataEnum.SKILL_BUY_HOUSE) || (skill.id == DataEnum.SKILL_CHANGE_PRICE_HOUSE)) && (!(houseInst.isOnSale))))
                            {
                            }
                            else
                            {
                                if (((skill.id == DataEnum.SKILL_BUY_HOUSE) && (houseInst.isMine)))
                                {
                                }
                                else
                                {
                                    if (((skill.id == DataEnum.SKILL_SELL_HOUSE) && (houseInst.isOnSale)))
                                    {
                                    }
                                    else
                                    {
                                        if (((skill.id == DataEnum.SKILL_LOCK_HOUSE) && (houseInst.isLocked)))
                                        {
                                        }
                                        else
                                        {
                                            if (((skill.id == DataEnum.SKILL_UNLOCK_HOUSE) && (!(houseInst.isLocked))))
                                            {
                                            }
                                            else
                                            {
                                                if (((((((skill.id == DataEnum.SKILL_SELL_HOUSE) || (skill.id == DataEnum.SKILL_CHANGE_PRICE_HOUSE)) || (skill.id == DataEnum.SKILL_LOCK_HOUSE)) || (skill.id == DataEnum.SKILL_UNLOCK_HOUSE)) && (!(houseInst.isMine))) && (!(Api.system.hasRight()))))
                                                {
                                                }
                                                else
                                                {
                                                    instanceId = houseInst.id;
                                                    if (((skill.id == DataEnum.SKILL_BUY_HOUSE) || (skill.id == DataEnum.SKILL_CHANGE_PRICE_HOUSE)))
                                                    {
                                                        text = (((Api.util.kamasToString(houseInst.price) + " (") + houseInst.label) + ")");
                                                    }
                                                    else
                                                    {
                                                        text = houseInst.label;
                                                    };
                                                    ownersMenu.push(ContextMenu.static_createContextMenuItemObject(text, this.onSkillClicked, [param[0], skill.instanceId, instanceId], false, null));
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                        if (ownersMenu.length > 1)
                        {
                            cm = ContextMenu.static_createContextMenuItemObject(skill.name, null, null, isDisabled, ownersMenu);
                        }
                        else
                        {
                            cm = ContextMenu.static_createContextMenuItemObject(skill.name, this.onSkillClicked, [param[0], skill.instanceId, instanceId], isDisabled);
                        };
                    }
                    else
                    {
                        cm = ContextMenu.static_createContextMenuItemObject(skill.name, this.onSkillClicked, [param[0], skill.instanceId], isDisabled);
                    };
                };
                if (isDisabled)
                {
                    cm.addDisabledCallback(this.onDisabledSkillClicked, params);
                };
                menu.push(cm);
            };
            return (menu);
        }


    }
}

