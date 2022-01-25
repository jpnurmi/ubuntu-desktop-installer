import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:ubuntu_desktop_installer/pages/allocate_disk_space/partition_size_box.dart';
import 'package:ubuntu_wizard/constants.dart';
import 'package:ubuntu_wizard/utils.dart';
import 'package:ubuntu_wizard/widgets.dart';

import '../../l10n.dart';

Future<void> showCreateLvmGroupDialog(BuildContext context) async {
  final accepted = showDialog(
    context: context,
    builder: (context) {
      return CreateLvmGroupDialog();
    },
  );
}

class CreateLvmGroupDialog extends StatelessWidget {
  const CreateLvmGroupDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return AlertDialog(
      title: Text('Create LVM volume group'),
      titlePadding: kHeaderPadding,
      contentPadding: kContentPadding.copyWith(
          top: kContentSpacing, bottom: kContentSpacing),
      actionsPadding: kFooterPadding,
      buttonPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Volume group name: '),
              const SizedBox(width: kContentSpacing),
              Expanded(
                child: TextField(),
              ),
            ],
          ),
          const SizedBox(height: kContentSpacing),
          Expanded(
            child: RoundedContainer(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(label: Text('Device')),
                    DataColumn(label: Text('Type')),
                    DataColumn(label: Text('Size')),
                    DataColumn(label: Text('Included')),
                  ],
                  rows: <DataRow>[
                    DataRow(cells: <DataCell>[
                      DataCell(Text('/dev/sda')),
                      DataCell(Text('disk')),
                      DataCell(Text('1.00 GiB')),
                      DataCell(Checkbox(value: false, onChanged: null)),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('/dev/sdb')),
                      DataCell(Text('disk')),
                      DataCell(Text('1.00 GiB')),
                      DataCell(Checkbox(value: false, onChanged: null)),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('/dev/sdc')),
                      DataCell(Text('disk')),
                      DataCell(Text('1.00 GiB')),
                      DataCell(Checkbox(value: false, onChanged: null)),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('/dev/sdd')),
                      DataCell(Text('disk')),
                      DataCell(Text('1.00 GiB')),
                      DataCell(Checkbox(value: false, onChanged: null)),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('/dev/sde')),
                      DataCell(Text('disk')),
                      DataCell(Text('1.00 GiB')),
                      DataCell(Checkbox(value: false, onChanged: null)),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('/dev/sdf')),
                      DataCell(Text('disk')),
                      DataCell(Text('1.00 GiB')),
                      DataCell(Checkbox(value: false, onChanged: null)),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('/dev/sdg')),
                      DataCell(Text('disk')),
                      DataCell(Text('1.00 GiB')),
                      DataCell(Checkbox(value: false, onChanged: null)),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: kContentSpacing),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Text('Size:'),
                    const SizedBox(width: kContentSpacing),
                    Expanded(
                      child: PartitionSizeBox(
                        bytes: ValueNotifier(398), //partitionSize,
                        unit:
                            ValueNotifier(DataUnit.megabytes), // partitionUnit,
                        freeSpace: 500000000, // disk.freeForPartitions ?? 0,
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: kContentSpacing),
                // CheckButton(
                //   title: Text('Create encrypted volume'),
                //   value: false,
                //   onChanged: null,
                // ),
                // TextField(
                //   decoration: InputDecoration(labelText: 'Passphrase'),
                // ),
                // const SizedBox(height: kContentSpacing / 2),
                // TextField(
                //   decoration: InputDecoration(labelText: 'Confirm passphrase'),
                // ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(lang.cancelButtonText),
        ),
        const SizedBox(width: kButtonBarSpacing),
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(lang.okButtonText),
        ),
      ],
    );
  }
}
