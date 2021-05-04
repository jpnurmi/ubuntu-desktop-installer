// Mocks generated by Mockito 5.0.14 from annotations
// in ubuntu_desktop_installer/test/device_model_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:dbus/dbus.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:nm/src/network_manager_client.dart' as _i2;
import 'package:udev/src/udev.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeNetworkManagerDeviceStateAndReason_0 extends _i1.Fake
    implements _i2.NetworkManagerDeviceStateAndReason {}

/// A class which mocks [NetworkManagerActiveConnection].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkManagerActiveConnection extends _i1.Mock
    implements _i2.NetworkManagerActiveConnection {
  MockNetworkManagerActiveConnection() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<List<String>> get propertiesChanged => (super.noSuchMethod(
      Invocation.getter(#propertiesChanged),
      returnValue: Stream<List<String>>.empty()) as _i3.Stream<List<String>>);
  @override
  String get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: '') as String);
  @override
  String get uuid =>
      (super.noSuchMethod(Invocation.getter(#uuid), returnValue: '') as String);
  @override
  String get type =>
      (super.noSuchMethod(Invocation.getter(#type), returnValue: '') as String);
  @override
  _i2.NetworkManagerActiveConnectionState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
              returnValue: _i2.NetworkManagerActiveConnectionState.unknown)
          as _i2.NetworkManagerActiveConnectionState);
  @override
  List<_i2.NetworkManagerActivationStateFlag> get stateFlags =>
      (super.noSuchMethod(Invocation.getter(#stateFlags),
              returnValue: <_i2.NetworkManagerActivationStateFlag>[])
          as List<_i2.NetworkManagerActivationStateFlag>);
  @override
  bool get default4 =>
      (super.noSuchMethod(Invocation.getter(#default4), returnValue: false)
          as bool);
  @override
  bool get default6 =>
      (super.noSuchMethod(Invocation.getter(#default6), returnValue: false)
          as bool);
  @override
  bool get vpn =>
      (super.noSuchMethod(Invocation.getter(#vpn), returnValue: false) as bool);
  @override
  List<_i2.NetworkManagerDevice> get devices =>
      (super.noSuchMethod(Invocation.getter(#devices),
              returnValue: <_i2.NetworkManagerDevice>[])
          as List<_i2.NetworkManagerDevice>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NetworkManagerDevice].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkManagerDevice extends _i1.Mock
    implements _i2.NetworkManagerDevice {
  MockNetworkManagerDevice() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<List<String>> get propertiesChanged => (super.noSuchMethod(
      Invocation.getter(#propertiesChanged),
      returnValue: Stream<List<String>>.empty()) as _i3.Stream<List<String>>);
  @override
  String get udi =>
      (super.noSuchMethod(Invocation.getter(#udi), returnValue: '') as String);
  @override
  String get path =>
      (super.noSuchMethod(Invocation.getter(#path), returnValue: '') as String);
  @override
  String get interface =>
      (super.noSuchMethod(Invocation.getter(#interface), returnValue: '')
          as String);
  @override
  String get ipInterface =>
      (super.noSuchMethod(Invocation.getter(#ipInterface), returnValue: '')
          as String);
  @override
  String get driver =>
      (super.noSuchMethod(Invocation.getter(#driver), returnValue: '')
          as String);
  @override
  String get driverVersion =>
      (super.noSuchMethod(Invocation.getter(#driverVersion), returnValue: '')
          as String);
  @override
  String get firmwareVersion =>
      (super.noSuchMethod(Invocation.getter(#firmwareVersion), returnValue: '')
          as String);
  @override
  List<_i2.NetworkManagerDeviceCapability> get capabilities =>
      (super.noSuchMethod(Invocation.getter(#capabilities),
              returnValue: <_i2.NetworkManagerDeviceCapability>[])
          as List<_i2.NetworkManagerDeviceCapability>);
  @override
  _i2.NetworkManagerDeviceState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
              returnValue: _i2.NetworkManagerDeviceState.unknown)
          as _i2.NetworkManagerDeviceState);
  @override
  _i2.NetworkManagerDeviceStateAndReason get stateReason =>
      (super.noSuchMethod(Invocation.getter(#stateReason),
              returnValue: _FakeNetworkManagerDeviceStateAndReason_0())
          as _i2.NetworkManagerDeviceStateAndReason);
  @override
  bool get managed =>
      (super.noSuchMethod(Invocation.getter(#managed), returnValue: false)
          as bool);
  @override
  bool get autoconnect =>
      (super.noSuchMethod(Invocation.getter(#autoconnect), returnValue: false)
          as bool);
  @override
  bool get firmwareMissing => (super
          .noSuchMethod(Invocation.getter(#firmwareMissing), returnValue: false)
      as bool);
  @override
  bool get nmPluginMissing => (super
          .noSuchMethod(Invocation.getter(#nmPluginMissing), returnValue: false)
      as bool);
  @override
  _i2.NetworkManagerDeviceType get deviceType =>
      (super.noSuchMethod(Invocation.getter(#deviceType),
              returnValue: _i2.NetworkManagerDeviceType.unknown)
          as _i2.NetworkManagerDeviceType);
  @override
  List<_i2.NetworkManagerSettingsConnection> get availableConnections =>
      (super.noSuchMethod(Invocation.getter(#availableConnections),
              returnValue: <_i2.NetworkManagerSettingsConnection>[])
          as List<_i2.NetworkManagerSettingsConnection>);
  @override
  String get physicalPortId =>
      (super.noSuchMethod(Invocation.getter(#physicalPortId), returnValue: '')
          as String);
  @override
  int get mtu =>
      (super.noSuchMethod(Invocation.getter(#mtu), returnValue: 0) as int);
  @override
  _i2.NetworkManagerMetered get metered =>
      (super.noSuchMethod(Invocation.getter(#metered),
              returnValue: _i2.NetworkManagerMetered.unknown)
          as _i2.NetworkManagerMetered);
  @override
  bool get real =>
      (super.noSuchMethod(Invocation.getter(#real), returnValue: false)
          as bool);
  @override
  _i2.NetworkManagerConnectivityState get ip4Connectivity =>
      (super.noSuchMethod(Invocation.getter(#ip4Connectivity),
              returnValue: _i2.NetworkManagerConnectivityState.unknown)
          as _i2.NetworkManagerConnectivityState);
  @override
  _i2.NetworkManagerConnectivityState get ip6Connectivity =>
      (super.noSuchMethod(Invocation.getter(#ip6Connectivity),
              returnValue: _i2.NetworkManagerConnectivityState.unknown)
          as _i2.NetworkManagerConnectivityState);
  @override
  List<_i2.NetworkManagerDeviceInterfaceFlag> get interfaceFlags =>
      (super.noSuchMethod(Invocation.getter(#interfaceFlags),
              returnValue: <_i2.NetworkManagerDeviceInterfaceFlag>[])
          as List<_i2.NetworkManagerDeviceInterfaceFlag>);
  @override
  String get hwAddress =>
      (super.noSuchMethod(Invocation.getter(#hwAddress), returnValue: '')
          as String);
  @override
  _i3.Future<void> disconnect() =>
      (super.noSuchMethod(Invocation.method(#disconnect, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> delete() =>
      (super.noSuchMethod(Invocation.method(#delete, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> setManaged(bool? value) =>
      (super.noSuchMethod(Invocation.method(#setManaged, [value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> setAutoconnect(bool? value) =>
      (super.noSuchMethod(Invocation.method(#setAutoconnect, [value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NetworkManagerSettingsConnection].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkManagerSettingsConnection extends _i1.Mock
    implements _i2.NetworkManagerSettingsConnection {
  MockNetworkManagerSettingsConnection() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<List<String>> get propertiesChanged => (super.noSuchMethod(
      Invocation.getter(#propertiesChanged),
      returnValue: Stream<List<String>>.empty()) as _i3.Stream<List<String>>);
  @override
  bool get unsaved =>
      (super.noSuchMethod(Invocation.getter(#unsaved), returnValue: false)
          as bool);
  @override
  List<_i2.NetworkManagerConnectionFlag> get flags =>
      (super.noSuchMethod(Invocation.getter(#flags),
              returnValue: <_i2.NetworkManagerConnectionFlag>[])
          as List<_i2.NetworkManagerConnectionFlag>);
  @override
  String get filename =>
      (super.noSuchMethod(Invocation.getter(#filename), returnValue: '')
          as String);
  @override
  _i3.Future<void> update(
          Map<String, Map<String, _i4.DBusValue>>? properties) =>
      (super.noSuchMethod(Invocation.method(#update, [properties]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> updateUnsaved(
          Map<String, Map<String, _i4.DBusValue>>? properties) =>
      (super.noSuchMethod(Invocation.method(#updateUnsaved, [properties]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> delete() =>
      (super.noSuchMethod(Invocation.method(#delete, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<Map<String, Map<String, _i4.DBusValue>>> getSettings() =>
      (super.noSuchMethod(Invocation.method(#getSettings, []),
          returnValue: Future<Map<String, Map<String, _i4.DBusValue>>>.value(
              <String, Map<String, _i4.DBusValue>>{})) as _i3
          .Future<Map<String, Map<String, _i4.DBusValue>>>);
  @override
  _i3.Future<Map<String, Map<String, _i4.DBusValue>>> getSecrets(
          [String? settingName = r'']) =>
      (super.noSuchMethod(Invocation.method(#getSecrets, [settingName]),
          returnValue: Future<Map<String, Map<String, _i4.DBusValue>>>.value(
              <String, Map<String, _i4.DBusValue>>{})) as _i3
          .Future<Map<String, Map<String, _i4.DBusValue>>>);
  @override
  _i3.Future<void> clearSecrets() =>
      (super.noSuchMethod(Invocation.method(#clearSecrets, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> save() => (super.noSuchMethod(Invocation.method(#save, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [Udev].
///
/// See the documentation for Mockito's code generation for more information.
class MockUdev extends _i1.Mock implements _i5.Udev {
  MockUdev() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  _i5.UdevDevice? device({String? syspath}) =>
      (super.noSuchMethod(Invocation.method(#device, [], {#syspath: syspath}))
          as _i5.UdevDevice?);
  @override
  String toString() => super.toString();
}

/// A class which mocks [UdevDevice].
///
/// See the documentation for Mockito's code generation for more information.
class MockUdevDevice extends _i1.Mock implements _i5.UdevDevice {
  MockUdevDevice() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get model =>
      (super.noSuchMethod(Invocation.getter(#model), returnValue: '')
          as String);
  @override
  String get vendor =>
      (super.noSuchMethod(Invocation.getter(#vendor), returnValue: '')
          as String);
  @override
  String toString() => super.toString();
}
