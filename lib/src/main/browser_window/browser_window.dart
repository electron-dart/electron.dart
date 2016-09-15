// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.browser_window;

import "dart:async";
import "package:js/js.dart";
import "package:nodejs/nodejs.dart";

import 'package:electron/src/both/native_image/native_image.dart';
import 'package:electron/src/main/menu/menu.dart';
import 'package:electron/src/main/session/session.dart';
import 'package:electron/src/main/web_contents/web_contents.dart';

part 'options.dart';
part 'web_preferences_option.dart';

@JS()
@anonymous
class AspectRatioExtraSize {
  external const factory AspectRatioExtraSize({int width, int height});

  external int get width;

  external int get height;
}

@JS()
@anonymous
class Bounds {
  external const factory Bounds({int x, int y, int width, int height});

  external int get x;
  external int get y;
  external int get width;
  external int get height;
}

@JS()
@anonymous
class ProgressBarOptions {
  /// Mode for the progres bar (none, normal, indeterminate, error, or paused)
  String mode;
}

@JS()
@anonymous
class DevToolsExtensionsInfo {
  external const factory DevToolsExtensionsInfo({String name, String version});

  external String get name;

  external String get version;
}

@JS()
@anonymous
class Button {
  /// The icon showing in thumbnail toolbar.
  external NativeImage get icon;

  external Function get click;

  /// The text of the button’s tooltip.
  external String get tooltip;

  /// Control specific states and behaviors of the button. By default, it is ['enabled'].
  /// enabled - The button is active and available to the user.
  /// disabled - The button is disabled. It is present, but has a visual state indicating it will not respond to user action.
  /// dismissonclick - When the button is clicked, the thumbnail window closes immediately.
  /// nobackground - Do not draw a button border, use only the image.
  /// hidden - The button is not shown to the user.
  /// noninteractive - The button is enabled but not interactive; no pressed button state is drawn. This value is intended for instances where the button is used in a notification.
  external List<String> get flags;
}

@JS('_electron.BrowserWindow')
class NativeJsBrowserWindow extends NativeJsEventEmitter {
  external factory NativeJsBrowserWindow([BrowserWindowOptions options]);

  /// Returns an array of all opened browser windows.
  external static List<NativeJsBrowserWindow> getAllWindows();

  /// Returns the window that is focused in this application, otherwise returns null.
  external static NativeJsBrowserWindow getFocusedWindow();

  /// Find a window according to the webContents it owns.
  external static NativeJsBrowserWindow fromWebContents(
      NativeJsWebContents webContents);

  /// Find a window according to its ID.
  external static NativeJsBrowserWindow fromId(int id);

  /// Adds DevTools extension located at path, and returns extension’s name.
  /// The extension will be remembered so you only need to call this API once,
  /// this API is not for programming use. If you try to add an extension that
  /// has already been loaded, this method will not return and instead log a
  /// warning to the console.
  ///
  /// The method will also not return if the extension’s manifest is missing or incomplete.
  ///
  /// Note: This API cannot be called before the ready event of the app module is emitted.
  external static String addDevToolsExtension(String path);

  /// Remove a DevTools extension by name.
  ///
  /// Note: This API cannot be called before the ready event of the app module is emitted.
  external static void removeDevToolsExtension(String name);

  ///  Returns an Object where the keys are the extension names and each value is an Object containing name and version properties.
  ///
  /// To check if a DevTools extension is installed you can run the following:
  ///
  /// const {BrowserWindow} = require('electron')
  ///
  /// let installed = BrowserWindow.getDevToolsExtensions().hasOwnProperty('devtron')
  /// console.log(installed)
  /// Note: This API cannot be called before the ready event of the app module is emitted.
  external static Map<String, DevToolsExtensionsInfo> getDevToolsExtensions();

  /// The WebContents object this window owns. All web page related events and
  /// operations will be done via it.
  external NativeJsWebContents get webContents;

  /// The unique ID of the window.
  external int get id;

  /// Force closing the window, the unload and beforeunload event won’t be emitted
  /// for the web page, and close event will also not be emitted for this window,
  /// but it guarantees the closed event will be emitted.
  external void destroy();

  /// Try to close the window. This has the same effect as a user manually
  /// clicking the close button of the window. The web page may cancel the
  /// close though. See the close event.
  external void close();

  /// Focuses on the window.
  external void focus();

  /// Removes focus from the window.
  external void blur();

  /// Returns a boolean, whether the window is focused.
  external bool isFocused();

  /// Returns a boolean, whether the window is destroyed.
  external bool isDestroyed();

  /// Shows and gives focus to the window.
  external void show();

  /// Shows the window but doesn’t focus on it.
  external void showInactive();

  /// Hides the window.
  external void hide();

  /// Returns a boolean, whether the window is visible to the user.
  external bool isVisible();

  /// Returns a boolean, whether current window is a modal window.
  external bool isModal();

  /// Maximizes the window.
  external void maximize();

  /// Unmaximizes the window.
  external void unmaximize();

  /// Returns a boolean, whether the window is maximized.
  external bool isMaximized();

  /// Minimizes the window. On some platforms the minimized window will be shown in the Dock.
  external void minimize();

  /// Restores the window from minimized state to its previous state.
  external void restore();

  /// Returns a boolean, whether the window is minimized.
  external bool isMinimized();

