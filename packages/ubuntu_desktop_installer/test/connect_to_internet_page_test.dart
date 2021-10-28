import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_desktop_installer/l10n.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/connect_model.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/connect_to_internet_model.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/connect_to_internet_page.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/ethernet_model.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/ethernet_view.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/hidden_wifi_model.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/hidden_wifi_view.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/wifi_auth_model.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/wifi_model.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/wifi_view.dart';
import 'package:ubuntu_desktop_installer/services.dart';
import 'package:ubuntu_wizard/widgets.dart';

import 'connect_to_internet_page_test.mocks.dart';

@GenerateMocks([
  ConnectToInternetModel,
  EthernetModel,
  EthernetDeviceModel,
  HiddenWifiModel,
  NetworkService,
  WifiAuthModel,
  WifiModel,
  WifiDeviceModel,
])
void main() {
  setUpAll(() async {
    await setupAppLocalizations();
  });

  testWidgets('selects the right connect mode on tap', (tester) async {
    final connectToInternetModel = ConnectToInternetModel();

    final ethernetModel = MockEthernetModel();
    when(ethernetModel.connectMode).thenReturn(ConnectMode.ethernet);
    when(ethernetModel.devices).thenReturn([MockEthernetDeviceModel()]);

    final hiddenWifiModel = MockHiddenWifiModel();
    when(hiddenWifiModel.connectMode).thenReturn(ConnectMode.hiddenWifi);
    when(hiddenWifiModel.ssid).thenReturn('');
    when(hiddenWifiModel.selectedDevice).thenReturn(null);
    when(hiddenWifiModel.isEnabled).thenReturn(true);
    when(hiddenWifiModel.devices).thenReturn([MockWifiDeviceModel()]);

    final wifiDevice = MockWifiDeviceModel();
    when(wifiDevice.model).thenReturn('model');
    when(wifiDevice.isAvailable).thenReturn(true);
    when(wifiDevice.scanning).thenReturn(false);
    when(wifiDevice.accessPoints).thenReturn([]);

    final wifiModel = MockWifiModel();
    when(wifiModel.connectMode).thenReturn(ConnectMode.wifi);
    when(wifiModel.devices).thenReturn([]);
    when(wifiModel.requestScan(ssid: anyNamed('ssid')))
        .thenAnswer((_) async => null);
    when(wifiModel.isEnabled).thenReturn(true);
    when(wifiModel.devices).thenReturn([wifiDevice]);
    when(wifiModel.isSelectedDevice(any)).thenReturn(false);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: localizationsDelegates,
        home: Scaffold(
          body: Wizard(
            routes: {
              '/': (_) {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider<ConnectToInternetModel>.value(
                        value: connectToInternetModel),
                    ChangeNotifierProvider<EthernetModel>.value(
                        value: ethernetModel),
                    ChangeNotifierProvider<HiddenWifiModel>.value(
                        value: hiddenWifiModel),
                    ChangeNotifierProvider<WifiAuthModel>(
                        create: (_) => MockWifiAuthModel()),
                    ChangeNotifierProvider<WifiModel>.value(value: wifiModel),
                  ],
                  child: ConnectToInternetPage(),
                );
              },
            },
          ),
        ),
      ),
    );

    final ethernetTile = find.byType(EthernetRadioButton);
    expect(ethernetTile, findsOneWidget);
    await tester.tap(ethernetTile);
    expect(connectToInternetModel.connectMode, ConnectMode.ethernet);

    final wifiTile = find.byType(WifiRadioButton);
    expect(wifiTile, findsOneWidget);
    await tester.tap(wifiTile);
    expect(connectToInternetModel.connectMode, ConnectMode.wifi);

    final hiddenWifiTile = find.byType(HiddenWifiRadioButton);
    expect(wifiTile, findsOneWidget);
    await tester.tap(hiddenWifiTile);
    expect(connectToInternetModel.connectMode, ConnectMode.hiddenWifi);

    final noConnectTile = find.byWidgetPredicate((widget) =>
        widget is RadioButton<ConnectMode> && widget.value == ConnectMode.none);
    expect(noConnectTile, findsOneWidget);
    await tester.tap(noConnectTile);
    expect(connectToInternetModel.connectMode, ConnectMode.none);
  });

  testWidgets('creates all models', (tester) async {
    final service = MockNetworkService();
    when(service.propertiesChanged)
        .thenAnswer((_) => Stream<List<String>>.empty());
    when(service.wiredDevices).thenReturn([]);
    when(service.wirelessDevices).thenReturn([]);
    when(service.wirelessEnabled).thenReturn(true);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: localizationsDelegates,
        home: Scaffold(
          body: Provider<NetworkService>.value(
            value: service,
            child: Wizard(routes: {'/': ConnectToInternetPage.create}),
          ),
        ),
      ),
    );

    final page = find.byType(ConnectToInternetPage);
    expect(page, findsOneWidget);

    final context = tester.element(page);
    expect(
        Provider.of<ConnectToInternetModel>(context, listen: false), isNotNull);
    expect(
        Provider.of<ConnectToInternetModel>(context, listen: false), isNotNull);
    expect(Provider.of<EthernetModel>(context, listen: false), isNotNull);
    expect(Provider.of<HiddenWifiModel>(context, listen: false), isNotNull);
    expect(Provider.of<WifiAuthModel>(context, listen: false), isNotNull);
    expect(Provider.of<WifiModel>(context, listen: false), isNotNull);
  });
}
