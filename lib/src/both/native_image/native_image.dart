@JS()
library electron.both.native_image;

import "package:js/js.dart";
import "package:nodejs/nodejs.dart";

@JS()
external NativeImage createEmpty();

@JS()
external NativeImage createFromPath(String path);

@JS()
external NativeImage createFromBuffer(Buffer buffer, [double scaleFactor]);

@JS()
external NativeImage createFromDataURL(String dataURL);

@JS()
class NativeImage {
  external Buffer toPNG();

  external Buffer toJPEG(int quality);

  external Buffer toBitmap();

  external String toDataURL();

  external Buffer getBitmap();

  external Buffer getNativeHandle();

  external bool isEmpty();

  external dynamic getSize();

  external void setTemplateImage(bool option);

  external bool isTemplateImage();
}