  /// Sets whether the window should be in fullscreen mode.
  external void setFullScreen(bool flag);

  /// Returns a boolean, whether the window is in fullscreen mode.
  external bool isFullScreen();

  /// This will make a window maintain an aspect ratio. The extra size allows a
  /// developer to have space, specified in pixels, not included within the
  /// aspect ratio calculations. This API already takes into account the
  /// difference between a window’s size and its content size.
  ///
  ///   aspectRatio Float - The aspect ratio to maintain for some portion of the content view.
  ///   extraSize Object (optional) - The extra size not to be included while maintaining the aspect ratio.
  ///
  /// Consider a normal window with an HD video player and associated controls.
  /// Perhaps there are 15 pixels of controls on the left edge, 25 pixels of
  /// controls on the right edge and 50 pixels of controls below the player.
  /// In order to maintain a 16:9 aspect ratio (standard aspect ratio for
  /// HD @1920x1080) within the player itself we would call this function with
  /// arguments of 16/9 and [ 40, 50 ]. The second argument doesn’t care where
  /// the extra width and height are within the content view–only that they exist.
  /// Just sum any extra width and height areas you have within the overall content view.
  external void setAspectRatio(double aspectRatio,
      [AspectRatioExtraSize extraSize]);

  /// Resizes and moves the window to width, height, x, y.
  external void setBounds(Bounds options, [bool animate]);

  /// Returns an object that contains window’s width, height, x and y values.
  external Bounds getBounds();

  /// Resizes and moves the window’s client area (e.g. the web page) to width, height, x, y.
  external void setContentBounds(Bounds options, [bool animate]);

  /// Returns an object that contains the window’s client area (e.g. the web page)
  /// width, height, x and y values.
  external Bounds getContentBounds();

  /// Resizes the window to width and height.
  external void setSize(int width, int height, [bool animate]);

  /// Returns an array that contains window’s width and height.
  external List<int> getSize();

  /// Resizes the window’s client area (e.g. the web page) to width and height.
  external void setContentSize(int width, int height, [bool animate]);

  /// Returns an array that contains window’s client area’s width and height.
  external List<int> getContentSize();

  /// Sets the minimum size of window to width and height.
  external void setMinimumSize(int width, int height);

  /// Returns an array that contains window’s minimum width and height.
  external List<int> getMinimumSize();

  /// Sets the maximum size of window to width and height.
  external void setMaximumSize(int width, int height);

  /// Returns an array that contains window’s maximum width and height.
  external List<int> getMaximumSize();

  /// Sets whether the window can be manually resized by user.
  external void setResizable(bool resizable);

  /// Returns whether the window can be manually resized by user.
  external bool isResizable();

  /// Sets whether the window can be moved by user. On Linux does nothing.
  external void setMovable(bool movable);

  /// Returns whether the window can be moved by user. On Linux always returns true.
  external bool isMovable();

  /// Sets whether the window can be manually minimized by user. On Linux does nothing.
  external void setMinimizable(bool minimizable);

  /// Returns whether the window can be manually minimized by user. On Linux
  /// always returns true.
  external bool isMinimizable();

  /// Sets whether the window can be manually maximized by user. On Linux does
  /// nothing.
  external void setMaximizable(bool maximizable);

  /// Returns whether the window can be manually maximized by user. On Linux always returns true.
  external bool isMaximizable();

  /// Sets whether the maximize/zoom window button toggles fullscreen mode or maximizes the window.
  external void setFullScreenable(bool fullscreenable);

  /// Returns whether the maximize/zoom window button toggles fullscreen mode or maximizes the window.
  external bool isFullScreenable();

  /// Sets whether the window can be manually closed by user. On Linux does nothing.
  external void setClosable(bool closable);

  /// Returns whether the window can be manually closed by user. On Linux always returns true.
  external bool isClosable();

  /// Sets whether the window should show always on top of other windows. After
  /// setting this, the window is still a normal window, not a toolbox window
  /// which can not be focused on.
  external void setAlwaysOnTop(bool flag);

  /// Returns whether the window is always on top of other windows.
  external bool isAlwaysOnTop();

  /// Moves window to the center of the screen.
  external void center();

  /// Moves window to x and y.
  external void setPosition(int x, int y, [bool animate]);

  /// Returns an array that contains window’s current position.
  external List<int> getPosition();

  /// Changes the title of native window to title.
  external String setTitle(String title);

  /// Returns the title of the native window.
  /// Note: The title of web page can be different from the title of the native window.
  external String getTitle();

  /// Changes the attachment point for sheets on macOS. By default, sheets are
  /// attached just below the window frame, but you may want to display them
  /// beneath a HTML-rendered toolbar. For example:
  ///
  ///     const {BrowserWindow} = require('electron')
  ///     let win = new BrowserWindow()
  ///
  ///     let toolbarRect = document.getElementById('toolbar').getBoundingClientRect()
  ///     win.setSheetOffset(toolbarRect.height)
  external void setSheetOffset(double offsetY, [double offsetX]);

  /// Starts or stops flashing the window to attract user’s attention.
  external void flashFrame(bool flag);

  /// Makes the window not show in the taskbar.
  external void setSkipTaskbar(bool skip);

  /// Enters or leaves the kiosk mode.
  external void setKiosk(bool flag);

  /// Returns whether the window is in kiosk mode.
  external bool isKiosk();

