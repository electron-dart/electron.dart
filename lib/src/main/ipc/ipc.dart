// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.main.ipc;

import "package:js/js.dart";

import 'package:electron/src/main/web_contents/web_contents.dart';

@JS()
class IpcEvent {
  //TODO external const factory({});

  /// Set this to the value to be returned in a synchronous message.
  external set returnValue(dynamic value);

  external dynamic get returnValue;

  /// Returns the webContents that sent the message, you can call
  /// event.sender.send to reply to the asynchronous message, see
  /// webContents.send for more information.
  external WebContents get sender;
}

/// Listens to channel, when a new message arrives listener would be called
/// with listener(event, args...).
@JS('_electron.ipcMain.on')
external void _on(String channel, Function listener);

/// Adds a one time listener function for the event. This listener is invoked
/// only the next time a message is sent to channel, after which it is removed.
@JS('_electron.ipcMain.once')
external void _once(String eventName, Function function);

/// Removes the specified listener from the listener array for the specified channel.
@JS('_electron.ipcMain.removeListener')
external void _removeListener(String eventName, Function function);

/// Removes all listeners, or those of the specified channel.
@JS('_electron.ipcMain.removeAllListeners')
external void _removeAllListeners([String eventName]);

class Ipc {
  static void on(String channel, Function listener) =>
      _on(channel, allowInterop(listener));

  static void once(String eventName, Function function) =>
      _once(eventName, allowInterop(function));

  static void removeListener(String eventName, Function function) =>
      _removeListener(eventName, allowInterop(function));

  static void removeAllListeners([String eventName]) =>
      _removeAllListeners(eventName);
}
