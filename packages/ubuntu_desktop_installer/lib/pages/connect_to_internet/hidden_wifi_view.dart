import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_wizard/constants.dart';
import 'package:ubuntu_wizard/widgets.dart';

import '../../l10n.dart';
import 'connect_model.dart';
import 'hidden_wifi_model.dart';
import 'network_tile.dart';

class HiddenWifiRadioButton extends StatelessWidget {
  const HiddenWifiRadioButton({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final ConnectMode? value;
  final ValueChanged<ConnectMode?> onChanged;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HiddenWifiModel>(context);
    if (!model.isEnabled || model.devices.isEmpty) return SizedBox.shrink();

    final lang = AppLocalizations.of(context);
    return RadioButton<ConnectMode>(
      title: Text(lang.hiddenWifiNetwork),
      contentPadding: EdgeInsets.only(top: 8),
      value: ConnectMode.hiddenWifi,
      groupValue: value,
      onChanged: onChanged,
    );
  }
}

class HiddenWifiView extends StatefulWidget {
  const HiddenWifiView({
    Key? key,
    required this.expanded,
    required this.onSelected,
  }) : super(key: key);

  final bool expanded;
  final VoidCallback onSelected;

  @override
  _HiddenWifiViewState createState() => _HiddenWifiViewState();
}

class _HiddenWifiViewState extends State<HiddenWifiView> {
  final _focusNode = FocusNode();
  final _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final model = Provider.of<HiddenWifiModel>(context, listen: false);
    _editingController.text = model.ssid;
    _editingController.addListener(_updateSsid);
  }

  void _updateSsid() {
    final model = Provider.of<HiddenWifiModel>(context, listen: false);
    model.setSsid(_editingController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _editingController.removeListener(_updateSsid);
    _editingController.dispose();
  }

  @override
  void didUpdateWidget(HiddenWifiView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.expanded != widget.expanded) {
      if (widget.expanded) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HiddenWifiModel>(context);
    if (!model.isEnabled || model.devices.isEmpty) return SizedBox.shrink();

    return AnimatedExpanded(
      expanded: widget.expanded,
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: kContentWidthFraction,
        child: NetworkTile(
          title: TextField(
            controller: _editingController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              suffix: SizedBox(
                width: 16,
                height: 16,
                child: model.selectedDevice?.isBusy == true
                    ? CircularProgressIndicator()
                    : null,
              ),
              helperText: model.selectedDevice?.state.toString(),
            ),
            onTap: widget.onSelected,
          ),
        ),
      ),
    );
  }
}
