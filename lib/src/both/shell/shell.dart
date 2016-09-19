// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library electron.both.shell;

import 'package:js/js.dart';

@JS()
@anonymous
class NativeJsShell {
  /// Show the given file in a file manager. If possible, select the file. Returns
  /// true if the item was successfully shown, false otherwise.
  external bool showItemInFolder(String fullPath);

  /// Open the given file in the desktop’s default manner. Returns true if the
  /// item was successfully opened, false otherwise.
  external bool openItem(String fullPath);

  /// Open the given external protocol URL in the desktop’s default manner.
  /// (For example, mailto: URLs in the user’s default mail agent.) Returns
  /// true if an application was available to open the URL, false otherwise.
  external bool openExternal(String url, [ShellOpenExternalOptions options]);

  /// Move the given file to trash and returns a boolean status for the operation.
  /// Returns true if the item was successfully moved to the trash, false otherwise.
  external bool moveItemToTrash(String fullPath);

  /// Play the beep sound.
  external void beep();

  /// Creates or updates a shortcut link at shortcutPath. On success true is
  /// returned, otherwise false is returned.
  external bool writeShortcutLink(
      String shortcutPath, String operation, ShellShortcutLinkInfo options);

  /// Resolves the shortcut link at shortcutPath. An object is returned with the
  /// fields described in the options of shell.writeShortcutLink.
  external ShellShortcutLinkInfo readShortcutLink(String shortcutPath);
}

@JS()
@anonymous
class ShellShortcutLinkInfo {
  external factory ShellShortcutLinkInfo(
      {String target,
      String cwd,
      String args,
      String description,
      String icon,
      int iconIndex,
      String appUserModelId});

  /// The target to launch from this shortcut.
  external String get target;

  /// The working directory. Default is empty.
  external String get cwd;

  /// The arguments to be applied to target when launching from this shortcut. Default is empty.
  external String get args;

  /// The description of the shortcut. Default is empty.
  external String get description;

  /// The path to the icon, can be a DLL or EXE. icon and iconIndex have to be set together. Default is empty, which uses the target’s icon.
  external String get icon;

  /// The resource ID of icon when icon is a DLL or EXE. Default is 0.
  external int get iconIndex;

  /// The Application User Model ID. Default is empty.
  external String get appUserModelId;
}

@JS()
@anonymous
class ShellOpenExternalOptions {
  external bool get activate;
}

@JS("_electron.shell")
external NativeJsShell get _shell;

final Shell shell = new Shell._();

class Shell {
  Shell._();

  /// Show the given file in a file manager. If possible, select the file. Returns
  /// true if the item was successfully shown, false otherwise.
  bool showItemInFolder(String fullPath) => _shell.showItemInFolder(fullPath);

  /// Open the given file in the desktop’s default manner. Returns true if the
  /// item was successfully opened, false otherwise.
  bool openItem(String fullPath) => _shell.openItem(fullPath);

  /// Open the given external protocol URL in the desktop’s default manner.
  /// (For example, mailto: URLs in the user’s default mail agent.) Returns
  /// true if an application was available to open the URL, false otherwise.
  bool openExternal(String url, [ShellOpenExternalOptions options]) =>
      _shell.openExternal(url, options);

  /// Move the given file to trash and returns a boolean status for the operation.
  /// Returns true if the item was successfully moved to the trash, false otherwise.
  bool moveItemToTrash(String fullPath) => _shell.moveItemToTrash(fullPath);

  /// Play the beep sound.
  void beep() => _shell.beep();

  /// Creates or updates a shortcut link at shortcutPath. On success true is
  /// returned, otherwise false is returned.
  bool writeShortcutLink(String shortcutPath, String operation,
          ShellShortcutLinkInfo options) =>
      _shell.writeShortcutLink(shortcutPath, operation, options);

  /// Resolves the shortcut link at shortcutPath. An object is returned with the
  /// fields described in the options of shell.writeShortcutLink.
  ShellShortcutLinkInfo readShortcutLink(String shortcutPath) =>
      _shell.readShortcutLink(shortcutPath);
}
