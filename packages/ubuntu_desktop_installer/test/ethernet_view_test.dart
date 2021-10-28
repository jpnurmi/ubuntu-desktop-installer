import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_desktop_installer/l10n.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/connect_model.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/ethernet_model.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/ethernet_view.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/network_tile.dart';
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
        localizationsDelegates: localizationsDelegates,
        home: ChangeNotifierProvider<EthernetModel>.value(
          value: model,
          child: Material(
            child: Column(
              children: [
                EthernetRadioButton(
                  value: ConnectMode.none,
                  onChanged: (value) => mode = value,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final tile = find.byType(EthernetRadioButton);
    expect(tile, findsOneWidget);
    await tester.tap(tile);
    expect(mode, equals(ConnectMode.ethernet));
  });

  testWidgets('no ethernet devices', (tester) async {
    final model = MockEthernetModel();
    when(model.devices).thenReturn([]);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: localizationsDelegates,
        home: ChangeNotifierProvider<EthernetModel>.value(
          value: model,
          child: Material(
            child: Column(
              children: [
                EthernetRadioButton(
                  value: ConnectMode.none,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.byType(NetworkTile), findsOneWidget);
    expect(find.byType(RadioButton), findsNothing);
  });
}
