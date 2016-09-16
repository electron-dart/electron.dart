// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.both.geometry;

import 'dart:math';
import "package:js/js.dart";

@JS()
@anonymous
class NativeJsSize {
  external const factory NativeJsSize({int width, int height});

  external int get width;

  external int get height;
}

class Size {
  Size(this.width, this.height);

  Size.fromNativeJsSize(NativeJsSize size)
      : width = size.width,
        height = size.height;

  int width = 0;

  int height = 0;

  NativeJsSize toNativeJsSize() {
    return new NativeJsSize(width: width, height: height);
  }

  @override
  String toString() {
    return "{width: $width, height: $height}";
  }
}

@JS()
@anonymous
class NativeJsBounds {
  external const factory NativeJsBounds({int x, int y, int width, int height});

  external int get x;

  external int get y;

  external int get width;

  external int get height;
}

NativeJsBounds rectToJs(Rectangle<int> rect) {
  if(rect is! Rectangle<int>) {
    return null;
  }

  return new NativeJsBounds(
      x: rect.left, y: rect.top, width: rect.width, height: rect.height);
}

Rectangle<int> rectFromJs(NativeJsBounds bounds) {
  if(bounds is! NativeJsBounds) {
    return null;
  }
  return new Rectangle<int>(bounds.x, bounds.y, bounds.width, bounds.height);
}

@JS()
@anonymous
class NativeJsPoint {
  external const factory NativeJsPoint({int x, int y});

  external int get x;

  external int get y;
}

NativeJsPoint pointToJs(Point<int> point) {
  if(point is! Point<int>) {
    return null;
  }

  return new NativeJsPoint(x: point.x, y: point.y);
}

Point<int> pointFromJs(NativeJsPoint point) {
  if(point is! NativeJsPoint) {
    return null;
  }

  return new Point<int>(point.x, point.y);
}