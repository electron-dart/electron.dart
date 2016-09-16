// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.main.web_contents;

import "package:js/js.dart";
import "package:nodejs/nodejs.dart";

import 'package:electron/src/main/session/session.dart';

part 'debugger.dart';

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

@JS('_electron.webContents.WebContents')
class NativeJsWebContents extends NativeJsEventEmitter {
  //TODO

  /// Loads the url in the window. The url must contain the protocol prefix,
  /// e.g. the http:// or file://. If the load should bypass http cache
  /// then use the pragma header to achieve it.
  external void loadURL(String url, [LoadURLOptions options]);

  /// Initiates a download of the resource at url without navigating. The
  /// will-download event of session will be triggered.
  external void downloadURL(String url);

  /// Returns URL of the current web page.
  external String getURL();

  /// Returns the title of the current web page.
  external String getTitle();

  /// Returns a Boolean, whether the web page is destroyed.
  external bool isDestroyed();

  /// Returns a Boolean, whether the web page is focused.
  external bool isFocused();

  /// Returns whether web page is still loading resources.
  external bool isLoading();

  /// Returns whether the main frame (and not just iframes or frames within it)
  /// is still loading.
  external bool isLoadingMainFrame();

  /// Returns whether the web page is waiting for a first-response from the main
  /// resource of the page.
  external bool isWaitingForResponse();

  /// Stops any pending navigation.
  external void stop();

  /// Reloads the current web page.
  external void reload();

  /// Reloads current page and ignores cache.
  external void reloadIgnoringCache();

  /// Returns whether the browser can go back to previous web page.
  external bool canGoBack();

  /// Returns whether the browser can go forward to next web page.
  external bool canGoForward();

  /// Returns whether the web page can go to offset.
  external bool canGoToOffset(int offset);

  /// Clears the navigation history.
  external void clearHistory();

  /// Makes the browser go back a web page.
  external void goBack();

  /// Makes the browser go forward a web page.
  external void goForward();

  /// Navigates browser to the specified absolute web page index.
  external void goToIndex(int index);

  /// Navigates to the specified offset from the “current entry”.
  external void goToOffset(int offset);

  /// Whether the renderer process has crashed.
  external bool isCrashed();

  /// Overrides the user agent for this web page.
  external void setUserAgent(String userAgent);

  /// Returns a String representing the user agent for this web page.
  external String getUserAgent();

  /// Injects CSS into the current web page.
  external void insertCSS(String css);

  /// Evaluates code in page.
  ///
  /// In the browser window some HTML APIs like requestFullScreen can only be
  /// invoked by a gesture from the user. Setting userGesture to true will
  /// remove this limitation.
  external void executeJavaScript(String code, [bool userGesture, Function callback]);

  /// Mute the audio on the current web page.
  external void setAudioMuted(bool muted);

  /// Returns whether this page has been muted.
  external bool isAudioMuted();

  /// Changes the zoom factor to the specified factor. Zoom factor is zoom
  /// percent divided by 100, so 300% = 3.0.
  external void setZoomFactor(num factor);

  /// Sends a request to get current zoom factor, the callback will be called
  /// with callback(zoomFactor).
  external void getZoomFactor(Function callback);

  /// Changes the zoom level to the specified level. The original size is 0 and
  /// each increment above or below represents zooming 20% larger or smaller
  /// to default limits of 300% and 50% of original size, respectively.
  external void setZoomLevel(num level);

  /// Sends a request to get current zoom level, the callback will be called
  /// with callback(zoomLevel).
  external void getZoomLevel(Function callback);

  /// Sets the maximum and minimum zoom level.
  external void setZoomLevelLimits(num minimumLevel, num maximumLevel);

  /// Executes the editing command undo in web page.
  external void undo();

  /// Executes the editing command redo in web page.
  external void redo();

  /// Executes the editing command cut in web page.
  external void cut();

  /// Executes the editing command copy in web page.
  external void copy();

  /// Copy the image at the given position to the clipboard.
  external void copyImageAt(int x, int y);

  /// Executes the editing command paste in web page.
  external void paste();

  /// Executes the editing command pasteAndMatchStyle in web page.
  external void pasteAndMatchStyle();

  /// Executes the editing command delete in web page.
  external void delete();

  /// Executes the editing command selectAll in web page.
  external void selectAll();

  /// Executes the editing command unselect in web page.
  external void unselect();

  /// Executes the editing command replace in web page.
  external void replace(String text);

  /// Executes the editing command replaceMisspelling in web page.
  external void replaceMisspelling(String text);

  /// Inserts text to the focused element.
  external void insertText(String text);

  //TODO findInPage

  //TODO stopFindInPage

//TODO capturePage

  /// Checks if any ServiceWorker is registered and returns a boolean as response to callback.
  external void hasServiceWorker(Function callback);

  /// Unregisters any ServiceWorker if present and returns a boolean as response
  /// to callback when the JS promise is fulfilled or false when the JS promise is rejected.
  external void unregisterServiceWorker(Function callback);

  //TODO print

  //TODO   printToPDF

  /// Adds the specified path to DevTools workspace.
  external void addWorkSpace(String path);

  /// Removes the specified path from DevTools workspace.
  external void removeWorkSpace(String path);

  //TODO openDevTools

  /// Closes the devtools.
  external void closeDevTools();

  /// Returns whether the devtools is opened.
  external bool isDevToolsOpened();

  /// Returns whether the devtools view is focused .
  external bool isDevToolsFocused();

  /// Toggles the developer tools.
  external void toggleDevTools();

  /// Starts inspecting element at position (x, y).
  external void inspectElement(int x, int y);

  /// Opens the developer tools for the service worker context.
  external void inspectServiceWorker();

  /// Send an asynchronous message to renderer process via channel, you can
  /// also send arbitrary arguments. Arguments will be serialized in JSON
  /// internally and hence no functions or prototype chain will be included.
  ///
  /// The renderer process can handle the message by listening to channel with
  /// the ipcRenderer module.
  external void send(String channel, dynamic data);

  //TODO enableDeviceEmulation

  /// Disable device emulation enabled by webContents.enableDeviceEmulation.
  external void disableDeviceEmulation();

  //TODO sendInputEvent

  //TODO

  /// Shows pop-up dictionary that searches the selected word on the page.
  external void showDefinitionForSelection();

  /// Indicates whether offscreen rendering is enabled.
  external bool isOffscreen();

  /// If offscreen rendering is enabled and not painting, start painting.
  external void startPainting();

  /// If offscreen rendering is enabled and painting, stop painting.
  external void stopPainting();

  /// If offscreen rendering is enabled returns whether it is currently painting.
  external bool isPainting();

  /// If offscreen rendering is enabled sets the frame rate to the specified
  /// number. Only values between 1 and 60 are accepted.
  external void setFrameRate(int fps);

  /// If offscreen rendering is enabled returns the current frame rate.
  external int getFrameRate();

  /// The unique ID of this WebContents.
  external int get id;

  /// Returns the session object used by this webContents.
  external NativeJsSession get session;

  /// Returns the WebContents that might own this WebContents.
  external NativeJsWebContents get hostWebContents;

  /// Get the WebContents of DevTools for this WebContents.
  ///
  /// Note: Users should never store this object because it may become null when
  /// the DevTools has been closed.
  external NativeJsWebContents get devToolsWebContents;

  /// Get the debugger instance for this webContents.
  external NativeJsDebugger get debugger;
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
