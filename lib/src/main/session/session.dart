@JS('_electron.session')
library electron.main.session;

import "package:js/js.dart";

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
@JS()
external Session fromPartition(String partition, [SessionOptions options]);


@JS()
external Session get defaultSession;

@JS('_electron.Session')
class Session {
  //TODO
}
