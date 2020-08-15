package com.ankama.zaap
{
    import org.apache.thrift.protocol.TProtocol;
    import org.apache.thrift.protocol.TMessage;
    import org.apache.thrift.protocol.TMessageType;
    import org.apache.thrift.TApplicationError;
    import org.apache.thrift.TError;

    public class ZaapServiceImpl implements ZaapService 
    {

        protected var iprot_:TProtocol;
        protected var oprot_:TProtocol;
        protected var seqid_:int;

        public function ZaapServiceImpl(_arg_1:TProtocol, _arg_2:TProtocol=null)
        {
            this.iprot_ = _arg_1;
            if (_arg_2 == null)
            {
                this.oprot_ = _arg_1;
            }
            else
            {
                this.oprot_ = _arg_2;
            };
        }

        public function getInputProtocol():TProtocol
        {
            return (this.iprot_);
        }

        public function getOutputProtocol():TProtocol
        {
            return (this.oprot_);
        }

        public function connect(gameName:String, releaseName:String, instanceId:int, hash:String, onError:Function, onSuccess:Function):void
        {
            this.oprot_.writeMessageBegin(new TMessage("connect", TMessageType.CALL, this.seqid_));
            var args:connect_args = new connect_args();
            args.gameName = gameName;
            args.releaseName = releaseName;
            args.instanceId = instanceId;
            args.hash = hash;
            args.write(this.oprot_);
            this.oprot_.writeMessageEnd();
            this.oprot_.getTransport().flush(function (error:Error):void
            {
                var msg:TMessage;
                var result:connect_result;
                var x:TApplicationError;
                try
                {
                    if (error != null)
                    {
                        if (onError != null)
                        {
                            onError(error);
                        };
                        return;
                    };
                    msg = iprot_.readMessageBegin();
                    if (msg.type == TMessageType.EXCEPTION)
                    {
                        x = TApplicationError.read(iprot_);
                        iprot_.readMessageEnd();
                        if (onError != null)
                        {
                            onError(x);
                        };
                        return;
                    };
                    result = new connect_result();
                    result.read(iprot_);
                    iprot_.readMessageEnd();
                    if (result.isSetSuccess())
                    {
                        if (onSuccess != null)
                        {
                            onSuccess(result.success);
                        };
                        return;
                    };
                    if (result.error != null)
                    {
                        if (onError != null)
                        {
                            onError(result.error);
                        };
                        return;
                    };
                    if (onError != null)
                    {
                        onError(new TApplicationError(TApplicationError.MISSING_RESULT, "connect failed: unknown result"));
                    };
                }
                catch(e:TError)
                {
                    if (onError != null)
                    {
                        onError(e);
                    };
                };
            });
        }

        public function auth_getGameToken(gameSession:String, gameId:int, onError:Function, onSuccess:Function):void
        {
            this.oprot_.writeMessageBegin(new TMessage("auth_getGameToken", TMessageType.CALL, this.seqid_));
            var args:auth_getGameToken_args = new auth_getGameToken_args();
            args.gameSession = gameSession;
            args.gameId = gameId;
            args.write(this.oprot_);
            this.oprot_.writeMessageEnd();
            this.oprot_.getTransport().flush(function (error:Error):void
            {
                var msg:TMessage;
                var result:auth_getGameToken_result;
                var x:TApplicationError;
                try
                {
                    if (error != null)
                    {
                        if (onError != null)
                        {
                            onError(error);
                        };
                        return;
                    };
                    msg = iprot_.readMessageBegin();
                    if (msg.type == TMessageType.EXCEPTION)
                    {
                        x = TApplicationError.read(iprot_);
                        iprot_.readMessageEnd();
                        if (onError != null)
                        {
                            onError(x);
                        };
                        return;
                    };
                    result = new auth_getGameToken_result();
                    result.read(iprot_);
                    iprot_.readMessageEnd();
                    if (result.isSetSuccess())
                    {
                        if (onSuccess != null)
                        {
                            onSuccess(result.success);
                        };
                        return;
                    };
                    if (result.error != null)
                    {
                        if (onError != null)
                        {
                            onError(result.error);
                        };
                        return;
                    };
                    if (onError != null)
                    {
                        onError(new TApplicationError(TApplicationError.MISSING_RESULT, "auth_getGameToken failed: unknown result"));
                    };
                }
                catch(e:TError)
                {
                    if (onError != null)
                    {
                        onError(e);
                    };
                };
            });
        }

        public function updater_isUpdateAvailable(gameSession:String, onError:Function, onSuccess:Function):void
        {
            this.oprot_.writeMessageBegin(new TMessage("updater_isUpdateAvailable", TMessageType.CALL, this.seqid_));
            var args:updater_isUpdateAvailable_args = new updater_isUpdateAvailable_args();
            args.gameSession = gameSession;
            args.write(this.oprot_);
            this.oprot_.writeMessageEnd();
            this.oprot_.getTransport().flush(function (error:Error):void
            {
                var msg:TMessage;
                var result:updater_isUpdateAvailable_result;
                var x:TApplicationError;
                try
                {
                    if (error != null)
                    {
                        if (onError != null)
                        {
                            onError(error);
                        };
                        return;
                    };
                    msg = iprot_.readMessageBegin();
                    if (msg.type == TMessageType.EXCEPTION)
                    {
                        x = TApplicationError.read(iprot_);
                        iprot_.readMessageEnd();
                        if (onError != null)
                        {
                            onError(x);
                        };
                        return;
                    };
                    result = new updater_isUpdateAvailable_result();
                    result.read(iprot_);
                    iprot_.readMessageEnd();
                    if (result.isSetSuccess())
                    {
                        if (onSuccess != null)
                        {
                            onSuccess(result.success);
                        };
                        return;
                    };
                    if (result.error != null)
                    {
                        if (onError != null)
                        {
                            onError(result.error);
                        };
                        return;
                    };
                    if (onError != null)
                    {
                        onError(new TApplicationError(TApplicationError.MISSING_RESULT, "updater_isUpdateAvailable failed: unknown result"));
                    };
                }
                catch(e:TError)
                {
                    if (onError != null)
                    {
                        onError(e);
                    };
                };
            });
        }

        public function settings_get(gameSession:String, key:String, onError:Function, onSuccess:Function):void
        {
            this.oprot_.writeMessageBegin(new TMessage("settings_get", TMessageType.CALL, this.seqid_));
            var args:settings_get_args = new settings_get_args();
            args.gameSession = gameSession;
            args.key = key;
            args.write(this.oprot_);
            this.oprot_.writeMessageEnd();
            this.oprot_.getTransport().flush(function (error:Error):void
            {
                var msg:TMessage;
                var result:settings_get_result;
                var x:TApplicationError;
                try
                {
                    if (error != null)
                    {
                        if (onError != null)
                        {
                            onError(error);
                        };
                        return;
                    };
                    msg = iprot_.readMessageBegin();
                    if (msg.type == TMessageType.EXCEPTION)
                    {
                        x = TApplicationError.read(iprot_);
                        iprot_.readMessageEnd();
                        if (onError != null)
                        {
                            onError(x);
                        };
                        return;
                    };
                    result = new settings_get_result();
                    result.read(iprot_);
                    iprot_.readMessageEnd();
                    if (result.isSetSuccess())
                    {
                        if (onSuccess != null)
                        {
                            onSuccess(result.success);
                        };
                        return;
                    };
                    if (result.error != null)
                    {
                        if (onError != null)
                        {
                            onError(result.error);
                        };
                        return;
                    };
                    if (onError != null)
                    {
                        onError(new TApplicationError(TApplicationError.MISSING_RESULT, "settings_get failed: unknown result"));
                    };
                }
                catch(e:TError)
                {
                    if (onError != null)
                    {
                        onError(e);
                    };
                };
            });
        }

        public function settings_set(gameSession:String, key:String, value:String, onError:Function, onSuccess:Function):void
        {
            this.oprot_.writeMessageBegin(new TMessage("settings_set", TMessageType.CALL, this.seqid_));
            var args:settings_set_args = new settings_set_args();
            args.gameSession = gameSession;
            args.key = key;
            args.value = value;
            args.write(this.oprot_);
            this.oprot_.writeMessageEnd();
            this.oprot_.getTransport().flush(function (error:Error):void
            {
                var msg:TMessage;
                var result:settings_set_result;
                var x:TApplicationError;
                try
                {
                    if (error != null)
                    {
                        if (onError != null)
                        {
                            onError(error);
                        };
                        return;
                    };
                    msg = iprot_.readMessageBegin();
                    if (msg.type == TMessageType.EXCEPTION)
                    {
                        x = TApplicationError.read(iprot_);
                        iprot_.readMessageEnd();
                        if (onError != null)
                        {
                            onError(x);
                        };
                        return;
                    };
                    result = new settings_set_result();
                    result.read(iprot_);
                    iprot_.readMessageEnd();
                    if (result.error != null)
                    {
                        if (onError != null)
                        {
                            onError(result.error);
                        };
                        return;
                    };
                    if (onSuccess != null)
                    {
                        onSuccess();
                    };
                    return;
                }
                catch(e:TError)
                {
                    if (onError != null)
                    {
                        onError(e);
                    };
                };
            });
        }

        public function userInfo_get(gameSession:String, onError:Function, onSuccess:Function):void
        {
            this.oprot_.writeMessageBegin(new TMessage("userInfo_get", TMessageType.CALL, this.seqid_));
            var args:userInfo_get_args = new userInfo_get_args();
            args.gameSession = gameSession;
            args.write(this.oprot_);
            this.oprot_.writeMessageEnd();
            this.oprot_.getTransport().flush(function (error:Error):void
            {
                var msg:TMessage;
                var result:userInfo_get_result;
                var x:TApplicationError;
                try
                {
                    if (error != null)
                    {
                        if (onError != null)
                        {
                            onError(error);
                        };
                        return;
                    };
                    msg = iprot_.readMessageBegin();
                    if (msg.type == TMessageType.EXCEPTION)
                    {
                        x = TApplicationError.read(iprot_);
                        iprot_.readMessageEnd();
                        if (onError != null)
                        {
                            onError(x);
                        };
                        return;
                    };
                    result = new userInfo_get_result();
                    result.read(iprot_);
                    iprot_.readMessageEnd();
                    if (result.isSetSuccess())
                    {
                        if (onSuccess != null)
                        {
                            onSuccess(result.success);
                        };
                        return;
                    };
                    if (result.error != null)
                    {
                        if (onError != null)
                        {
                            onError(result.error);
                        };
                        return;
                    };
                    if (onError != null)
                    {
                        onError(new TApplicationError(TApplicationError.MISSING_RESULT, "userInfo_get failed: unknown result"));
                    };
                }
                catch(e:TError)
                {
                    if (onError != null)
                    {
                        onError(e);
                    };
                };
            });
        }

        public function release_restartOnExit(gameSession:String, onError:Function, onSuccess:Function):void
        {
            this.oprot_.writeMessageBegin(new TMessage("release_restartOnExit", TMessageType.CALL, this.seqid_));
            var args:release_restartOnExit_args = new release_restartOnExit_args();
            args.gameSession = gameSession;
            args.write(this.oprot_);
            this.oprot_.writeMessageEnd();
            this.oprot_.getTransport().flush(function (error:Error):void
            {
                var msg:TMessage;
                var result:release_restartOnExit_result;
                var x:TApplicationError;
                try
                {
                    if (error != null)
                    {
                        if (onError != null)
                        {
                            onError(error);
                        };
                        return;
                    };
                    msg = iprot_.readMessageBegin();
                    if (msg.type == TMessageType.EXCEPTION)
                    {
                        x = TApplicationError.read(iprot_);
                        iprot_.readMessageEnd();
                        if (onError != null)
                        {
                            onError(x);
                        };
                        return;
                    };
                    result = new release_restartOnExit_result();
                    result.read(iprot_);
                    iprot_.readMessageEnd();
                    if (onSuccess != null)
                    {
                        onSuccess();
                    };
                    return;
                }
                catch(e:TError)
                {
                    if (onError != null)
                    {
                        onError(e);
                    };
                };
            });
        }

        public function release_exitAndRepair(gameSession:String, restartAfterRepair:Boolean, onError:Function, onSuccess:Function):void
        {
            this.oprot_.writeMessageBegin(new TMessage("release_exitAndRepair", TMessageType.CALL, this.seqid_));
            var args:release_exitAndRepair_args = new release_exitAndRepair_args();
            args.gameSession = gameSession;
            args.restartAfterRepair = restartAfterRepair;
            args.write(this.oprot_);
            this.oprot_.writeMessageEnd();
            this.oprot_.getTransport().flush(function (error:Error):void
            {
                var msg:TMessage;
                var result:release_exitAndRepair_result;
                var x:TApplicationError;
                try
                {
                    if (error != null)
                    {
                        if (onError != null)
                        {
                            onError(error);
                        };
                        return;
                    };
                    msg = iprot_.readMessageBegin();
                    if (msg.type == TMessageType.EXCEPTION)
                    {
                        x = TApplicationError.read(iprot_);
                        iprot_.readMessageEnd();
                        if (onError != null)
                        {
                            onError(x);
                        };
                        return;
                    };
                    result = new release_exitAndRepair_result();
                    result.read(iprot_);
                    iprot_.readMessageEnd();
                    if (onSuccess != null)
                    {
                        onSuccess();
                    };
                    return;
                }
                catch(e:TError)
                {
                    if (onError != null)
                    {
                        onError(e);
                    };
                };
            });
        }

        public function zaapVersion_get(gameSession:String, onError:Function, onSuccess:Function):void
        {
            this.oprot_.writeMessageBegin(new TMessage("zaapVersion_get", TMessageType.CALL, this.seqid_));
            var args:zaapVersion_get_args = new zaapVersion_get_args();
            args.gameSession = gameSession;
            args.write(this.oprot_);
            this.oprot_.writeMessageEnd();
            this.oprot_.getTransport().flush(function (error:Error):void
            {
                var msg:TMessage;
                var result:zaapVersion_get_result;
                var x:TApplicationError;
                try
                {
                    if (error != null)
                    {
                        if (onError != null)
                        {
                            onError(error);
                        };
                        return;
                    };
                    msg = iprot_.readMessageBegin();
                    if (msg.type == TMessageType.EXCEPTION)
                    {
                        x = TApplicationError.read(iprot_);
                        iprot_.readMessageEnd();
                        if (onError != null)
                        {
                            onError(x);
                        };
                        return;
                    };
                    result = new zaapVersion_get_result();
                    result.read(iprot_);
                    iprot_.readMessageEnd();
                    if (result.isSetSuccess())
                    {
                        if (onSuccess != null)
                        {
                            onSuccess(result.success);
                        };
                        return;
                    };
                    if (onError != null)
                    {
                        onError(new TApplicationError(TApplicationError.MISSING_RESULT, "zaapVersion_get failed: unknown result"));
                    };
                }
                catch(e:TError)
                {
                    if (onError != null)
                    {
                        onError(e);
                    };
                };
            });
        }

        public function zaapMustUpdate_get(gameSession:String, onError:Function, onSuccess:Function):void
        {
            this.oprot_.writeMessageBegin(new TMessage("zaapMustUpdate_get", TMessageType.CALL, this.seqid_));
            var args:zaapMustUpdate_get_args = new zaapMustUpdate_get_args();
            args.gameSession = gameSession;
            args.write(this.oprot_);
            this.oprot_.writeMessageEnd();
            this.oprot_.getTransport().flush(function (error:Error):void
            {
                var msg:TMessage;
                var result:zaapMustUpdate_get_result;
                var x:TApplicationError;
                try
                {
                    if (error != null)
                    {
                        if (onError != null)
                        {
                            onError(error);
                        };
                        return;
                    };
                    msg = iprot_.readMessageBegin();
                    if (msg.type == TMessageType.EXCEPTION)
                    {
                        x = TApplicationError.read(iprot_);
                        iprot_.readMessageEnd();
                        if (onError != null)
                        {
                            onError(x);
                        };
                        return;
                    };
                    result = new zaapMustUpdate_get_result();
                    result.read(iprot_);
                    iprot_.readMessageEnd();
                    if (result.isSetSuccess())
                    {
                        if (onSuccess != null)
                        {
                            onSuccess(result.success);
                        };
                        return;
                    };
                    if (onError != null)
                    {
                        onError(new TApplicationError(TApplicationError.MISSING_RESULT, "zaapMustUpdate_get failed: unknown result"));
                    };
                }
                catch(e:TError)
                {
                    if (onError != null)
                    {
                        onError(e);
                    };
                };
            });
        }


    }
}

