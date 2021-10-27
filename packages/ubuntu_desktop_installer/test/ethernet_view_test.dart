import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/connect_model.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/ethernet_model.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/ethernet_view.dart';
import 'package:ubuntu_wizard/widgets.dart';

import 'ethernet_view_test.mocks.dart';

@GenerateMocks([EthernetModel, EthernetDeviceModel])
void main() {
  testWidgets('select ethernet mode', (tester) async {
    ConnectMode? mode;

    final model = MockEthernetModel();
    when(model.devices).thenReturn([MockEthernetDeviceModel()]);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<EthernetModel>.value(
          value: model,
          child: Material(
            child: Column(
              children: [
                EthernetRadioListTile<ConnectMode>(
                  value: ConnectMode.ethernet,
                  groupValue: ConnectMode.none,
                  onChanged: (value) => mode = value,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final tile = find.byWidgetPredicate((widget) {
      return widget is EthernetRadioListTile<ConnectMode>;
    });
    expect(tile, findsOneWidget);
    await tester.tap(tile);
    expect(mode, equals(ConnectMode.ethernet));
  });

  testWidgets('no ethernet devices', (tester) async {
    final model = MockEthernetModel();
    when(model.devices).thenReturn([]);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<EthernetModel>.value(
          value: model,
          child: Material(
            child: Column(
              children: [
                EthernetRadioListTile<dynamic>(
                  value: ConnectMode.ethernet,
                  groupValue: ConnectMode.none,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.byType(RadioIconTile), findsOneWidget);
    expect(find.byType(RadioListTile), findsNothing);
  });
}
