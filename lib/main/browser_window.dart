// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of electron_main;

@JS()
@anonymous
class BrowserWindowOptions {
  external const factory BrowserWindowOptions(
      {int width: 800, int height: 600, bool show: true});

  external int get width;
  external int get height;
  external bool get show;
}

@JS('_electron.BrowserWindow')
class NativeJsBrowserWindow extends NativeJsEventEmitter {
  external factory NativeJsBrowserWindow([BrowserWindowOptions options]);

  external void loadURL(String url);
  external void show();
}

const BrowserWindowOptions defaultBrowserWindowOptions =
    const BrowserWindowOptions();

class BrowserWindow extends EventEmitter {
  NativeJsBrowserWindow _browserWindow;

  StreamController<Null> _closed;

  BrowserWindow([BrowserWindowOptions options = defaultBrowserWindowOptions]) {
    _browserWindow = new NativeJsBrowserWindow(options);
    _initAllStreamController();
  }

  Stream<Null> get onClosed => _closed.stream;

  void loadURL(String url) => _browserWindow.loadURL(url);
  void show() => _browserWindow.show();

  void _initAllStreamController() {
    _closed = new StreamController<Null>(sync: true);
    on('closed', _onClosed);
  }

  void _onClosed([dynamic event]) => _closed.add(null);
}
