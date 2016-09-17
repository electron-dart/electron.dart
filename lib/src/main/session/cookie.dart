part of electron.main.session;

typedef void CookiesGetCallback(dynamic error, Cookie cookies);

typedef void CookiesSetCallback(dynamic error);

typedef void CookiesRemoveCallback();

@JS()
@anonymous
class CookiesFilterOptions {
  /// Retrieves cookies which are associated with url. Empty implies retrieving
  /// cookies of all urls.
  external String get url;
  /// Filters cookies by name.
  external String get name;
  /// Retrieves cookies whose domains match or are subdomains of domains
  external String get domain;

  /// Retrieves cookies whose path matches path.
  external String get path;

  /// Filters cookies by their Secure property.
  external bool get secure;

  /// Filters out session or persistent cookies.
  external bool get session;
}

@JS()
@anonymous
class CookiesDetailsOption {
  /// The url to associate the cookie with.
  external String get url;

  /// The name of the cookie. Empty by default if omitted.
  external String get name;

  /// The value of the cookie. Empty by default if omitted.
  external String get value;

  /// The domain of the cookie. Empty by default if omitted.
  external String get domain;

  /// The path of the cookie. Empty by default if omitted.
  external String get path;

  /// Whether the cookie should be marked as Secure. Defaults to false.
  external bool get secure;

  /// Whether the cookie should be marked as HTTP only. Defaults to false.
  external bool get httpOnly;

  /// The expiration date of the cookie as the number of seconds since the UNIX
  /// epoch. If omitted then the cookie becomes a session cookie and will not
  /// be retained between sessions.
  external double get expirationDate;
}

@JS()
@anonymous
class Cookie {
  /// The name of the cookie. Empty by default if omitted.
  external String get name;

  /// The value of the cookie. Empty by default if omitted.
  external String get value;

  /// The domain of the cookie. Empty by default if omitted.
  external String get domain;

  /// The path of the cookie. Empty by default if omitted.
  external String get path;

  /// Whether the cookie should be marked as Secure. Defaults to false.
  external bool get secure;

  /// Whether the cookie should be marked as HTTP only. Defaults to false.
  external bool get httpOnly;

  /// Whether the cookie is a session cookie or a persistent cookie with an expiration date.
  external bool get session;

  /// The expiration date of the cookie as the number of seconds since the UNIX
  /// epoch. If omitted then the cookie becomes a session cookie and will not
  /// be retained between sessions.
  external double get expirationDate;
}

@JS('_electron.session.Cookies')
class NativeJsCookies {
  external void get(CookiesFilterOptions filter, CookiesGetCallback callback);

  external void set(CookiesDetailsOption details, CookiesSetCallback callback);

  external void remove(String url, String name, CookiesRemoveCallback callback);
}

class Cookies {
  NativeJsCookies _nativeJsCookies;

  Cookies.fromNativeJsCookies(this._nativeJsCookies);

  NativeJsCookies get nativeJsCookies => _nativeJsCookies;

  void get(CookiesFilterOptions filter, CookiesGetCallback callback) => _nativeJsCookies.get(filter, allowInterop(callback));

  void set(CookiesDetailsOption details, CookiesSetCallback callback) => _nativeJsCookies.set(details, allowInterop(callback));

  void remove(String url, String name, CookiesRemoveCallback callback) => _nativeJsCookies.remove(url, name, allowInterop(callback));
}