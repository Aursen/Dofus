package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM_luaD_precall extends Machine
   {
      
      public function FSM_luaD_precall() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaD_precall = null;
         _loc1_ = new FSM_luaD_precall();
         FSM_luaD_precall.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 21;
      
      public static const NumberRegCount:int = 1;
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
      public var i17:int;
      
      public var i19:int;
      
      public var i16:int;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public var i8:int;
      
      public var i9:int;
      
      public var i18:int;
      
      override public final function work() : void {
      }
      
      public var i20:int;
      
      public var f0:Number;
   }
}