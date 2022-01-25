import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:ubuntu_wizard/constants.dart';
import 'package:ubuntu_wizard/utils.dart';
import 'package:ubuntu_wizard/widgets.dart';

import '../../l10n.dart';

class PartitionSizeBox extends StatelessWidget {
  const PartitionSizeBox({
    Key? key,
    required this.bytes,
    required this.unit,
    required this.freeSpace,
  }) : super(key: key);

  final ValueNotifier<int> bytes;
  final ValueNotifier<DataUnit> unit;
  final int freeSpace;

  void _setBytes(double value) => bytes.value = toBytes(value, unit.value);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([bytes, unit]),
      builder: (context, snapshot) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SpinBox(
                value: fromBytes(bytes.value, unit.value),
                max: fromBytes(freeSpace, unit.value),
                onChanged: _setBytes,
              ),
            ),
            const SizedBox(width: kButtonBarSpacing),
            IntrinsicWidth(
              child: DropdownBuilder<DataUnit>(
                values: DataUnit.values,
                selected: unit.value,
                onSelected: (value) => unit.value = value!,
                itemBuilder: (context, unit, _) {
                  return Text(unit.localize(context), key: ValueKey(unit));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

extension _PartitionUnitLang on DataUnit {
  String localize(BuildContext context) {
    final lang = AppLocalizations.of(context);
    switch (this) {
      case DataUnit.bytes:
        return lang.partitionUnitB;
      case DataUnit.kilobytes:
        return lang.partitionUnitKB;
      case DataUnit.megabytes:
        return lang.partitionUnitMB;
      case DataUnit.gigabytes:
        return lang.partitionUnitGB;
    }
  }
}
