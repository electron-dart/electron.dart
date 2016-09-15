// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of electron.browser_window;

@JS()
@anonymous
class BrowserWindowOptions {
  external const factory BrowserWindowOptions(
      {int width: 800,
      int height: 600,
      int x,
      int y,
      bool useContentSize,
      bool center,
      int minWidth,
      int minHeight,
      int maxWidth,
      int maxHeight,
      bool resizable,
      bool movable,
      bool minimizable,
      bool maximizable,
      bool closable,
      bool focusable,
      bool alwaysOnTop,
      bool fullscreen,
      bool fullscreenable,
      bool skipTaskbar,
      bool kiosk,
      String title,
      NativeImage icon,
      bool show,
      bool frame,
      BrowserWindow parent,
      bool modal,
      bool acceptFirstMouse,
      bool disableAutoHideCursor,
      bool autoHideMenuBar,
      bool enableLargerThanScreen,
      String backgroundColor,
      bool hasShadow,
      bool darkTheme,
      bool transparent,
      String type,
      String titleBarStyle,
      bool thickFrame,
      WebPreferencesOption webPreferences
      });

  /// Window’s width in pixels. Default is 800
  external int get width;

  /// Window’s height in pixels. Default is 600
  external int get height;

  /// Window’s left offset from screen. Default is to center the window.
  external int get x;

  /// Window’s top offset from screen. Default is to center the window.
  external int get y;

  /// The width and height would be used as web page’s size, which means the
  /// actual window’s size will include window frame’s size and be slightly
  /// larger. Default is false.
  external bool get useContentSize;

  /// Show window in the center of the screen.
  external bool get center;

  /// Window’s minimum width. Default is 0.
  external int get minWidth;

  /// Window’s minimum height. Default is 0.
  external int get minHeight;

  /// Window’s maximum width. Default is no limit.
  external int get maxWidth;

  /// Window’s maximum height. Default is no limit.
  external int get maxHeight;

  /// Whether window is resizable. Default is true.
  external bool get resizable;

  /// Whether window is movable. This is not implemented on Linux. Default is
  /// true.
  external bool get movable;

  /// Whether window is minimizable. This is not implemented on Linux. Default
  /// is true.
  external bool get minimizable;

  /// Whether window is maximizable. This is not implemented on Linux. Default
  /// is true.
  external bool get maximizable;

  /// Whether window is closable. This is not implemented on Linux. Default is
  /// true.
  external bool get closable;

  /// Whether the window can be focused. Default is true. On Windows setting
  /// focusable: false also implies setting skipTaskbar: true. On Linux setting
  /// focusable: false makes the window stop interacting with wm, so the window
  /// will always stay on top in all workspaces.
  external bool get focusable;

  /// Whether the window should always stay on top of other windows. Default is
  /// false.
  external bool get alwaysOnTop;

  /// Whether the window should show in fullscreen. When explicitly set to false
  /// the fullscreen button will be hidden or disabled on macOS. Default is false.
  external bool get fullscreen;

  /// Whether the window can be put into fullscreen mode. On macOS, also whether
  /// the maximize/zoom button should toggle full screen mode or maximize window.
  /// Default is true.
  external bool get fullscreenable;

  /// Whether to show the window in taskbar. Default is false.
  external bool get skipTaskbar;

  /// The kiosk mode. Default is false.
  external bool get kiosk;

  /// Default window title. Default is "Electron".
  external String get title;

  /// The window icon. On Windows it is recommended to use ICO icons to get best
  /// visual effects, you can also leave it undefined so the executable’s icon
  /// will be used.
  external NativeImage get icon;

  /// Whether window should be shown when created. Default is true.
  external bool get show;

  /// Specify false to create a Frameless Window. Default is true.
  external bool get frame;

  /// Specify parent window. Default is null.
  external BrowserWindow get parent;

  /// Whether this is a modal window. This only works when the window is a child
  /// window. Default is false.
  external bool get modal;

  /// Whether the web view accepts a single mouse-down event that simultaneously
  /// activates the window. Default is false.
  external bool get acceptFirstMouse;

  /// Whether to hide cursor when typing. Default is false.
  external bool get disableAutoHideCursor;

  /// Auto hide the menu bar unless the Alt key is pressed. Default is false.
  external bool get autoHideMenuBar;

  /// Enable the window to be resized larger than screen. Default is false.
  external bool get enableLargerThanScreen;

  /// Window’s background color as Hexadecimal value, like #66CD00 or #FFF or
  /// #80FFFFFF (alpha is supported). Default is #FFF (white).
  external String get backgroundColor;

  /// Whether window should have a shadow. This is only implemented on macOS.
  /// Default is true.
  external bool get hasShadow;

  /// Forces using dark theme for the window, only works on some GTK+3 desktop
  /// environments. Default is false.
  external bool get darkTheme;

  /// Makes the window transparent. Default is false.
  external bool get transparent;

  /// The type of window, default is normal window. See more about this below.
  external String get type;

  /// The style of window title bar. See more about this below.
  external String get titleBarStyle;

  /// Use WS_THICKFRAME style for frameless windows on Windows, which adds
  /// standard window frame. Setting it to false will remove window shadow and
  /// window animations. Default is true.
  external bool get thickFrame;

  /// Settings of web page’s features. See more about this below.
  external WebPreferencesOption get webPreferences;
}


