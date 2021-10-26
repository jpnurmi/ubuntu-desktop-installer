import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_wizard/widgets.dart';

import 'ethernet_model.dart';

class EthernetRadioListTile<T> extends StatelessWidget {
  const EthernetRadioListTile({
    Key? key,
    this.title,
    this.errorTitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.contentPadding,
  }) : super(key: key);

  final Widget? title;
  final Widget? errorTitle;
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<EthernetModel>(context);
    if (model.devices.isEmpty) {
      return RadioIconTile(
        contentPadding: contentPadding,
        icon: Icon(Icons.close, color: Theme.of(context).errorColor),
        title: errorTitle,
      );
    }

    return RadioListTile<T>(
      title: title,
      contentPadding: contentPadding,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
