import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_wizard/constants.dart';
import 'package:ubuntu_wizard/widgets.dart';

import '../../l10n.dart';
import 'connect_model.dart';
import 'wifi_auth_model.dart';
import 'wifi_model.dart';

const _kIconSize = 96.0;

/// Shows a dialog to authenticate to a WiFi network.
Future<Authentication?> showWifiAuthDialog({
  required BuildContext context,
  required WifiDeviceModel device,
  required AccessPointModel accessPoint,
}) async {
  final model = Provider.of<WifiAuthModel>(context, listen: false);
  final passwordController = TextEditingController();

  final accepted = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      final lang = AppLocalizations.of(context);
      final model = Provider.of<WifiAuthModel>(context);
      final tileHeight = defaultTileHeight(context);

      String dropdownText(WifiSecurity value) {
        switch (value) {
          case WifiSecurity.wpa2Personal:
            return lang.wpa2Personal;
          case WifiSecurity.wpa3Personal:
            return lang.wpa3Personal;
          default:
            throw UnimplementedError(value.toString());
        }
      }

      String menuText(StorePassword value) {
        switch (value) {
          case StorePassword.thisUser:
            return lang.storeWifiPasswordThisUser;
          case StorePassword.allUsers:
            return lang.storeWifiPasswordAllUsers;
          case StorePassword.askAlways:
            return lang.askWifiPasswordAlways;
          default:
            throw UnimplementedError(value.toString());
        }
      }

      IconData menuIcon(StorePassword value) {
        switch (value) {
          case StorePassword.thisUser:
            return Icons.person;
          case StorePassword.allUsers:
            return Icons.people;
          case StorePassword.askAlways:
            return Icons.help;
          default:
            throw UnimplementedError(value.toString());
        }
      }

      return ChangeNotifierProvider.value(
        value: model,
        child: FractionallySizedBox(
          widthFactor: kContentWidthFraction,
          child: AlertDialog(
            contentPadding: kContentPadding.copyWith(
                top: kContentSpacing, bottom: kContentSpacing),
            actionsPadding: kFooterPadding,
            buttonPadding: EdgeInsets.zero,
            scrollable: true,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IntrinsicWidth(
                      child: Column(
                        children: <Widget>[
                          const Icon(Icons.wifi, size: _kIconSize),
                          const SizedBox(height: kContentSpacing * 2),
                          _FieldLabel(lang.wifiSecurity),
                          const SizedBox(height: kContentSpacing),
                          _FieldLabel(lang.wifiPassword),
                          const SizedBox(height: 4),
                          ListTile(),
                        ],
                      ),
                    ),
                    const SizedBox(width: kContentSpacing / 2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          const SizedBox(height: kContentSpacing),
                          Text(
                            lang.wifiAuthenticationRequired,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(height: kContentSpacing),
                          Text(
                            lang.wifiPasswordRequired(
                              String.fromCharCodes(accessPoint.ssid),
                            ),
                            softWrap: true,
                          ),
                          const SizedBox(height: kContentSpacing * 2),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: tileHeight),
                            child: DropdownBuilder<WifiSecurity>(
                              selected: model.wifiSecurity,
                              values: WifiSecurity.values,
                              itemBuilder: (context, value, _) {
                                return Text(dropdownText(value));
                              },
                              onSelected: (v) => model.wifiSecurity = v!,
                            ),
                          ),
                          const SizedBox(height: kContentSpacing),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: tileHeight),
                            child: TextField(
                              autofocus: true,
                              obscureText: !model.showPassword,
                              controller: passwordController,
                              decoration: InputDecoration(
                                suffixIcon: MenuButtonBuilder<StorePassword>(
                                  selected: model.storePassword,
                                  onSelected: (v) => model.storePassword = v,
                                  values: StorePassword.values,
                                  iconBuilder: (context, value, _) {
                                    return Icon(
                                      menuIcon(value),
                                      color: Theme.of(context).hintColor,
                                    );
                                  },
                                  itemBuilder: (context, value, _) {
                                    return Text(menuText(value));
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          IntrinsicWidth(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: CheckButton(
                                value: model.showPassword,
                                title: Text(lang.showPassword),
                                onChanged: (v) =>
                                    model.showPassword = v ?? false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              OutlinedButton(
                child: Text(lang.cancelButtonText),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              const SizedBox(width: kButtonBarSpacing),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: passwordController,
                builder: (context, password, child) {
                  return OutlinedButton(
                    child: Text(lang.connectButtonText),
                    onPressed: password.text.isNotEmpty
                        ? () => Navigator.of(context).pop(true)
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );

  return accepted == true
      ? Authentication(
          password: passwordController.text,
          storePassword: model.storePassword,
          wifiSecurity: model.wifiSecurity)
      : null;
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.data, {Key? key}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Align(
        alignment: Alignment.topRight,
        child: Text(data),
      ),
    );
  }
}