  /// Returns the platform-specific handle of the window as Buffer.
  ///
  /// The native type of the handle is HWND on Windows, NSView* on macOS, and Window (unsigned long) on Linux.
  external Buffer getNativeWindowHandle();

  /// Hooks a windows message. The callback is called when the message is received in the WndProc.
  external bool hookWindowMessage(int message, Function callback);

  /// Returns true or false depending on whether the message is hooked.
  external bool isWindowMessageHooked(int message);

  /// Unhook the window message.
  external void unhookWindowMessage(int message);

  /// Unhooks all of the window messages.
  external void unhookAllWindowMessages();

  /// Sets the pathname of the file the window represents, and the icon of the file will show in window’s title bar.
  external void setRepresentedFilename(String filename);

  /// Returns the pathname of the file the window represents.
  external String getRepresentedFilename();

  /// Specifies whether the window’s document has been edited, and the icon in title bar will become gray when set to true.
  external void setDocumentEdited(bool edited);

  /// Whether the window’s document has been edited.
  external bool isDocumentEdited();

  external void focusOnWebView();

  external void blurWebView();

  /// Same as webContents.capturePage([rect, ]callback).
  /// rect (optional) - The area of the page to be captured
  external void capturePage(Bounds rect, Function callback);

  /// Same as webContents.loadURL(url[, options]).
  ///
  /// The url can be a remote address (e.g. http://) or a path to a local HTML file using the file:// protocol.
  //
  /// To ensure that file URLs are properly formatted, it is recommended to use Node’s url.format method:
  ///
  ///  let url = require('url').format({
  ///   protocol: 'file',
  ///    slashes: true,
  ///    pathname: require('path').join(__dirname, 'index.html')
  ///  })
  ///
  /// win.loadURL(url)
  external void loadURL(String url, [LoadURLOptions options]);

  /// Same as webContents.reload.
  external void reload();

  /// Sets the menu as the window’s menu bar, setting it to null will remove the menu bar.
  external void setMenu(NativeJsMenu menu);

  /// Sets progress value in progress bar. Valid range is [0, 1.0].
  ///
  /// Remove progress bar when progress < 0; Change to indeterminate mode when progress > 1.
  ///
  /// On Linux platform, only supports Unity desktop environment, you need to specify the *.desktop file name to desktopName field in package.json. By default, it will assume app.getName().desktop.
  ///
  /// On Windows, a mode can be passed. Accepted values are none, normal, indeterminate, error, and paused. If you call setProgressBar without a mode set (but with a value within the valid range), normal will be assumed.
  external void setProgressBar(double progress, [ProgressBarOptions options]);

  /// Sets a 16 x 16 pixel overlay onto the current taskbar icon, usually used to
  /// convey some sort of application status or to passively notify the user.
  external void setOverlayIcon(NativeJsNativeImage overlay, String description);

  /// Sets whether the window should have a shadow. On Windows and Linux does nothing.
  external void setHasShadow(bool hasShadow);

  /// Returns whether the window has a shadow. On Windows and Linux always returns true.
  external bool hasShadow();

  /// Add a thumbnail toolbar with a specified set of buttons to the thumbnail
  /// image of a window in a taskbar button layout. Returns a Boolean object
  /// indicates whether the thumbnail has been added successfully.
  ///
  /// The number of buttons in thumbnail toolbar should be no greater than 7 due
  /// to the limited room. Once you setup the thumbnail toolbar, the toolbar
  /// cannot be removed due to the platform’s limitation. But you can call the
  /// API with an empty array to clean the buttons.
  external bool setThumbarButtons(List<Button> buttons);

  /// Sets the region of the window to show as the thumbnail image displayed when
  /// hovering over the window in the taskbar. You can reset the thumbnail to be
  /// the entire window by specifying an empty region: {x: 0, y: 0, width: 0, height: 0}.
  external bool setThumbnailClip(Bounds region);

  /// Sets the toolTip that is displayed when hovering over the window thumbnail
  /// in the taskbar.
  external bool setThumbnailToolTip(String toolTip);

  /// Same as webContents.showDefinitionForSelection().
  external void showDefinitionForSelection();

  /// Changes window icon.
  external void setIcon(NativeJsNativeImage icon);

  /// Sets whether the window menu bar should hide itself automatically. Once set
  /// the menu bar will only show when users press the single Alt key.
  ///
  /// If the menu bar is already visible, calling setAutoHideMenuBar(true) won’t
  /// hide it immediately.
  external void setAutoHideMenuBar(bool hide);

  /// Returns whether menu bar automatically hides itself.
  external bool isMenuBarAutoHide();

  /// Sets whether the menu bar should be visible. If the menu bar is auto-hide,
  /// users can still bring up the menu bar by pressing the single Alt key.
  external void setMenuBarVisibility(bool visible);

  /// Returns whether the menu bar is visible.
  external bool isMenuBarVisible();

  /// Sets whether the window should be visible on all workspaces.
  ///
  /// Note: This API does nothing on Windows.
  external void setVisibleOnAllWorkspaces(bool visible);

  /// Returns whether the window is visible on all workspaces.
  ///
  /// Note: This API always returns false on Windows.
  external bool isVisibleOnAllWorkspaces();

