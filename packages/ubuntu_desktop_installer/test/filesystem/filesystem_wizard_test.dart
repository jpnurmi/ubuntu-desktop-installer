import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:subiquity_client/subiquity_client.dart';
import 'package:ubuntu_desktop_installer/l10n.dart';
import 'package:ubuntu_desktop_installer/pages/filesystem/filesystem_wizard.dart';
import 'package:ubuntu_desktop_installer/pages/welcome/welcome_widgets.dart';
import 'package:ubuntu_desktop_installer/pages/welcome/welcome_wizard.dart';
import 'package:ubuntu_desktop_installer/routes.dart';
import 'package:ubuntu_desktop_installer/services.dart';
import 'package:ubuntu_test/mocks.dart';
import 'package:ubuntu_test/utils.dart';
import 'package:ubuntu_wizard/utils.dart';
import 'package:ubuntu_wizard/widgets.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import '../test_utils.dart';
//import 'allocate_disk_space/allocate_disk_space_model_test.mocks.dart';
import 'installation_type/installation_type_model_test.mocks.dart';
// import 'welcome_model_test.mocks.dart';

const ubuntu = OsProber(
  long: 'Ubuntu 24.04 LTS',
  label: 'Ubuntu',
  version: '24.04 LTS',
  type: 'linux',
);

final info = ProductInfo(
  name: 'Windows',
  version: '11',
);

const gap = Gap(offset: 0, size: 0, usable: GapUsable.YES);

void main() {
  testWidgets('erase disk', (tester) async {
    await tester.buildFilesystemWizard(storages: [
      const GuidedStorageTargetReformat(diskId: 'sda', capabilities: []),
    ]);
    await tester.pumpAndSettle();
    expect(find.byType(InstallationTypePage), findsOneWidget);

    await tester.tapRadioButton(InstallationType.erase);
    await tester.pump();

    await tester.tapContinue();
    await tester.pumpAndSettle();

    expect(find.text('fs done'), findsOneWidget);
  });

  testWidgets('erase + encrypt disk', (tester) async {
    await tester.buildFilesystemWizard(storages: [
      const GuidedStorageTargetReformat(diskId: 'sda', capabilities: []),
    ], target: 0, useEncryption: true, securityKey: 'foo');
    await tester.pumpAndSettle();
    expect(find.byType(InstallationTypePage), findsOneWidget);

    await tester.tapRadioButton(InstallationType.erase);
    await tester.pump();

    await tester.tapContinue();
    await tester.pumpAndSettle();

    expect(find.byType(SecurityKeyPage), findsOneWidget);

    await tester.tapContinue();
    await tester.pumpAndSettle();

    expect(find.text('fs done'), findsOneWidget);
  });

  testWidgets('select guided storage', (tester) async {
    await tester.buildFilesystemWizard(storages: [
      const GuidedStorageTargetReformat(diskId: 'sda', capabilities: []),
      const GuidedStorageTargetReformat(diskId: 'sdb', capabilities: []),
    ]);
    await tester.pumpAndSettle();
    expect(find.byType(InstallationTypePage), findsOneWidget);

    await tester.tapRadioButton(InstallationType.erase);
    await tester.pump();

    await tester.tapContinue();
    await tester.pumpAndSettle();

    expect(find.byType(SelectGuidedStoragePage), findsOneWidget);

    await tester.tapButton(tester.lang.selectGuidedStorageInstallNow);
    await tester.pumpAndSettle();

    expect(find.text('fs done'), findsOneWidget);
  });

  testWidgets('select + encrypt guided storage', (tester) async {
    await tester.buildFilesystemWizard(
      storages: [
        const GuidedStorageTargetReformat(diskId: 'sda', capabilities: []),
        const GuidedStorageTargetReformat(diskId: 'sdb', capabilities: []),
      ],
      useEncryption: true,
      securityKey: 'foo',
    );
    await tester.pumpAndSettle();
    expect(find.byType(InstallationTypePage), findsOneWidget);

    await tester.tapRadioButton(InstallationType.erase);
    await tester.pump();

    await tester.tapContinue();
    await tester.pumpAndSettle();

    expect(find.byType(SelectGuidedStoragePage), findsOneWidget);

    // TODO: "install now" should be "next"
    await tester.tapButton(tester.lang.selectGuidedStorageInstallNow);
    await tester.pumpAndSettle();

    expect(find.byType(SecurityKeyPage), findsOneWidget);

    await tester.tapContinue();
    await tester.pumpAndSettle();

    expect(find.text('fs done'), findsOneWidget);
  });

  testWidgets('one gap', (tester) async {
    await tester.buildFilesystemWizard(info: info, storages: [
      const GuidedStorageTargetUseGap(
          diskId: 'sda', gap: gap, capabilities: []),
    ]);
    await tester.pumpAndSettle();
    expect(find.byType(InstallationTypePage), findsOneWidget);

    await tester.tapRadioButton(InstallationType.alongside);
    await tester.pump();

    await tester.tapContinue();
    await tester.pumpAndSettle();

    expect(find.text('fs done'), findsOneWidget);
  });

  testWidgets('bitlocker', (tester) async {
    await tester.buildFilesystemWizard(hasBitLocker: true, info: info);
    await tester.pumpAndSettle();
    expect(find.byType(InstallationTypePage), findsOneWidget);

    await tester.tapRadioButton(InstallationType.bitlocker);
    await tester.pump();

    await tester.tapContinue();
    await tester.pumpAndSettle();

    expect(find.byType(BitLockerPage), findsOneWidget);
  });
}

extension on WidgetTester {
  Future<void> buildFilesystemWizard({
    List<GuidedStorageTarget>? storages,
    int? target,
    List<OsProber>? existingOS,
    bool? useLvm,
    bool? useEncryption,
    bool? hasBitLocker,
    ProductInfo? info,
    String? securityKey,
  }) {
    final client = MockSubiquityClient();
    registerMockService<SubiquityClient>(client);

    final product = MockProductService();
    when(product.getProductInfo()).thenReturn(info ?? ProductInfo(name: ''));
    registerMockService<ProductService>(product);

    final storage = MockDiskStorageService();
    when(storage.getStorage()).thenAnswer((_) async => []);
    when(storage.getGuidedStorage()).thenAnswer(
        (_) async => testGuidedStorageResponse(possible: storages ?? []));
    when(storage.hasBitLocker()).thenAnswer((_) async => hasBitLocker ?? false);
    when(storage.existingOS).thenReturn(existingOS ?? []);
    when(storage.useLvm).thenReturn(useLvm ?? false);
    when(storage.useEncryption).thenReturn(useEncryption ?? false);
    when(storage.guidedTarget)
        .thenReturn(target != null ? storages?.elementAtOrNull(target) : null);
    when(storage.securityKey).thenReturn(securityKey);
    registerMockService<DiskStorageService>(storage);

    final telemetry = MockTelemetryService();
    registerMockService<TelemetryService>(telemetry);

    return pumpWidget(
      InheritedLocale(
        child: Flavor(
          data: const FlavorData(name: 'Ubuntu'),
          child: MaterialApp(
            localizationsDelegates: localizationsDelegates,
            home: Wizard(
              routes: {
                Routes.filesystem:
                    const WizardRoute(builder: FilesystemWizard.create),
                '/fs-done': WizardRoute(builder: (_) => const Text('fs done')),
              },
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> tapRadioButton(String text) {
  //   final button = find.widgetWithText(YaruRadioButton<InstallationType>, text);
  //   expect(button, findsOneWidget);
  //   return tap(button);
  // }
}
