package com.ankamagames.berilia.utils
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import nochump.util.zip.ZipEntry;
    import nochump.util.zip.ZipFile;
    import flash.filesystem.File;
    import flash.filesystem.FileStream;
    import flash.utils.ByteArray;
    import flash.filesystem.FileMode;

    public class ThemeInspector 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ThemeInspector));
        public static const whiteList:Array = new Array("dt", "swf", "xml", "xmls", "txt", "png", "jpg", "css", "dt", "json", "fla");
        public static const MAX_FILE_SIZE:int = int.MAX_VALUE;//2147483647
        public static const MAX_FILE_NUM:int = 1500;


        public static function checkArchiveValidity(archive:ZipFile):Boolean
        {
            var entry:ZipEntry;
            var totalSize:int;
            for each (entry in archive.entries)
            {
                totalSize = (totalSize + entry.size);
            };
            return ((totalSize < MAX_FILE_SIZE) && (archive.size < MAX_FILE_NUM));
        }

        public static function getDtFile(targetFile:File):XML
        {
            var entry:File;
            var dmData:XML;
            var rfs:FileStream;
            var rawData:ByteArray = new ByteArray();
            if (targetFile.exists)
            {
                for each (entry in targetFile.getDirectoryListing())
                {
                    if (!entry.isDirectory)
                    {
                        if (entry.type == ".dt")
                        {
                            if (entry.name.lastIndexOf("/") != -1)
                            {
                                return (null);
                            };
                            rfs = new FileStream();
                            rfs.open(File(entry), FileMode.READ);
                            rfs.readBytes(rawData, 0, rfs.bytesAvailable);
                            rfs.close();
                            dmData = new XML(rawData.readUTFBytes(rawData.bytesAvailable));
                            return (dmData);
                        };
                    };
                };
            };
            return (null);
        }

        public static function getZipDmFile(targetFile:ZipFile):XML
        {
            var entry:ZipEntry;
            var dtData:XML;
            var dotIndex:int;
            var fileType:String;
            var rawData:ByteArray = new ByteArray();
            for each (entry in targetFile.entries)
            {
                if (!entry.isDirectory())
                {
                    dotIndex = entry.name.lastIndexOf(".");
                    fileType = entry.name.substring((dotIndex + 1));
                    if (fileType.toLowerCase() == "dt")
                    {
                        if (entry.name.lastIndexOf("/") != -1)
                        {
                            return (null);
                        };
                        rawData = ZipFile(targetFile).getInput(entry);
                        try
                        {
                            dtData = new XML(rawData.readUTFBytes(rawData.bytesAvailable));
                        }
                        catch(error:Error)
                        {
                            _log.error(((("Error parsing " + entry.name) + "\n") + error.message));
                        };
                        return (dtData);
                    };
                };
            };
            return (null);
        }


    }
} com.ankamagames.berilia.utils

