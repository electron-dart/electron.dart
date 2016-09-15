// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of electron.browser_window;

/// Options to request default font for the font-family.
@JS()
@anonymous
class FontFamilyOptions {
  external const factory FontFamilyOptions(
      {String standard, String serif, String sansSerif, String monospace});

  /// Defaults to Times New Roman.
  external String get standard;

  /// Defaults to Times New Roman.
  external String get serif;

  /// Defaults to Arial.
  external String get sansSerif;

  /// Defaults to Courier New.
  external String get monospace;
}

@JS()
@anonymous
class WebPreferencesOption {
  external const factory WebPreferencesOption(
      {bool devTools,
      bool nodeIntegration,
      String preload,
      Session session,
      String partition,
      num zoomFactor,
      bool javascript,
      bool webSecurity,
      bool allowDisplayingInsecureContent,
      bool allowRunningInsecureContent,
      bool images,
      bool textAreasAreResizable,
      bool webgl,
      bool webaudio,
      bool plugins,
      bool experimentalFeatures,
      bool experimentalCanvasFeatures,
      bool scrollBounce,
      String blinkFeatures,
      String disableBlinkFeatures,
      FontFamilyOptions defaultFontFamily,
      String standard,
      String serif,
      String sansSerif,
      String monospace,
      int defaultFontSize,
      int defaultMonospaceFontSize,
      int minimumFontSize,
      String defaultEncoding,
      bool backgroundThrottling,
      bool offscreen});

  /// Whether to enable DevTools. If it is set to false, can not use BrowserWindow.webContents.openDevTools() to open DevTools. Default is true.
  external bool get devTools;

  /// Whether node integration is enabled. Default is true.
  external bool get nodeIntegration;

  /// Specifies a script that will be loaded before other scripts run in the page.
  /// This script will always have access to node APIs no matter whether node
  /// integration is turned on or off. The value should be the absolute file
  /// path to the script. When node integration is turned off, the preload script
  /// can reintroduce Node global symbols back to the global scope. See example here.
  external String get preload;

  /// Sets the session used by the page. Instead of passing the Session object
  /// directly, you can also choose to use the partition option instead, which
  /// accepts a partition string. When both session and partition are provided,
  /// session will be preferred. Default is the default session.
  external Session get session;

  /// Sets the session used by the page according to the session’s partition string. If partition starts with persist:, the page will use a persistent session available to all pages in the app with the same partition. If there is no persist: prefix, the page will use an in-memory session. By assigning the same partition, multiple pages can share the same session. Default is the default session.
  external String get partition;

  /// The default zoom factor of the page, 3.0 represents 300%. Default is 1.0.
  external num get zoomFactor;

  /// Enables JavaScript support. Default is true.
  external bool get javascript;

  /// When false, it will disable the same-origin policy (usually using testing websites by people), and set allowDisplayingInsecureContent and allowRunningInsecureContent to true if these two options are not set by user. Default is true.
  external bool get webSecurity;

  /// Allow an https page to display content like images from http URLs. Default is false.
  external bool get allowDisplayingInsecureContent;

  /// Allow an https page to run JavaScript, CSS or plugins from http URLs. Default is false.
  external bool get allowRunningInsecureContent;

  /// Enables image support. Default is true.
  external bool get images;

  /// Make TextArea elements resizable. Default is true.
  external bool get textAreasAreResizable;

  /// Enables WebGL support. Default is true.
  external bool get webgl;

  /// Enables WebAudio support. Default is true.
  external bool get webaudio;

  /// Whether plugins should be enabled. Default is false.
  external bool get plugins;

  /// Enables Chromium’s experimental features. Default is false.
  external bool get experimentalFeatures;

  /// Enables Chromium’s experimental canvas features. Default is false.
  external bool get experimentalCanvasFeatures;

  /// Enables scroll bounce (rubber banding) effect on macOS. Default is false.
  external bool get scrollBounce;

  /// A list of feature strings separated by ,, like CSSVariables,KeyboardEventKey to enable. The full list of supported feature strings can be found in the RuntimeEnabledFeatures.in file.
  external String get blinkFeatures;

  /// A list of feature strings separated by ,, like CSSVariables,KeyboardEventKey to disable. The full list of supported feature strings can be found in the RuntimeEnabledFeatures.in file.
  external String get disableBlinkFeatures;

  /// Sets the default font for the font-family.
  external FontFamilyOptions get defaultFontFamily;

  /// Defaults to Times New Roman.
  external String get standard;

  /// Defaults to Times New Roman.
  external String get serif;

  /// Defaults to Arial.
  external String get sansSerif;

  /// Defaults to Courier New.
  external String get monospace;

  /// Defaults to 16.
  external int get defaultFontSize;

  /// Defaults to 13.
  external int get defaultMonospaceFontSize;

  /// Defaults to 0.
  external int get minimumFontSize;

  /// Defaults to ISO-8859-1.
  external String get defaultEncoding;

  /// Whether to throttle animations and timers when the page becomes background. Defaults to true.
  external bool get backgroundThrottling;

  /// Whether to enable offscreen rendering for the browser window. Defaults to false.
  external bool get offscreen;
}
