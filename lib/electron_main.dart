// Copyright (c) 2016, GrimShield. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron_main;

import "dart:async";

import "package:js/js.dart";

import "package:nodejs/nodejs.dart";

part "main/app.dart";
part "main/browser_window.dart";

@JS('_electron')
external NativeJsObject get _electron;
@JS('_electron')
external set _electron(NativeJsObject value);

void _requireElectron() {
  if (_electron == null) {
    _electron = require("electron");
  }
}
