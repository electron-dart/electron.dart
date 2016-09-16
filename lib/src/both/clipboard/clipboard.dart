// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.renderer.clipboard;

import "package:js/js.dart";

import 'package:electron/src/both/native_image/native_image.dart';

@JS()
@anonymous
class WriteClipboardData {
  external const factory WriteClipboardData(
      {String text,
      String html,
      NativeImage image,
      String rtf,
      String bookmark});

  external String get text;

  external String get html;

  external NativeImage get image;

  external String get rtf;

  /// The title of the url at text.
  external String get bookmark;
}

@JS()
@anonymous
class BookmarkInfo {
  external const factory BookmarkInfo({String title, String url});

  external String get title;

  external String get url;
}

/// Returns the content in the clipboard as plain text.
@JS('_electron.clipboard.readText')
external String _readText([String type]);

/// Writes the text into the clipboard as plain text.
@JS('_electron.clipboard.writeText')
external void _writeText(String text, [String type]);

/// Returns the content in the clipboard as markup.
@JS('_electron.clipboard.readHTML')
external String _readHTML([String type]);

/// Writes markup to the clipboard.
@JS('_electron.clipboard.writeHTML')
external void _writeHTML(String markup, [String type]);

/// Returns the content in the clipboard as a NativeImage.
@JS('_electron.clipboard.readImage')
external NativeImage _readImage([String type]);

/// Writes image to the clipboard.
@JS('_electron.clipboard.writeImage')
external void _writeImage(NativeImage image, [String type]);

/// Returns the content in the clipboard as RTF.
@JS('_electron.clipboard.readRTF')
external String _readRTF([String type]);

/// Writes the text into the clipboard in RTF.
@JS('_electron.clipboard.writeRTF')
external void _writeRTF(String text, [String type]);

/// Returns an Object containing title and url keys representing the bookmark in
/// the clipboard. The title and url values will be empty strings when the
/// bookmark is unavailable.
@JS('_electron.clipboard.readBookmark')
external BookmarkInfo _readBookmark();

/// Writes the title and url into the clipboard as a bookmark.
@JS('_electron.clipboard.writeBookmark')
external void _writeBookmark(String title, String url, [String type]);

/// Clears the clipboard content.
@JS('_electron.clipboard.clear')
external void _clear([String type]);

/// Returns an array of supported formats for the clipboard type.
@JS('_electron.clipboard.availableFormats')
external List<String> _availableFormats([String type]);

/// Returns whether the clipboard supports the format of specified data.
///
/// const {clipboard} = require('electron')
/// console.log(clipboard.has('<p>selection</p>'))
@JS('_electron.clipboard.has')
external bool _has(String data, [String type]);

/// Reads data from the clipboard.
@JS('_electron.clipboard.read')
external String _read(String data, [String type]);

/// Writes data to the clipboard.
///
/// const {clipboard} = require('electron')
/// clipboard.write({text: 'test', html: '<b>test</b>'})
@JS('_electron.clipboard.write')
external void _write(WriteClipboardData data, [String type]);

class Clipboard {
  static String readText([String type]) => _readText(type);

  static void writeText(String text, [String type]) => _writeText(text, type);

  static String readHTML([String type]) => _readHTML(type);

  static void writeHTML(String markup, [String type]) => _writeHTML(markup, type);

  static NativeImage readImage([String type]) => _readImage(type);

  static void writeImage(NativeImage image, [String type]) => _writeImage(image, type);

  static String readRTF([String type]) => _readRTF(type);

  static void writeRTF(String text, [String type]) => _writeRTF(text, type);

  static BookmarkInfo readBookmark() => _readBookmark();

  static void writeBookmark(String title, String url, [String type]) => _writeBookmark(title, url, type);

  static void clear([String type]) => _clear(type);

  static List<String> availableFormats([String type]) => _availableFormats(type);

  static bool has(String data, [String type]) => _has(data, type);

  static String read(String data, [String type]) => _read(data, type);

  static void write(WriteClipboardData data, [String type]) => _write(data, type);
}