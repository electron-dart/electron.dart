part of electron.main.session;

@JS('_electron.session.WebRequest')
class NativeJsWebRequest {
  //TODO
}

class WebRequest {
  NativeJsWebRequest _nativeJsWebRequest;

  WebRequest.fromNativeJsWebRequest(this._nativeJsWebRequest);

  NativeJsWebRequest get nativeJsWebRequest => _nativeJsWebRequest;

  //TODO
}