  /// Makes the window ignore all mouse events.
  ///
  /// All mouse events happened in this window will be passed to the window below
  /// this window, but if this window has focus, it will still receive keyboard events.
  external void setIgnoreMouseEvents(bool ignore);

  /// Prevents the window contents from being captured by other apps.
  ///
  /// On macOS it sets the NSWindow’s sharingType to NSWindowSharingNone. On Windows
  /// it calls SetWindowDisplayAffinity with WDA_MONITOR.
  external void setContentProtection(bool enable);

  /// Changes whether the window can be focused.
  external void setFocusable(bool focusable);

  /// Sets parent as current window’s parent window, passing null will turn current
  /// window into a top-level window.
  external void setParentWindow(NativeJsBrowserWindow parent);

  /// Returns the parent window.
  external BrowserWindow getParentWindow();

  /// Returns all child windows.
  external List<BrowserWindow> getChildWindows();
}

const BrowserWindowOptions defaultBrowserWindowOptions =
    const BrowserWindowOptions();

class EventEmitterGlue<T> {
  EventEmitter _emitter;

  StreamController<T> _controller;

  EventEmitterGlue(this._emitter, String event, [Function callback]) {
    _controller = new StreamController<T>(sync: true);
    if (callback is Function) {
      _emitter.on(event, callback);
    } else {
      _emitter.on(event, defConverter);
    }
  }

  void defConverter([dynamic a, dynamic b, dynamic c, dynamic d]) {
    add();
  }

  void add([T el]) {
    _controller.add(el);
  }

  Future<Null> destroy() async {
    await _controller.close();
  }

  Stream<T> get stream => _controller.stream;
}

class BrowserWindow extends EventEmitter {
  factory BrowserWindow(
      [BrowserWindowOptions options = defaultBrowserWindowOptions]) {
    return new BrowserWindow.fromNativeJsBrowserWindow(
        new NativeJsBrowserWindow(options));
  }

  BrowserWindow.fromNativeJsBrowserWindow(NativeJsBrowserWindow window)
      : super.fromNativeJsEventEmitter(window) {
    _nativeJs = window;

    _initAllEventStreams();
  }

  NativeJsBrowserWindow _nativeJs;

  NativeJsBrowserWindow get nativeJs => _nativeJs;

  EventEmitterGlue<Null> _pageTitleUpdated;

  Stream<Null> get onPageTitleUpdated => _pageTitleUpdated.stream;

  EventEmitterGlue<Null> _close;

  Stream<Null> get onClose => _close.stream;

  EventEmitterGlue<Null> _closed;

  Stream<Null> get onClosed => _closed.stream;

  EventEmitterGlue<Null> _unresponsive;

  Stream<Null> get onUnresponsive => _unresponsive.stream;

  EventEmitterGlue<Null> _responsive;

  Stream<Null> get onResponsive => _responsive.stream;

  EventEmitterGlue<Null> _blur;

  Stream<Null> get onBlur => _blur.stream;

  EventEmitterGlue<Null> _focus;

  Stream<Null> get onFocus => _focus.stream;

  EventEmitterGlue<Null> _show;

  Stream<Null> get onShow => _show.stream;

  EventEmitterGlue<Null> _hide;

  Stream<Null> get onHide => _hide.stream;

  EventEmitterGlue<Null> _readyToShow;

  Stream<Null> get onReadyToShow => _readyToShow.stream;

  EventEmitterGlue<Null> _maximize;

  Stream<Null> get onMaximize => _maximize.stream;

  EventEmitterGlue<Null> _unmaximize;

  Stream<Null> get onUnmaximize => _unmaximize.stream;

  EventEmitterGlue<Null> _minimize;

  Stream<Null> get onMinimize => _minimize.stream;

  EventEmitterGlue<Null> _restore;

  Stream<Null> get onRestore => _restore.stream;

  EventEmitterGlue<Null> _resize;

  Stream<Null> get onResize => _resize.stream;

  EventEmitterGlue<Null> _move;

  Stream<Null> get onMove => _move.stream;

  EventEmitterGlue<Null> _moved;

  Stream<Null> get onMoved => _moved.stream;

  EventEmitterGlue<Null> _enterFullScreen;

  Stream<Null> get onEnterFullScreen => _enterFullScreen.stream;

  EventEmitterGlue<Null> _leaveFullScreen;

  Stream<Null> get onLeaveFullScreen => _leaveFullScreen.stream;

  EventEmitterGlue<Null> _enterHtmlFullScreen;

  Stream<Null> get onEnterHtmlFullScreen => _enterHtmlFullScreen.stream;

  EventEmitterGlue<Null> _leaveHtmlFullScreen;

  Stream<Null> get onLeaveHtmlFullScreen => _leaveHtmlFullScreen.stream;

  EventEmitterGlue<Null> _appCommand;

  Stream<Null> get onAppCommand => _appCommand.stream;

  EventEmitterGlue<Null> _scrollTouchBegin;

  Stream<Null> get onScrollTouchBegin => _scrollTouchBegin.stream;

  EventEmitterGlue<Null> _scrollTouchEnd;

  Stream<Null> get onScrollTouchEnd => _scrollTouchEnd.stream;

  EventEmitterGlue<Null> _swipe;

  Stream<Null> get onSwipe => _swipe.stream;

