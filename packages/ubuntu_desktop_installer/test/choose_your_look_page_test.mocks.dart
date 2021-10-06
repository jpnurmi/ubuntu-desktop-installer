// Mocks generated by Mockito 5.0.14 from annotations
// in ubuntu_desktop_installer/test/choose_your_look_page_test.dart.
// Do not manually edit this file.

import 'dart:ui' as _i2;

import 'package:flutter/material.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:ubuntu_wizard/settings.dart' as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeLocale_0 extends _i1.Fake implements _i2.Locale {}

/// A class which mocks [Settings].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettings extends _i1.Mock implements _i3.Settings {
  MockSettings() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get testAnotherMockChange =>
      (super.noSuchMethod(Invocation.getter(#testAnotherMockChange),
          returnValue: false) as bool);
  @override
  _i4.ThemeMode get theme => (super.noSuchMethod(Invocation.getter(#theme),
      returnValue: _i4.ThemeMode.system) as _i4.ThemeMode);
  @override
  _i2.Locale get locale => (super.noSuchMethod(Invocation.getter(#locale),
      returnValue: _FakeLocale_0()) as _i2.Locale);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  void applyTheme(_i2.Brightness? brightness) =>
      super.noSuchMethod(Invocation.method(#applyTheme, [brightness]),
          returnValueForMissingStub: null);
  @override
  void applyLocale(_i2.Locale? locale) =>
      super.noSuchMethod(Invocation.method(#applyLocale, [locale]),
          returnValueForMissingStub: null);
  @override
  void addListener(_i2.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i2.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
