package com.ankamagames.dofus.datacenter.notifications
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class Notification#471 implements IDataCenter
   {
      
      public static const MODULE:String = "Notifications";
      
      protected static const _log:Logger;
      
      public static var idAccessors:IdAccessors;
      
      
      public var id:int;
      
      public var titleId:uint;
      
      public var messageId:uint;
      
      public var iconId:int;
      
      public var typeId:int;
      
      public var trigger:String;
      
      private var _title:String;
      
      private var _message:String;
      
      public function Notification#471()
      {
      }
      
      public static function getNotificationById(id:int) : Notification#471
      {
         return null; //autogenerated
      }
      
      public static function getNotifications() : Array
      {
         return null; //autogenerated
      }
      
      public function get title() : String
      {
         return ""; //autogenerated
      }
      
      public function get message() : String
      {
         return ""; //autogenerated
      }
   }
}