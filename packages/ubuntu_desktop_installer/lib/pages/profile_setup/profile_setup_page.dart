import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wizard_router/wizard_router.dart';

import '../../app_theme.dart';
import '../../constants.dart';
import '../../services.dart';
import '../../widgets.dart';
import '../wizard_page.dart';
import 'profile_setup_model.dart';

const _kContentWidthFactor = 0.75;

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({
    Key? key,
  }) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<UserService>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => ProfileSetupModel(service: service),
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
          content: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _kContentWidthFactor,
            child: ListView(
              children: <Widget>[
                ValidatedFormField(
                  initialValue: model.username,
                  onChanged: (value) => model.username = value,
                  labelText: lang.profileSetupUsernameHint,
                  helperText: lang.profileSetupUsernameHelper,
                  successWidget: successIcon,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'username is required'),
                    MinLengthValidator(2,
                        errorText: 'username must be at least 2 characters'),
                    PatternValidator(
                        r'^(?=.{2,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$',
                        errorText: 'invalid username')
                  ]),
                ),
                const SizedBox(height: kContentSpacing),
                ValidatedFormField(
                  initialValue: model.password,
                  onChanged: (value) => model.password = value,
                  obscureText: true,
                  labelText: lang.profileSetupPasswordHint,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'password is required'),
                    MinLengthValidator(2,
                        errorText: 'password must be at least 2 characters'),
                  ]),
                ),
                // _createTextField(
                //   obscureText: true,
                //   controller: _confirmPasswordController,
                //   hintText: lang.profileSetupConfirmPasswordHint,
                // ),
                const SizedBox(height: kContentSpacing),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CheckButton(
                    title: Text(lang.profileSetupShowAdvancedOptions),
                    value: model.showAdvancedOptions,
                    onChanged: (value) => model.showAdvancedOptions = value,
                  ),
                ),
              ],
            ),
          ),
          actions: <WizardAction>[
            WizardAction(
              label: lang.backButtonText,
              onActivated: Wizard.of(context).back,
            ),
            WizardAction(
              label: lang.continueButtonText,
              enabled: model.isValid,
              onActivated: Wizard.of(context).next,
            ),
          ],
        );
      },
    );
  }

  static Widget _createTextField({
    required TextEditingController controller,
    bool? obscureText,
    String? hintText,
    String? helperText,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kContentPadding.left),
      child: TextField(
        controller: controller,
        obscureText: obscureText == true,
        decoration: InputDecoration(hintText: hintText, helperText: helperText),
      ),
    );
  }
}
