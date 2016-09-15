// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.renderer.ipc;

import "package:js/js.dart";

/// Listens to channel, when a new message arrives listener would be called
/// with listener(event, args...).
@JS('_electron.ipcRenderer.on')
external void _on(String channel, Function listener);

/// Adds a one time listener function for the event. This listener is invoked
/// only the next time a message is sent to channel, after which it is removed.
@JS('_electron.ipcRenderer.once')
external void _once(String eventName, Function function);

/// Removes the specified listener from the listener array for the specified channel.
@JS('_electron.ipcRenderer.removeListener')
external void _removeListener(String eventName, Function function);

/// Removes all listeners, or those of the specified channel.
@JS('_electron.ipcRenderer.removeAllListeners')
external void _removeAllListeners([String eventName]);

/// Send a message to the main process asynchronously via channel, you can also
/// send arbitrary arguments. Arguments will be serialized in JSON internally
/// and hence no functions or prototype chain will be included.
///
/// The main process handles it by listening for channel with ipcMain module.
@JS('_electron.ipcRenderer.send')
external void _send(String channel, dynamic data);

/// Send a message to the main process synchronously via channel, you can also
/// send arbitrary arguments. Arguments will be serialized in JSON internally
/// and hence no functions or prototype chain will be included.
/// The main process handles it by listening for channel with ipcMain module,
/// and replies by setting event.returnValue.
///
/// Note: Sending a synchronous message will block the whole renderer process,
/// unless you know what you are doing you should never use it.
@JS('_electron.ipcRenderer.sendSync')
external dynamic _sendSync(String channel, dynamic data);

/// Like ipcRenderer.send but the event will be sent to the <webview> element
/// in the host page instead of the main process.
@JS('_electron.ipcRenderer.sendToHost')
external void _sendToHost(String channel, dynamic data);

class Ipc {
  static void on(String channel, Function listener) =>
      _on(channel, allowInterop(listener));

  static void once(String eventName, Function function) =>
      _once(eventName, allowInterop(function));

  static void removeListener(String eventName, Function function) =>
      _removeListener(eventName, allowInterop(function));

  static void removeAllListeners([String eventName]) =>
      _removeAllListeners(eventName);

  static void send(String channel, dynamic data) => _send(channel, data);

  static dynamic sendSync(String channel, dynamic data) =>
      _sendSync(channel, data);

  static void sendToHost(String channel, dynamic data) =>
      _sendToHost(channel, data);
}
