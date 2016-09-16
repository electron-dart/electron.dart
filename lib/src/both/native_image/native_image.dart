// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.both.native_image;

import "package:js/js.dart";
import "package:nodejs/nodejs.dart";

import "package:electron/src/both/geometry/geometry.dart";

@JS('_electron.nativeImage.createEmpty')
external NativeJsNativeImage _createEmpty();

@JS('_electron.nativeImage.createFromPath')
external NativeJsNativeImage _createFromPath(String path);

@JS('_electron.nativeImage.createFromBuffer')
external NativeJsNativeImage _createFromBuffer(Buffer buffer, [double scaleFactor]);

@JS('_electron.nativeImage.createFromDataURL')
external NativeJsNativeImage _createFromDataURL(String dataURL);

@JS('_electron.nativeImage.NativeImage')
class NativeJsNativeImage {
  external Buffer toPNG();

  external Buffer toJPEG(int quality);

  external Buffer toBitmap();

  external String toDataURL();

  external Buffer getBitmap();

  external Buffer getNativeHandle();

  external bool isEmpty();

  external NativeJsSize getSize();

  external void setTemplateImage(bool option);

  external bool isTemplateImage();
}

class NativeImage {
  NativeJsNativeImage nativeJs;

  NativeImage.createEmpty() {
    nativeJs = _createEmpty();
  }

  NativeImage.createFromPath(String path) {
    nativeJs = _createFromPath(path);
  }

  NativeImage.createFromBuffer(Buffer buffer, [double scaleFactor]) {
    nativeJs = _createFromBuffer(buffer, scaleFactor);
  }

  NativeImage.createFromDataURL(String dataURL) {
    nativeJs = _createFromDataURL(dataURL);
  }

  Buffer toPNG() => nativeJs.toPNG();

  Buffer toJPEG(int quality) => nativeJs.toJPEG(quality);

  Buffer toBitmap() => nativeJs.toBitmap();

  String toDataURL() => nativeJs.toDataURL();

  Buffer getBitmap() => nativeJs.getBitmap();

  Buffer getNativeHandle() => nativeJs.getNativeHandle();

  bool isEmpty() => nativeJs.isEmpty();

  Size getSize() => new Size.fromNativeJsSize(nativeJs.getSize());

  void setTemplateImage(bool option) => nativeJs.setTemplateImage(option);

  bool isTemplateImage() => nativeJs.isTemplateImage();
}