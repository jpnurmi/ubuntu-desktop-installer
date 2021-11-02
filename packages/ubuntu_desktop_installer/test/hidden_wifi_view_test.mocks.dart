// Mocks generated by Mockito 5.0.14 from annotations
// in ubuntu_desktop_installer/test/hidden_wifi_view_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import 'package:mockito/mockito.dart' as _i1;
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/connect_model.dart'
    as _i4;
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/hidden_wifi_model.dart'
    as _i3;
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/wifi_model.dart'
    as _i5;
import 'package:ubuntu_desktop_installer/services.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeNetworkManagerDevice_0 extends _i1.Fake
    implements _i2.NetworkManagerDevice {}

/// A class which mocks [HiddenWifiModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockHiddenWifiModel extends _i1.Mock implements _i3.HiddenWifiModel {
  MockHiddenWifiModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get canConnect =>
      (super.noSuchMethod(Invocation.getter(#canConnect), returnValue: false)
          as bool);
  @override
  _i4.ConnectMode get connectMode =>
      (super.noSuchMethod(Invocation.getter(#connectMode),
          returnValue: _i4.ConnectMode.none) as _i4.ConnectMode);
  @override
  String get ssid =>
      (super.noSuchMethod(Invocation.getter(#ssid), returnValue: '') as String);
  @override
  bool get canContinue =>
      (super.noSuchMethod(Invocation.getter(#canContinue), returnValue: false)
          as bool);
  @override
  bool get isActive =>
      (super.noSuchMethod(Invocation.getter(#isActive), returnValue: false)
          as bool);
  @override
  bool get isBusy =>
      (super.noSuchMethod(Invocation.getter(#isBusy), returnValue: false)
          as bool);
  @override
  bool get isEnabled =>
      (super.noSuchMethod(Invocation.getter(#isEnabled), returnValue: false)
          as bool);
  @override
  List<_i5.WifiDeviceModel> get devices =>
      (super.noSuchMethod(Invocation.getter(#devices),
          returnValue: <_i5.WifiDeviceModel>[]) as List<_i5.WifiDeviceModel>);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  void init() => super.noSuchMethod(Invocation.method(#init, []),
      returnValueForMissingStub: null);
  @override
  _i6.Future<void> connect() =>
      (super.noSuchMethod(Invocation.method(#connect, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void setSsid(String? ssid) =>
      super.noSuchMethod(Invocation.method(#setSsid, [ssid]),
          returnValueForMissingStub: null);
  @override
  void enable() => super.noSuchMethod(Invocation.method(#enable, []),
      returnValueForMissingStub: null);
  @override
  void cleanup() => super.noSuchMethod(Invocation.method(#cleanup, []),
      returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  bool isSelectedDevice(_i5.WifiDeviceModel? device) =>
      (super.noSuchMethod(Invocation.method(#isSelectedDevice, [device]),
          returnValue: false) as bool);
  @override
  void selectDevice(_i5.WifiDeviceModel? device) =>
      super.noSuchMethod(Invocation.method(#selectDevice, [device]),
          returnValueForMissingStub: null);
  @override
  _i6.Future<dynamic> requestScan({String? ssid}) =>
      (super.noSuchMethod(Invocation.method(#requestScan, [], {#ssid: ssid}),
          returnValue: Future<dynamic>.value()) as _i6.Future<dynamic>);
  @override
  void addProperties(_i6.Stream<List<String>>? properties) =>
      super.noSuchMethod(Invocation.method(#addProperties, [properties]),
          returnValueForMissingStub: null);
  @override
  void addPropertyListener(String? property, _i7.VoidCallback? onChanged) =>
      super.noSuchMethod(
          Invocation.method(#addPropertyListener, [property, onChanged]),
          returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  void addListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

/// A class which mocks [WifiDeviceModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockWifiDeviceModel extends _i1.Mock implements _i5.WifiDeviceModel {
  MockWifiDeviceModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isActive =>
      (super.noSuchMethod(Invocation.getter(#isActive), returnValue: false)
          as bool);
  @override
  bool get canConnect =>
      (super.noSuchMethod(Invocation.getter(#canConnect), returnValue: false)
          as bool);
  @override
  List<_i5.AccessPointModel> get accessPoints =>
      (super.noSuchMethod(Invocation.getter(#accessPoints),
          returnValue: <_i5.AccessPointModel>[]) as List<_i5.AccessPointModel>);
  @override
  bool get scanning =>
      (super.noSuchMethod(Invocation.getter(#scanning), returnValue: false)
          as bool);
  @override
  int get lastScan =>
      (super.noSuchMethod(Invocation.getter(#lastScan), returnValue: 0) as int);
  @override
  _i2.NetworkManagerDevice get device => (super.noSuchMethod(
      Invocation.getter(#device),
      returnValue: _FakeNetworkManagerDevice_0()) as _i2.NetworkManagerDevice);
  @override
  String get interface =>
      (super.noSuchMethod(Invocation.getter(#interface), returnValue: '')
          as String);
  @override
  _i2.NetworkManagerDeviceState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
              returnValue: _i2.NetworkManagerDeviceState.unknown)
          as _i2.NetworkManagerDeviceState);
  @override
  _i2.NetworkManagerDeviceStateReason get stateReason =>
      (super.noSuchMethod(Invocation.getter(#stateReason),
              returnValue: _i2.NetworkManagerDeviceStateReason.none)
          as _i2.NetworkManagerDeviceStateReason);
  @override
  bool get isBusy =>
      (super.noSuchMethod(Invocation.getter(#isBusy), returnValue: false)
          as bool);
  @override
  bool get isAvailable =>
      (super.noSuchMethod(Invocation.getter(#isAvailable), returnValue: false)
          as bool);
  @override
  List<_i2.NetworkManagerSettingsConnection> get availableConnections =>
      (super.noSuchMethod(Invocation.getter(#availableConnections),
              returnValue: <_i2.NetworkManagerSettingsConnection>[])
          as List<_i2.NetworkManagerSettingsConnection>);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  void init() => super.noSuchMethod(Invocation.method(#init, []),
      returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  bool isActiveAccessPoint(_i5.AccessPointModel? accessPoint) => (super
      .noSuchMethod(Invocation.method(#isActiveAccessPoint, [accessPoint]),
          returnValue: false) as bool);
  @override
  bool isSelectedAccessPoint(_i5.AccessPointModel? accessPoint) => (super
      .noSuchMethod(Invocation.method(#isSelectedAccessPoint, [accessPoint]),
          returnValue: false) as bool);
  @override
  void selectAccessPoint(_i5.AccessPointModel? accessPoint) =>
      super.noSuchMethod(Invocation.method(#selectAccessPoint, [accessPoint]),
          returnValueForMissingStub: null);
  @override
  _i6.Future<List<int>?> getSsid(
          _i2.NetworkManagerSettingsConnection? connection) =>
      (super.noSuchMethod(Invocation.method(#getSsid, [connection]),
          returnValue: Future<List<int>?>.value()) as _i6.Future<List<int>?>);
  @override
  _i6.Future<_i2.NetworkManagerSettingsConnection?> findAvailableConnection(
          _i5.AccessPointModel? accessPoint) =>
      (super.noSuchMethod(
              Invocation.method(#findAvailableConnection, [accessPoint]),
              returnValue:
                  Future<_i2.NetworkManagerSettingsConnection?>.value())
          as _i6.Future<_i2.NetworkManagerSettingsConnection?>);
  @override
  _i6.Future<void> requestScan({String? ssid}) =>
      (super.noSuchMethod(Invocation.method(#requestScan, [], {#ssid: ssid}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i5.AccessPointModel? findAccessPoint(String? ssid) =>
      (super.noSuchMethod(Invocation.method(#findAccessPoint, [ssid]))
          as _i5.AccessPointModel?);
  @override
  _i6.Future<void> disconnect() =>
      (super.noSuchMethod(Invocation.method(#disconnect, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void addProperties(_i6.Stream<List<String>>? properties) =>
      super.noSuchMethod(Invocation.method(#addProperties, [properties]),
          returnValueForMissingStub: null);
  @override
  void addPropertyListener(String? property, _i7.VoidCallback? onChanged) =>
      super.noSuchMethod(
          Invocation.method(#addPropertyListener, [property, onChanged]),
          returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  void addListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
