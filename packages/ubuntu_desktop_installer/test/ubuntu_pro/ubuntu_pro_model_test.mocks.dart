// Mocks generated by Mockito 5.0.14 from annotations
// in ubuntu_desktop_installer/test/ubuntu_pro/ubuntu_pro_model_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dbus/dbus.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:nm/nm.dart' as _i2;
import 'package:ubuntu_desktop_installer/services/network_service.dart' as _i3;
import 'package:ubuntu_desktop_installer/services/ubuntu_pro_client.dart'
    as _i6;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeNetworkManagerSettings_0 extends _i1.Fake
    implements _i2.NetworkManagerSettings {}

class _FakeNetworkManagerDnsManager_1 extends _i1.Fake
    implements _i2.NetworkManagerDnsManager {}

class _FakeNetworkManagerActiveConnection_2 extends _i1.Fake
    implements _i2.NetworkManagerActiveConnection {}

/// A class which mocks [NetworkService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkService extends _i1.Mock implements _i3.NetworkService {
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
  _i4.Stream<_i2.NetworkManagerDevice> get deviceAdded =>
      (super.noSuchMethod(Invocation.getter(#deviceAdded),
              returnValue: Stream<_i2.NetworkManagerDevice>.empty())
          as _i4.Stream<_i2.NetworkManagerDevice>);
  @override
  _i4.Stream<_i2.NetworkManagerDevice> get deviceRemoved =>
      (super.noSuchMethod(Invocation.getter(#deviceRemoved),
              returnValue: Stream<_i2.NetworkManagerDevice>.empty())
          as _i4.Stream<_i2.NetworkManagerDevice>);
  @override
  _i4.Stream<_i2.NetworkManagerActiveConnection> get activeConnectionAdded =>
      (super.noSuchMethod(Invocation.getter(#activeConnectionAdded),
              returnValue: Stream<_i2.NetworkManagerActiveConnection>.empty())
          as _i4.Stream<_i2.NetworkManagerActiveConnection>);
  @override
  _i4.Stream<_i2.NetworkManagerActiveConnection> get activeConnectionRemoved =>
      (super.noSuchMethod(Invocation.getter(#activeConnectionRemoved),
              returnValue: Stream<_i2.NetworkManagerActiveConnection>.empty())
          as _i4.Stream<_i2.NetworkManagerActiveConnection>);
  @override
  _i4.Stream<List<String>> get propertiesChanged => (super.noSuchMethod(
      Invocation.getter(#propertiesChanged),
      returnValue: Stream<List<String>>.empty()) as _i4.Stream<List<String>>);
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
  _i2.NetworkManagerState get state => (super.noSuchMethod(
      Invocation.getter(#state),
      returnValue: _i2.NetworkManagerState.unknown) as _i2.NetworkManagerState);
  @override
  _i2.NetworkManagerSettings get settings =>
      (super.noSuchMethod(Invocation.getter(#settings),
              returnValue: _FakeNetworkManagerSettings_0())
          as _i2.NetworkManagerSettings);
  @override
  _i2.NetworkManagerDnsManager get dnsManager =>
      (super.noSuchMethod(Invocation.getter(#dnsManager),
              returnValue: _FakeNetworkManagerDnsManager_1())
          as _i2.NetworkManagerDnsManager);
  @override
  Map<String, Map<String, _i5.DBusValue>> getWifiSettings({String? ssid}) =>
      (super.noSuchMethod(
              Invocation.method(#getWifiSettings, [], {#ssid: ssid}),
              returnValue: <String, Map<String, _i5.DBusValue>>{})
          as Map<String, Map<String, _i5.DBusValue>>);
  @override
  _i4.Future<void> connect() =>
      (super.noSuchMethod(Invocation.method(#connect, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> setWirelessEnabled(bool? value) =>
      (super.noSuchMethod(Invocation.method(#setWirelessEnabled, [value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> setWwanEnabled(bool? value) =>
      (super.noSuchMethod(Invocation.method(#setWwanEnabled, [value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> setConnectivityCheckEnabled(bool? value) => (super
      .noSuchMethod(Invocation.method(#setConnectivityCheckEnabled, [value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<_i2.NetworkManagerActiveConnection> addAndActivateConnection(
          {Map<String, Map<String, _i5.DBusValue>>? connection = const {},
          _i2.NetworkManagerDevice? device,
          _i2.NetworkManagerAccessPoint? accessPoint}) =>
      (super.noSuchMethod(
              Invocation.method(#addAndActivateConnection, [], {
                #connection: connection,
                #device: device,
                #accessPoint: accessPoint
              }),
              returnValue: Future<_i2.NetworkManagerActiveConnection>.value(
                  _FakeNetworkManagerActiveConnection_2()))
          as _i4.Future<_i2.NetworkManagerActiveConnection>);
  @override
  _i4.Future<_i2.NetworkManagerActiveConnection> activateConnection(
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
                  _FakeNetworkManagerActiveConnection_2()))
          as _i4.Future<_i2.NetworkManagerActiveConnection>);
  @override
  _i4.Future<void> deactivateConnection(
          _i2.NetworkManagerActiveConnection? connection) =>
      (super.noSuchMethod(
          Invocation.method(#deactivateConnection, [connection]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [UbuntuProClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockUbuntuProClient extends _i1.Mock implements _i6.UbuntuProClient {
  MockUbuntuProClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get daemonVersion =>
      (super.noSuchMethod(Invocation.getter(#daemonVersion), returnValue: '')
          as String);
  @override
  bool get isAttached =>
      (super.noSuchMethod(Invocation.getter(#isAttached), returnValue: false)
          as bool);
  @override
  _i4.Stream<List<String>> get propertiesChanged => (super.noSuchMethod(
      Invocation.getter(#propertiesChanged),
      returnValue: Stream<List<String>>.empty()) as _i4.Stream<List<String>>);
  @override
  _i4.Future<void> connect() =>
      (super.noSuchMethod(Invocation.method(#connect, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> attach(String? token) =>
      (super.noSuchMethod(Invocation.method(#attach, [token]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> detach() =>
      (super.noSuchMethod(Invocation.method(#detach, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  String toString() => super.toString();
}
