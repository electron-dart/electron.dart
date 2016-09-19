part of electron.main.protocol;

typedef void ProtocolRegisterCompletion(dynamic error);

typedef void ProtocolFileCallback(String filepath);

typedef void ProtocolBufferCallback(ProtocolBufferReply reply);

typedef void ProtocolStringCallback(ProtocolStringReply reply);

typedef void ProtocolHttpCallback(ProtocolHttpReply reply);

typedef void ProtocolRegisterFileHandler(
    ProtocolRequest request, ProtocolFileCallback callback);

typedef void ProtocolRegisterBufferHandler(
    ProtocolRequest request, ProtocolBufferCallback callback);

typedef void ProtocolRegisterStringHandler(
    ProtocolRequest request, ProtocolStringCallback callback);

typedef void ProtocolRegisterHttpHandler(
    ProtocolRequest request, ProtocolHttpCallback callback);

@JS()
@anonymous
class ProtocolBufferReply {
  external const factory ProtocolBufferReply(
      {Buffer data, String mimeType, String charset});

  external Buffer get data;

  external String get mimeType;

  external String get charset;
}

@JS()
@anonymous
class ProtocolStringReply {
  external const factory ProtocolStringReply(
      {String data, String mimeType, String charset});

  external String get data;

  external String get mimeType;

  external String get charset;
}

@JS()
@anonymous
class ProtocolHttpReply {
  external const factory ProtocolHttpReply(
      {ProtocolHttpData uploadData, String url, String method});

  external String get url;

  external String get method;

  //TODO session

  external ProtocolHttpData get uploadData;
}

@JS()
@anonymous
class ProtocolHttpData {
  external const factory ProtocolHttpData({String contentType, String data});

  /// MIME type of the content.
  external String get contentType;

  /// Content to be sent.
  external String get data;
}
