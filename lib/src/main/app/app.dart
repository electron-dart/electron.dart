// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.main.app;

import "dart:async";
import "package:js/js.dart";
import "package:nodejs/nodejs.dart";

import 'package:electron/src/main/menu/menu.dart';

import 'package:electron/src/both/native_image/native_image.dart';

@JS('_electron')
external NativeJsObject get _electron;

@JS('_electron')
external set _electron(NativeJsObject value);

void _requireElectron() {
  if (_electron == null) {
    _electron = require("electron");
  }
}

@JS("_electron.app")
class NativeJsApp extends NativeJsEventEmitter {
  external void quit();

  /// Exits immediately with exitCode. exitCode defaults to 0.
  ///
  /// All windows will be closed immediately without asking user and the before-quit and will-quit events will not be emitted.
  external void exit([int exitCode]);

  external void relaunch([options]);

  external bool isReady();

  external void focus();

  external void hide();

  external void show();

  external String getAppPath();

  external String getPath(String name);

  external void setPath(String name, String path);

  external String getVersion();

  external String getName();

  external void setName(String name);

  external String getLocale();

  external void addRecentDocument(String path);

  external void clearRecentDocuments();

  external bool setAsDefaultProtocolClient(String protocol, [String path, List<String> args]);

  external bool removeAsDefaultProtocolClient(String protocol, [String path, List<String> args]);

  external bool isDefaultProtocolClient(String protocol, [String path, List<String> args]);

  //TODO setUserTasks

  //TODO getJumpListSettings

  //TODO setJumpList

  external bool makeSingleInstance(Function callback);

  external void releaseSingleInstance();

  external String getCurrentActivityType();

  external void setAppUserModelId(String id);

  //TODO

  external void disableHardwareAcceleration();

  external bool setBadgeCount(int count);

  /// Returns the current value displayed in the counter badge.
  external int getBadgeCount();

  /// Returns whether current desktop environment is Unity launcher.
  external bool isUnityRunning();

  external void getLoginItemSettings();

  external void setLoginItemSettings(LoginItemSettingOption settings);

  external bool isAccessibilitySupportEnabled();

  external CommandLine get commandLine;

  external Dock get dock;
}

@JS()
@anonymous
class LoginItemSettingOption {
  external factory LoginItemSettingOption({bool openAtLogin, bool openAsHidden});

  external bool get openAtLogin;

  external bool get openAsHidden;
}

@JS()
@anonymous
class LoginItemSetting {
  external bool get openAtLogin;

  external bool get openAsHidden;

  external bool get wasOpenedAtLogin;

  external bool get wasOpenedAsHidden;

  external bool get restoreState;
}

@JS()
@anonymous
class CommandLine {
  external void appendSwitch(String switcharg, [String value]);

  external void appendArgument(String value);
}

@JS()
@anonymous
class Dock {
  external int bounce([String type]);

  external void cancelBounce(int id);

  external void downloadFinished(String filePath);

  external void setBadge(String text);

  external void hide();

  external void show();

  external bool isVisible();

  external void setMenu(NativeJsMenu menu);

  external void setIcon(NativeJsNativeImage image);
}

@JS("_electron.app")
external NativeJsApp get _app;

class App extends EventEmitter {
  NativeJsApp _app;

  App.fromNativeJsApp(NativeJsApp app) : super.fromNativeJsEventEmitter(app) {
    _app = app;
    _initAllStreamController();
  }

  EventEmitterGlue<Null> _willFinishLaunching;

  Stream<Null> get onWillFinishLaunching => _willFinishLaunching.stream;

  EventEmitterGlue<Null> _ready;

  Stream<Null> get onReady => _ready.stream;

  EventEmitterGlue<Null> _windowAllClosed;

  Stream<Null> get onWindowAllClosed => _windowAllClosed.stream;

  //TODO

  void _initAllStreamController() {
    _willFinishLaunching = new EventEmitterGlue<Null>(this, "will-finish-launching");

    _ready = new EventEmitterGlue<Null>(this, "ready");

    _windowAllClosed = new EventEmitterGlue<Null>(this, 'window-all-closed');

    //TODO
  }

  void quit() => _app.quit();
}

App _getApp() {
  _requireElectron();
  return new App.fromNativeJsApp(_app);
}

App app = _getApp();