  void _initAllEventStreams() {
    _pageTitleUpdated = new EventEmitterGlue<Null>(this, "page-title-updated",
        (dynamic a1, dynamic a2) => _pageTitleUpdated.add());

    _close = new EventEmitterGlue<Null>(this, "close");

    _closed = new EventEmitterGlue<Null>(this, "closed");

    _unresponsive = new EventEmitterGlue<Null>(this, "unresponsive");

    _responsive = new EventEmitterGlue<Null>(this, "responsive");

    _blur = new EventEmitterGlue<Null>(this, "blur");

    _focus = new EventEmitterGlue<Null>(this, "focus");

    _show = new EventEmitterGlue<Null>(this, "show");

    _hide = new EventEmitterGlue<Null>(this, "hide");

    _readyToShow = new EventEmitterGlue<Null>(this, "ready-to-show");

    _maximize = new EventEmitterGlue<Null>(this, "maximize");

    _unmaximize = new EventEmitterGlue<Null>(this, "unmaximize");

    _minimize = new EventEmitterGlue<Null>(this, "minimize");

    _restore = new EventEmitterGlue<Null>(this, "restore");

    _resize = new EventEmitterGlue<Null>(this, "resize");

    _move = new EventEmitterGlue<Null>(this, "move");

    _moved = new EventEmitterGlue<Null>(this, "moved");

    _enterFullScreen = new EventEmitterGlue<Null>(this, "enter-full-screen");

    _leaveFullScreen = new EventEmitterGlue<Null>(this, "leave-full-screen");

    _enterHtmlFullScreen =
        new EventEmitterGlue<Null>(this, "enter-html-full-screen");

    _leaveHtmlFullScreen =
        new EventEmitterGlue<Null>(this, "leave-html-full-screen");

    _appCommand = new EventEmitterGlue<Null>(this, "app-command");

    _scrollTouchBegin = new EventEmitterGlue<Null>(this, "scroll-touch-begin");

    _scrollTouchEnd = new EventEmitterGlue<Null>(this, "scroll-touch-end");

    _swipe = new EventEmitterGlue<Null>(this, "swipe");
  }

  /// Returns an array of all opened browser windows.
  static List<BrowserWindow> getAllWindows() =>
      NativeJsBrowserWindow.getAllWindows().map((NativeJsBrowserWindow window) {
        return new BrowserWindow.fromNativeJsBrowserWindow(window);
      }).toList();

  /// Returns the window that is focused in this application, otherwise returns null.
  static BrowserWindow getFocusedWindow() =>
      new BrowserWindow.fromNativeJsBrowserWindow(
          NativeJsBrowserWindow.getFocusedWindow());

  /// Find a window according to the webContents it owns.
  static BrowserWindow fromWebContents(WebContents webContents) =>
      new BrowserWindow.fromNativeJsBrowserWindow(
          NativeJsBrowserWindow.fromWebContents(webContents.nativeJs));

  /// Find a window according to its ID.
  static BrowserWindow fromId(int id) =>
      new BrowserWindow.fromNativeJsBrowserWindow(
          NativeJsBrowserWindow.fromId(id));

  /// Adds DevTools extension located at path, and returns extension’s name.
  /// The extension will be remembered so you only need to call this API once,
  /// this API is not for programming use. If you try to add an extension that
  /// has already been loaded, this method will not return and instead log a
  /// warning to the console.
  ///
  /// The method will also not return if the extension’s manifest is missing or incomplete.
  ///
  /// Note: This API cannot be called before the ready event of the app module is emitted.
  static String addDevToolsExtension(String path) =>
      NativeJsBrowserWindow.addDevToolsExtension(path);

  /// Remove a DevTools extension by name.
  ///
  /// Note: This API cannot be called before the ready event of the app module is emitted.
  static void removeDevToolsExtension(String name) =>
      NativeJsBrowserWindow.removeDevToolsExtension(name);

  ///  Returns an Object where the keys are the extension names and each value is an Object containing name and version properties.
  ///
  /// To check if a DevTools extension is installed you can run the following:
  ///
  /// const {BrowserWindow} = require('electron')
  ///
  /// let installed = BrowserWindow.getDevToolsExtensions().hasOwnProperty('devtron')
  /// console.log(installed)
  /// Note: This API cannot be called before the ready event of the app module is emitted.
  static Map<String, DevToolsExtensionsInfo> getDevToolsExtensions() =>
      NativeJsBrowserWindow.getDevToolsExtensions();

  /// The WebContents object this window owns. All web page related events and
  /// operations will be done via it.
  WebContents get webContents => new WebContents.fromNativeJsWebContent(_nativeJs.webContents);

  /// The unique ID of the window.
  int get id => _nativeJs.id;

  /// Force closing the window, the unload and beforeunload event won’t be emitted
  /// for the web page, and close event will also not be emitted for this window,
  /// but it guarantees the closed event will be emitted.
  void destroy() => _nativeJs.destroy();

  /// Try to close the window. This has the same effect as a user manually
  /// clicking the close button of the window. The web page may cancel the
  /// close though. See the close event.
  void close() => _nativeJs.close();

  /// Focuses on the window.
  void focus() => _nativeJs.focus();

  /// Removes focus from the window.
  void blur() => _nativeJs.blur();

  /// Returns a boolean, whether the window is focused.
  bool isFocused() => _nativeJs.isFocused();

  /// Returns a boolean, whether the window is destroyed.
  bool isDestroyed() => _nativeJs.isDestroyed();

