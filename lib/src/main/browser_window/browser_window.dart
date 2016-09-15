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
class LoadURLOptions {
  /// A HTTP Referrer url.
  String httpReferrer;

  /// A user agent originating the request.
  String userAgent;

  /// Extra headers separated by “\n”
  String extraHeaders;
}

@JS()
@anonymous
class ProgressBarOptions {
/// Mode for the progres bar (none, normal, indeterminate, error, or paused)
String mode;
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
  external void setAspectRatio(double aspectRatio, [ AspectRatioExtraSize extraSize]);

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
  external String setTitle(title);

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
  external void setMenu(Menu menu);

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
  external void setOverlayIcon(NativeImage overlay, String description);

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
  external void setIcon(NativeImage icon);

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
  external void setParentWindow(BrowserWindow parent);

  /// Returns the parent window.
  external BrowserWindow getParentWindow();

  /// Returns all child windows.
  external List<BrowserWindow> getChildWindows();
}

const BrowserWindowOptions defaultBrowserWindowOptions =
    const BrowserWindowOptions();

class BrowserWindow extends EventEmitter {
  NativeJsBrowserWindow _browserWindow;

  StreamController<Null> _closed;

  BrowserWindow([BrowserWindowOptions options = defaultBrowserWindowOptions]) {
    _browserWindow = new NativeJsBrowserWindow(options);
    _initAllStreamController();
  }

  Stream<Null> get onClosed => _closed.stream;

  void loadURL(String url) => _browserWindow.loadURL(url);

  void show() => _browserWindow.show();

  void _initAllStreamController() {
    _closed = new StreamController<Null>(sync: true);
    on('closed', _onClosed);
  }

  void _onClosed([dynamic event]) => _closed.add(null);
}
