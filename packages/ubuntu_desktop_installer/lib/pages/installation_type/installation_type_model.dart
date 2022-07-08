import 'package:collection/collection.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:subiquity_client/subiquity_client.dart';
import 'package:ubuntu_wizard/utils.dart';

import '../../services.dart';

/// Available installation types.
enum InstallationType {
  /// Erase entire disk and perform guided partitioning.
  erase,

  /// Replace existing OS installation.
  reinstall,

  /// Install alongside existing OS installation.
  alongside,

  /// Manual partitioning.
  manual,
}

/// Available advanced features.
enum AdvancedFeature {
  /// No advanced features.
  none,

  /// Use LVM.
  lvm,

  /// Use ZFS (experimental).
  zfs,
}

/// View model for [InstallationTypePage].
class InstallationTypeModel extends SafeChangeNotifier {
  /// Creates a new model with the given client and service.
  InstallationTypeModel(this._diskService, this._telemetryService);

  final DiskStorageService _diskService;
  final TelemetryService _telemetryService;
  var _installationType = InstallationType.erase;
  var _advancedFeature = AdvancedFeature.none;
  var _encryption = false;
  List<GuidedStorageTarget>? _storages;

  /// The selected installation type.
  InstallationType get installationType => _installationType;
  set installationType(InstallationType type) {
    if (_installationType == type) return;
    _installationType = type;
    notifyListeners();
  }

  /// The selected advanced feature.
  AdvancedFeature get advancedFeature => _advancedFeature;
  set advancedFeature(AdvancedFeature feature) {
    if (_advancedFeature == feature) return;
    _advancedFeature = feature;
    notifyListeners();
  }

  /// Whether to encrypt the disk.
  bool get encryption => _encryption;
  set encryption(bool encryption) {
    if (_encryption == encryption) return;
    _encryption = encryption;
    notifyListeners();
  }

  /// The version of the OS.
  final productInfo = ProductInfoExtractor().getProductInfo();

  /// A list of existing OS installations or null if not detected.
  List<OsProber>? get existingOS => _diskService.existingOS;

  /// A list of guided storage targets or null if not detected.
  List<GuidedStorageTarget>? get storages => _storages;

  /// Initializes the model.
  Future<void> init() async {
    await _diskService.getGuidedStorage().then((r) => _storages = r.possible);
    // TODO: determine the preferred installation type from the available targets
    notifyListeners();
  }

  /// Saves the installation type selection and applies the guide storage
  /// if appropriate (single guided storage).
  Future<void> save() async {
    _diskService.useLvm = advancedFeature == AdvancedFeature.lvm;

    // select the appropriate target right away when there's only one option
    if (_installationType == InstallationType.erase) {
      final reformat =
          storages?.whereType<GuidedStorageTargetReformat>().singleOrNull;
      if (reformat != null) {
        await _diskService.setGuidedStorage(reformat);
      }
    }

    // All possible values for the partition method
    // were extracted from Ubiquity's ubi-partman.py
    // (see PageGtk.get_autopartition_choice()).
    if (installationType == InstallationType.erase) {
      _telemetryService.setPartitionMethod('use_device');
    } else if (installationType == InstallationType.reinstall) {
      _telemetryService.setPartitionMethod('reinstall_partition');
    } else if (installationType == InstallationType.alongside) {
      _telemetryService.setPartitionMethod('resize_use_free');
    } else if (installationType == InstallationType.manual) {
      _telemetryService.setPartitionMethod('manual');
    }
    if (advancedFeature == AdvancedFeature.lvm) {
      _telemetryService.setPartitionMethod('use_lvm');
    } else if (advancedFeature == AdvancedFeature.zfs) {
      _telemetryService.setPartitionMethod('use_zfs');
    }
    if (_diskService.hasEncryption && advancedFeature != AdvancedFeature.zfs) {
      _telemetryService.setPartitionMethod('use_crypto');
    }
    // TODO: map upgrading the current Ubuntu installation without
    // wiping the user's home directory (not implemented yet)
    // to the 'reuse_partition' method.
  }
}
