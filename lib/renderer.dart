// Copyright (c) 2016, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// Support for doing something awesome.
///
/// More dartdocs go here.

@JS()
library electron.main;

import "package:js/js.dart";
import "package:nodejs/nodejs.dart";

//Common exports
export 'package:electron/src/both/clipboard/clipboard.dart';
export 'package:electron/src/both/native_image/native_image.dart';
export 'package:electron/src/both/process/process.dart';
export 'package:electron/src/both/screen/screen.dart';

// Main process export
export 'package:electron/src/renderer/ipc/ipc.dart';

@JS('_electron')
external NativeJsObject get _electron;

@JS('_electron')
external set _electron(NativeJsObject value);

void _requireElectron() {
  if (_electron == null) {
    _electron = require("electron");
  }
}

void prepareElectron() {
  _requireElectron();
}