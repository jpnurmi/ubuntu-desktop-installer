import 'package:flutter/material.dart';
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

const _kIconSpacing = 10.0;

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({
    Key? key,
  }) : super(key: key);

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

    final successIcon =
        Icon(Icons.check_circle, color: Theme.of(context).successColor);

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
              return ListView(
                children: <Widget>[
                  ValidatedFormField(
                    spacing: _kIconSpacing,
                    fieldWidth: constraints.maxWidth * kContentWidthFraction,
                    initialValue: model.username,
                    onChanged: (value) => model.username = value,
                    labelText: lang.profileSetupUsernameHint,
                    helperText: lang.profileSetupUsernameHelper,
                    successWidget: successIcon,
                    validator: MultiValidator([
                      RequiredValidator(errorText: lang.usernameRequired),
                      PatternValidator(
                        kValidUsernamePattern,
                        errorText: lang.usernameInvalid,
                      )
                    ]),
                  ),
                  const SizedBox(height: kContentSpacing),
                  ValidatedFormField(
                    spacing: _kIconSpacing,
                    fieldWidth: constraints.maxWidth * kContentWidthFraction,
                    initialValue: model.password,
                    onChanged: (value) => model.password = value,
                    obscureText: true,
                    labelText: lang.profileSetupPasswordHint,
                    successWidget: _PasswordStrengthLabel(
                      password: model.password,
                      strength: model.passwordStrength,
                    ),
                    validator: RequiredValidator(
                      errorText: lang.passwordRequired,
                    ),
                  ),
                  const SizedBox(height: kContentSpacing),
                  ValidatedFormField(
                    spacing: _kIconSpacing,
                    fieldWidth: constraints.maxWidth * kContentWidthFraction,
                    obscureText: true,
                    labelText: lang.profileSetupConfirmPasswordHint,
                    successWidget: successIcon,
                    validator: _ConfirmPasswordValidator(
                      model.password,
                      errorText: lang.passwordMismatch,
                    ),
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

class _ConfirmPasswordValidator extends FieldValidator<String?> {
  final String _password;

  _ConfirmPasswordValidator(this._password, {required String errorText})
      : super(errorText);

  @override
  bool isValid(String? value) {
    return value?.isNotEmpty == true && value == _password;
  }
}

class _PasswordStrengthLabel extends StatelessWidget {
  const _PasswordStrengthLabel({
    Key? key,
    required this.password,
    required this.strength,
  }) : super(key: key);

  final String password;
  final PasswordStrength strength;

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) {
        switch (strength) {
          case PasswordStrength.weak:
            return Text(
              lang.weakPassword,
              style: TextStyle(color: Theme.of(context).errorColor),
            );
          case PasswordStrength.moderate:
            return Text(lang.moderatePassword);
          case PasswordStrength.strong:
            return Text(
              lang.strongPassword,
              style: TextStyle(color: Theme.of(context).successColor),
            );
          default:
            return SizedBox.shrink();
        }
      },
    );
  }
}
