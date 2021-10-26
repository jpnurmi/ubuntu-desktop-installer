import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_desktop_installer/l10n.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/connect_model.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/wifi_auth_dialog.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/wifi_auth_model.dart';
import 'package:ubuntu_desktop_installer/pages/connect_to_internet/wifi_model.dart';
import 'package:ubuntu_wizard/widgets.dart';

import 'widget_tester_extensions.dart';
import 'wifi_auth_dialog_test.mocks.dart';

@GenerateMocks([
  AccessPointModel,
  WifiAuthModel,
  WifiDeviceModel,
])
void main() {
  setUpAll(() async {
    await setupAppLocalizations();
    LangTester.context = Scaffold;
  });

  Future<void> pumpWifiAuthApp(
    WidgetTester tester, {
    required WifiAuthModel model,
  }) {
    tester.binding.window.devicePixelRatioTestValue = 1;

    return tester.pumpWidget(
      ChangeNotifierProvider<WifiAuthModel>.value(
        value: model,
        builder: (_, __) => MaterialApp(
          localizationsDelegates: localizationsDelegates,
          routes: {'/': (_) => Scaffold()},
        ),
      ),
    );
  }

  testWidgets('cancel', (tester) async {
    final model = MockWifiAuthModel();
    when(model.showPassword).thenReturn(false);
    when(model.storePassword).thenReturn(StorePassword.thisUser);
    when(model.wifiSecurity).thenReturn(WifiSecurity.wpa2Personal);

    await pumpWifiAuthApp(tester, model: model);

    final accessPoint = MockAccessPointModel();
    when(accessPoint.ssid).thenReturn('ssid'.codeUnits);

    final result = showWifiAuthDialog(
      context: tester.element(find.byType(Scaffold)),
      device: MockWifiDeviceModel(),
      accessPoint: accessPoint,
    );
    await tester.pumpAndSettle();

    await tester.tap(
      find.widgetWithText(OutlinedButton, tester.lang.cancelButtonText),
    );
    expect(await result, isNull);
  });

  testWidgets('enter password', (tester) async {
    final model = MockWifiAuthModel();
    when(model.showPassword).thenReturn(false);
    when(model.storePassword).thenReturn(StorePassword.thisUser);
    when(model.wifiSecurity).thenReturn(WifiSecurity.wpa2Personal);

    await pumpWifiAuthApp(tester, model: model);

    final accessPoint = MockAccessPointModel();
    when(accessPoint.ssid).thenReturn([]);

    final result = showWifiAuthDialog(
      context: tester.element(find.byType(Scaffold)),
      device: MockWifiDeviceModel(),
      accessPoint: accessPoint,
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Ubuntu');
    await tester.pumpAndSettle();

    await tester.tap(
        find.widgetWithText(OutlinedButton, tester.lang.connectButtonText));
    final auth = await result;
    expect(auth, isNotNull);
    expect(auth!.password, equals('Ubuntu'));
  });

  testWidgets('show password', (tester) async {
    final model = MockWifiAuthModel();
    when(model.showPassword).thenReturn(false);
    when(model.storePassword).thenReturn(StorePassword.thisUser);
    when(model.wifiSecurity).thenReturn(WifiSecurity.wpa2Personal);

    await pumpWifiAuthApp(tester, model: model);

    final accessPoint = MockAccessPointModel();
    when(accessPoint.ssid).thenReturn([]);

    showWifiAuthDialog(
      context: tester.element(find.byType(Scaffold)),
      device: MockWifiDeviceModel(),
      accessPoint: accessPoint,
    );
    await tester.pumpAndSettle();

    expect(
      tester.widget<CheckButton>(find.byType(CheckButton)).value,
      isFalse,
    );
    expect(
      tester.widget<TextField>(find.byType(TextField)).obscureText,
      isTrue,
    );

    await tester.tap(find.byType(CheckButton));
    await tester.pumpAndSettle();
    verify(model.showPassword = true).called(1);
  });

  testWidgets('hide password', (tester) async {
    final model = MockWifiAuthModel();
    when(model.showPassword).thenReturn(true);
    when(model.storePassword).thenReturn(StorePassword.thisUser);
    when(model.wifiSecurity).thenReturn(WifiSecurity.wpa2Personal);

    await pumpWifiAuthApp(tester, model: model);

    final accessPoint = MockAccessPointModel();
    when(accessPoint.ssid).thenReturn([]);

    showWifiAuthDialog(
      context: tester.element(find.byType(Scaffold)),
      device: MockWifiDeviceModel(),
      accessPoint: accessPoint,
    );
    await tester.pumpAndSettle();

    expect(
      tester.widget<CheckButton>(find.byType(CheckButton)).value,
      isTrue,
    );
    expect(
      tester.widget<TextField>(find.byType(TextField)).obscureText,
      isFalse,
    );

    await tester.tap(find.byType(CheckButton));
    await tester.pumpAndSettle();
    verify(model.showPassword = false).called(1);
  });

  testWidgets('wifi security', (tester) async {
    final model = MockWifiAuthModel();
    when(model.showPassword).thenReturn(false);
    when(model.storePassword).thenReturn(StorePassword.thisUser);
    when(model.wifiSecurity).thenReturn(WifiSecurity.wpa2Personal);

    await pumpWifiAuthApp(tester, model: model);

    final accessPoint = MockAccessPointModel();
    when(accessPoint.ssid).thenReturn([]);

    final result = showWifiAuthDialog(
      context: tester.element(find.byType(Scaffold)),
      device: MockWifiDeviceModel(),
      accessPoint: accessPoint,
    );
    await tester.pumpAndSettle();

    final dropdownButton = find
        .byWidgetPredicate((widget) => widget is DropdownButton<WifiSecurity>);
    await tester.tap(dropdownButton);
    await tester.pumpAndSettle();

    await tester.tap(find.text(tester.lang.wpa3Personal).last);
    await tester.pumpAndSettle();
    verify(model.wifiSecurity = WifiSecurity.wpa3Personal).called(1);
    when(model.wifiSecurity).thenReturn(WifiSecurity.wpa3Personal);

    await tester.enterText(find.byType(TextField), '...');
    await tester.pumpAndSettle();

    await tester.tap(find.text(tester.lang.connectButtonText));
    final auth = await result;
    expect(auth, isNotNull);
    expect(auth!.wifiSecurity, equals(WifiSecurity.wpa3Personal));
  });

  testWidgets('store password', (tester) async {
    final model = MockWifiAuthModel();
    when(model.showPassword).thenReturn(false);
    when(model.storePassword).thenReturn(StorePassword.thisUser);
    when(model.wifiSecurity).thenReturn(WifiSecurity.wpa2Personal);

    await pumpWifiAuthApp(tester, model: model);

    final accessPoint = MockAccessPointModel();
    when(accessPoint.ssid).thenReturn([]);

    final result = showWifiAuthDialog(
      context: tester.element(find.byType(Scaffold)),
      device: MockWifiDeviceModel(),
      accessPoint: accessPoint,
    );
    await tester.pumpAndSettle();

    final dropdownButton = find.byWidgetPredicate(
        (widget) => widget is PopupMenuButton<StorePassword>);
    await tester.tap(dropdownButton);
    await tester.pumpAndSettle();

    await tester.tap(find.text(tester.lang.storeWifiPasswordAllUsers).last);
    await tester.pumpAndSettle();
    verify(model.storePassword = StorePassword.allUsers).called(1);
    when(model.storePassword).thenReturn(StorePassword.allUsers);

    await tester.enterText(find.byType(TextField), '...');
    await tester.pumpAndSettle();

    await tester.tap(find.text(tester.lang.connectButtonText));
    final auth = await result;
    expect(auth, isNotNull);
    expect(auth!.storePassword, equals(StorePassword.allUsers));
  });
}
