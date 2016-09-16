// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.main.tray;

import 'dart:math';
import "dart:async";
import "package:js/js.dart";
import "package:nodejs/nodejs.dart";

import 'package:electron/src/both/native_image/native_image.dart';
import 'package:electron/src/both/geometry/geometry.dart';

import 'package:electron/src/main/menu/menu.dart';

@JS()
@anonymous
class TrayBalloonOptions {
  external const factory TrayBalloonOptions(
      {NativeJsNativeImage icon, String title, String content});

  external NativeJsNativeImage get icon;

  external String get title;

  external String get content;
}

@JS('_electron.Tray')
class NativeJsTray extends NativeJsEventEmitter {
  /// Creates a new tray icon associated with the image.
  external factory NativeJsTray(NativeJsNativeImage image);

  /// Destroys the tray icon immediately.
  external void destroy();

  /// Sets the image associated with this tray icon.
  external void setImage(NativeJsNativeImage image);

  /// Sets the image associated with this tray icon when pressed on macOS.
  external void setPressedImage(NativeJsNativeImage image);

  /// Sets the hover text for this tray icon.
  external void setToolTip(String toolTip);

  /// Sets the title displayed aside of the tray icon in the status bar.
  external void setTitle(String title);

  /// Sets when the tray’s icon background becomes highlighted (in blue).
  ///
  /// Note: You can use highlightMode with a BrowserWindow by toggling between
  /// 'never' and 'always' modes when the window visibility changes.
  external void setHighlightMode(String mode);

  /// Displays a tray balloon.
  external void displayBalloon(TrayBalloonOptions options);

  /// Pops up the context menu of the tray icon. When menu is passed, the menu
  /// will be shown instead of the tray icon’s context menu.
  ///
  /// The position is only available on Windows, and it is (0, 0) by default.
  external void popUpContextMenu([NativeJsMenu menu, NativeJsPoint position]);

  /// Sets the context menu for this icon.
  external void setContextMenu(NativeJsMenu menu);

  /// Returns the bounds of this tray icon as Object.
  external NativeJsBounds getBounds();
}

@JS()
@anonymous
class _EventClick {
  external bool get altKey;
  external bool get shiftKey;
  external bool get ctrlKey;
  external bool get metaKey;
}

class EventTrayClick {
  EventTrayClick(_EventClick event, this.bounds)
      : altKey = event.altKey,
        shiftKey = event.shiftKey,
        ctrlKey = event.ctrlKey,
        metaKey = event.metaKey;

  final bool altKey;

  final bool shiftKey;

  final bool ctrlKey;

  final bool metaKey;

  final Rectangle<int> bounds;
}

class EventTrayDropText {
  EventTrayDropText(this.event, this.text);

  final dynamic event;

  final String text;
}

class EventTrayDropFile {
  EventTrayDropFile(this.event, this.files);

  final dynamic event;

  final List<String> files;
}

class Tray extends EventEmitter {
  NativeJsTray _nativeJs;

  /// Creates a new tray icon associated with the image.
  factory Tray(NativeImage image) {
    return new Tray.fromNativeJsTray(new NativeJsTray(image.nativeJs));
  }

  Tray.fromNativeJsTray(NativeJsTray native)
      : super.fromNativeJsEventEmitter(native) {
    _nativeJs = native;

    _initAllEventStreams();
  }

  NativeJsTray get nativeJs => _nativeJs;

  EventEmitterGlue<EventTrayClick> _click;

  /// Emitted when the tray icon is clicked.
  Stream<EventTrayClick> get onClick => _click.stream;

  EventEmitterGlue<EventTrayClick> _rightClick;

  /// Emitted when the tray icon is right clicked.
  Stream<EventTrayClick> get onRightClick => _rightClick.stream;

  EventEmitterGlue<EventTrayClick> _doubleClick;

  /// Emitted when the tray icon is double clicked.
  Stream<EventTrayClick> get onDoubleClick => _doubleClick.stream;

  EventEmitterGlue<Null> _balloonShow;

  /// Emitted when the tray balloon shows.
  Stream<Null> get onBalloonShow => _balloonShow.stream;

  EventEmitterGlue<Null> _balloonClick;

  /// Emitted when the tray balloon is clicked.
  Stream<Null> get onBalloonClick => _balloonClick.stream;

  EventEmitterGlue<Null> _balloonClose;

  /// Emitted when the tray balloon is closed because of timeout or user manually closes it.
  Stream<Null> get onBalloonClose => _balloonClose.stream;

  EventEmitterGlue<Null> _drop;

