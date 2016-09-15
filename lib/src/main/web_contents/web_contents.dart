// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.main.web_contents;

import "package:js/js.dart";
import "package:nodejs/nodejs.dart";

@JS('_electron.WebContents')
class NativeJsWebContents extends NativeJsEventEmitter {
  //TODO
}

class WebContents extends EventEmitter {
  /*
  factory WebContents() {
    return new WebContents.fromNativeJsWebContent(new NativeJsWebContents());
  }
  */

  WebContents.fromNativeJsWebContent(NativeJsWebContents window)
      : super.fromNativeJsEventEmitter(window) {
    _nativeJs = window;

    _initAllEventStreams();
  }

  void _initAllEventStreams() {
    //TODO
  }

  NativeJsWebContents _nativeJs;

  NativeJsWebContents get nativeJs => _nativeJs;

  //TODO
}