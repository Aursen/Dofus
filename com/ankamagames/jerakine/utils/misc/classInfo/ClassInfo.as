package com.ankamagames.jerakine.utils.misc.classInfo
{
    import __AS3__.vec.Vector;
    import flash.utils.Dictionary;

    public class ClassInfo 
    {

        public var extendsClasses:Vector.<String>;
        public var implementsInterfaces:Vector.<String>;
        public var variables:Vector.<String>;
        public var accessorsRW:Vector.<String>;
        public var accessorsR:Vector.<String>;
        public var accessorsW:Vector.<String>;
        public var variablesMetadatas:Dictionary = new Dictionary();
        public var metadatas:Vector.<MetadataInfo>;


    }
}

