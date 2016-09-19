// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.both.process;

import 'dart:async';
import "package:js/js.dart";
import "package:nodejs/nodejs.dart" as nodejs;

@JS()
@anonymous
class ProcessMemoryInfo {
  /// The amount of memory currently pinned to actual physical RAM.
  external int get workingSetSize;

  /// The maximum amount of memory that has ever been pinned to actual physical RAM.
  external int get peakWorkingSetSize;

  /// The amount of memory not shared by other processes, such as JS heap or HTML content.
  external int get privateBytes;

  /// The amount of memory shared between processes, typically memory consumed by the Electron code itself
  external int get sharedBytes;
}

@JS()
@anonymous
class SystemMemoryInfo {
  /// The total amount of physical memory in Kilobytes available to the system.
  external int get total;

  /// The total amount of memory not being used by applications or disk cache.
  external int get free;

  /// The total amount of swap memory in Kilobytes available to the system. Windows Linux
  external int get swapTotal;

  /// The free amount of swap memory in Kilobytes available to the system. Windows Linux
  external int get swapFree;
}

@JS()
@anonymous
class ProcessVersions {
  /// Electron’s version string.
  String electron;

  /// Chrome’s version string.
  String chrome;
}

@JS()
@anonymous
class NativeJsProcess extends nodejs.NativeJsEventEmitter {
  external NativeJsProcess();

  /// Setting this to true can disable the support for asar archives in Node’s built-in modules.
  external set noAsar(bool value);

  /// Current process’s type, can be "browser" (i.e. main process) or "renderer".
  external String get type;

  external ProcessVersions get versions;

  /// Path to the resources directory.
  external String get resourcesPath;

  /// For Mac App Store build, this property is true, for other builds it is undefined.
  external bool get mas;

  /// If the app is running as a Windows Store app (appx), this property is true,
  /// for otherwise it is undefined.
  external bool get windowsStore;

  /// When app is started by being passed as parameter to the default app, this
  /// property is true in the main process, otherwise it is undefined.
  external bool get defaultApp;

  /// Causes the main thread of the current process crash.
  external void crash();

  /// Causes the main thread of the current process hang.
  external void hang();

  /// Sets the file descriptor soft limit to maxDescriptors or the OS hard limit, whichever is lower for the current process.
  external void setFdLimit(int maxDescriptors);

  external ProcessMemoryInfo getProcessMemoryInfo();

  external SystemMemoryInfo getSystemMemoryInfo();
}

@JS('process')
external NativeJsProcess get _process;

final Process process = new Process.fromNativeJsProcess(_process);

class Process extends nodejs.EventEmitter {
  Process.fromNativeJsProcess(NativeJsProcess native): super.fromNativeJsEventEmitter(native) {
    _loaded = new nodejs.EventEmitterGlue<Null>(this, 'loaded');
  }

  nodejs.EventEmitterGlue<Null> _loaded;

  /// Emitted when the tray icon is double clicked.
  Stream<Null> get onLoaded => _loaded.stream;

  /// Setting this to true can disable the support for asar archives in Node’s built-in modules.
  set noAsar(bool value) {
    _process.noAsar = value;
  }

  /// Current process’s type, can be "browser" (i.e. main process) or "renderer".
  String get type => _process.type;

  ProcessVersions get versions => _process.versions;

  /// Path to the resources directory.
  String get resourcesPath => _process.resourcesPath;

  /// For Mac App Store build, this property is true, for other builds it is undefined.
  bool get mas => _process.mas;

  /// If the app is running as a Windows Store app (appx), this property is true,
  /// for otherwise it is undefined.
  bool get windowsStore => _process.windowsStore;

  /// When app is started by being passed as parameter to the default app, this
  /// property is true in the main process, otherwise it is undefined.
  bool get defaultApp => _process.defaultApp;
}
