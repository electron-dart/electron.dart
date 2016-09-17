// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.main.protocol;

import "package:js/js.dart";
import 'package:nodejs/nodejs.dart';

part 'callbacks.dart';

@JS()
@anonymous
class ProtocolRequest {
  external String get url;
  external String get referrer;
  external String get method;
  external List<ProtocolFileData> get uploadData;
}

@JS()
@anonymous
class ProtocolFileData {
  /// Content being sent.
  external Buffer get bytes;

  /// Path of file being uploaded.
  external String get file;
}

@JS('_electron.protocol')
class NativeJsProtocol {
  external const factory NativeJsProtocol();

  external void registerStandardSchemes(List<String> schemes);

  external void registerServiceWorkerSchemes(List<String> schemes);

  external void registerFileProtocol(
      String scheme, ProtocolRegisterFileHandler handler,
      [ProtocolRegisterCompletion completion]);

  external void registerBufferProtocol(
      String scheme, ProtocolRegisterBufferHandler handler,
      [ProtocolRegisterCompletion completion]);

  external void registerStringProtocol(
      String scheme, ProtocolRegisterStringHandler handler,
      [ProtocolRegisterCompletion completion]);

  external void registerHttpProtocol(
      String scheme, ProtocolRegisterHttpHandler handler,
      [ProtocolRegisterCompletion completion]);

  external void unregisterProtocol(String scheme,
      [ProtocolRegisterCompletion completion]);

  external void isProtocolHandled(String scheme, Function callback);

  external void interceptFileProtocol(
      String scheme, ProtocolRegisterFileHandler handler,
      [ProtocolRegisterCompletion completion]);

  external void interceptStringProtocol(
      String scheme, ProtocolRegisterStringHandler handler,
      [ProtocolRegisterCompletion completion]);

  external void interceptBufferProtocol(
      String scheme, ProtocolRegisterBufferHandler handler,
      [ProtocolRegisterCompletion completion]);

  external void interceptHttpProtocol(
      String scheme, ProtocolRegisterHttpHandler handler,
      [ProtocolRegisterCompletion completion]);

  external void uninterceptProtocol(String scheme, [Function completion]);
}

class Protocol {
  NativeJsProtocol _nativeJsProtocol;

  factory Protocol() {
    return new Protocol.fromNativeJsProtocol(new NativeJsProtocol());
  }

  Protocol.fromNativeJsProtocol(this._nativeJsProtocol);

  NativeJsProtocol get nativeJsProtocol => _nativeJsProtocol;

  void registerStandardSchemes(List<String> schemes) =>
      _nativeJsProtocol.registerStandardSchemes(schemes);

  void registerServiceWorkerSchemes(List<String> schemes) =>
      _nativeJsProtocol.registerServiceWorkerSchemes(schemes);

  void registerFileProtocol(String scheme, ProtocolRegisterFileHandler handler,
      [ProtocolRegisterCompletion completion]) {
    ProtocolRegisterCompletion completionJs;
    if (completion is Function) {
      completionJs = allowInterop(completion);
    }
    _nativeJsProtocol.registerFileProtocol(
        scheme, allowInterop(handler), completionJs);
  }

  void registerBufferProtocol(
      String scheme, ProtocolRegisterBufferHandler handler,
      [ProtocolRegisterCompletion completion]) {
    ProtocolRegisterCompletion completionJs;
    if (completion is Function) {
      completionJs = allowInterop(completion);
    }
    _nativeJsProtocol.registerBufferProtocol(
        scheme, allowInterop(handler), completionJs);
  }

  void registerStringProtocol(
      String scheme, ProtocolRegisterStringHandler handler,
      [ProtocolRegisterCompletion completion]) {
    ProtocolRegisterCompletion completionJs;
    if (completion is Function) {
      completionJs = allowInterop(completion);
    }
    _nativeJsProtocol.registerStringProtocol(
        scheme, allowInterop(handler), completionJs);
  }

  void registerHttpProtocol(String scheme, ProtocolRegisterHttpHandler handler,
      [ProtocolRegisterCompletion completion]) {
    ProtocolRegisterCompletion completionJs;
    if (completion is Function) {
      completionJs = allowInterop(completion);
    }
    _nativeJsProtocol.registerHttpProtocol(
        scheme, allowInterop(handler), completionJs);
  }

  void unregisterProtocol(String scheme,
          [ProtocolRegisterCompletion completion]) {
    ProtocolRegisterCompletion completionJs;
    if (completion is Function) {
      completionJs = allowInterop(completion);
    }

    _nativeJsProtocol.unregisterProtocol(scheme, completionJs);
  }

  void isProtocolHandled(String scheme, Function callback) =>
      _nativeJsProtocol.isProtocolHandled(scheme, allowInterop(callback));

  void interceptFileProtocol(String scheme, ProtocolRegisterFileHandler handler,
      [ProtocolRegisterCompletion completion]) {
    ProtocolRegisterCompletion completionJs;
    if (completion is Function) {
      completionJs = allowInterop(completion);
    }
    _nativeJsProtocol.interceptFileProtocol(
        scheme, allowInterop(handler), completionJs);
  }

  void interceptStringProtocol(
      String scheme, ProtocolRegisterStringHandler handler,
      [ProtocolRegisterCompletion completion]) {
    ProtocolRegisterCompletion completionJs;
    if (completion is Function) {
      completionJs = allowInterop(completion);
    }
    _nativeJsProtocol.interceptStringProtocol(
        scheme, allowInterop(handler), completionJs);
  }

  void interceptBufferProtocol(
      String scheme, ProtocolRegisterBufferHandler handler,
      [ProtocolRegisterCompletion completion]) {
    ProtocolRegisterCompletion completionJs;
    if (completion is Function) {
      completionJs = allowInterop(completion);
    }
    _nativeJsProtocol.interceptBufferProtocol(
        scheme, allowInterop(handler), completionJs);
  }

  void interceptHttpProtocol(String scheme, ProtocolRegisterHttpHandler handler,
      [ProtocolRegisterCompletion completion]) {
    ProtocolRegisterCompletion completionJs;
    if (completion is Function) {
      completionJs = allowInterop(completion);
    }
    _nativeJsProtocol.interceptHttpProtocol(
        scheme, allowInterop(handler), completionJs);
  }

  void uninterceptProtocol(String scheme, [Function completion]) {
    Function completionJs;
    if (completion is Function) {
      completionJs = allowInterop(completion);
    }
    _nativeJsProtocol.uninterceptProtocol(scheme, completionJs);
  }
}
