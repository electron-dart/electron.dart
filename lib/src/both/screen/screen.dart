// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.both.screen;

import 'dart:async';
import 'dart:math';
import 'package:js/js.dart';
import "package:nodejs/nodejs.dart" as nodejs;

import 'package:electron/src/both/geometry/geometry.dart';

@JS()
@anonymous
class NativeJsDisplay {
  /// Unique identifier associated with the display.
  external int get id;

  /// Can be 0, 90, 180, 270, represents screen rotation in clock-wise degrees.
  external int get rotation;

  /// Output device’s pixel scale factor.
  external num get scaleFactor;

  /// Can be available, unavailable, unknown.
  external String get touchSupport;

  external NativeJsBounds get bounds;

  external NativeJsSize get size;

  external NativeJsBounds get workArea;

  external NativeJsSize get workAreaSize;
}

class Display {
  NativeJsDisplay _nativeJsDisplay;

  Display.fromNativeJsDisplay(this._nativeJsDisplay);

  /// Unique identifier associated with the display.
  int get id => _nativeJsDisplay.id;

  /// Can be 0, 90, 180, 270, represents screen rotation in clock-wise degrees.
  int get rotation => _nativeJsDisplay.rotation;

  /// Output device’s pixel scale factor.
  num get scaleFactor => _nativeJsDisplay.scaleFactor;

  /// Can be available, unavailable, unknown.
  String get touchSupport => _nativeJsDisplay.touchSupport;

  Rectangle<int> get bounds => rectFromJs(_nativeJsDisplay.bounds);

  Size get size => new Size.fromNativeJsSize(_nativeJsDisplay.size);

  Rectangle<int> get workArea => rectFromJs(_nativeJsDisplay.workArea);

  Size get workAreaSize =>
      new Size.fromNativeJsSize(_nativeJsDisplay.workAreaSize);
}

@JS()
@anonymous
class NativeJsScreen extends nodejs.NativeJsEventEmitter {
  /// Returns the current absolute position of the mouse pointer.
  external NativeJsPoint getCursorScreenPoint();

  /// Returns the primary display.
  external NativeJsDisplay getPrimaryDisplay();

  /// Returns an array of displays that are currently available.
  external List<NativeJsDisplay> getAllDisplays();

  /// Returns the display nearest the specified point.
  external NativeJsDisplay getDisplayNearestPoint(NativeJsPoint point);

  /// Returns the display that most closely intersects the provided bounds.
  external NativeJsDisplay getDisplayMatching(NativeJsBounds rect);
}

class EventDisplay {
  EventDisplay(this.event, this.display);

  final dynamic event;

  final Display display;
}

class EventDisplayMetrics {
  EventDisplayMetrics(this.event, this.display, this.changedMetrics);

  final dynamic event;

  final Display display;

  final List<String> changedMetrics;
}

@JS("_electron.screen")
external NativeJsScreen get _screen;

final Screen screen = new Screen();

class Screen extends nodejs.EventEmitter {
  Screen() : super.fromNativeJsEventEmitter(_screen) {
    _displayAdded = new nodejs.EventEmitterGlue<EventDisplay>(
        this, 'display-added', (dynamic event, NativeJsDisplay display) {
      _displayAdded.add(
          new EventDisplay(event, new Display.fromNativeJsDisplay(display)));
    });

    _displayRemoved = new nodejs.EventEmitterGlue<EventDisplay>(
        this, 'display-removed', (dynamic event, NativeJsDisplay display) {
      _displayRemoved.add(
          new EventDisplay(event, new Display.fromNativeJsDisplay(display)));
    });

    _displayMetricsChanged = new nodejs.EventEmitterGlue<EventDisplayMetrics>(
        this, 'display-metrics-changed',
        (dynamic event, NativeJsDisplay display, List<String> metrics) {
      _displayMetricsChanged.add(new EventDisplayMetrics(
          event, new Display.fromNativeJsDisplay(display), metrics));
    });
  }

  nodejs.EventEmitterGlue<EventDisplay> _displayAdded;

  Stream<EventDisplay> get onDisplayAdded => _displayAdded.stream;

  nodejs.EventEmitterGlue<EventDisplay> _displayRemoved;

  Stream<EventDisplay> get onDisplayRemoved => _displayRemoved.stream;

  nodejs.EventEmitterGlue<EventDisplayMetrics> _displayMetricsChanged;

  Stream<EventDisplayMetrics> get onDisplayMetricsChanged =>
      _displayMetricsChanged.stream;

  /// Returns the current absolute position of the mouse pointer.
  Point<int> getCursorScreenPoint() =>
      pointFromJs(_screen.getCursorScreenPoint());

  /// Returns the primary display.
  Display getPrimaryDisplay() =>
      new Display.fromNativeJsDisplay(_screen.getPrimaryDisplay());

  /// Returns an array of displays that are currently available.
  List<Display> getAllDisplays() => _screen
      .getAllDisplays()
      .map(
          (NativeJsDisplay display) => new Display.fromNativeJsDisplay(display))
      .toList();

  /// Returns the display nearest the specified point.
  Display getDisplayNearestPoint(Point<int> point) =>
      new Display.fromNativeJsDisplay(
          _screen.getDisplayNearestPoint(pointToJs(point)));

  /// Returns the display that most closely intersects the provided bounds.
  Display getDisplayMatching(Rectangle<int> rect) =>
      new Display.fromNativeJsDisplay(
          _screen.getDisplayMatching(rectToJs(rect)));
}