  /// Shows and gives focus to the window.
  void show() => _nativeJs.show();

  /// Shows the window but doesn’t focus on it.
  void showInactive() => _nativeJs.showInactive();

  /// Hides the window.
  void hide() => _nativeJs.hide();

  /// Returns a boolean, whether the window is visible to the user.
  bool isVisible() => _nativeJs.isVisible();

  /// Returns a boolean, whether current window is a modal window.
  bool isModal() => _nativeJs.isModal();

  /// Maximizes the window.
  void maximize() => _nativeJs.maximize();

  /// Unmaximizes the window.
  void unmaximize() => _nativeJs.unmaximize();

  /// Returns a boolean, whether the window is maximized.
  bool isMaximized() => _nativeJs.isMaximized();

  /// Minimizes the window. On some platforms the minimized window will be shown in the Dock.
  void minimize() => _nativeJs.minimize();

  /// Restores the window from minimized state to its previous state.
  void restore() => _nativeJs.restore();

  /// Returns a boolean, whether the window is minimized.
  bool isMinimized() => _nativeJs.isMinimized();

  /// Sets whether the window should be in fullscreen mode.
  void setFullScreen(bool flag) => _nativeJs.setFullScreen(flag);

  /// Returns a boolean, whether the window is in fullscreen mode.
  bool isFullScreen() => _nativeJs.isFullScreen();

  /// This will make a window maintain an aspect ratio. The extra size allows a
  /// developer to have space, specified in pixels, not included within the
  /// aspect ratio calculations. This API already takes into account the
  /// difference between a window’s size and its content size.
  ///
  ///   aspectRatio Float - The aspect ratio to maintain for some portion of the content view.
  ///   extraSize Object (optional) - The extra size not to be included while maintaining the aspect ratio.
  ///
  /// Consider a normal window with an HD video player and associated controls.
  /// Perhaps there are 15 pixels of controls on the left edge, 25 pixels of
  /// controls on the right edge and 50 pixels of controls below the player.
  /// In order to maintain a 16:9 aspect ratio (standard aspect ratio for
  /// HD @1920x1080) within the player itself we would call this function with
  /// arguments of 16/9 and [ 40, 50 ]. The second argument doesn’t care where
  /// the extra width and height are within the content view–only that they exist.
  /// Just sum any extra width and height areas you have within the overall content view.
  void setAspectRatio(double aspectRatio, [AspectRatioExtraSize extraSize]) =>
      _nativeJs.setAspectRatio(aspectRatio, extraSize);

  /// Resizes and moves the window to width, height, x, y.
  void setBounds(Bounds options, [bool animate]) =>
      _nativeJs.setBounds(options, animate);

  /// Returns an object that contains window’s width, height, x and y values.
  Bounds getBounds() => _nativeJs.getBounds();

  /// Resizes and moves the window’s client area (e.g. the web page) to width, height, x, y.
  void setContentBounds(Bounds options, [bool animate]) =>
      _nativeJs.setContentBounds(options, animate);

  /// Returns an object that contains the window’s client area (e.g. the web page)
  /// width, height, x and y values.
  Bounds getContentBounds() => _nativeJs.getContentBounds();

  /// Resizes the window to width and height.
  void setSize(int width, int height, [bool animate]) =>
      _nativeJs.setSize(width, height, animate);

  /// Returns an array that contains window’s width and height.
  List<int> getSize() => _nativeJs.getSize();

  /// Resizes the window’s client area (e.g. the web page) to width and height.
  void setContentSize(int width, int height, [bool animate]) =>
      _nativeJs.setContentSize(width, height, animate);

  /// Returns an array that contains window’s client area’s width and height.
  List<int> getContentSize() => _nativeJs.getContentSize();

  /// Sets the minimum size of window to width and height.
  void setMinimumSize(int width, int height) =>
      _nativeJs.setMinimumSize(width, height);

  /// Returns an array that contains window’s minimum width and height.
  List<int> getMinimumSize() => _nativeJs.getMinimumSize();

  /// Sets the maximum size of window to width and height.
  void setMaximumSize(int width, int height) =>
      _nativeJs.setMaximumSize(width, height);

  /// Returns an array that contains window’s maximum width and height.
  List<int> getMaximumSize() => _nativeJs.getMaximumSize();

  /// Sets whether the window can be manually resized by user.
  void setResizable(bool resizable) => _nativeJs.setResizable(resizable);

  /// Returns whether the window can be manually resized by user.
  bool isResizable() => _nativeJs.isResizable();

  /// Sets whether the window can be moved by user. On Linux does nothing.
  void setMovable(bool movable) => _nativeJs.setMovable(movable);

  /// Returns whether the window can be moved by user. On Linux always returns true.
  bool isMovable() => _nativeJs.isMovable();

  /// Sets whether the window can be manually minimized by user. On Linux does nothing.
  void setMinimizable(bool minimizable) =>
      _nativeJs.setMinimizable(minimizable);

  /// Returns whether the window can be manually minimized by user. On Linux
  /// always returns true.
  bool isMinimizable() => _nativeJs.isMinimizable();

  /// Sets whether the window can be manually maximized by user. On Linux does
  /// nothing.
  void setMaximizable(bool maximizable) =>
      _nativeJs.setMaximizable(maximizable);

