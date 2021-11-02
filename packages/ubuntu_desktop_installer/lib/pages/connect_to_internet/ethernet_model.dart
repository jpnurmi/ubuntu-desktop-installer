import 'package:collection/collection.dart';

import '../../services.dart';
import 'connect_model.dart';
import 'device_model.dart';
import 'property_stream_notifier.dart';

class EthernetModel extends PropertyStreamNotifier implements ConnectModel {
  EthernetModel(this._service) {
    addProperties(_service.propertiesChanged);
    addPropertyListener('Devices', _updateDevices);
  }

  @override
  bool get canConnect => _selected?.isActive == false;

  @override
  bool get canContinue => _selected?.isActive == true;

  @override
  bool get isBusy => _selected?.isBusy == true;

  @override
  bool get isActive => devices.any((device) => device.isActive);

  @override
  ConnectMode get connectMode => ConnectMode.ethernet;

  @override
  void init() => selectDevice(devices.firstWhereOrNull((d) => d.isActive));

  @override
  void cleanup() {}

  @override
  Future<void> connect() async {
    assert(false);
  }

  @override
  void dispose() {
    _resetDevices();
    super.dispose();
  }

  final NetworkService _service;

  List<EthernetDeviceModel>? _devices;
  List<EthernetDeviceModel> get devices => _devices ??= _getDevices();

  List<EthernetDeviceModel> _getDevices() {
    return _service.wiredDevices
        .map((device) => EthernetDeviceModel(device))
        .toList();
  }

  void _resetDevices() {
    if (_devices == null) return;
    for (final device in _devices!) {
      device.dispose();
    }
    _devices = null;
  }

  void _updateDevices() {
    _resetDevices();
    notifyListeners();
  }

  EthernetDeviceModel? _selected;
  EthernetDeviceModel? get selectedDevice => _selected;
  bool isSelectedDevice(EthernetDeviceModel device) => device == _selected;
  void selectDevice(EthernetDeviceModel? device) {
    _selected = device;
    notifyListeners();
  }
}

class EthernetDeviceModel extends DeviceModel {
  EthernetDeviceModel(NetworkManagerDevice device) : super(device);
}
