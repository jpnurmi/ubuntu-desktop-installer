import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_desktop_installer/l10n.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/wifi_model.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/wifi_view.dart';

import 'wifi_view_test.mocks.dart';

@GenerateMocks([AccessPointModel, WifiModel, WifiDeviceModel])
void main() {
  testWidgets('device and access point tiles', (tester) async {
    final device1 = MockWifiDeviceModel();
    when(device1.model).thenReturn('model1');
    when(device1.scanning).thenReturn(false);
    when(device1.isBusy).thenReturn(false);
    when(device1.isAvailable).thenReturn(true);
    when(device1.isActive).thenReturn(false);

    final accessPoint1 = MockAccessPointModel();
    when(accessPoint1.name).thenReturn('ap1');
    when(accessPoint1.strength).thenReturn(1);
    when(accessPoint1.isOpen).thenReturn(true);
    when(device1.accessPoints).thenReturn([accessPoint1]);
    when(device1.isSelectedAccessPoint(accessPoint1)).thenReturn(false);
    when(device1.isActiveAccessPoint(accessPoint1)).thenReturn(false);

    final device2 = MockWifiDeviceModel();
    when(device2.model).thenReturn('model2');
    when(device2.scanning).thenReturn(true);
    when(device2.isBusy).thenReturn(true);
    when(device2.isAvailable).thenReturn(true);
    when(device2.isActive).thenReturn(true);

    final accessPoint2 = MockAccessPointModel();
    when(accessPoint2.name).thenReturn('ap2');
    when(accessPoint2.strength).thenReturn(2);
    when(accessPoint2.isOpen).thenReturn(false);
    when(device2.accessPoints).thenReturn([accessPoint2]);
    when(device2.isActiveAccessPoint(accessPoint2)).thenReturn(true);
    when(device2.isSelectedAccessPoint(accessPoint2)).thenReturn(true);

    final model = MockWifiModel();
    when(model.devices).thenReturn([device1, device2]);
    when(model.isSelectedDevice(any)).thenReturn(false);
    when(model.requestScan()).thenAnswer((_) async => null);
    when(model.isEnabled).thenReturn(true);

    WifiDeviceModel? selectedDevice;
    AccessPointModel? selectedAccessPoint;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: localizationsDelegates,
        home: ChangeNotifierProvider<WifiModel>.value(
          value: model,
          child: Material(
            child: Column(
              children: [
                WifiView(
                  expanded: true,
                  onSelected: (device, accessPoint) {
                    selectedDevice = device;
                    selectedAccessPoint = accessPoint;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // device is not scanning
    expect(
      find.descendant(
        of: find.widgetWithText(ListTile, 'model1').first,
        matching: find.byType(CircularProgressIndicator),
      ),
      findsNothing,
    );

    // select ap
    final ap1 = find.widgetWithText(ListTile, 'ap1').first;
    expect(ap1, findsOneWidget);
    await tester.tap(ap1);
    expect(selectedDevice, equals(device1));
    expect(selectedAccessPoint, equals(accessPoint1));

    // ap is not busy
    expect(
      find.descendant(
        of: ap1,
        matching: find.byType(CircularProgressIndicator),
      ),
      findsNothing,
    );

    // device is scanning
    expect(
      find.descendant(
        of: find.widgetWithText(ListTile, 'model2').first,
        matching: find.byType(CircularProgressIndicator),
      ),
      findsOneWidget,
    );

    // select another ap
    final ap2 = find.widgetWithText(ListTile, 'ap2').first;
    expect(ap2, findsOneWidget);
    await tester.tap(ap2);
    expect(selectedDevice, equals(device2));
    expect(selectedAccessPoint, equals(accessPoint2));

    // ap is busy
    expect(
      find.descendant(
        of: ap2,
        matching: find.byType(CircularProgressIndicator),
      ),
      findsOneWidget,
    );
  });

  testWidgets('wifi disabled', (tester) async {
    final model = MockWifiModel();
    when(model.requestScan()).thenAnswer((_) async => null);
    when(model.isEnabled).thenReturn(false);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: localizationsDelegates,
        home: ChangeNotifierProvider<WifiModel>.value(
          value: model,
          child: WifiView(
            expanded: true,
            onSelected: (device, accessPoint) {},
          ),
        ),
      ),
    );

    expect(find.byType(WifiListView), findsNothing);
  });

  testWidgets('no wifi devices', (tester) async {
    final model = MockWifiModel();
    when(model.requestScan()).thenAnswer((_) async => null);
    when(model.isEnabled).thenReturn(true);
    when(model.devices).thenReturn([]);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: localizationsDelegates,
        home: ChangeNotifierProvider<WifiModel>.value(
          value: model,
          child: WifiView(
            expanded: true,
            onSelected: (device, accessPoint) {},
          ),
        ),
      ),
    );

    expect(find.byType(WifiListView), findsNothing);
  });
}
