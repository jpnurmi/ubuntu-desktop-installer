import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_wizard/constants.dart';
import 'package:ubuntu_wizard/widgets.dart';

import '../../l10n.dart';
import 'allocate_disk_space_model.dart';

enum CreateStorageMode { createPartition, createLvmVolumeGroup }

Future<CreateStorageMode> showCreateStorageDialog(BuildContext context) async {
  final model = Provider.of<AllocateDiskSpaceModel>(context, listen: false);
  final mode = ValueNotifier(CreateStorageMode.createPartition);
  final disk = ValueNotifier(model.selectedDiskIndex);

  final accepted = await showDialog(
    context: context,
    builder: (context) {
      return AnimatedBuilder(
        animation: Listenable.merge([mode, disk]),
        builder: (context, child) {
          return CreateStorageDialog(
            mode: mode.value,
            onModeChanged: (value) => mode.value = value,
            disks: model.disks,
            selectedDisk: disk.value,
            onDiskSelected: (value) => disk.value = value,
          );
        },
      );
    },
  );

  if (accepted == true) {
    model.selectStorage(disk.value);
  }

  return mode.value;
}

class CreateStorageDialog extends StatelessWidget {
  const CreateStorageDialog({
    Key? key,
    required this.mode,
    required this.onModeChanged,
    required this.disks,
    required this.selectedDisk,
    required this.onDiskSelected,
  }) : super(key: key);

  final CreateStorageMode mode;
  final ValueChanged<CreateStorageMode> onModeChanged;
  final List<Disk> disks;
  final int selectedDisk;
  final ValueChanged<int> onDiskSelected;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return AlertDialog(
      title: Text('Add new device'),
      titlePadding: kHeaderPadding,
      contentPadding: kContentPadding.copyWith(
          top: kContentSpacing, bottom: kContentSpacing),
      actionsPadding: kFooterPadding,
      buttonPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RadioButton<CreateStorageMode>(
            title: Text('New partition'),
            value: CreateStorageMode.createPartition,
            groupValue: mode,
            onChanged: (value) => onModeChanged(value!),
          ),
          RadioIconTile(
            contentPadding: EdgeInsets.zero,
            title: DropdownBuilder<int>(
              selected: selectedDisk,
              values: List.generate(disks.length, (index) => index),
              onSelected: (value) {
                onDiskSelected.call(value!);
                onModeChanged(CreateStorageMode.createPartition);
              },
              itemBuilder: (context, index, _) {
                return Text(
                  prettyFormatDisk(disks[index]),
                  key: ValueKey(index),
                );
              },
            ),
          ),
          const SizedBox(height: kContentSpacing),
          RadioButton<CreateStorageMode>(
            title: Text('New LVM volume group'),
            value: CreateStorageMode.createLvmVolumeGroup,
            groupValue: mode,
            onChanged: (value) => onModeChanged(value!),
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
