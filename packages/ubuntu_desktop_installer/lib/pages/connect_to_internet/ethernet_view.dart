import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_wizard/widgets.dart';

import '../../l10n.dart';
import 'connect_model.dart';
import 'ethernet_model.dart';
import 'network_tile.dart';

class EthernetRadioButton extends StatelessWidget {
  const EthernetRadioButton({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final ConnectMode? value;
  final ValueChanged<ConnectMode?> onChanged;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<EthernetModel>(context);
    final lang = AppLocalizations.of(context);
    if (model.devices.isEmpty) {
      return NetworkTile(
        leading: Icon(Icons.close, color: Theme.of(context).errorColor),
        title: Text(lang.noWiredConnection),
      );
    }

    return RadioButton<ConnectMode>(
      title: Text(lang.useWiredConnection),
      value: ConnectMode.ethernet,
      groupValue: value,
      onChanged: onChanged,
    );
  }
}
