package com.ankamagames.dofus.console.chat
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.dofus.logic.game.spin2.chat.ChatService;
    import __AS3__.vec.Vector;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.logic.game.spin2.chat.data.GameActivities;
    import chat.protocol.user.data.FriendList;
    import chat.protocol.user.data.Friend;
    import chat.protocol.user.data.UserList;
    import chat.protocol.user.data.User;
    import com.ankamagames.dofus.logic.game.spin2.chat.ChatServiceManager;
    import chat.protocol.friendinvite.data.DeleteFriendInviteReason;
    import com.ankamagames.jerakine.console.ConsoleHandler;
    import __AS3__.vec.*;

    public class ChatServiceInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var chatService:ChatService;
            var activities:Vector.<String>;
            var metadatas:Dictionary;
            var gameActivities:Vector.<GameActivities>;
            var subCmd:String;
            var target:String;
            var target2:String;
            var reason:String;
            var friendList:FriendList;
            var friend:Friend;
            var msg:String;
            var length:int;
            var i:int;
            var a:GameActivities;
            var userId:String;
            var userList:UserList;
            var user:User;
            chatService = ChatServiceManager.getInstance().chatService;
            if (chatService == null)
            {
                console.output("Can't find chat service. probably not connected...");
                return;
            };
            switch (cmd)
            {
                case "friendinvite":
                    if (args.length == 4)
                    {
                        subCmd = args[0];
                        target = args[1];
                        target2 = args[2];
                        reason = args[3];
                        if ((((!(target == "")) && (!(target2 == ""))) && (((reason == DeleteFriendInviteReason.CANCELED) || (reason == DeleteFriendInviteReason.REJECTED)) || (reason == DeleteFriendInviteReason.ACCEPTED))))
                        {
                            if (subCmd == "process")
                            {
                                if (target == "all")
                                {
                                    chatService.processAllUserFriendInvites(reason);
                                }
                                else
                                {
                                    chatService.processUserFriendInvite(target, target2, reason);
                                };
                            };
                        };
                    };
                    if (args.length == 1)
                    {
                        chatService.sendFriendInvite(args[0]);
                    };
                    break;
                case "friend":
                    if (args.length == 1)
                    {
                        subCmd = args[0];
                        if (subCmd == "list")
                        {
                            friendList = chatService.friendList;
                            for each (friend in friendList.values)
                            {
                                console.output(friend.toString());
                            };
                        };
                    };
                    if (args.length == 2)
                    {
                        subCmd = args[0];
                        target = args[1];
                        if (((subCmd == "delete") && (!(target == ""))))
                        {
                            if (target == "all")
                            {
                                chatService.deleteAllUserFriend();
                            }
                            else
                            {
                                chatService.deleteUserFriend(target);
                            };
                        };
                    };
                    if (args.length == 3)
                    {
                        subCmd = args[0];
                        target = args[1];
                        if (((subCmd == "update") && (!(target == ""))))
                        {
                            chatService.updateUserFriend(target, args[2]);
                        };
                    };
                    break;
                case "friendgroup":
                    if (args.length == 2)
                    {
                        subCmd = args[0];
                        target = args[1];
                        if (((subCmd == "create") && (!(target == ""))))
                        {
                            chatService.createFriendGroup(target);
                        };
                        if (((subCmd == "delete") && (!(target == ""))))
                        {
                            chatService.deleteFriendGroup(target);
                        };
                    };
                    break;
                case "msg":
                    if (args.length >= 2)
                    {
                        target = args[0];
                        msg = "";
                        length = args.length;
                        i = 1;
                        while (i < length)
                        {
                            msg = (msg + (args[i] + " "));
                            i++;
                        };
                        if (((!(target == "")) && (!(msg == ""))))
                        {
                            chatService.sendMessage(target, msg);
                        };
                    };
                    break;
                case "mystatus":
                    if (args.length == 1)
                    {
                        chatService.updateUserStatus(args[0]);
                    };
                    break;
                case "myactivity":
                    activities = new Vector.<String>();
                    metadatas = new Dictionary();
                    if (args.length > 1)
                    {
                        activities.push(args[0]);
                        if (args.length >= 3)
                        {
                            metadatas[args[1]] = args[2];
                        };
                    };
                    chatService.updateUserActivity(activities, metadatas);
                    break;
                case "listactivities":
                    gameActivities = chatService.getGameActivities();
                    for each (a in gameActivities)
                    {
                        console.output(a.toString());
                    };
                    break;
                case "blockuser":
                    if (args.length == 2)
                    {
                        cmd = args[0];
                        userId = args[1];
                        if (cmd == "add")
                        {
                            chatService.blockUser(userId);
                        }
                        else
                        {
                            if (cmd == "delete")
                            {
                                chatService.deleteBlockedUser(userId);
                            };
                        };
                    }
                    else
                    {
                        if (((args.length == 1) && (args[0] == "list")))
                        {
                            userList = chatService.blockedUserList;
                            for each (user in userList.values)
                            {
                                console.output(user.toString());
                            };
                        };
                    };
                    break;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "friendinvite":
                    return ("\n/friendinvite userId|userName\n/friendinvite process inviterId recipientId Accepted|Rejected|Canceled\n/friendinvite process all Accepted|Rejected|Canceled");
                case "friend":
                    return ("\n/friend list\n/friend delete userId|userName|all\n/friend update userId|userName groupName");
                case "friendgroup":
                    return ("\n/friendgroup create groupName\n/friendgroup delete groupName");
                case "msg":
                    return ("/msg userId|userName hello spin world !!!");
                case "mystatus":
                    return ("/mystatus Available|Away|Busy");
                case "myactivity":
                    return ("/myactivity properties");
                case "listactivities":
                    return ("/listactivities");
                case "blockuser":
                    return ("\n/blockuser add|delete userId\n/blockuser list");
            };
            return ("");
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}

