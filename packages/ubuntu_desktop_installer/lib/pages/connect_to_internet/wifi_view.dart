import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_wizard/constants.dart';
import 'package:ubuntu_wizard/widgets.dart';

import '../../l10n.dart';
import 'connect_model.dart';
import 'network_tile.dart';
import 'wifi_model.dart';

typedef OnWifiSelected = void Function(
  WifiDeviceModel device,
  AccessPointModel accessPoint,
);

class WifiRadioButton extends StatelessWidget {
  const WifiRadioButton({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final ConnectMode? value;
  final ValueChanged<ConnectMode?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WifiModel>(context);
    final lang = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: !model.isEnabled || model.devices.isEmpty
          ? NetworkTile(
              leading: Icon(Icons.close, color: Theme.of(context).errorColor),
              title: !model.isEnabled
                  ? const Text('Wireless networking disabled')
                  : const Text('No Wi-Fi devices detected'),
            )
          : RadioButton<ConnectMode>(
              title: Text(lang.selectWifiNetwork),
              value: ConnectMode.wifi,
              groupValue: value,
              onChanged: onChanged,
            ),
    );
  }
}

class WifiView extends StatefulWidget {
  const WifiView({
    Key? key,
    required this.expanded,
    required this.onSelected,
  }) : super(key: key);

  final bool expanded;
  final OnWifiSelected onSelected;

  @override
  _WifiViewState createState() => _WifiViewState();
}

class _WifiViewState extends State<WifiView> {
  @override
  void initState() {
    super.initState();
    Provider.of<WifiModel>(context, listen: false).requestScan();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WifiModel>(context);
    if (!model.isEnabled) {
      return NetworkTile(
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('To use Wi-Fi on this computer, Wi-Fi must be enabled'),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: model.enable,
              child: Text('Enable Wi-Fi'),
            ),
          ],
        ),
      );
    }
    if (model.devices.isEmpty) return SizedBox.shrink();

    return AnimatedExpanded(
      expanded: widget.expanded,
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: kContentWidthFraction,
        child: RadioIconTile(
          contentPadding: EdgeInsets.zero,
          title: WifiListView(onSelected: widget.onSelected),
        ),
      ),
    );
  }
}

class WifiListView extends StatelessWidget {
  const WifiListView({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final OnWifiSelected onSelected;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WifiModel>(context);
    return RoundedContainer(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: model.devices.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: model.devices[index],
            child: WifiListTile(
              key: ValueKey(index),
              selected: model.isSelectedDevice(model.devices[index]),
              onSelected: (device, accessPoint) {
                model.selectDevice(device);
                onSelected(device, accessPoint);
              },
            ),
          );
        },
      ),
    );
  }
}

class WifiListTile extends StatelessWidget {
  const WifiListTile({
    Key? key,
    required this.selected,
    required this.onSelected,
  }) : super(key: key);

  final bool selected;
  final OnWifiSelected onSelected;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WifiDeviceModel>(context);
    final textColor = Theme.of(context).textTheme.subtitle1!.color;
    final iconSize = IconTheme.of(context).size;
    return ExpansionTile(
      initiallyExpanded: true,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(model.model ?? model.interface),
      textColor: textColor,
      iconColor: textColor,
      trailing: SizedBox(
        width: iconSize,
        height: iconSize,
        child: !model.isAvailable
            ? SizedBox.shrink()
            : model.scanning
                ? CircularProgressIndicator()
                : IconButton(
                    icon: const Icon(Icons.refresh),
                    padding: EdgeInsets.zero,
                    onPressed: model.requestScan,
                  ),
      ),
      children: <Widget>[
        for (final accessPoint in model.accessPoints)
          ChangeNotifierProvider.value(
            value: accessPoint,
            child: ListTile(
              key: ValueKey(accessPoint.name),
              title: Text(accessPoint.name),
              leading: SizedBox.shrink(),
              selected: selected && model.isSelectedAccessPoint(accessPoint),
              trailing: SizedBox(
                width: iconSize,
                height: iconSize,
                child: model.isActiveAccessPoint(accessPoint)
                    ? model.isBusy
                        ? CircularProgressIndicator()
                        : Icon(Icons.check)
                    : Icon(_wifiIcon(accessPoint)),
              ),
              onTap: () {
                model.selectAccessPoint(accessPoint);
                onSelected(model, accessPoint);
              },
            ),
          ),
      ],
    );
  }
}

IconData _wifiIcon(AccessPointModel model) {
  final strength = (model.strength ~/ 25 + 1).clamp(1, 4);
  return model.isOpen ? _wifiIconOpen(strength) : _wifiIconLock(strength);
}

IconData _wifiIconOpen(int strength) {
  const icons = <int, IconData>{
    1: MdiIcons.wifiStrength1,
    2: MdiIcons.wifiStrength2,
    3: MdiIcons.wifiStrength3,
    4: MdiIcons.wifiStrength4,
  };
  return icons[strength]!;
}

IconData _wifiIconLock(int strength) {
  const icons = <int, IconData>{
    1: MdiIcons.wifiStrength1Lock,
    2: MdiIcons.wifiStrength2Lock,
    3: MdiIcons.wifiStrength3Lock,
    4: MdiIcons.wifiStrength4Lock,
  };
  return icons[strength]!;
}
