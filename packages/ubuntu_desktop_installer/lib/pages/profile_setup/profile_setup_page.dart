import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:subiquity_client/subiquity_client.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wizard_router/wizard_router.dart';

import '../../app_theme.dart';
import '../../constants.dart';
import '../../widgets.dart';
import '../wizard_page.dart';
import 'profile_setup_model.dart';

part 'profile_setup_widgets.dart';

const _kIconSpacing = 10.0;

/// WSL Profile setup page.
///
/// See also:
/// * [ProfileSetupModel]
class ProfileSetupPage extends StatefulWidget {
  /// Use [create] instead.
  @visibleForTesting
  const ProfileSetupPage({Key? key}) : super(key: key);

  /// Creates an instance with [ProfileSetupModel].
  static Widget create(BuildContext context) {
    final client = Provider.of<SubiquityClient>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => ProfileSetupModel(client),
      child: ProfileSetupPage(),
    );
  }

  @override
  _ProfileSetupPageState createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  @override
  void initState() {
    super.initState();

    final model = Provider.of<ProfileSetupModel>(context, listen: false);
    model.loadProfileSetup();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileSetupModel>(context);
    return LocalizedView(
      builder: (context, lang) {
        return WizardPage(
          contentPadding: EdgeInsets.zero,
          title: Text(lang.profileSetupTitle),
          header: Html(
            data: lang.profileSetupHeader,
            style: {'body': Style(margin: EdgeInsets.all(0))},
            onLinkTap: (url, _, __, ___) => launch(url!),
          ),
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: kContentPadding.left),
            child: LayoutBuilder(builder: (context, constraints) {
              final fieldWidth = constraints.maxWidth * kContentWidthFraction;
              return ListView(
                children: <Widget>[
                  _UsernameFormField(
                    lang: lang,
                    model: model,
                    fieldWidth: fieldWidth,
                  ),
                  const SizedBox(height: kContentSpacing),
                  _PasswordFormField(
                    lang: lang,
                    model: model,
                    fieldWidth: fieldWidth,
                  ),
                  const SizedBox(height: kContentSpacing),
                  _ConfirmPasswordFormField(
                    lang: lang,
                    model: model,
                    fieldWidth: fieldWidth,
                  ),
                  const SizedBox(height: kContentSpacing),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CheckButton(
                      contentPadding: EdgeInsets.only(left: _kIconSpacing),
                      title: Text(lang.profileSetupShowAdvancedOptions),
                      value: model.showAdvancedOptions,
                      onChanged: (value) => model.showAdvancedOptions = value,
                    ),
                  ),
                ],
              );
            }),
          ),
          actions: <WizardAction>[
            WizardAction(
              label: lang.backButtonText,
              onActivated: Wizard.of(context).back,
            ),
            WizardAction(
              label: lang.continueButtonText,
              enabled: model.isValid,
              onActivated: () {
                model.saveProfileSetup();
                Wizard.of(context).next(arguments: model.showAdvancedOptions);
              },
            ),
          ],
        );
      },
    );
  }
}