import org.apache.thrift.TBase;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TType;
import flash.utils.Dictionary;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TProtocol;
import com.ankama.zaap.ZaapError;
import org.apache.thrift.meta_data.StructMetaData;
import org.apache.thrift.protocol.*;
import org.apache.thrift.meta_data.*;
import com.ankama.zaap.*;
import org.apache.thrift.*;

class connect_args implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("connect_args");
    /*private*/ static const GAME_NAME_FIELD_DESC:TField = new TField("gameName", TType.STRING, 1);
    /*private*/ static const RELEASE_NAME_FIELD_DESC:TField = new TField("releaseName", TType.STRING, 2);
    /*private*/ static const INSTANCE_ID_FIELD_DESC:TField = new TField("instanceId", TType.I32, 3);
    /*private*/ static const HASH_FIELD_DESC:TField = new TField("hash", TType.STRING, 4);
    public static const GAMENAME:int = 1;
    public static const RELEASENAME:int = 2;
    public static const INSTANCEID:int = 3;
    public static const HASH:int = 4;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _gameName:String;
    /*private*/ var _releaseName:String;
    /*private*/ var _instanceId:int;
    /*private*/ var _hash:String;
    /*private*/ var __isset_instanceId:Boolean = false;

    {
        metaDataMap[GAMENAME] = new FieldMetaData("gameName", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        metaDataMap[RELEASENAME] = new FieldMetaData("releaseName", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        metaDataMap[INSTANCEID] = new FieldMetaData("instanceId", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.I32));
        metaDataMap[HASH] = new FieldMetaData("hash", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        FieldMetaData.addStructMetaDataMap(connect_args, metaDataMap);
    }


    public function get gameName():String
    {
        return (this._gameName);
    }

    public function set gameName(_arg_1:String):void
    {
        this._gameName = _arg_1;
    }

    public function unsetGameName():void
    {
        this.gameName = null;
    }

    public function isSetGameName():Boolean
    {
        return (!(this.gameName == null));
    }

    public function get releaseName():String
    {
        return (this._releaseName);
    }

    public function set releaseName(_arg_1:String):void
    {
        this._releaseName = _arg_1;
    }

    public function unsetReleaseName():void
    {
        this.releaseName = null;
    }

    public function isSetReleaseName():Boolean
    {
        return (!(this.releaseName == null));
    }

    public function get instanceId():int
    {
        return (this._instanceId);
    }

    public function set instanceId(_arg_1:int):void
    {
        this._instanceId = _arg_1;
        this.__isset_instanceId = true;
    }

    public function unsetInstanceId():void
    {
        this.__isset_instanceId = false;
    }

    public function isSetInstanceId():Boolean
    {
        return (this.__isset_instanceId);
    }

    public function get hash():String
    {
        return (this._hash);
    }

    public function set hash(_arg_1:String):void
    {
        this._hash = _arg_1;
    }

    public function unsetHash():void
    {
        this.hash = null;
    }

    public function isSetHash():Boolean
    {
        return (!(this.hash == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case GAMENAME:
                if (_arg_2 == null)
                {
                    this.unsetGameName();
                }
                else
                {
                    this.gameName = _arg_2;
                };
                return;
            case RELEASENAME:
                if (_arg_2 == null)
                {
                    this.unsetReleaseName();
                }
                else
                {
                    this.releaseName = _arg_2;
                };
                return;
            case INSTANCEID:
                if (_arg_2 == null)
                {
                    this.unsetInstanceId();
                }
                else
                {
                    this.instanceId = _arg_2;
                };
                return;
            case HASH:
                if (_arg_2 == null)
                {
                    this.unsetHash();
                }
                else
                {
                    this.hash = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case GAMENAME:
                return (this.gameName);
            case RELEASENAME:
                return (this.releaseName);
            case INSTANCEID:
                return (this.instanceId);
            case HASH:
                return (this.hash);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case GAMENAME:
                return (this.isSetGameName());
            case RELEASENAME:
                return (this.isSetReleaseName());
            case INSTANCEID:
                return (this.isSetInstanceId());
            case HASH:
                return (this.isSetHash());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case GAMENAME:
                    if (_local_2.type == TType.STRING)
                    {
                        this.gameName = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                case RELEASENAME:
                    if (_local_2.type == TType.STRING)
                    {
                        this.releaseName = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                case INSTANCEID:
                    if (_local_2.type == TType.I32)
                    {
                        this.instanceId = _arg_1.readI32();
                        this.__isset_instanceId = true;
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                case HASH:
                    if (_local_2.type == TType.STRING)
                    {
                        this.hash = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        this.validate();
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.gameName != null)
        {
            _arg_1.writeFieldBegin(GAME_NAME_FIELD_DESC);
            _arg_1.writeString(this.gameName);
            _arg_1.writeFieldEnd();
        };
        if (this.releaseName != null)
        {
            _arg_1.writeFieldBegin(RELEASE_NAME_FIELD_DESC);
            _arg_1.writeString(this.releaseName);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldBegin(INSTANCE_ID_FIELD_DESC);
        _arg_1.writeI32(this.instanceId);
        _arg_1.writeFieldEnd();
        if (this.hash != null)
        {
            _arg_1.writeFieldBegin(HASH_FIELD_DESC);
            _arg_1.writeString(this.hash);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("connect_args(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "gameName:");
        if (this.gameName == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.gameName);
        };
        _local_2 = false;
        _local_1 = (_local_1 + ", ");
        _local_1 = (_local_1 + "releaseName:");
        if (this.releaseName == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.releaseName);
        };
        _local_2 = false;
        _local_1 = (_local_1 + ", ");
        _local_1 = (_local_1 + "instanceId:");
        _local_1 = (_local_1 + this.instanceId);
        _local_2 = false;
        _local_1 = (_local_1 + ", ");
        _local_1 = (_local_1 + "hash:");
        if (this.hash == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.hash);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class connect_result implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("connect_result");
    /*private*/ static const SUCCESS_FIELD_DESC:TField = new TField("success", TType.STRING, 0);
    /*private*/ static const ERROR_FIELD_DESC:TField = new TField("error", TType.STRUCT, 1);
    public static const SUCCESS:int = 0;
    public static const ERROR:int = 1;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _success:String;
    /*private*/ var _error:ZaapError;

    {
        metaDataMap[SUCCESS] = new FieldMetaData("success", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        metaDataMap[ERROR] = new FieldMetaData("error", TFieldRequirementType.DEFAULT, new StructMetaData(TType.STRUCT, ZaapError));
        FieldMetaData.addStructMetaDataMap(connect_result, metaDataMap);
    }


    public function get success():String
    {
        return (this._success);
    }

    public function set success(_arg_1:String):void
    {
        this._success = _arg_1;
    }

    public function unsetSuccess():void
    {
        this.success = null;
    }

    public function isSetSuccess():Boolean
    {
        return (!(this.success == null));
    }

    public function get error():ZaapError
    {
        return (this._error);
    }

    public function set error(_arg_1:ZaapError):void
    {
        this._error = _arg_1;
    }

    public function unsetError():void
    {
        this.error = null;
    }

    public function isSetError():Boolean
    {
        return (!(this.error == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case SUCCESS:
                if (_arg_2 == null)
                {
                    this.unsetSuccess();
                }
                else
                {
                    this.success = _arg_2;
                };
                return;
            case ERROR:
                if (_arg_2 == null)
                {
                    this.unsetError();
                }
                else
                {
                    this.error = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.success);
            case ERROR:
                return (this.error);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.isSetSuccess());
            case ERROR:
                return (this.isSetError());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case SUCCESS:
                    if (_local_2.type == TType.STRING)
                    {
                        this.success = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                case ERROR:
                    if (_local_2.type == TType.STRUCT)
                    {
                        this.error = new ZaapError();
                        this.error.read(_arg_1);
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.isSetSuccess())
        {
            _arg_1.writeFieldBegin(SUCCESS_FIELD_DESC);
            _arg_1.writeString(this.success);
            _arg_1.writeFieldEnd();
        }
        else
        {
            if (this.isSetError())
            {
                _arg_1.writeFieldBegin(ERROR_FIELD_DESC);
                this.error.write(_arg_1);
                _arg_1.writeFieldEnd();
            };
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("connect_result(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "success:");
        if (this.success == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.success);
        };
        _local_1 = (_local_1 + ", ");
        _local_1 = (_local_1 + "error:");
        if (this.error == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.error);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class auth_getGameToken_args implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("auth_getGameToken_args");
    /*private*/ static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession", TType.STRING, 1);
    /*private*/ static const GAME_ID_FIELD_DESC:TField = new TField("gameId", TType.I32, 2);
    public static const GAMESESSION:int = 1;
    public static const GAMEID:int = 2;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _gameSession:String;
    /*private*/ var _gameId:int;
    /*private*/ var __isset_gameId:Boolean = false;

    {
        metaDataMap[GAMESESSION] = new FieldMetaData("gameSession", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        metaDataMap[GAMEID] = new FieldMetaData("gameId", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.I32));
        FieldMetaData.addStructMetaDataMap(auth_getGameToken_args, metaDataMap);
    }


    public function get gameSession():String
    {
        return (this._gameSession);
    }

    public function set gameSession(_arg_1:String):void
    {
        this._gameSession = _arg_1;
    }

    public function unsetGameSession():void
    {
        this.gameSession = null;
    }

    public function isSetGameSession():Boolean
    {
        return (!(this.gameSession == null));
    }

    public function get gameId():int
    {
        return (this._gameId);
    }

    public function set gameId(_arg_1:int):void
    {
        this._gameId = _arg_1;
        this.__isset_gameId = true;
    }

    public function unsetGameId():void
    {
        this.__isset_gameId = false;
    }

    public function isSetGameId():Boolean
    {
        return (this.__isset_gameId);
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                if (_arg_2 == null)
                {
                    this.unsetGameSession();
                }
                else
                {
                    this.gameSession = _arg_2;
                };
                return;
            case GAMEID:
                if (_arg_2 == null)
                {
                    this.unsetGameId();
                }
                else
                {
                    this.gameId = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.gameSession);
            case GAMEID:
                return (this.gameId);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.isSetGameSession());
            case GAMEID:
                return (this.isSetGameId());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case GAMESESSION:
                    if (_local_2.type == TType.STRING)
                    {
                        this.gameSession = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                case GAMEID:
                    if (_local_2.type == TType.I32)
                    {
                        this.gameId = _arg_1.readI32();
                        this.__isset_gameId = true;
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        this.validate();
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.gameSession != null)
        {
            _arg_1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
            _arg_1.writeString(this.gameSession);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldBegin(GAME_ID_FIELD_DESC);
        _arg_1.writeI32(this.gameId);
        _arg_1.writeFieldEnd();
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("auth_getGameToken_args(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "gameSession:");
        if (this.gameSession == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.gameSession);
        };
        _local_1 = (_local_1 + ", ");
        _local_1 = (_local_1 + "gameId:");
        _local_1 = (_local_1 + this.gameId);
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class auth_getGameToken_result implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("auth_getGameToken_result");
    /*private*/ static const SUCCESS_FIELD_DESC:TField = new TField("success", TType.STRING, 0);
    /*private*/ static const ERROR_FIELD_DESC:TField = new TField("error", TType.STRUCT, 1);
    public static const SUCCESS:int = 0;
    public static const ERROR:int = 1;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _success:String;
    /*private*/ var _error:ZaapError;

    {
        metaDataMap[SUCCESS] = new FieldMetaData("success", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        metaDataMap[ERROR] = new FieldMetaData("error", TFieldRequirementType.DEFAULT, new StructMetaData(TType.STRUCT, ZaapError));
        FieldMetaData.addStructMetaDataMap(auth_getGameToken_result, metaDataMap);
    }


    public function get success():String
    {
        return (this._success);
    }

    public function set success(_arg_1:String):void
    {
        this._success = _arg_1;
    }

    public function unsetSuccess():void
    {
        this.success = null;
    }

    public function isSetSuccess():Boolean
    {
        return (!(this.success == null));
    }

    public function get error():ZaapError
    {
        return (this._error);
    }

    public function set error(_arg_1:ZaapError):void
    {
        this._error = _arg_1;
    }

    public function unsetError():void
    {
        this.error = null;
    }

    public function isSetError():Boolean
    {
        return (!(this.error == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case SUCCESS:
                if (_arg_2 == null)
                {
                    this.unsetSuccess();
                }
                else
                {
                    this.success = _arg_2;
                };
                return;
            case ERROR:
                if (_arg_2 == null)
                {
                    this.unsetError();
                }
                else
                {
                    this.error = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.success);
            case ERROR:
                return (this.error);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.isSetSuccess());
            case ERROR:
                return (this.isSetError());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case SUCCESS:
                    if (_local_2.type == TType.STRING)
                    {
                        this.success = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                case ERROR:
                    if (_local_2.type == TType.STRUCT)
                    {
                        this.error = new ZaapError();
                        this.error.read(_arg_1);
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.isSetSuccess())
        {
            _arg_1.writeFieldBegin(SUCCESS_FIELD_DESC);
            _arg_1.writeString(this.success);
            _arg_1.writeFieldEnd();
        }
        else
        {
            if (this.isSetError())
            {
                _arg_1.writeFieldBegin(ERROR_FIELD_DESC);
                this.error.write(_arg_1);
                _arg_1.writeFieldEnd();
            };
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("auth_getGameToken_result(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "success:");
        if (this.success == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.success);
        };
        _local_1 = (_local_1 + ", ");
        _local_1 = (_local_1 + "error:");
        if (this.error == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.error);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class updater_isUpdateAvailable_args implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("updater_isUpdateAvailable_args");
    /*private*/ static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession", TType.STRING, 1);
    public static const GAMESESSION:int = 1;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _gameSession:String;

    {
        metaDataMap[GAMESESSION] = new FieldMetaData("gameSession", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        FieldMetaData.addStructMetaDataMap(updater_isUpdateAvailable_args, metaDataMap);
    }


    public function get gameSession():String
    {
        return (this._gameSession);
    }

    public function set gameSession(_arg_1:String):void
    {
        this._gameSession = _arg_1;
    }

    public function unsetGameSession():void
    {
        this.gameSession = null;
    }

    public function isSetGameSession():Boolean
    {
        return (!(this.gameSession == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                if (_arg_2 == null)
                {
                    this.unsetGameSession();
                }
                else
                {
                    this.gameSession = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.gameSession);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.isSetGameSession());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case GAMESESSION:
                    if (_local_2.type == TType.STRING)
                    {
                        this.gameSession = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        this.validate();
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.gameSession != null)
        {
            _arg_1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
            _arg_1.writeString(this.gameSession);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("updater_isUpdateAvailable_args(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "gameSession:");
        if (this.gameSession == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.gameSession);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class updater_isUpdateAvailable_result implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("updater_isUpdateAvailable_result");
    /*private*/ static const SUCCESS_FIELD_DESC:TField = new TField("success", TType.BOOL, 0);
    /*private*/ static const ERROR_FIELD_DESC:TField = new TField("error", TType.STRUCT, 1);
    public static const SUCCESS:int = 0;
    public static const ERROR:int = 1;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _success:Boolean;
    /*private*/ var _error:ZaapError;
    /*private*/ var __isset_success:Boolean = false;

    {
        metaDataMap[SUCCESS] = new FieldMetaData("success", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.BOOL));
        metaDataMap[ERROR] = new FieldMetaData("error", TFieldRequirementType.DEFAULT, new StructMetaData(TType.STRUCT, ZaapError));
        FieldMetaData.addStructMetaDataMap(updater_isUpdateAvailable_result, metaDataMap);
    }


    public function get success():Boolean
    {
        return (this._success);
    }

    public function set success(_arg_1:Boolean):void
    {
        this._success = _arg_1;
        this.__isset_success = true;
    }

    public function unsetSuccess():void
    {
        this.__isset_success = false;
    }

    public function isSetSuccess():Boolean
    {
        return (this.__isset_success);
    }

    public function get error():ZaapError
    {
        return (this._error);
    }

    public function set error(_arg_1:ZaapError):void
    {
        this._error = _arg_1;
    }

    public function unsetError():void
    {
        this.error = null;
    }

    public function isSetError():Boolean
    {
        return (!(this.error == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case SUCCESS:
                if (_arg_2 == null)
                {
                    this.unsetSuccess();
                }
                else
                {
                    this.success = _arg_2;
                };
                return;
            case ERROR:
                if (_arg_2 == null)
                {
                    this.unsetError();
                }
                else
                {
                    this.error = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.success);
            case ERROR:
                return (this.error);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.isSetSuccess());
            case ERROR:
                return (this.isSetError());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case SUCCESS:
                    if (_local_2.type == TType.BOOL)
                    {
                        this.success = _arg_1.readBool();
                        this.__isset_success = true;
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                case ERROR:
                    if (_local_2.type == TType.STRUCT)
                    {
                        this.error = new ZaapError();
                        this.error.read(_arg_1);
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.isSetSuccess())
        {
            _arg_1.writeFieldBegin(SUCCESS_FIELD_DESC);
            _arg_1.writeBool(this.success);
            _arg_1.writeFieldEnd();
        }
        else
        {
            if (this.isSetError())
            {
                _arg_1.writeFieldBegin(ERROR_FIELD_DESC);
                this.error.write(_arg_1);
                _arg_1.writeFieldEnd();
            };
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("updater_isUpdateAvailable_result(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "success:");
        _local_1 = (_local_1 + this.success);
        _local_1 = (_local_1 + ", ");
        _local_1 = (_local_1 + "error:");
        if (this.error == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.error);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class settings_get_args implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("settings_get_args");
    /*private*/ static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession", TType.STRING, 1);
    /*private*/ static const KEY_FIELD_DESC:TField = new TField("key", TType.STRING, 2);
    public static const GAMESESSION:int = 1;
    public static const KEY:int = 2;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _gameSession:String;
    /*private*/ var _key:String;

    {
        metaDataMap[GAMESESSION] = new FieldMetaData("gameSession", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        metaDataMap[KEY] = new FieldMetaData("key", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        FieldMetaData.addStructMetaDataMap(settings_get_args, metaDataMap);
    }


    public function get gameSession():String
    {
        return (this._gameSession);
    }

    public function set gameSession(_arg_1:String):void
    {
        this._gameSession = _arg_1;
    }

    public function unsetGameSession():void
    {
        this.gameSession = null;
    }

    public function isSetGameSession():Boolean
    {
        return (!(this.gameSession == null));
    }

    public function get key():String
    {
        return (this._key);
    }

    public function set key(_arg_1:String):void
    {
        this._key = _arg_1;
    }

    public function unsetKey():void
    {
        this.key = null;
    }

    public function isSetKey():Boolean
    {
        return (!(this.key == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                if (_arg_2 == null)
                {
                    this.unsetGameSession();
                }
                else
                {
                    this.gameSession = _arg_2;
                };
                return;
            case KEY:
                if (_arg_2 == null)
                {
                    this.unsetKey();
                }
                else
                {
                    this.key = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.gameSession);
            case KEY:
                return (this.key);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.isSetGameSession());
            case KEY:
                return (this.isSetKey());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case GAMESESSION:
                    if (_local_2.type == TType.STRING)
                    {
                        this.gameSession = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                case KEY:
                    if (_local_2.type == TType.STRING)
                    {
                        this.key = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        this.validate();
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.gameSession != null)
        {
            _arg_1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
            _arg_1.writeString(this.gameSession);
            _arg_1.writeFieldEnd();
        };
        if (this.key != null)
        {
            _arg_1.writeFieldBegin(KEY_FIELD_DESC);
            _arg_1.writeString(this.key);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("settings_get_args(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "gameSession:");
        if (this.gameSession == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.gameSession);
        };
        _local_1 = (_local_1 + ", ");
        _local_1 = (_local_1 + "key:");
        if (this.key == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.key);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class settings_get_result implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("settings_get_result");
    /*private*/ static const SUCCESS_FIELD_DESC:TField = new TField("success", TType.STRING, 0);
    /*private*/ static const ERROR_FIELD_DESC:TField = new TField("error", TType.STRUCT, 1);
    public static const SUCCESS:int = 0;
    public static const ERROR:int = 1;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _success:String;
    /*private*/ var _error:ZaapError;

    {
        metaDataMap[SUCCESS] = new FieldMetaData("success", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        metaDataMap[ERROR] = new FieldMetaData("error", TFieldRequirementType.DEFAULT, new StructMetaData(TType.STRUCT, ZaapError));
        FieldMetaData.addStructMetaDataMap(settings_get_result, metaDataMap);
    }


    public function get success():String
    {
        return (this._success);
    }

    public function set success(_arg_1:String):void
    {
        this._success = _arg_1;
    }

    public function unsetSuccess():void
    {
        this.success = null;
    }

    public function isSetSuccess():Boolean
    {
        return (!(this.success == null));
    }

    public function get error():ZaapError
    {
        return (this._error);
    }

    public function set error(_arg_1:ZaapError):void
    {
        this._error = _arg_1;
    }

    public function unsetError():void
    {
        this.error = null;
    }

    public function isSetError():Boolean
    {
        return (!(this.error == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case SUCCESS:
                if (_arg_2 == null)
                {
                    this.unsetSuccess();
                }
                else
                {
                    this.success = _arg_2;
                };
                return;
            case ERROR:
                if (_arg_2 == null)
                {
                    this.unsetError();
                }
                else
                {
                    this.error = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.success);
            case ERROR:
                return (this.error);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.isSetSuccess());
            case ERROR:
                return (this.isSetError());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case SUCCESS:
                    if (_local_2.type == TType.STRING)
                    {
                        this.success = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                case ERROR:
                    if (_local_2.type == TType.STRUCT)
                    {
                        this.error = new ZaapError();
                        this.error.read(_arg_1);
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.isSetSuccess())
        {
            _arg_1.writeFieldBegin(SUCCESS_FIELD_DESC);
            _arg_1.writeString(this.success);
            _arg_1.writeFieldEnd();
        }
        else
        {
            if (this.isSetError())
            {
                _arg_1.writeFieldBegin(ERROR_FIELD_DESC);
                this.error.write(_arg_1);
                _arg_1.writeFieldEnd();
            };
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("settings_get_result(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "success:");
        if (this.success == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.success);
        };
        _local_1 = (_local_1 + ", ");
        _local_1 = (_local_1 + "error:");
        if (this.error == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.error);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class settings_set_args implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("settings_set_args");
    /*private*/ static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession", TType.STRING, 1);
    /*private*/ static const KEY_FIELD_DESC:TField = new TField("key", TType.STRING, 2);
    /*private*/ static const VALUE_FIELD_DESC:TField = new TField("value", TType.STRING, 3);
    public static const GAMESESSION:int = 1;
    public static const KEY:int = 2;
    public static const VALUE:int = 3;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _gameSession:String;
    /*private*/ var _key:String;
    /*private*/ var _value:String;

    {
        metaDataMap[GAMESESSION] = new FieldMetaData("gameSession", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        metaDataMap[KEY] = new FieldMetaData("key", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        metaDataMap[VALUE] = new FieldMetaData("value", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        FieldMetaData.addStructMetaDataMap(settings_set_args, metaDataMap);
    }


    public function get gameSession():String
    {
        return (this._gameSession);
    }

    public function set gameSession(_arg_1:String):void
    {
        this._gameSession = _arg_1;
    }

    public function unsetGameSession():void
    {
        this.gameSession = null;
    }

    public function isSetGameSession():Boolean
    {
        return (!(this.gameSession == null));
    }

    public function get key():String
    {
        return (this._key);
    }

    public function set key(_arg_1:String):void
    {
        this._key = _arg_1;
    }

    public function unsetKey():void
    {
        this.key = null;
    }

    public function isSetKey():Boolean
    {
        return (!(this.key == null));
    }

    public function get value():String
    {
        return (this._value);
    }

    public function set value(_arg_1:String):void
    {
        this._value = _arg_1;
    }

    public function unsetValue():void
    {
        this.value = null;
    }

    public function isSetValue():Boolean
    {
        return (!(this.value == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                if (_arg_2 == null)
                {
                    this.unsetGameSession();
                }
                else
                {
                    this.gameSession = _arg_2;
                };
                return;
            case KEY:
                if (_arg_2 == null)
                {
                    this.unsetKey();
                }
                else
                {
                    this.key = _arg_2;
                };
                return;
            case VALUE:
                if (_arg_2 == null)
                {
                    this.unsetValue();
                }
                else
                {
                    this.value = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.gameSession);
            case KEY:
                return (this.key);
            case VALUE:
                return (this.value);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.isSetGameSession());
            case KEY:
                return (this.isSetKey());
            case VALUE:
                return (this.isSetValue());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case GAMESESSION:
                    if (_local_2.type == TType.STRING)
                    {
                        this.gameSession = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                case KEY:
                    if (_local_2.type == TType.STRING)
                    {
                        this.key = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                case VALUE:
                    if (_local_2.type == TType.STRING)
                    {
                        this.value = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        this.validate();
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.gameSession != null)
        {
            _arg_1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
            _arg_1.writeString(this.gameSession);
            _arg_1.writeFieldEnd();
        };
        if (this.key != null)
        {
            _arg_1.writeFieldBegin(KEY_FIELD_DESC);
            _arg_1.writeString(this.key);
            _arg_1.writeFieldEnd();
        };
        if (this.value != null)
        {
            _arg_1.writeFieldBegin(VALUE_FIELD_DESC);
            _arg_1.writeString(this.value);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("settings_set_args(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "gameSession:");
        if (this.gameSession == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.gameSession);
        };
        _local_2 = false;
        _local_1 = (_local_1 + ", ");
        _local_1 = (_local_1 + "key:");
        if (this.key == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.key);
        };
        _local_2 = false;
        _local_1 = (_local_1 + ", ");
        _local_1 = (_local_1 + "value:");
        if (this.value == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.value);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class settings_set_result implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("settings_set_result");
    /*private*/ static const ERROR_FIELD_DESC:TField = new TField("error", TType.STRUCT, 1);
    public static const ERROR:int = 1;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _error:ZaapError;

    {
        metaDataMap[ERROR] = new FieldMetaData("error", TFieldRequirementType.DEFAULT, new StructMetaData(TType.STRUCT, ZaapError));
        FieldMetaData.addStructMetaDataMap(settings_set_result, metaDataMap);
    }


    public function get error():ZaapError
    {
        return (this._error);
    }

    public function set error(_arg_1:ZaapError):void
    {
        this._error = _arg_1;
    }

    public function unsetError():void
    {
        this.error = null;
    }

    public function isSetError():Boolean
    {
        return (!(this.error == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case ERROR:
                if (_arg_2 == null)
                {
                    this.unsetError();
                }
                else
                {
                    this.error = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case ERROR:
                return (this.error);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case ERROR:
                return (this.isSetError());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case ERROR:
                    if (_local_2.type == TType.STRUCT)
                    {
                        this.error = new ZaapError();
                        this.error.read(_arg_1);
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.isSetError())
        {
            _arg_1.writeFieldBegin(ERROR_FIELD_DESC);
            this.error.write(_arg_1);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("settings_set_result(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "error:");
        if (this.error == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.error);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class userInfo_get_args implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("userInfo_get_args");
    /*private*/ static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession", TType.STRING, 1);
    public static const GAMESESSION:int = 1;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _gameSession:String;

    {
        metaDataMap[GAMESESSION] = new FieldMetaData("gameSession", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        FieldMetaData.addStructMetaDataMap(userInfo_get_args, metaDataMap);
    }


    public function get gameSession():String
    {
        return (this._gameSession);
    }

    public function set gameSession(_arg_1:String):void
    {
        this._gameSession = _arg_1;
    }

    public function unsetGameSession():void
    {
        this.gameSession = null;
    }

    public function isSetGameSession():Boolean
    {
        return (!(this.gameSession == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                if (_arg_2 == null)
                {
                    this.unsetGameSession();
                }
                else
                {
                    this.gameSession = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.gameSession);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.isSetGameSession());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case GAMESESSION:
                    if (_local_2.type == TType.STRING)
                    {
                        this.gameSession = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        this.validate();
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.gameSession != null)
        {
            _arg_1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
            _arg_1.writeString(this.gameSession);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("userInfo_get_args(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "gameSession:");
        if (this.gameSession == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.gameSession);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class userInfo_get_result implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("userInfo_get_result");
    /*private*/ static const SUCCESS_FIELD_DESC:TField = new TField("success", TType.STRING, 0);
    /*private*/ static const ERROR_FIELD_DESC:TField = new TField("error", TType.STRUCT, 1);
    public static const SUCCESS:int = 0;
    public static const ERROR:int = 1;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _success:String;
    /*private*/ var _error:ZaapError;

    {
        metaDataMap[SUCCESS] = new FieldMetaData("success", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        metaDataMap[ERROR] = new FieldMetaData("error", TFieldRequirementType.DEFAULT, new StructMetaData(TType.STRUCT, ZaapError));
        FieldMetaData.addStructMetaDataMap(userInfo_get_result, metaDataMap);
    }


    public function get success():String
    {
        return (this._success);
    }

    public function set success(_arg_1:String):void
    {
        this._success = _arg_1;
    }

    public function unsetSuccess():void
    {
        this.success = null;
    }

    public function isSetSuccess():Boolean
    {
        return (!(this.success == null));
    }

    public function get error():ZaapError
    {
        return (this._error);
    }

    public function set error(_arg_1:ZaapError):void
    {
        this._error = _arg_1;
    }

    public function unsetError():void
    {
        this.error = null;
    }

    public function isSetError():Boolean
    {
        return (!(this.error == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case SUCCESS:
                if (_arg_2 == null)
                {
                    this.unsetSuccess();
                }
                else
                {
                    this.success = _arg_2;
                };
                return;
            case ERROR:
                if (_arg_2 == null)
                {
                    this.unsetError();
                }
                else
                {
                    this.error = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.success);
            case ERROR:
                return (this.error);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.isSetSuccess());
            case ERROR:
                return (this.isSetError());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case SUCCESS:
                    if (_local_2.type == TType.STRING)
                    {
                        this.success = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                case ERROR:
                    if (_local_2.type == TType.STRUCT)
                    {
                        this.error = new ZaapError();
                        this.error.read(_arg_1);
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.isSetSuccess())
        {
            _arg_1.writeFieldBegin(SUCCESS_FIELD_DESC);
            _arg_1.writeString(this.success);
            _arg_1.writeFieldEnd();
        }
        else
        {
            if (this.isSetError())
            {
                _arg_1.writeFieldBegin(ERROR_FIELD_DESC);
                this.error.write(_arg_1);
                _arg_1.writeFieldEnd();
            };
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("userInfo_get_result(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "success:");
        if (this.success == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.success);
        };
        _local_1 = (_local_1 + ", ");
        _local_1 = (_local_1 + "error:");
        if (this.error == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.error);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class release_restartOnExit_args implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("release_restartOnExit_args");
    /*private*/ static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession", TType.STRING, 1);
    public static const GAMESESSION:int = 1;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _gameSession:String;

    {
        metaDataMap[GAMESESSION] = new FieldMetaData("gameSession", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        FieldMetaData.addStructMetaDataMap(release_restartOnExit_args, metaDataMap);
    }


    public function get gameSession():String
    {
        return (this._gameSession);
    }

    public function set gameSession(_arg_1:String):void
    {
        this._gameSession = _arg_1;
    }

    public function unsetGameSession():void
    {
        this.gameSession = null;
    }

    public function isSetGameSession():Boolean
    {
        return (!(this.gameSession == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                if (_arg_2 == null)
                {
                    this.unsetGameSession();
                }
                else
                {
                    this.gameSession = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.gameSession);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.isSetGameSession());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case GAMESESSION:
                    if (_local_2.type == TType.STRING)
                    {
                        this.gameSession = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        this.validate();
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.gameSession != null)
        {
            _arg_1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
            _arg_1.writeString(this.gameSession);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("release_restartOnExit_args(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "gameSession:");
        if (this.gameSession == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.gameSession);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class release_restartOnExit_result implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("release_restartOnExit_result");
    public static const metaDataMap:Dictionary = new Dictionary();

    {
        FieldMetaData.addStructMetaDataMap(release_restartOnExit_result, metaDataMap);
    }


    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        _arg_1.writeStructBegin(STRUCT_DESC);
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("release_restartOnExit_result(");
        var _local_2:Boolean = true;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class release_exitAndRepair_args implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("release_exitAndRepair_args");
    /*private*/ static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession", TType.STRING, 1);
    /*private*/ static const RESTART_AFTER_REPAIR_FIELD_DESC:TField = new TField("restartAfterRepair", TType.BOOL, 2);
    public static const GAMESESSION:int = 1;
    public static const RESTARTAFTERREPAIR:int = 2;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _gameSession:String;
    /*private*/ var _restartAfterRepair:Boolean;
    /*private*/ var __isset_restartAfterRepair:Boolean = false;

    {
        metaDataMap[GAMESESSION] = new FieldMetaData("gameSession", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        metaDataMap[RESTARTAFTERREPAIR] = new FieldMetaData("restartAfterRepair", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.BOOL));
        FieldMetaData.addStructMetaDataMap(release_exitAndRepair_args, metaDataMap);
    }


    public function get gameSession():String
    {
        return (this._gameSession);
    }

    public function set gameSession(_arg_1:String):void
    {
        this._gameSession = _arg_1;
    }

    public function unsetGameSession():void
    {
        this.gameSession = null;
    }

    public function isSetGameSession():Boolean
    {
        return (!(this.gameSession == null));
    }

    public function get restartAfterRepair():Boolean
    {
        return (this._restartAfterRepair);
    }

    public function set restartAfterRepair(_arg_1:Boolean):void
    {
        this._restartAfterRepair = _arg_1;
        this.__isset_restartAfterRepair = true;
    }

    public function unsetRestartAfterRepair():void
    {
        this.__isset_restartAfterRepair = false;
    }

    public function isSetRestartAfterRepair():Boolean
    {
        return (this.__isset_restartAfterRepair);
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                if (_arg_2 == null)
                {
                    this.unsetGameSession();
                }
                else
                {
                    this.gameSession = _arg_2;
                };
                return;
            case RESTARTAFTERREPAIR:
                if (_arg_2 == null)
                {
                    this.unsetRestartAfterRepair();
                }
                else
                {
                    this.restartAfterRepair = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.gameSession);
            case RESTARTAFTERREPAIR:
                return (this.restartAfterRepair);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.isSetGameSession());
            case RESTARTAFTERREPAIR:
                return (this.isSetRestartAfterRepair());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case GAMESESSION:
                    if (_local_2.type == TType.STRING)
                    {
                        this.gameSession = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                case RESTARTAFTERREPAIR:
                    if (_local_2.type == TType.BOOL)
                    {
                        this.restartAfterRepair = _arg_1.readBool();
                        this.__isset_restartAfterRepair = true;
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        this.validate();
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.gameSession != null)
        {
            _arg_1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
            _arg_1.writeString(this.gameSession);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldBegin(RESTART_AFTER_REPAIR_FIELD_DESC);
        _arg_1.writeBool(this.restartAfterRepair);
        _arg_1.writeFieldEnd();
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("release_exitAndRepair_args(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "gameSession:");
        if (this.gameSession == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.gameSession);
        };
        _local_1 = (_local_1 + ", ");
        _local_1 = (_local_1 + "restartAfterRepair:");
        _local_1 = (_local_1 + this.restartAfterRepair);
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class release_exitAndRepair_result implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("release_exitAndRepair_result");
    public static const metaDataMap:Dictionary = new Dictionary();

    {
        FieldMetaData.addStructMetaDataMap(release_exitAndRepair_result, metaDataMap);
    }


    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        _arg_1.writeStructBegin(STRUCT_DESC);
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("release_exitAndRepair_result(");
        var _local_2:Boolean = true;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class zaapVersion_get_args implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("zaapVersion_get_args");
    /*private*/ static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession", TType.STRING, 1);
    public static const GAMESESSION:int = 1;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _gameSession:String;

    {
        metaDataMap[GAMESESSION] = new FieldMetaData("gameSession", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        FieldMetaData.addStructMetaDataMap(zaapVersion_get_args, metaDataMap);
    }


    public function get gameSession():String
    {
        return (this._gameSession);
    }

    public function set gameSession(_arg_1:String):void
    {
        this._gameSession = _arg_1;
    }

    public function unsetGameSession():void
    {
        this.gameSession = null;
    }

    public function isSetGameSession():Boolean
    {
        return (!(this.gameSession == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                if (_arg_2 == null)
                {
                    this.unsetGameSession();
                }
                else
                {
                    this.gameSession = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.gameSession);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.isSetGameSession());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case GAMESESSION:
                    if (_local_2.type == TType.STRING)
                    {
                        this.gameSession = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        this.validate();
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.gameSession != null)
        {
            _arg_1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
            _arg_1.writeString(this.gameSession);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("zaapVersion_get_args(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "gameSession:");
        if (this.gameSession == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.gameSession);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class zaapVersion_get_result implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("zaapVersion_get_result");
    /*private*/ static const SUCCESS_FIELD_DESC:TField = new TField("success", TType.STRING, 0);
    public static const SUCCESS:int = 0;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _success:String;

    {
        metaDataMap[SUCCESS] = new FieldMetaData("success", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        FieldMetaData.addStructMetaDataMap(zaapVersion_get_result, metaDataMap);
    }


    public function get success():String
    {
        return (this._success);
    }

    public function set success(_arg_1:String):void
    {
        this._success = _arg_1;
    }

    public function unsetSuccess():void
    {
        this.success = null;
    }

    public function isSetSuccess():Boolean
    {
        return (!(this.success == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case SUCCESS:
                if (_arg_2 == null)
                {
                    this.unsetSuccess();
                }
                else
                {
                    this.success = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.success);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.isSetSuccess());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case SUCCESS:
                    if (_local_2.type == TType.STRING)
                    {
                        this.success = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.isSetSuccess())
        {
            _arg_1.writeFieldBegin(SUCCESS_FIELD_DESC);
            _arg_1.writeString(this.success);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("zaapVersion_get_result(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "success:");
        if (this.success == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.success);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class zaapMustUpdate_get_args implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("zaapMustUpdate_get_args");
    /*private*/ static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession", TType.STRING, 1);
    public static const GAMESESSION:int = 1;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _gameSession:String;

    {
        metaDataMap[GAMESESSION] = new FieldMetaData("gameSession", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.STRING));
        FieldMetaData.addStructMetaDataMap(zaapMustUpdate_get_args, metaDataMap);
    }


    public function get gameSession():String
    {
        return (this._gameSession);
    }

    public function set gameSession(_arg_1:String):void
    {
        this._gameSession = _arg_1;
    }

    public function unsetGameSession():void
    {
        this.gameSession = null;
    }

    public function isSetGameSession():Boolean
    {
        return (!(this.gameSession == null));
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                if (_arg_2 == null)
                {
                    this.unsetGameSession();
                }
                else
                {
                    this.gameSession = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.gameSession);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case GAMESESSION:
                return (this.isSetGameSession());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case GAMESESSION:
                    if (_local_2.type == TType.STRING)
                    {
                        this.gameSession = _arg_1.readString();
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        this.validate();
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.gameSession != null)
        {
            _arg_1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
            _arg_1.writeString(this.gameSession);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("zaapMustUpdate_get_args(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "gameSession:");
        if (this.gameSession == null)
        {
            _local_1 = (_local_1 + "null");
        }
        else
        {
            _local_1 = (_local_1 + this.gameSession);
        };
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}

class zaapMustUpdate_get_result implements TBase 
{

    /*private*/ static const STRUCT_DESC:TStruct = new TStruct("zaapMustUpdate_get_result");
    /*private*/ static const SUCCESS_FIELD_DESC:TField = new TField("success", TType.BOOL, 0);
    public static const SUCCESS:int = 0;
    public static const metaDataMap:Dictionary = new Dictionary();

    /*private*/ var _success:Boolean;
    /*private*/ var __isset_success:Boolean = false;

    {
        metaDataMap[SUCCESS] = new FieldMetaData("success", TFieldRequirementType.DEFAULT, new FieldValueMetaData(TType.BOOL));
        FieldMetaData.addStructMetaDataMap(zaapMustUpdate_get_result, metaDataMap);
    }


    public function get success():Boolean
    {
        return (this._success);
    }

    public function set success(_arg_1:Boolean):void
    {
        this._success = _arg_1;
        this.__isset_success = true;
    }

    public function unsetSuccess():void
    {
        this.__isset_success = false;
    }

    public function isSetSuccess():Boolean
    {
        return (this.__isset_success);
    }

    public function setFieldValue(_arg_1:int, _arg_2:*):void
    {
        switch (_arg_1)
        {
            case SUCCESS:
                if (_arg_2 == null)
                {
                    this.unsetSuccess();
                }
                else
                {
                    this.success = _arg_2;
                };
                return;
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function getFieldValue(_arg_1:int):*
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.success);
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function isSet(_arg_1:int):Boolean
    {
        switch (_arg_1)
        {
            case SUCCESS:
                return (this.isSetSuccess());
            default:
                throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
        };
    }

    public function read(_arg_1:TProtocol):void
    {
        var _local_2:TField;
        _arg_1.readStructBegin();
        while (true)
        {
            _local_2 = _arg_1.readFieldBegin();
            if (_local_2.type == TType.STOP) break;
            switch (_local_2.id)
            {
                case SUCCESS:
                    if (_local_2.type == TType.BOOL)
                    {
                        this.success = _arg_1.readBool();
                        this.__isset_success = true;
                    }
                    else
                    {
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                    };
                    break;
                default:
                    TProtocolUtil.skip(_arg_1, _local_2.type);
            };
            _arg_1.readFieldEnd();
        };
        _arg_1.readStructEnd();
        this.validate();
    }

    public function write(_arg_1:TProtocol):void
    {
        _arg_1.writeStructBegin(STRUCT_DESC);
        if (this.isSetSuccess())
        {
            _arg_1.writeFieldBegin(SUCCESS_FIELD_DESC);
            _arg_1.writeBool(this.success);
            _arg_1.writeFieldEnd();
        };
        _arg_1.writeFieldStop();
        _arg_1.writeStructEnd();
    }

    public function toString():String
    {
        var _local_1:String = new String("zaapMustUpdate_get_result(");
        var _local_2:Boolean = true;
        _local_1 = (_local_1 + "success:");
        _local_1 = (_local_1 + this.success);
        _local_2 = false;
        return (_local_1 + ")");
    }

    public function validate():void
    {
    }


}


