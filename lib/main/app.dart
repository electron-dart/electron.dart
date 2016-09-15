// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of electron_main;

@JS("_electron.app")
class NativeJsApp extends NativeJsEventEmitter {
  external void quit();
}

@JS("_electron.app")
external NativeJsApp get _app;

class App extends EventEmitter {
  NativeJsApp _app;

  StreamController<Null> _windowAllClosed;
  StreamController<Null> _ready;

  App.fromNativeJsApp(NativeJsApp app) : super.fromNativeJsEventEmitter(app) {
    _app = app;
    _initAllStreamController();
  }

  Stream<Null> get onWindowAllClosed => _windowAllClosed.stream;
  Stream<Null> get onReady => _ready.stream;

  void quit() => _app.quit();

  void _initAllStreamController() {
    _windowAllClosed = new StreamController<Null>(sync: true);
    on('window-all-closed', _onWindowAllClosed);
    _ready = new StreamController<Null>(sync: true);
    on('ready', _onReady);
  }

  void _onWindowAllClosed([dynamic event]) => _windowAllClosed.add(null);
  void _onReady([dynamic event]) => _ready.add(null);
}

App _getApp() {
  _requireElectron();
  return new App.fromNativeJsApp(_app);
}

App app = _getApp();