  /// Emitted when any dragged items are dropped on the tray icon.
  Stream<Null> get onDrop => _drop.stream;

  EventEmitterGlue<EventTrayDropFile> _dropFiles;

  /// Emitted when dragged files are dropped in the tray icon.
  Stream<EventTrayDropFile> get onDropFiles => _dropFiles.stream;

  EventEmitterGlue<EventTrayDropText> _dropText;

  /// Emitted when dragged text is dropped in the tray icon.
  Stream<EventTrayDropText> get onDropText => _dropText.stream;

  EventEmitterGlue<Null> _dragEnter;

  /// Emitted when a drag operation enters the tray icon.
  Stream<Null> get onDragEnter => _dragEnter.stream;

  EventEmitterGlue<Null> _dragLeave;

  /// Emitted when a drag operation exits the tray icon.
  Stream<Null> get onDragLeave => _dragLeave.stream;

  EventEmitterGlue<Null> _dragEnd;

  /// Emitted when a drag operation ends on the tray or ends at another location.
  Stream<Null> get onDragEnd => _dragEnd.stream;

  void _initAllEventStreams() {
    _click = new EventEmitterGlue<EventTrayClick>(this, "click",
        (_EventClick event, NativeJsBounds bounds) {
      _click.add(new EventTrayClick(event, rectFromJs(bounds)));
    });

    _rightClick = new EventEmitterGlue<EventTrayClick>(this, "right-click",
        (_EventClick event, NativeJsBounds bounds) {
      _rightClick.add(new EventTrayClick(event, rectFromJs(bounds)));
    });

    _doubleClick = new EventEmitterGlue<EventTrayClick>(this, "double-click",
        (_EventClick event, NativeJsBounds bounds) {
      _doubleClick.add(new EventTrayClick(event, rectFromJs(bounds)));
    });

    _balloonShow = new EventEmitterGlue<Null>(this, "balloon-show");

    _balloonClick = new EventEmitterGlue<Null>(this, "balloon-click");

    _balloonClose = new EventEmitterGlue<Null>(this, "balloon-close");

    _drop = new EventEmitterGlue<Null>(this, "drop");

    _dropFiles = new EventEmitterGlue<EventTrayDropFile>(this, "drop-file",
        (dynamic event, List<String> files) {
      _dropFiles.add(new EventTrayDropFile(event, files));
    });

    _dropText = new EventEmitterGlue<EventTrayDropText>(this, "drop-text",
        (dynamic event, String text) {
      _dropText.add(new EventTrayDropText(event, text));
    });

    _dragEnter = new EventEmitterGlue<Null>(this, "drag-enter");

    _dragLeave = new EventEmitterGlue<Null>(this, "drag-leave");

    _dragEnd = new EventEmitterGlue<Null>(this, "drag-end");
  }

  /// Destroys the tray icon immediately.
  void destroy() => _nativeJs.destroy();

  /// Sets the image associated with this tray icon.
  void setImage(NativeImage image) => _nativeJs.setImage(image.nativeJs);

  /// Sets the image associated with this tray icon when pressed on macOS.
  void setPressedImage(NativeImage image) =>
      _nativeJs.setPressedImage(image.nativeJs);

  /// Sets the hover text for this tray icon.
  void setToolTip(String toolTip) => _nativeJs.setToolTip(toolTip);

  /// Sets the title displayed aside of the tray icon in the status bar.
  void setTitle(String title) => _nativeJs.setTitle(title);

  /// Sets when the tray’s icon background becomes highlighted (in blue).
  ///
  /// Note: You can use highlightMode with a BrowserWindow by toggling between
  /// 'never' and 'always' modes when the window visibility changes.
  void setHighlightMode(String mode) => _nativeJs.setHighlightMode(mode);

  /// Displays a tray balloon.
  void displayBalloon(TrayBalloonOptions options) =>
      _nativeJs.displayBalloon(options);

  /// Pops up the context menu of the tray icon. When menu is passed, the menu
  /// will be shown instead of the tray icon’s context menu.
  ///
  /// The position is only available on Windows, and it is (0, 0) by default.
  void popUpContextMenu([Menu menu, Point<int> position]) {
    NativeJsMenu menuNative;
    if (menu is Menu) {
      menuNative = menu.nativeJs;
    }
    _nativeJs.popUpContextMenu(menuNative, pointToJs(position));
  }

  /// Sets the context menu for this icon.
  void setContextMenu(Menu menu) => _nativeJs.setContextMenu(menu.nativeJs);

  /// Returns the bounds of this tray icon as Object.
  Rectangle<int> getBounds() => rectFromJs(_nativeJs.getBounds());
}
