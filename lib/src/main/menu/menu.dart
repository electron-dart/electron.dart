@JS()
library electron.main.menu;

import "package:js/js.dart";

import 'package:electron/src/both/native_image/native_image.dart';
import 'package:electron/src/main/accelerator/accelerator.dart';
import 'package:electron/src/main/browser_window/browser_window.dart';

part 'menu_item.dart';

@JS('_electron.Menu')
class Menu {
  /// Creates a new menu.
  external Menu();

  /// Sets menu as the application menu on macOS. On Windows and Linux, the menu
  /// will be set as each window’s top menu.
  ///
  /// Note: This API has to be called after the ready event of app module.
  external static void setApplicationMenu(Menu menu);

  /// Returns the application menu (an instance of Menu), if set, or null, if not set.
  external static Menu getApplicationMenu();

  /// Sends the action to the first responder of application. This is used for
  /// emulating default Cocoa menu behaviors, usually you would just use the role
  /// property of MenuItem.
  ///
  /// See the macOS Cocoa Event Handling Guide for more information on macOS’ native actions.
  external static void sendActionToFirstResponder(String action);

  /// Generally, the template is just an array of options for constructing a MenuItem.
  /// The usage can be referenced above.
  ///
  /// You can also attach other fields to the element of the template and they
  /// will become properties of the constructed menu items.
  external static Menu buildFromTemplate(List<MenuItemOptions> template);

  /// Pops up this menu as a context menu in the browserWindow.
  ///
  /// browserWindow - Default is BrowserWindow.getFocusedWindow().
  /// x - Default is the current mouse cursor position.
  /// y - Default is the current mouse cursor position.
  /// positioningItem - The index of the menu item to be positioned under the
  /// mouse cursor at the specified coordinates. Default is -1.
  external void popup([BrowserWindow browserWindow, num x, num y, num positioningItem]);

  /// Appends the menuItem to the menu.
  external void append(MenuItem menuItem);

  /// Inserts the menuItem to the pos position of the menu.
  external void insert(int pos, MenuItem menuItem);

  /// Get an array containing the menu’s items.
  external List<MenuItem> get items;
}
