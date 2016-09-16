// Copyright (c) 2016, electron.dart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of electron.main.web_contents;

@JS()
@anonymous
class FindInPageOptions {
  external const factory FindInPageOptions(
      {bool forward,
      bool findNext,
      bool matchCase,
      bool wordStart,
      bool medialCapitalAsWordStart});

  /// Whether to search forward or backward, defaults to true.
  external bool get forward;

  /// Whether the operation is first request or a follow up, defaults to false.
  external bool get findNext;

  /// Whether search should be case-sensitive, defaults to false.
  external bool get matchCase;

  /// Whether to look only at the start of words. defaults to false.
  external bool get wordStart;

  /// When combined with wordStart, accepts a match in the middle of a word if
  /// the match begins with an uppercase letter followed by a lowercase or
  /// non-letter. Accepts several other intra-word matches, defaults to false.
  external bool get medialCapitalAsWordStart;
}
