import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_wizard/constants.dart';
import 'package:ubuntu_wizard/widgets.dart';

import '../../l10n.dart';
import '../../services.dart';
import 'connect_model.dart';
import 'connect_to_internet_model.dart';
import 'ethernet_model.dart';
import 'ethernet_view.dart';
import 'hidden_wifi_model.dart';
import 'hidden_wifi_view.dart';
import 'wifi_auth_dialog.dart';
import 'wifi_auth_model.dart';
import 'wifi_model.dart';
import 'wifi_view.dart';

class ConnectToInternetPage extends StatefulWidget {
  const ConnectToInternetPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<NetworkService>(context, listen: false);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectToInternetModel()),
        ChangeNotifierProvider(create: (_) => EthernetModel(service)),
        ChangeNotifierProvider(create: (_) => HiddenWifiModel(service)),
        ChangeNotifierProvider(create: (_) => WifiAuthModel()),
        ChangeNotifierProvider(create: (_) => WifiModel(service)),
      ],
      child: ConnectToInternetPage(),
    );
  }

  @override
  _ConnectToInternetPageState createState() => _ConnectToInternetPageState();
}

class _ConnectToInternetPageState extends State<ConnectToInternetPage> {
  Future<Authentication?> _authenticate(
    WifiDeviceModel device,
    AccessPointModel accessPoint,
  ) async {
    return showWifiAuthDialog(
      context: context,
      device: device,
      accessPoint: accessPoint,
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ConnectToInternetModel>(context);
    final lang = AppLocalizations.of(context);
    return WizardPage(
      title: Text(lang.connectToInternetPageTitle),
      header: Text(lang.connectToInternetDescription),
      contentPadding: EdgeInsets.zero,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          EthernetRadioListTile<ConnectMode>(
            title: Text(lang.useWiredConnection),
            errorTitle: Text(lang.noWiredConnection),
            contentPadding: kContentPadding,
            value: ConnectMode.ethernet,
            groupValue: model.connectMode,
            onChanged: (_) {
              model.select(context.read<EthernetModel>());
            },
          ),
          WifiRadioListTile<ConnectMode>(
            title: Text(lang.selectWifiNetwork),
            contentPadding: kContentPadding,
            value: ConnectMode.wifi,
            groupValue: model.connectMode,
            onChanged: (_) {
              model.select(context.read<WifiModel>());
            },
          ),
          WifiView(
            contentPadding: kContentPadding,
            contentWidthFactor: kContentWidthFraction,
            expanded: model.connectMode == ConnectMode.wifi,
            onSelected: (device, accessPoint) {
              model.select(context.read<WifiModel>());
            },
          ),
          HiddenWifiRadioListTile<ConnectMode>(
            title: Text(lang.hiddenWifiNetwork),
            contentPadding: kContentPadding,
            value: ConnectMode.hiddenWifi,
            groupValue: model.connectMode,
            onChanged: (_) {
              model.select(context.read<HiddenWifiModel>());
            },
          ),
          HiddenWifiView(
            contentPadding: kContentPadding,
            contentWidthFactor: kContentWidthFraction,
            expanded: model.connectMode == ConnectMode.hiddenWifi,
            onSelected: () {
              model.select(context.read<HiddenWifiModel>());
            },
          ),
          RadioListTile<ConnectMode>(
            title: Text(lang.noInternet),
            contentPadding: kContentPadding,
            value: ConnectMode.none,
            groupValue: model.connectMode,
            onChanged: (_) {
              model.select(NoConnectModel());
            },
          ),
        ],
      ),
      actions: <WizardAction>[
        WizardAction.back(context),
        WizardAction(
          label: lang.connectButtonText,
          enabled: model.canConnect && !model.isBusy,
          visible: !model.canContinue,
          onActivated: () => model.connect(onAuthenticate: _authenticate),
        ),
        WizardAction.next(
          context,
          enabled: !model.isBusy,
          visible: model.canContinue,
          onActivated: Wizard.of(context).next,
        ),
      ],
    );
  }
}
