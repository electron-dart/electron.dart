part of  electron.main.web_contents;

@JS('_electron.webContents.Debugger')
class NativeJsDebugger {
  /// Attaches the debugger to the webContents.
  ///
  /// protocolVersion Requested debugging protocol version.
  external void attach([String protocolVersion]);

  /// Returns a boolean indicating whether a debugger is attached to the webContents.
  external bool isAttached();

  /// Detaches the debugger from the webContents.
  external void detach();
}

class Debugger {
  NativeJsDebugger _nativeJs;

  Debugger.fromNativeJsDebugger(NativeJsDebugger nativeJs) {
    _nativeJs = nativeJs;
  }

  NativeJsDebugger get nativeJs => _nativeJs;

  //TODO events

  /// Attaches the debugger to the webContents.
  ///
  /// protocolVersion Requested debugging protocol version.
  void attach([String protocolVersion]) => _nativeJs.attach(protocolVersion);

  /// Returns a boolean indicating whether a debugger is attached to the webContents.
  bool isAttached() => isAttached();

  /// Detaches the debugger from the webContents.
  void detach() => _nativeJs.detach();
}