  /// Returns whether the window can be manually maximized by user. On Linux always returns true.
  bool isMaximizable() => _nativeJs.isMaximizable();

  /// Sets whether the maximize/zoom window button toggles fullscreen mode or maximizes the window.
  void setFullScreenable(bool fullscreenable) =>
      _nativeJs.setFullScreenable(fullscreenable);

  /// Returns whether the maximize/zoom window button toggles fullscreen mode or maximizes the window.
  bool isFullScreenable() => _nativeJs.isFullScreenable();

  /// Sets whether the window can be manually closed by user. On Linux does nothing.
  void setClosable(bool closable) => _nativeJs.setClosable(closable);

  /// Returns whether the window can be manually closed by user. On Linux always returns true.
  bool isClosable() => _nativeJs.isClosable();

  /// Sets whether the window should show always on top of other windows. After
  /// setting this, the window is still a normal window, not a toolbox window
  /// which can not be focused on.
  void setAlwaysOnTop(bool flag) => _nativeJs.setAlwaysOnTop(flag);

  /// Returns whether the window is always on top of other windows.
  bool isAlwaysOnTop() => _nativeJs.isAlwaysOnTop();

  /// Moves window to the center of the screen.
  void center() => _nativeJs.center();

  /// Moves window to x and y.
  void setPosition(int x, int y, [bool animate]) =>
      _nativeJs.setPosition(x, y, animate);

  /// Returns an array that contains window’s current position.
  List<int> getPosition() => _nativeJs.getPosition();

  /// Changes the title of native window to title.
  String setTitle(String title) => _nativeJs.setTitle(title);

  /// Returns the title of the native window.
  /// Note: The title of web page can be different from the title of the native window.
  String getTitle() => _nativeJs.getTitle();

  /// Changes the attachment point for sheets on macOS. By default, sheets are
  /// attached just below the window frame, but you may want to display them
  /// beneath a HTML-rendered toolbar. For example:
  ///
  ///     const {BrowserWindow} = require('electron')
  ///     let win = new BrowserWindow()
  ///
  ///     let toolbarRect = document.getElementById('toolbar').getBoundingClientRect()
  ///     win.setSheetOffset(toolbarRect.height)
  void setSheetOffset(double offsetY, [double offsetX]) =>
      _nativeJs.setSheetOffset(offsetY, offsetX);

  /// Starts or stops flashing the window to attract user’s attention.
  void flashFrame(bool flag) => _nativeJs.flashFrame(flag);

  /// Makes the window not show in the taskbar.
  void setSkipTaskbar(bool skip) => _nativeJs.setSkipTaskbar(skip);

  /// Enters or leaves the kiosk mode.
  void setKiosk(bool flag) => _nativeJs.setKiosk(flag);

  /// Returns whether the window is in kiosk mode.
  bool isKiosk() => _nativeJs.isKiosk();

  /// Returns the platform-specific handle of the window as Buffer.
  ///
  /// The native type of the handle is HWND on Windows, NSView* on macOS, and Window (unsigned long) on Linux.
  Buffer getNativeWindowHandle() => _nativeJs.getNativeWindowHandle();

  /// Hooks a windows message. The callback is called when the message is received in the WndProc.
  bool hookWindowMessage(int message, Function callback) =>
      _nativeJs.hookWindowMessage(message, callback);

  /// Returns true or false depending on whether the message is hooked.
  bool isWindowMessageHooked(int message) =>
      _nativeJs.isWindowMessageHooked(message);

  /// Unhook the window message.
  void unhookWindowMessage(int message) =>
      _nativeJs.unhookWindowMessage(message);

  /// Unhooks all of the window messages.
  void unhookAllWindowMessages() => _nativeJs.unhookAllWindowMessages();

  /// Sets the pathname of the file the window represents, and the icon of the file will show in window’s title bar.
  void setRepresentedFilename(String filename) =>
      _nativeJs.setRepresentedFilename(filename);

  /// Returns the pathname of the file the window represents.
  String getRepresentedFilename() => _nativeJs.getRepresentedFilename();

  /// Specifies whether the window’s document has been edited, and the icon in title bar will become gray when set to true.
  void setDocumentEdited(bool edited) => _nativeJs.setDocumentEdited(edited);

  /// Whether the window’s document has been edited.
  bool isDocumentEdited() => _nativeJs.isDocumentEdited();

  void focusOnWebView() => _nativeJs.focusOnWebView();

  void blurWebView() => _nativeJs.blurWebView();

  /// Same as webContents.capturePage([rect, ]callback).
  /// rect (optional) - The area of the page to be captured
  void capturePage(Bounds rect, Function callback) =>
      _nativeJs.capturePage(rect, callback);

  /// Same as webContents.loadURL(url[, options]).
  ///
  /// The url can be a remote address (e.g. http://) or a path to a local HTML file using the file:// protocol.
  //
  /// To ensure that file URLs are properly formatted, it is recommended to use Node’s url.format method:
  ///
  ///  let url = require('url').format({
  ///   protocol: 'file',
  ///    slashes: true,
  ///    pathname: require('path').join(__dirname, 'index.html')
  ///  })
  ///
  /// win.loadURL(url)
  void loadURL(String url, [LoadURLOptions options]) =>
      _nativeJs.loadURL(url, options);

  /// Same as webContents.reload.
  void reload() => _nativeJs.reload();

