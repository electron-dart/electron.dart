part of electron.main.menu;

@JS()
@anonymous
class MenuItemOptions {
  external const factory MenuItemOptions(
      {Function click,
      String role,
      String type,
      String label,
      String sublabel,
      Accelerator accelerator,
      NativeImage icon,
      bool enabled,
      bool visible,
      bool checked,
      Menu submenu,
      String id,
      String position});

  /// Will be called with click(menuItem, browserWindow, event) when the menu
  /// item is clicked.
  external Function get click;

  /// Define the action of the menu item, when specified the click property will
  /// be ignored.
  external String get role;

  /// Can be normal, separator, submenu, checkbox or radio.
  external String get type;

  /// Label on the menu item.
  external String get label;

  /// Sub lable on the menu item.
  external String get sublabel;

  /// Accelerator
  external Accelerator get accelerator;

  /// Icon on the menu item.
  external NativeImage get icon;

  /// If false, the menu item will be greyed out and unclickable.
  external bool get enabled;

  /// If false, the menu item will be entirely hidden.
  external bool get visible;

  /// Should only be specified for checkbox or radio type menu items.
  external bool get checked;

  /// Should be specified for submenu type menu items. If submenu is specified,
  /// the type: 'submenu' can be omitted. If the value is not a Menu then it
  /// will be automatically converted to one using Menu.buildFromTemplate.
  external Menu get submenu;

  /// Unique within a single menu. If defined then it can be used as a reference to this item by the position attribute.
  external String get id;

  /// This field allows fine-grained definition of the specific location within a given menu.
  external String get position;
}

@JS('_electron.MenuItem')
class MenuItem {
  external MenuItem(MenuItemOptions options);

  /// A Boolean indicating whether the item is enabled, this property can be dynamically changed.
  external bool get enabled;

  /// A Boolean indicating whether the item is visible, this property can be dynamically changed.
  external bool get visible;

  /// A Boolean indicating whether the item is checked, this property can be dynamically changed.
  ///
  /// A checkbox menu item will toggle the checked property on and off when selected.
  ///
  /// A radio menu item will turn on its checked property when clicked, and will turn off that property for all adjacent items in the same menu.
  ///
  /// You can add a click function for additional behavior.
  external bool get checked;
}
