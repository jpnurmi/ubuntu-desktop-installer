import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets.dart';
import '../wizard_page.dart';
import 'setup_complete_model.dart';

class SetupCompletePage extends StatelessWidget {
  const SetupCompletePage({
    Key? key,
  }) : super(key: key);

  static Widget create(BuildContext context) {
    return Provider.value(
      value: SetupCompleteModel(),
      child: SetupCompletePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SetupCompleteModel>(context);
    return LocalizedView(
      builder: (context, lang) {
        return WizardPage(
          title: Text(lang.setupCompleteTitle),
          header: Text(lang.setupCompleteHeader(model.username)),
          content: ListView(
            children: <Widget>[
              Text(lang.setupCompleteUpdate),
              const SizedBox(height: 16),
              _buildCodeLabel(context, '\$ sudo apt update'),
              const SizedBox(height: 16),
              _buildCodeLabel(context, '\$ sudo apt upgrade'),
              const SizedBox(height: kContentSpacing),
              Text(lang.setupCompleteManage),
              const SizedBox(height: 16),
              _buildCodeLabel(context, '\$ sudo ubuntuwsl...'),
              const SizedBox(height: 56),
              Text(lang.setupCompleteRestart),
            ],
          ),
          actions: <WizardAction>[
            WizardAction(
              label: lang.finishButtonText,
              enabled: false,
              onActivated: () {
                // TODO
              },
            ),
          ],
        );
      },
    );
  }

  static Widget _buildCodeLabel(BuildContext context, String code) {
    final style = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontFamily: 'Ubuntu Mono',
          backgroundColor: Theme.of(context).highlightColor,
        );
    return Text(code, style: style);
  }
}