  /// Sets the menu as the window’s menu bar, setting it to null will remove the menu bar.
  void setMenu(Menu menu) => _nativeJs.setMenu(menu.nativeJs);

  /// Sets progress value in progress bar. Valid range is [0, 1.0].
  ///
  /// Remove progress bar when progress < 0; Change to indeterminate mode when progress > 1.
  ///
  /// On Linux platform, only supports Unity desktop environment, you need to specify the *.desktop file name to desktopName field in package.json. By default, it will assume app.getName().desktop.
  ///
  /// On Windows, a mode can be passed. Accepted values are none, normal, indeterminate, error, and paused. If you call setProgressBar without a mode set (but with a value within the valid range), normal will be assumed.
  void setProgressBar(double progress, [ProgressBarOptions options]) =>
      _nativeJs.setProgressBar(progress, options);

  /// Sets a 16 x 16 pixel overlay onto the current taskbar icon, usually used to
  /// convey some sort of application status or to passively notify the user.
  void setOverlayIcon(NativeImage overlay, String description) =>
      _nativeJs.setOverlayIcon(overlay.nativeJs, description);

  /// Sets whether the window should have a shadow. On Windows and Linux does nothing.
  void setHasShadow(bool hasShadow) => _nativeJs.setHasShadow(hasShadow);

  /// Returns whether the window has a shadow. On Windows and Linux always returns true.
  bool hasShadow() => _nativeJs.hasShadow();

  /// Add a thumbnail toolbar with a specified set of buttons to the thumbnail
  /// image of a window in a taskbar button layout. Returns a Boolean object
  /// indicates whether the thumbnail has been added successfully.
  ///
  /// The number of buttons in thumbnail toolbar should be no greater than 7 due
  /// to the limited room. Once you setup the thumbnail toolbar, the toolbar
  /// cannot be removed due to the platform’s limitation. But you can call the
  /// API with an empty array to clean the buttons.
  bool setThumbarButtons(List<Button> buttons) =>
      _nativeJs.setThumbarButtons(buttons);

  /// Sets the region of the window to show as the thumbnail image displayed when
  /// hovering over the window in the taskbar. You can reset the thumbnail to be
  /// the entire window by specifying an empty region: {x: 0, y: 0, width: 0, height: 0}.
  bool setThumbnailClip(Bounds region) => _nativeJs.setThumbnailClip(region);

  /// Sets the toolTip that is displayed when hovering over the window thumbnail
  /// in the taskbar.
  bool setThumbnailToolTip(String toolTip) =>
      _nativeJs.setThumbnailToolTip(toolTip);

  /// Same as webContents.showDefinitionForSelection().
  void showDefinitionForSelection() => _nativeJs.showDefinitionForSelection();

  /// Changes window icon.
  void setIcon(NativeImage icon) => _nativeJs.setIcon(icon.nativeJs);

  /// Sets whether the window menu bar should hide itself automatically. Once set
  /// the menu bar will only show when users press the single Alt key.
  ///
  /// If the menu bar is already visible, calling setAutoHideMenuBar(true) won’t
  /// hide it immediately.
  void setAutoHideMenuBar(bool hide) => _nativeJs.setAutoHideMenuBar(hide);

  /// Returns whether menu bar automatically hides itself.
  bool isMenuBarAutoHide() => _nativeJs.isMenuBarAutoHide();

  /// Sets whether the menu bar should be visible. If the menu bar is auto-hide,
  /// users can still bring up the menu bar by pressing the single Alt key.
  void setMenuBarVisibility(bool visible) =>
      _nativeJs.setMenuBarVisibility(visible);

  /// Returns whether the menu bar is visible.
  bool isMenuBarVisible() => _nativeJs.isMenuBarVisible();

  /// Sets whether the window should be visible on all workspaces.
  ///
  /// Note: This API does nothing on Windows.
  void setVisibleOnAllWorkspaces(bool visible) =>
      _nativeJs.setVisibleOnAllWorkspaces(visible);

  /// Returns whether the window is visible on all workspaces.
  ///
  /// Note: This API always returns false on Windows.
  bool isVisibleOnAllWorkspaces() => _nativeJs.isVisibleOnAllWorkspaces();

  /// Makes the window ignore all mouse events.
  ///
  /// All mouse events happened in this window will be passed to the window below
  /// this window, but if this window has focus, it will still receive keyboard events.
  void setIgnoreMouseEvents(bool ignore) =>
      _nativeJs.setIgnoreMouseEvents(ignore);

  /// Prevents the window contents from being captured by other apps.
  ///
  /// On macOS it sets the NSWindow’s sharingType to NSWindowSharingNone. On Windows
  /// it calls SetWindowDisplayAffinity with WDA_MONITOR.
  void setContentProtection(bool enable) =>
      _nativeJs.setContentProtection(enable);

  /// Changes whether the window can be focused.
  void setFocusable(bool focusable) => _nativeJs.setFocusable(focusable);

  /// Sets parent as current window’s parent window, passing null will turn current
  /// window into a top-level window.
  void setParentWindow(BrowserWindow parent) =>
      _nativeJs.setParentWindow(parent._nativeJs);

  /// Returns the parent window.
  BrowserWindow getParentWindow() => _nativeJs.getParentWindow();

  /// Returns all child windows.
  List<BrowserWindow> getChildWindows() => _nativeJs.getChildWindows();
}
