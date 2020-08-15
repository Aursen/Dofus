package com.ankamagames.jerakine.data
{
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import flash.utils.IDataInput;
    import com.ankamagames.jerakine.enum.GameDataTypeEnum;
    import flash.utils.ByteArray;
    import __AS3__.vec.*;

    public class GameDataProcess 
    {

        private var _searchFieldIndex:Dictionary;
        private var _searchFieldCount:Dictionary;
        private var _searchFieldType:Dictionary;
        private var _queryableField:Vector.<String>;
        private var _stream:IDataInput;
        private var _currentStream:IDataInput;
        private var _sortIndex:Dictionary;

        public function GameDataProcess(stream:IDataInput)
        {
            this._stream = stream;
            this._sortIndex = new Dictionary();
            this.parseStream();
        }

        public function getQueryableField():Vector.<String>
        {
            return (this._queryableField);
        }

        public function getFieldType(fieldName:String):int
        {
            return (this._searchFieldType[fieldName]);
        }

        public function query(fieldName:String, match:Function):Vector.<uint>
        {
            var idsCount:Number;
            var j:uint;
            var result:Vector.<uint> = new Vector.<uint>();
            if (!this._searchFieldIndex[fieldName])
            {
                return (null);
            };
            var _local_4:int = this._searchFieldType[fieldName];
            var readFct:Function = this.getReadFunction(_local_4);
            var itemCount:uint = this._searchFieldCount[fieldName];
            Object(this._stream).position = this._searchFieldIndex[fieldName];
            if (readFct == null)
            {
                return (null);
            };
            var i:uint;
            while (i++ < itemCount)
            {
                if (match(readFct()))
                {
                    idsCount = (this._stream.readInt() * 0.25);
                    j = 0;
                    while (j < idsCount)
                    {
                        result.push(this._stream.readInt());
                        j++;
                    };
                }
                else
                {
                    Object(this._stream).position = (this._stream.readInt() + Object(this._stream).position);
                };
            };
            return (result);
        }

        public function queryEquals(fieldName:String, value:*):Vector.<uint>
        {
            var readValue:*;
            var idsCount:Number;
            var j:uint;
            var result:Vector.<uint> = new Vector.<uint>();
            if (!this._searchFieldIndex[fieldName])
            {
                return (null);
            };
            var iterable:* = (!((((((value is uint) || (value is int)) || (value is Number)) || (value is String)) || (value is Boolean)) || (value == null)));
            if (((iterable) && (value.length == 0)))
            {
                return (result);
            };
            if (!iterable)
            {
                value = [value];
            };
            var itemCount:uint = this._searchFieldCount[fieldName];
            Object(this._stream).position = this._searchFieldIndex[fieldName];
            var _local_6:int = this._searchFieldType[fieldName];
            var readFct:Function = this.getReadFunction(_local_6);
            if (readFct == null)
            {
                return (null);
            };
            var valueIndex:uint;
            value.sort(Array.NUMERIC);
            var currentValue:* = value[0];
            var i:uint;
            while (i++ < itemCount)
            {
                readValue = readFct();
                while (readValue > currentValue)
                {
                    if (++valueIndex == value.length)
                    {
                        return (result);
                    };
                    currentValue = value[valueIndex];
                };
                if (readValue == currentValue)
                {
                    idsCount = (this._stream.readInt() * 0.25);
                    j = 0;
                    while (j < idsCount)
                    {
                        result.push(this._stream.readInt());
                        j++;
                    };
                    if (++valueIndex == value.length)
                    {
                        return (result);
                    };
                    currentValue = value[valueIndex];
                }
                else
                {
                    Object(this._stream).position = (this._stream.readInt() + Object(this._stream).position);
                };
            };
            return (result);
        }

        public function sort(fieldNames:*, ids:Vector.<uint>, ascending:*=true):Vector.<uint>
        {
            ids.sort(this.getSortFunction(fieldNames, ascending));
            return (ids);
        }

        private function getSortFunction(fieldNames:*, ascending:*):Function
        {
            var sortWay:Vector.<Number>;
            var indexes:Vector.<Dictionary>;
            var maxFieldIndex:uint;
            var fieldName:String;
            if ((fieldNames is String))
            {
                fieldNames = [fieldNames];
            };
            if ((ascending is Boolean))
            {
                ascending = [ascending];
            };
            sortWay = new Vector.<Number>();
            indexes = new Vector.<Dictionary>();
            var i:uint;
            while (i < fieldNames.length)
            {
                fieldName = fieldNames[i];
                if (this._searchFieldType[fieldName] == GameDataTypeEnum.I18N)
                {
                    this.buildI18nSortIndex(fieldName);
                }
                else
                {
                    this.buildSortIndex(fieldName);
                };
                if (ascending.length < fieldNames.length)
                {
                    ascending.push(true);
                };
                sortWay.push(((ascending[i]) ? 1 : -1));
                indexes.push(this._sortIndex[fieldName]);
                i++;
            };
            maxFieldIndex = fieldNames.length;
            return (function (t1:uint, t2:uint):Number
            {
                var fieldIndex:* = 0;
                while (fieldIndex < maxFieldIndex)
                {
                    if (indexes[fieldIndex][t1] < indexes[fieldIndex][t2])
                    {
                        return (-(sortWay[fieldIndex]));
                    };
                    if (indexes[fieldIndex][t1] > indexes[fieldIndex][t2])
                    {
                        return (sortWay[fieldIndex]);
                    };
                    fieldIndex++;
                };
                return (0);
            });
        }

        private function buildSortIndex(fieldName:String):void
        {
            var v:*;
            var idsCount:Number;
            var j:uint;
            if (((this._sortIndex[fieldName]) || (!(this._searchFieldIndex[fieldName]))))
            {
                return;
            };
            var result:Vector.<uint> = new Vector.<uint>();
            var itemCount:uint = this._searchFieldCount[fieldName];
            Object(this._stream).position = this._searchFieldIndex[fieldName];
            var ref:Dictionary = new Dictionary();
            this._sortIndex[fieldName] = ref;
            var _local_5:int = this._searchFieldType[fieldName];
            var readFct:Function = this.getReadFunction(_local_5);
            if (readFct == null)
            {
                return;
            };
            var id:uint;
            var quickIndexCount:uint;
            var i:uint;
            while (i++ < itemCount)
            {
                v = readFct();
                idsCount = (this._stream.readInt() * 0.25);
                j = 0;
                while (j < idsCount)
                {
                    ref[this._stream.readInt()] = v;
                    j++;
                };
            };
        }

        private function buildI18nSortIndex(fieldName:String):void
        {
            var key:uint;
            var idsCount:Number;
            var i18nOrder:uint;
            var j:uint;
            if (((this._sortIndex[fieldName]) || (!(this._searchFieldIndex[fieldName]))))
            {
                return;
            };
            var result:Vector.<uint> = new Vector.<uint>();
            var itemCount:uint = this._searchFieldCount[fieldName];
            Object(this._stream).position = this._searchFieldIndex[fieldName];
            var ref:Dictionary = new Dictionary();
            this._sortIndex[fieldName] = ref;
            var i:uint;
            while (i++ < itemCount)
            {
                key = this._stream.readInt();
                idsCount = (this._stream.readInt() * 0.25);
                if (idsCount)
                {
                    i18nOrder = I18nFileAccessor.getInstance().getOrderIndex(key);
                    j = 0;
                    while (j < idsCount)
                    {
                        ref[this._stream.readInt()] = i18nOrder;
                        j++;
                    };
                };
            };
        }

        private function readI18n():String
        {
            return (I18nFileAccessor.getInstance().getUnDiacriticalText(this._currentStream.readInt()));
        }

        private function getReadFunction(_arg_1:int):Function
        {
            var readFct:Function;
            var directBuffer:ByteArray;
            switch (_arg_1)
            {
                case GameDataTypeEnum.INT:
                    readFct = this._stream.readInt;
                    break;
                case GameDataTypeEnum.BOOLEAN:
                    readFct = this._stream.readBoolean;
                    break;
                case GameDataTypeEnum.STRING:
                    readFct = this._stream.readUTF;
                    break;
                case GameDataTypeEnum.NUMBER:
                    readFct = this._stream.readDouble;
                    break;
                case GameDataTypeEnum.I18N:
                    I18nFileAccessor.getInstance().useDirectBuffer(true);
                    readFct = this.readI18n;
                    if (!(this._stream is ByteArray))
                    {
                        directBuffer = new ByteArray();
                        Object(this._stream).position = 0;
                        this._stream.readBytes(directBuffer);
                        directBuffer.position = 0;
                        this._stream = directBuffer;
                        this._currentStream = this._stream;
                    };
                    break;
                case GameDataTypeEnum.UINT:
                    readFct = this._stream.readUnsignedInt;
                    break;
            };
            return (readFct);
        }

        private function parseStream():void
        {
            var size:uint;
            var fieldName:String;
            this._queryableField = new Vector.<String>();
            this._searchFieldIndex = new Dictionary();
            this._searchFieldType = new Dictionary();
            this._searchFieldCount = new Dictionary();
            var fieldListSize:int = this._stream.readInt();
            var indexSearchOffset:uint = ((Object(this._stream).position + fieldListSize) + 4);
            while (fieldListSize)
            {
                size = this._stream.bytesAvailable;
                fieldName = this._stream.readUTF();
                this._queryableField.push(fieldName);
                this._searchFieldIndex[fieldName] = (this._stream.readInt() + indexSearchOffset);
                this._searchFieldType[fieldName] = this._stream.readInt();
                this._searchFieldCount[fieldName] = this._stream.readInt();
                fieldListSize = (fieldListSize - (size - this._stream.bytesAvailable));
            };
        }


    }
}

