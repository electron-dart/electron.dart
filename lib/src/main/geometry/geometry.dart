// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.both.geometry;

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

  Size.fromNativeJsSize(NativeJsSize size): width = size.width, height = size.height;

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