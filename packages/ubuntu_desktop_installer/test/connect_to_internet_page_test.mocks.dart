// Mocks generated by Mockito 5.0.14 from annotations
// in ubuntu_desktop_installer/test/connect_to_internet_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;
import 'dart:ui' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/connect_model.dart'
    as _i4;
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/connect_to_internet_model.dart'
    as _i3;
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/ethernet_model.dart'
    as _i7;
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/hidden_wifi_model.dart'
    as _i8;
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/wifi_auth_model.dart'
    as _i10;
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/wifi_model.dart'
    as _i9;
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

class _FakeNetworkManagerSettings_1 extends _i1.Fake
    implements _i2.NetworkManagerSettings {}

class _FakeNetworkManagerDnsManager_2 extends _i1.Fake
    implements _i2.NetworkManagerDnsManager {}

class _FakeNetworkManagerSettingsConnection_3 extends _i1.Fake
    implements _i2.NetworkManagerSettingsConnection {}

class _FakeNetworkManagerActiveConnection_4 extends _i1.Fake
    implements _i2.NetworkManagerActiveConnection {}

/// A class which mocks [ConnectToInternetModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockConnectToInternetModel extends _i1.Mock
    implements _i3.ConnectToInternetModel {
  MockConnectToInternetModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get canConnect =>
      (super.noSuchMethod(Invocation.getter(#canConnect), returnValue: false)
          as bool);
  @override
  bool get canContinue =>
      (super.noSuchMethod(Invocation.getter(#canContinue), returnValue: false)
          as bool);
  @override
  bool get isBusy =>
      (super.noSuchMethod(Invocation.getter(#isBusy), returnValue: false)
          as bool);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  void select(_i4.ConnectModel? model) =>
      super.noSuchMethod(Invocation.method(#select, [model]),
          returnValueForMissingStub: null);
  @override
  void init() => super.noSuchMethod(Invocation.method(#init, []),
      returnValueForMissingStub: null);
  @override
  _i5.Future<void> connect({_i4.OnAuthenticate? onAuthenticate}) =>
      (super.noSuchMethod(
          Invocation.method(#connect, [], {#onAuthenticate: onAuthenticate}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  void addListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i6.VoidCallback? listener) =>
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

/// A class which mocks [EthernetModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockEthernetModel extends _i1.Mock implements _i7.EthernetModel {
  MockEthernetModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get canConnect =>
      (super.noSuchMethod(Invocation.getter(#canConnect), returnValue: false)
          as bool);
  @override
  bool get canContinue =>
      (super.noSuchMethod(Invocation.getter(#canContinue), returnValue: false)
          as bool);
  @override
  bool get isBusy =>
      (super.noSuchMethod(Invocation.getter(#isBusy), returnValue: false)
          as bool);
  @override
  _i4.ConnectMode get connectMode =>
      (super.noSuchMethod(Invocation.getter(#connectMode),
          returnValue: _i4.ConnectMode.none) as _i4.ConnectMode);
  @override
  List<_i7.EthernetDeviceModel> get devices =>
      (super.noSuchMethod(Invocation.getter(#devices),
              returnValue: <_i7.EthernetDeviceModel>[])
          as List<_i7.EthernetDeviceModel>);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  void init() => super.noSuchMethod(Invocation.method(#init, []),
      returnValueForMissingStub: null);
  @override
  _i5.Future<void> connect({_i4.OnAuthenticate? onAuthenticate}) =>
      (super.noSuchMethod(
          Invocation.method(#connect, [], {#onAuthenticate: onAuthenticate}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  bool isSelectedDevice(_i7.EthernetDeviceModel? device) =>
      (super.noSuchMethod(Invocation.method(#isSelectedDevice, [device]),
          returnValue: false) as bool);
  @override
  void selectDevice(_i7.EthernetDeviceModel? device) =>
      super.noSuchMethod(Invocation.method(#selectDevice, [device]),
          returnValueForMissingStub: null);
  @override
  void addProperties(_i5.Stream<List<String>>? properties) =>
      super.noSuchMethod(Invocation.method(#addProperties, [properties]),
          returnValueForMissingStub: null);
  @override
  void addPropertyListener(String? property, _i6.VoidCallback? onChanged) =>
      super.noSuchMethod(
          Invocation.method(#addPropertyListener, [property, onChanged]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void addListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

/// A class which mocks [EthernetDeviceModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockEthernetDeviceModel extends _i1.Mock
    implements _i7.EthernetDeviceModel {
  MockEthernetDeviceModel() {
    _i1.throwOnMissingStub(this);
  }

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
  bool get isActive =>
      (super.noSuchMethod(Invocation.getter(#isActive), returnValue: false)
          as bool);
  @override
  bool get isBusy =>
      (super.noSuchMethod(Invocation.getter(#isBusy), returnValue: false)
          as bool);
  @override
  List<_i2.NetworkManagerSettingsConnection> get availableConnections =>
      (super.noSuchMethod(Invocation.getter(#availableConnections),
              returnValue: <_i2.NetworkManagerSettingsConnection>[])
          as List<_i2.NetworkManagerSettingsConnection>);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  void addProperties(_i5.Stream<List<String>>? properties) =>
      super.noSuchMethod(Invocation.method(#addProperties, [properties]),
          returnValueForMissingStub: null);
  @override
  void addPropertyListener(String? property, _i6.VoidCallback? onChanged) =>
      super.noSuchMethod(
          Invocation.method(#addPropertyListener, [property, onChanged]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void addListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

/// A class which mocks [HiddenWifiModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockHiddenWifiModel extends _i1.Mock implements _i8.HiddenWifiModel {
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
  bool get isBusy =>
      (super.noSuchMethod(Invocation.getter(#isBusy), returnValue: false)
          as bool);
  @override
  List<_i9.WifiDeviceModel> get devices =>
      (super.noSuchMethod(Invocation.getter(#devices),
          returnValue: <_i9.WifiDeviceModel>[]) as List<_i9.WifiDeviceModel>);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  void init() => super.noSuchMethod(Invocation.method(#init, []),
      returnValueForMissingStub: null);
  @override
  _i5.Future<void> connect({_i4.OnAuthenticate? onAuthenticate}) =>
      (super.noSuchMethod(
          Invocation.method(#connect, [], {#onAuthenticate: onAuthenticate}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  void setSsid(String? ssid) =>
      super.noSuchMethod(Invocation.method(#setSsid, [ssid]),
          returnValueForMissingStub: null);
  @override
  bool isSelectedDevice(_i9.WifiDeviceModel? device) =>
      (super.noSuchMethod(Invocation.method(#isSelectedDevice, [device]),
          returnValue: false) as bool);
  @override
  void selectDevice(_i9.WifiDeviceModel? device) =>
      super.noSuchMethod(Invocation.method(#selectDevice, [device]),
          returnValueForMissingStub: null);
  @override
  _i5.Future<dynamic> requestScan({String? ssid}) =>
      (super.noSuchMethod(Invocation.method(#requestScan, [], {#ssid: ssid}),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
  @override
  void addProperties(_i5.Stream<List<String>>? properties) =>
      super.noSuchMethod(Invocation.method(#addProperties, [properties]),
          returnValueForMissingStub: null);
  @override
  void addPropertyListener(String? property, _i6.VoidCallback? onChanged) =>
      super.noSuchMethod(
          Invocation.method(#addPropertyListener, [property, onChanged]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void addListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NetworkService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkService extends _i1.Mock implements _i2.NetworkService {
  MockNetworkService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  List<_i2.NetworkManagerDevice> get wiredDevices =>
      (super.noSuchMethod(Invocation.getter(#wiredDevices),
              returnValue: <_i2.NetworkManagerDevice>[])
          as List<_i2.NetworkManagerDevice>);
  @override
  List<_i2.NetworkManagerDevice> get wirelessDevices =>
      (super.noSuchMethod(Invocation.getter(#wirelessDevices),
              returnValue: <_i2.NetworkManagerDevice>[])
          as List<_i2.NetworkManagerDevice>);
  @override
  _i5.Stream<_i2.NetworkManagerDevice> get deviceAdded =>
      (super.noSuchMethod(Invocation.getter(#deviceAdded),
              returnValue: Stream<_i2.NetworkManagerDevice>.empty())
          as _i5.Stream<_i2.NetworkManagerDevice>);
  @override
  _i5.Stream<_i2.NetworkManagerDevice> get deviceRemoved =>
      (super.noSuchMethod(Invocation.getter(#deviceRemoved),
              returnValue: Stream<_i2.NetworkManagerDevice>.empty())
          as _i5.Stream<_i2.NetworkManagerDevice>);
  @override
  _i5.Stream<_i2.NetworkManagerActiveConnection> get activeConnectionAdded =>
      (super.noSuchMethod(Invocation.getter(#activeConnectionAdded),
              returnValue: Stream<_i2.NetworkManagerActiveConnection>.empty())
          as _i5.Stream<_i2.NetworkManagerActiveConnection>);
  @override
  _i5.Stream<_i2.NetworkManagerActiveConnection> get activeConnectionRemoved =>
      (super.noSuchMethod(Invocation.getter(#activeConnectionRemoved),
              returnValue: Stream<_i2.NetworkManagerActiveConnection>.empty())
          as _i5.Stream<_i2.NetworkManagerActiveConnection>);
  @override
  _i5.Stream<List<String>> get propertiesChanged => (super.noSuchMethod(
      Invocation.getter(#propertiesChanged),
      returnValue: Stream<List<String>>.empty()) as _i5.Stream<List<String>>);
  @override
  List<_i2.NetworkManagerDevice> get devices =>
      (super.noSuchMethod(Invocation.getter(#devices),
              returnValue: <_i2.NetworkManagerDevice>[])
          as List<_i2.NetworkManagerDevice>);
  @override
  List<_i2.NetworkManagerDevice> get allDevices =>
      (super.noSuchMethod(Invocation.getter(#allDevices),
              returnValue: <_i2.NetworkManagerDevice>[])
          as List<_i2.NetworkManagerDevice>);
  @override
  bool get networkingEnabled =>
      (super.noSuchMethod(Invocation.getter(#networkingEnabled),
          returnValue: false) as bool);
  @override
  bool get wirelessEnabled => (super
          .noSuchMethod(Invocation.getter(#wirelessEnabled), returnValue: false)
      as bool);
  @override
  bool get wirelessHardwareEnabled =>
      (super.noSuchMethod(Invocation.getter(#wirelessHardwareEnabled),
          returnValue: false) as bool);
  @override
  bool get wwanEnabled =>
      (super.noSuchMethod(Invocation.getter(#wwanEnabled), returnValue: false)
          as bool);
  @override
  bool get wwanHardwareEnabled =>
      (super.noSuchMethod(Invocation.getter(#wwanHardwareEnabled),
          returnValue: false) as bool);
  @override
  List<_i2.NetworkManagerActiveConnection> get activeConnections =>
      (super.noSuchMethod(Invocation.getter(#activeConnections),
              returnValue: <_i2.NetworkManagerActiveConnection>[])
          as List<_i2.NetworkManagerActiveConnection>);
  @override
  String get primaryConnectionType =>
      (super.noSuchMethod(Invocation.getter(#primaryConnectionType),
          returnValue: '') as String);
  @override
  _i2.NetworkManagerMetered get metered =>
      (super.noSuchMethod(Invocation.getter(#metered),
              returnValue: _i2.NetworkManagerMetered.unknown)
          as _i2.NetworkManagerMetered);
  @override
  bool get startup =>
      (super.noSuchMethod(Invocation.getter(#startup), returnValue: false)
          as bool);
  @override
  String get version =>
      (super.noSuchMethod(Invocation.getter(#version), returnValue: '')
          as String);
  @override
  _i2.NetworkManagerConnectivityState get connectivity =>
      (super.noSuchMethod(Invocation.getter(#connectivity),
              returnValue: _i2.NetworkManagerConnectivityState.unknown)
          as _i2.NetworkManagerConnectivityState);
  @override
  bool get connectivityCheckAvailable =>
      (super.noSuchMethod(Invocation.getter(#connectivityCheckAvailable),
          returnValue: false) as bool);
  @override
  bool get connectivityCheckEnabled =>
      (super.noSuchMethod(Invocation.getter(#connectivityCheckEnabled),
          returnValue: false) as bool);
  @override
  String get connectivityCheckUri =>
      (super.noSuchMethod(Invocation.getter(#connectivityCheckUri),
          returnValue: '') as String);
  @override
  _i2.NetworkManagerSettings get settings =>
      (super.noSuchMethod(Invocation.getter(#settings),
              returnValue: _FakeNetworkManagerSettings_1())
          as _i2.NetworkManagerSettings);
  @override
  _i2.NetworkManagerDnsManager get dnsManager =>
      (super.noSuchMethod(Invocation.getter(#dnsManager),
              returnValue: _FakeNetworkManagerDnsManager_2())
          as _i2.NetworkManagerDnsManager);
  @override
  _i5.Future<_i2.NetworkManagerSettingsConnection> addWiredConnection(
          {_i2.NetworkManagerDevice? device}) =>
      (super.noSuchMethod(
              Invocation.method(#addWiredConnection, [], {#device: device}),
              returnValue: Future<_i2.NetworkManagerSettingsConnection>.value(
                  _FakeNetworkManagerSettingsConnection_3()))
          as _i5.Future<_i2.NetworkManagerSettingsConnection>);
  @override
  _i5.Future<_i2.NetworkManagerSettingsConnection> addWirelessConnection(
          {List<int>? ssid,
          String? bssid,
          bool? private = false,
          bool? hidden = false,
          String? password}) =>
      (super.noSuchMethod(
              Invocation.method(#addWirelessConnection, [], {
                #ssid: ssid,
                #bssid: bssid,
                #private: private,
                #hidden: hidden,
                #password: password
              }),
              returnValue: Future<_i2.NetworkManagerSettingsConnection>.value(
                  _FakeNetworkManagerSettingsConnection_3()))
          as _i5.Future<_i2.NetworkManagerSettingsConnection>);
  @override
  _i5.Future<void> connect() =>
      (super.noSuchMethod(Invocation.method(#connect, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> setWirelessEnabled(bool? value) =>
      (super.noSuchMethod(Invocation.method(#setWirelessEnabled, [value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> setWwanEnabled(bool? value) =>
      (super.noSuchMethod(Invocation.method(#setWwanEnabled, [value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> setConnectivityCheckEnabled(bool? value) => (super
      .noSuchMethod(Invocation.method(#setConnectivityCheckEnabled, [value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<_i2.NetworkManagerActiveConnection> activateConnection(
          {_i2.NetworkManagerDevice? device,
          _i2.NetworkManagerSettingsConnection? connection,
          _i2.NetworkManagerAccessPoint? accessPoint}) =>
      (super.noSuchMethod(
              Invocation.method(#activateConnection, [], {
                #device: device,
                #connection: connection,
                #accessPoint: accessPoint
              }),
              returnValue: Future<_i2.NetworkManagerActiveConnection>.value(
                  _FakeNetworkManagerActiveConnection_4()))
          as _i5.Future<_i2.NetworkManagerActiveConnection>);
  @override
  _i5.Future<void> deactivateConnection(
          _i2.NetworkManagerActiveConnection? connection) =>
      (super.noSuchMethod(
          Invocation.method(#deactivateConnection, [connection]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [WifiAuthModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockWifiAuthModel extends _i1.Mock implements _i10.WifiAuthModel {
  MockWifiAuthModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get showPassword =>
      (super.noSuchMethod(Invocation.getter(#showPassword), returnValue: false)
          as bool);
  @override
  set showPassword(bool? value) =>
      super.noSuchMethod(Invocation.setter(#showPassword, value),
          returnValueForMissingStub: null);
  @override
  _i4.StorePassword get storePassword =>
      (super.noSuchMethod(Invocation.getter(#storePassword),
          returnValue: _i4.StorePassword.thisUser) as _i4.StorePassword);
  @override
  set storePassword(_i4.StorePassword? value) =>
      super.noSuchMethod(Invocation.setter(#storePassword, value),
          returnValueForMissingStub: null);
  @override
  _i4.WifiSecurity get wifiSecurity =>
      (super.noSuchMethod(Invocation.getter(#wifiSecurity),
          returnValue: _i4.WifiSecurity.wpa2Personal) as _i4.WifiSecurity);
  @override
  set wifiSecurity(_i4.WifiSecurity? value) =>
      super.noSuchMethod(Invocation.setter(#wifiSecurity, value),
          returnValueForMissingStub: null);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  void addListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i6.VoidCallback? listener) =>
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

/// A class which mocks [WifiModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockWifiModel extends _i1.Mock implements _i9.WifiModel {
  MockWifiModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get canConnect =>
      (super.noSuchMethod(Invocation.getter(#canConnect), returnValue: false)
          as bool);
  @override
  bool get canContinue =>
      (super.noSuchMethod(Invocation.getter(#canContinue), returnValue: false)
          as bool);
  @override
  bool get isBusy =>
      (super.noSuchMethod(Invocation.getter(#isBusy), returnValue: false)
          as bool);
  @override
  _i4.ConnectMode get connectMode =>
      (super.noSuchMethod(Invocation.getter(#connectMode),
          returnValue: _i4.ConnectMode.none) as _i4.ConnectMode);
  @override
  List<_i9.WifiDeviceModel> get devices =>
      (super.noSuchMethod(Invocation.getter(#devices),
          returnValue: <_i9.WifiDeviceModel>[]) as List<_i9.WifiDeviceModel>);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  void init() => super.noSuchMethod(Invocation.method(#init, []),
      returnValueForMissingStub: null);
  @override
  _i5.Future<void> connect({_i4.OnAuthenticate? onAuthenticate}) =>
      (super.noSuchMethod(
          Invocation.method(#connect, [], {#onAuthenticate: onAuthenticate}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  bool isSelectedDevice(_i9.WifiDeviceModel? device) =>
      (super.noSuchMethod(Invocation.method(#isSelectedDevice, [device]),
          returnValue: false) as bool);
  @override
  void selectDevice(_i9.WifiDeviceModel? device) =>
      super.noSuchMethod(Invocation.method(#selectDevice, [device]),
          returnValueForMissingStub: null);
  @override
  _i5.Future<dynamic> requestScan({String? ssid}) =>
      (super.noSuchMethod(Invocation.method(#requestScan, [], {#ssid: ssid}),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
  @override
  void addProperties(_i5.Stream<List<String>>? properties) =>
      super.noSuchMethod(Invocation.method(#addProperties, [properties]),
          returnValueForMissingStub: null);
  @override
  void addPropertyListener(String? property, _i6.VoidCallback? onChanged) =>
      super.noSuchMethod(
          Invocation.method(#addPropertyListener, [property, onChanged]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void addListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
