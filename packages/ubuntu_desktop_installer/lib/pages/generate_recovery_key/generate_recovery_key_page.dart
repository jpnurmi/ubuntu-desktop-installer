import 'dart:async';

import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subiquity_client/subiquity_client.dart';
import 'package:ubuntu_wizard/constants.dart';
import 'package:ubuntu_wizard/widgets.dart';

import '../../l10n.dart';
import 'generate_recovery_key_model.dart';

part 'generate_recovery_key_widgets.dart';

/// https://github.com/canonical/ubuntu-desktop-installer/issues/34
///
/// See also:
/// * [GenerateRecoveryKeyModel]
class GenerateRecoveryKeyPage extends StatefulWidget {
  /// Use [create] instead.
  @visibleForTesting
  const GenerateRecoveryKeyPage({
    Key? key,
  }) : super(key: key);

  /// Creates an instance with [GenerateRecoveryKeyModel].
  static Widget create(BuildContext context) {
    final client = Provider.of<SubiquityClient>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => GenerateRecoveryKeyModel(client),
      child: const GenerateRecoveryKeyPage(),
    );
  }

  @override
  _GenerateRecoveryKeyPageState createState() =>
      _GenerateRecoveryKeyPageState();
}

class _GenerateRecoveryKeyPageState extends State<GenerateRecoveryKeyPage> {
  @override
  void initState() {
    super.initState();

    final model = Provider.of<GenerateRecoveryKeyModel>(context, listen: false);
    model.loadRecoveryKey();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    final model = Provider.of<GenerateRecoveryKeyModel>(context);
    return WizardPage(
      title: Text(lang.generateRecoveryKeyTitle),
      header: Text(lang.generateRecoveryKeyHeader),
      content: LayoutBuilder(builder: (context, constraints) {
        final fieldWidth = constraints.maxWidth * kContentWidthFraction;
        return ListView(
          children: <Widget>[
            _RecoveryKeyLocationSelector(),
            const SizedBox(height: kContentSpacing),
            ValidatedFormField(
              obscureText: true,
              labelText: lang.generateRecoveryKeyLabel,
              fieldWidth: fieldWidth,
            ),
            const SizedBox(height: kContentSpacing * 2),
            Text(lang.generateRecoveryKeyMoreSecurity),
            const SizedBox(height: kContentSpacing),
            CheckButton(
              value: model.overwriteEmptyDiskSpace,
              title: Text(lang.generateRecoveryKeyOverwriteEmptyDiskSpace),
              subtitle: Text(lang.generateRecoveryKeyLongerInstallation),
              onChanged: (value) => model.overwriteEmptyDiskSpace = value!,
            ),
          ],
        );
      }),
      actions: <WizardAction>[
        WizardAction.back(context),
        WizardAction.next(
          context,
          enabled: context
              .select<GenerateRecoveryKeyModel, bool>((model) => model.isValid),
          onActivated: () async {
            final model =
                Provider.of<GenerateRecoveryKeyModel>(context, listen: false);
            await model.saveRecoveryKey();

            Wizard.of(context).next();
          },
        ),
      ],
    );
  }
}
