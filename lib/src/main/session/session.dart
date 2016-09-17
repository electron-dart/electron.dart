// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.main.session;

import "package:js/js.dart";

import 'package:electron/src/main/protocol/protocol.dart';

part 'cookie.dart';
part 'web_request.dart';

@JS()
@anonymous
class SessionOptions {
  external const factory SessionOptions({bool cache});

  /// Whether to enable cache.
  external bool get cache;
}

/// Returns a Session instance from partition string. When there is an existing
/// Session with the same partition, it will be returned; othewise a new Session
/// instance will be created with options.
///
/// If partition starts with persist:, the page will use a persistent session
/// available to all pages in the app with the same partition. if there is no
/// persist: prefix, the page will use an in-memory session. If the partition
/// is empty then default session of the app will be returned.
///
/// To create a Session with options, you have to ensure the Session with the
/// partition has never been used before. There is no way to change the options
/// of an existing Session object.
@JS('_electron.session.fromPartition')
external NativeJsSession _fromPartition(String partition,
    [SessionOptions options]);

@JS('_electron.session.defaultSession')
external NativeJsSession get _defaultSession;

@JS('_electron.session.Session')
class NativeJsSession {

  /// Returns the session’s current cache size.
  external void getCacheSize(Function callback);

  /// Clears the session’s HTTP cache.
  /// callback - Called when operation is done
  external void clearCache(Function callback);

  //TODO clearStorageData

  /// Writes any unwritten DOMStorage data to disk.
  external void flushStorageData();

  //TODO

  ///   Overrides the userAgent and acceptLanguages for this session.
  ///
  /// The acceptLanguages must a comma separated ordered list of language codes,
  /// for example "en-US,fr,de,ko,zh-CN,ja".
  ///
  /// This doesn’t affect existing WebContents, and each WebContents can use
  /// webContents.setUserAgent to override the session-wide user agent.
  external void setUserAgent(String userAgent, [String acceptLanguages]);

  /// Returns a String representing the user agent for this session.
  external String getUserAgent();

  external NativeJsCookies get cookies;

  external NativeJsWebRequest get webRequest;

  external NativeJsProtocol get protocol;
}

class Session {
  NativeJsSession _nativeJsSession;

  Session.fromNativeJsSession(this._nativeJsSession);

  NativeJsSession get nativeJsSession => _nativeJsSession;

  static Session fromPartition(String partition, [SessionOptions options]) =>
      new Session.fromNativeJsSession(_fromPartition(partition, options));

  static Session get defaultSession => new Session.fromNativeJsSession(_defaultSession);

  /// Returns the session’s current cache size.
  void getCacheSize(Function callback) => _nativeJsSession.getCacheSize(allowInterop(callback));

  /// Clears the session’s HTTP cache.
  /// callback - Called when operation is done
  void clearCache(Function callback) => _nativeJsSession.clearCache(allowInterop(callback));

  //TODO

  Cookies get cookies => new Cookies.fromNativeJsCookies(_nativeJsSession.cookies);

  WebRequest get webRequest => new WebRequest.fromNativeJsWebRequest(_nativeJsSession.webRequest);

  Protocol get protocol => new Protocol.fromNativeJsProtocol(_nativeJsSession.protocol);
}
